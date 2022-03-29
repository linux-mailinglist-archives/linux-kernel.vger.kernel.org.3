Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51D84EB578
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiC2Vz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 17:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiC2VzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AD8A546A5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648590819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=puBJtnI/eFwkwibbXKroPb7DsEqz6d/eI2XJNgk+jx4=;
        b=hat+nWifqN3fTy4majiQLLa60IrS6lqaawwIXTCwXTagYrl1ymiBE4txBumu+i+od8ckwL
        t08XJTyUrH+l5Jdsyf3Ue8jtOWwRTQWlFZNcWJHxEFaBkssVLG8fO8TJFPCDzI960TQlaO
        871VsY525NXj24bsPy11OO/RSne+PV0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-AHPZ-0BLMtSOAcWUBzuaug-1; Tue, 29 Mar 2022 17:53:33 -0400
X-MC-Unique: AHPZ-0BLMtSOAcWUBzuaug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AE37801585;
        Tue, 29 Mar 2022 21:53:33 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3547F2024CB7;
        Tue, 29 Mar 2022 21:53:33 +0000 (UTC)
Message-ID: <07be89ad-e355-69b9-6e36-07beaebf2d8b@redhat.com>
Date:   Tue, 29 Mar 2022 17:53:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH-mm v3] mm/list_lru: Optimize
 memcg_reparent_list_lru_node()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220309144000.1470138-1-longman@redhat.com>
 <CAMZfGtWS581YW4Y8oNU=E_zPnpK=mMdYVSG1F3U3fJNAzBzc+g@mail.gmail.com>
 <2263666d-5eef-b1fe-d5e3-b166a3185263@redhat.com>
 <CAMZfGtVG2YcmxY0fECkAYNb=sKXJQhWJqgtMTEpQwxXEXmSOLw@mail.gmail.com>
 <e93696b7-b678-6f41-9c1e-46aad447ce8d@redhat.com>
 <YkIIjGk5t4XorQXe@carbon.dhcp.thefacebook.com>
 <CAMZfGtXhoLso9FN_LwybqUHaZr28_hxmjeuA8T=zQdWWz=FDrA@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAMZfGtXhoLso9FN_LwybqUHaZr28_hxmjeuA8T=zQdWWz=FDrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/22 21:15, Muchun Song wrote:
> On Tue, Mar 29, 2022 at 3:12 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>> On Sun, Mar 27, 2022 at 08:57:15PM -0400, Waiman Long wrote:
>>> On 3/22/22 22:12, Muchun Song wrote:
>>>> On Wed, Mar 23, 2022 at 9:55 AM Waiman Long <longman@redhat.com> wrote:
>>>>> On 3/22/22 21:06, Muchun Song wrote:
>>>>>> On Wed, Mar 9, 2022 at 10:40 PM Waiman Long <longman@redhat.com> wrote:
>>>>>>> Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
>>>>>>> to be race free"), we are tracking the total number of lru
>>>>>>> entries in a list_lru_node in its nr_items field.  In the case of
>>>>>>> memcg_reparent_list_lru_node(), there is nothing to be done if nr_items
>>>>>>> is 0.  We don't even need to take the nlru->lock as no new lru entry
>>>>>>> could be added by a racing list_lru_add() to the draining src_idx memcg
>>>>>>> at this point.
>>>>>> Hi Waiman,
>>>>>>
>>>>>> Sorry for the late reply.  Quick question: what if there is an inflight
>>>>>> list_lru_add()?  How about the following race?
>>>>>>
>>>>>> CPU0:                               CPU1:
>>>>>> list_lru_add()
>>>>>>        spin_lock(&nlru->lock)
>>>>>>        l = list_lru_from_kmem(memcg)
>>>>>>                                        memcg_reparent_objcgs(memcg)
>>>>>>                                        memcg_reparent_list_lrus(memcg)
>>>>>>                                            memcg_reparent_list_lru()
>>>>>>                                                memcg_reparent_list_lru_node()
>>>>>>                                                    if (!READ_ONCE(nlru->nr_items))
>>>>>>                                                        // Miss reparenting
>>>>>>                                                        return
>>>>>>        // Assume 0->1
>>>>>>        l->nr_items++
>>>>>>        // Assume 0->1
>>>>>>        nlru->nr_items++
>>>>>>
>>>>>> IIUC, we use nlru->lock to serialise this scenario.
>>>>> I guess this race is theoretically possible but very unlikely since it
>>>>> means a very long pause between list_lru_from_kmem() and the increment
>>>>> of nr_items.
>>>> It is more possible in a VM.
>>>>
>>>>> How about the following changes to make sure that this race can't happen?
>>>>>
>>>>> diff --git a/mm/list_lru.c b/mm/list_lru.c
>>>>> index c669d87001a6..c31a0a8ad4e7 100644
>>>>> --- a/mm/list_lru.c
>>>>> +++ b/mm/list_lru.c
>>>>> @@ -395,9 +395,10 @@ static void memcg_reparent_list_lru_node(struct
>>>>> list_lru *lru, int nid,
>>>>>            struct list_lru_one *src, *dst;
>>>>>
>>>>>            /*
>>>>> -        * If there is no lru entry in this nlru, we can skip it
>>>>> immediately.
>>>>> +        * If there is no lru entry in this nlru and the nlru->lock is free,
>>>>> +        * we can skip it immediately.
>>>>>             */
>>>>> -       if (!READ_ONCE(nlru->nr_items))
>>>>> +       if (!READ_ONCE(nlru->nr_items) && !spin_is_locked(&nlru->lock))
>>>> I think we also should insert a smp_rmb() between those two loads.
>>> Thinking about this some more, I believe that adding spin_is_locked() check
>>> will be enough for x86. However, that will likely not be enough for arches
>>> with a more relaxed memory semantics. So the safest way to avoid this
>>> possible race is to move the check to within the lock critical section,
>>> though that comes with a slightly higher overhead for the 0 nr_items case. I
>>> will send out a patch to correct that. Thanks for bring this possible race
>>> to my attention.
>> Yes, I think it's not enough:
> I think it may be enough if we insert a smp_rmb() between those two loads.
>
>> CPU0                                       CPU1
>> READ_ONCE(&nlru->nr_items) -> 0
>>                                             spin_lock(&nlru->lock);
>>                                             nlru->nr_items++;
>                                               ^^^
>                                               |||
>                                               The nlr here is not the
> same as the one in CPU0,
>                                               since CPU0 have done the
> memcg reparting. Then
>                                               CPU0 will not miss nlru
> reparting.  If I am wrong, please
>                                               correct me.  Thanks.
>>                                             spin_unlock(&nlru->lock);
>> && !spin_is_locked(&nlru->lock) -> 0

I just realize that there is another lock/unlock pair in 
memcg_reparent_objcgs():

memcg_reparent_objcgs()
     spin_lock_irq()
     memcg reparenting
     spin_unlock_irq()
     percpu_ref_kill()
         spin_lock_irqsave()
         ...
         spin_unlock_irqrestore()

This lock/unlock pair in percpu_ref_kill() will stop the reordering of 
read/write before the memcg reparenting. Now I think just adding a 
spin_is_locked() check with smp_rmb() should be enough. However, I would 
like to change the ordering like that:

if (!spin_is_locked(&nlru->lock)) {
         smp_rmb();
         if (!READ_ONCE(nlru->nr_items))
                 return;
}

Otherwise, we will have the problem

list_lru_add()
       spin_lock(&nlru->lock)
       l = list_lru_from_kmem(memcg)
READ_ONCE(nlru->nr_items);
       // Assume 0->1
       l->nr_items++
       // Assume 0->1
       nlru->nr_items++
       spin_unlock(&nlru->lock)
                                       spin_is_locked()

If spin_is_locked() is before spin_lock() in list_lru_add(), 
list_lru_from_kmem() is guarantee to get the reparented memcg and so 
won't added to the reparented lru.

Thanks,
Longman


