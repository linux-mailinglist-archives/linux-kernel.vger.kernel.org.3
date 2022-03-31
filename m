Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD7A4ED1F7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiCaC6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiCaC6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:58:45 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25E31255B4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:56:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648694928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GMH0mPyygzee1kjfgYk2myFSoN2Dy3HPVOSEklSnjvE=;
        b=wU49G/J70KRunQNmNOTSvdD4e0DvXrXgr1MKUM3Va7O5PWrvx1QxUMswDNikDQyxRpBhH8
        Yr9ISTWnKaHFfTqAG2l8sJWb5B9f82wBlqPVdPq6ySt5TSgnDotA9Int2/OGuQGrwc34gP
        l28o3MkNE3sX2oydsHYVJ56arAYsIjM=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/list_lru: Fix possible race in memcg_reparent_list_lru_node()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <20220330191440.1cc1b2de2b849d1ba93d2ba7@linux-foundation.org>
Date:   Wed, 30 Mar 2022 19:48:45 -0700
Cc:     Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Message-Id: <89B53D3A-FCC5-4107-8D49-81D5B9AE5172@linux.dev>
References: <20220330191440.1cc1b2de2b849d1ba93d2ba7@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 30, 2022, at 7:14 PM, Andrew Morton <akpm@linux-foundation.org> wro=
te:
>=20
> =EF=BB=BFOn Wed, 30 Mar 2022 13:26:46 -0400 Waiman Long <longman@redhat.co=
m> wrote:
>=20
>> Muchun Song found out there could be a race between list_lru_add()
>> and memcg_reparent_list_lru_node() causing the later function to miss
>> reparenting of a lru entry as shown below:
>>=20
>> CPU0:                           CPU1:
>> list_lru_add()
>>    spin_lock(&nlru->lock)
>>    l =3D list_lru_from_kmem(memcg)
>>                                memcg_reparent_objcgs(memcg)
>>                                memcg_reparent_list_lrus(memcg)
>>                                    memcg_reparent_list_lru()
>>                                        memcg_reparent_list_lru_node()
>>                                            if (!READ_ONCE(nlru->nr_items)=
)
>>                                                // Miss reparenting
>>                                                return
>>    // Assume 0->1
>>    l->nr_items++
>>    // Assume 0->1
>>    nlru->nr_items++
>>=20
>> Though it is not likely that a list_lru_node that has 0 item suddenly
>> has a newly added lru entry at the end of its life. The race is still
>> theoretically possible.
>>=20
>> With the lock/unlock pair used within the percpu_ref_kill() which is
>> the last function call of memcg_reparent_objcgs(), any read issued
>> in memcg_reparent_list_lru_node() will not be reordered before the
>> reparenting of objcgs.
>>=20
>> Adding a !spin_is_locked()/smp_rmb()/!READ_ONCE(nlru->nr_items) check
>> to ensure that either the reading of nr_items is valid or the racing
>> list_lru_add() will see the reparented objcg.
>>=20
>> ...
>>=20
>> --- a/mm/list_lru.c
>> +++ b/mm/list_lru.c
>> @@ -395,10 +395,33 @@ static void memcg_reparent_list_lru_node(struct lis=
t_lru *lru, int nid,
>>    struct list_lru_one *src, *dst;
>>=20
>>    /*
>> -     * If there is no lru entry in this nlru, we can skip it immediately=
.
>> +     * With the lock/unlock pair used within the percpu_ref_kill()
>> +     * which is the last function call of memcg_reparent_objcgs(), any
>> +     * read issued here will not be reordered before the reparenting
>> +     * of objcgs.
>> +     *
>> +     * Assuming a racing list_lru_add():
>> +     * list_lru_add()
>> +     *                <- memcg_reparent_list_lru_node()
>> +     *   spin_lock(&nlru->lock)
>> +     *   l =3D list_lru_from_kmem(memcg)
>> +     *   nlru->nr_items++
>> +     *   spin_unlock(&nlru->lock)
>> +     *                <- memcg_reparent_list_lru_node()
>> +     *
>> +     * The !spin_is_locked(&nlru->lock) check is true means it is
>> +     * either before the spin_lock() or after the spin_unlock(). In the
>> +     * former case, list_lru_add() will see the reparented objcg and so
>> +     * won't touch the lru to be reparented. In the later case, it will
>> +     * see the updated nr_items. So we can use the optimization that if
>> +     * there is no lru entry in this nlru, skip it immediately.
>>     */
>> -    if (!READ_ONCE(nlru->nr_items))
>> -        return;
>> +    if (!spin_is_locked(&nlru->lock)) {
>=20
> ick.
>=20
>> +        /* nr_items read must be ordered after nlru->lock */
>> +        smp_rmb();
>> +        if (!READ_ONCE(nlru->nr_items))
>> +            return;
>> +    }
>=20
> include/linux/spinlock_up.h has
>=20
> #define arch_spin_is_locked(lock)    ((void)(lock), 0)
>=20
> so this `if' will always be true on CONFIG_SMP=3Dn.  Will the kernel
> still work?

I guess yes, because this race is not possible on a !smp machine.

>=20
> At the very least let's have changelogging and commenting explaining
> that we've actually thought about this.
>=20
> Preferably, can we fix this hole properly and avoid this hack?  There is
> a reason for this:
>=20
> hp2:/usr/src/25> grep spin_is_locked mm/*.c
> hp2:/usr/src/25>=20


But honestly, I=E2=80=99d drop the original optimization together with the f=
ix, if only there is no _real world_ data on the problem and the improvement=
. It seems like it has started as a nice simple improvement, but the race ma=
kes it complex and probably not worth the added complexity and fragility.

Thanks!=
