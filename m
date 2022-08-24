Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AA059F3E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbiHXHEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiHXHES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:04:18 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6289291D2C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:04:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661324655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6tvwkfCP3dZ+ZrJ0eNLvzLAz7UpWICuxq3NpSBeqntU=;
        b=JunrwnnLdI6piFW4nALnDaW6RyDeknYztEVEEq1kYXEcDlQDHTBFWTvP8zNva/nFBj7Jxq
        QepF3Va2IjydiNXNph8l3Is8C6a5p7We4mMSMhRFhSpyNugZV2Ruqu96o5gAM6ppHqVPEU
        o4s67SknytA+VlP/1MMoBlMJW2LD4U4=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: fix pgdat->kswap accessed concurrently
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <16cf184f-95ec-a763-0606-7423db8dcb0f@huawei.com>
Date:   Wed, 24 Aug 2022 15:03:50 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B0D6AB9-736E-40EB-996F-C0B6200EE749@linux.dev>
References: <20220820032506.126860-1-wangkefeng.wang@huawei.com>
 <1E87F09C-4904-49E2-B45C-C408DD5F6F62@linux.dev>
 <20220820135955.1520aa480fe04ab31d4fce1f@linux-foundation.org>
 <abe568d8-2d48-7e73-fe66-822915c0bd74@huawei.com>
 <16cf184f-95ec-a763-0606-7423db8dcb0f@huawei.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 23, 2022, at 22:47, Kefeng Wang <wangkefeng.wang@huawei.com> =
wrote:
>=20
>=20
> On 2022/8/23 9:07, Kefeng Wang wrote:
>>=20
>> On 2022/8/21 4:59, Andrew Morton wrote:
>>> On Sat, 20 Aug 2022 15:33:04 +0800 Muchun Song =
<muchun.song@linux.dev> wrote:
>>>=20
>>>>=20
>>>>> +    if (IS_ERR(t)) {
>>>>>         /* failure at boot is fatal */
>>>>>         BUG_ON(system_state < SYSTEM_RUNNING);
>>>>>         pr_err("Failed to start kswapd on node %d\n", nid);
>>>>> -        pgdat->kswapd =3D NULL;
>>>>> +        WRITE_ONCE(pgdat->kswapd, NULL);
>>>>> +    } else {
>>>>> +        WRITE_ONCE(pgdat->kswapd, t);
>>>>>     }
>>>>> }
>>>> IIUC, the race is like the followings:
>>>>=20
>>>> CPU 0:                    CPU 1:
>>>>=20
>>>> kswapd_run()
>>>>     pgdat->kswapd =3D kthread_run()
>>>>     if (IS_ERR(pgdat->kswapd))
>>>>                     kswapd_is_running
>>>>                         // load pgdat->kswapd and it is NOT NULL.
>>>>         pgdat->kswapd =3D NULL
>>>>                         task_is_running(pgdat->kswapd); // NULL =
pointer dereference
>>>>=20
>>> But don't we still have a bug?  Sure, kswapd_is_running() will no
>>> longer deref a null pointer.  But it now runs kswapd_is_running()
>>> against a task which has exited - a use-after-free?
>=20
> The UAF is caused by race between kswapd_stop() and kcompactd(), =
right?
>=20
> so  kcompactd() should be stop before kswapd_stop() to avoid the above =
UAF.
>=20
> $ git diff
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index fad6d1f2262a..2fd45ccbce45 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1940,8 +1940,8 @@ int __ref offline_pages(unsigned long start_pfn, =
unsigned long nr_pages,
>=20
>         node_states_clear_node(node, &arg);
>         if (arg.status_change_nid >=3D 0) {
> -               kswapd_stop(node);
>                 kcompactd_stop(node);
> +               kswapd_stop(node);
>         }
>=20
>         writeback_set_ratelimit();

The changes make sense to me. Again:

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

>=20
>> we could add get/put_task_struct() to avoid the UAF=EF=BC=8C will =
update=EF=BC=8C thanks.
>=20
> sorry, the task refcount won't fix anything.
>=20
>=20
>> .

