Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D4359AC3C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343630AbiHTHdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244415AbiHTHdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:33:15 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E25C47
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 00:33:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660980789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXPB7dY7tQ2n85mgIrq2bkd3Z/lqPrZbbmrEZHKR2EI=;
        b=V53qx512BBfkXrE3QHlAuCrjOL/BGRhH15a+RPQLzdh5ADOmo4WZzCYasXbWSLF7hQrROy
        vzgnfu5PhZ7MljCwl1QuTRDtohzAPsG1odlzHbyoaNSseMMPQCu3EI9th7yo4q2B+Hygvm
        W8put8C83HqTG+wE2Ncg5iamruWSeIw=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: fix pgdat->kswap accessed concurrently
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220820032506.126860-1-wangkefeng.wang@huawei.com>
Date:   Sat, 20 Aug 2022 15:33:04 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E87F09C-4904-49E2-B45C-C408DD5F6F62@linux.dev>
References: <20220820032506.126860-1-wangkefeng.wang@huawei.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 20, 2022, at 11:25, Kefeng Wang <wangkefeng.wang@huawei.com> =
wrote:
>=20
> The pgdat->kswap could be accessed concurrently by kswapd_run() and
> kcompactd(), it don't be protected by any lock, which leads to the
> following null-ptr-deref,
>=20
>  vmscan: Failed to start kswapd on node 0
>  ...
>  BUG: KASAN: null-ptr-deref in kcompactd+0x440/0x504
>  Read of size 8 at addr 0000000000000024 by task kcompactd0/37
>=20
>  CPU: 0 PID: 37 Comm: kcompactd0 Kdump: loaded Tainted: G           OE =
    5.10.60 #1
>  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>  Call trace:
>   dump_backtrace+0x0/0x394
>   show_stack+0x34/0x4c
>   dump_stack+0x158/0x1e4
>   __kasan_report+0x138/0x140
>   kasan_report+0x44/0xdc
>   __asan_load8+0x94/0xd0
>   kcompactd+0x440/0x504
>   kthread+0x1a4/0x1f0
>   ret_from_fork+0x10/0x18
>=20
> Fix it by adding READ_ONCE()|WRITE_ONCE().
>=20
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> mm/compaction.c |  4 +++-
> mm/vmscan.c     | 15 +++++++++------
> 2 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 640fa76228dd..aa1cfe47f046 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1983,7 +1983,9 @@ static inline bool is_via_compact_memory(int =
order)
>=20
> static bool kswapd_is_running(pg_data_t *pgdat)
> {
> -	return pgdat->kswapd && task_is_running(pgdat->kswapd);
> +	struct task_struct *t =3D READ_ONCE(pgdat->kswapd);
> +
> +	return t && task_is_running(t);
> }
>=20
> /*
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b2b1431352dc..9abba714249e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4642,16 +4642,19 @@ unsigned long shrink_all_memory(unsigned long =
nr_to_reclaim)
> void kswapd_run(int nid)
> {
> 	pg_data_t *pgdat =3D NODE_DATA(nid);
> +	struct task_struct *t;
>=20
> -	if (pgdat->kswapd)
> +	if (READ_ONCE(pgdat->kswapd))
> 		return;
>=20
> -	pgdat->kswapd =3D kthread_run(kswapd, pgdat, "kswapd%d", nid);
> -	if (IS_ERR(pgdat->kswapd)) {
> +	t =3D kthread_run(kswapd, pgdat, "kswapd%d", nid);
> +	if (IS_ERR(t)) {
> 		/* failure at boot is fatal */
> 		BUG_ON(system_state < SYSTEM_RUNNING);
> 		pr_err("Failed to start kswapd on node %d\n", nid);
> -		pgdat->kswapd =3D NULL;
> +		WRITE_ONCE(pgdat->kswapd, NULL);
> +	} else {
> +		WRITE_ONCE(pgdat->kswapd, t);
> 	}
> }

IIUC, the race is like the followings:

CPU 0:					CPU 1:

kswapd_run()
	pgdat->kswapd =3D kthread_run()
	if (IS_ERR(pgdat->kswapd))
					kswapd_is_running
						// load pgdat->kswapd =
and it is NOT NULL.
		pgdat->kswapd =3D NULL
						=
task_is_running(pgdat->kswapd); // NULL pointer dereference

So

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

>=20
> @@ -4661,11 +4664,11 @@ void kswapd_run(int nid)
>  */
> void kswapd_stop(int nid)
> {
> -	struct task_struct *kswapd =3D NODE_DATA(nid)->kswapd;
> +	struct task_struct *kswapd =3D =
READ_ONCE(NODE_DATA(nid)->kswapd);
>=20
> 	if (kswapd) {
> 		kthread_stop(kswapd);
> -		NODE_DATA(nid)->kswapd =3D NULL;
> +		WRITE_ONCE(NODE_DATA(nid)->kswapd, NULL);
> 	}
> }
>=20
> --=20
> 2.35.3
>=20
>=20

