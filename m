Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF5F59F3DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiHXHAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiHXHA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:00:26 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E998B2D7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:00:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661324422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wTEkRmEhfEAMOHgr9KTE38V3eHehsSikHxHeXkBHng=;
        b=NrZDTTvpTLZgrK2eRDx+Z2rlZZ4jfW/qh/ZsfbRzbVfvDKLu91zEp5+jpBi4QLoTY19/hg
        CbK3w8YK+hDgkwFPScEuW/d1bUmdQWVXn5+4wDsvbEanA0ovhRwLh5z1MyTdY5ltFeQprf
        SsBD4UNq55rAEaaUMfo2f7CYBMb9uh4=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: fix pgdat->kswap accessed concurrently
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220820135955.1520aa480fe04ab31d4fce1f@linux-foundation.org>
Date:   Wed, 24 Aug 2022 14:59:45 +0800
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux MM <linux-mm@kvack.org>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E16D12C3-80AB-41FD-BE6B-5D0E62044A2D@linux.dev>
References: <20220820032506.126860-1-wangkefeng.wang@huawei.com>
 <1E87F09C-4904-49E2-B45C-C408DD5F6F62@linux.dev>
 <20220820135955.1520aa480fe04ab31d4fce1f@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 21, 2022, at 04:59, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Sat, 20 Aug 2022 15:33:04 +0800 Muchun Song <muchun.song@linux.dev> =
wrote:
>=20
>>=20
>>=20
>>> +	if (IS_ERR(t)) {
>>> 		/* failure at boot is fatal */
>>> 		BUG_ON(system_state < SYSTEM_RUNNING);
>>> 		pr_err("Failed to start kswapd on node %d\n", nid);
>>> -		pgdat->kswapd =3D NULL;
>>> +		WRITE_ONCE(pgdat->kswapd, NULL);
>>> +	} else {
>>> +		WRITE_ONCE(pgdat->kswapd, t);
>>> 	}
>>> }
>>=20
>> IIUC, the race is like the followings:
>>=20
>> CPU 0:					CPU 1:
>>=20
>> kswapd_run()
>> 	pgdat->kswapd =3D kthread_run()
>> 	if (IS_ERR(pgdat->kswapd))
>> 					kswapd_is_running
>> 						// load pgdat->kswapd =
and it is NOT NULL.
>> 		pgdat->kswapd =3D NULL
>> 						=
task_is_running(pgdat->kswapd); // NULL pointer dereference
>>=20
>=20
> But don't we still have a bug?  Sure, kswapd_is_running() will no
> longer deref a null pointer.  But it now runs kswapd_is_running()
> against a task which has exited - a use-after-free?
>=20

Agree. I missed that.

Thanks,
Muchun

