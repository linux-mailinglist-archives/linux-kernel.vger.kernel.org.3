Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E837058F280
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiHJSqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiHJSqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 722676052F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660157159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vap7a99o24vJ9gF26JY37jOu10iwst4opAFZ2NW/EBw=;
        b=YHIkg1Z2KAL9gxCNr8q+uA7aSdi9ID09qJB4C4b1QF4dexACK1T4wiLJ2Id3iUGYe3gNST
        GL6C+MSZ2DTplTy7YY6cZUMaYUnBI4697oMU0D5j9Kr5F1w/6UczvskDADIxyYy7JJCMXz
        mpF6GutNIY3GUEnr5d/0em2CcgIZFzo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-Jm0bHJ5fOiWgNLnnaHgzyg-1; Wed, 10 Aug 2022 14:45:54 -0400
X-MC-Unique: Jm0bHJ5fOiWgNLnnaHgzyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01B7C85A59A;
        Wed, 10 Aug 2022 18:45:54 +0000 (UTC)
Received: from [10.22.9.72] (unknown [10.22.9.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 536A818EAA;
        Wed, 10 Aug 2022 18:45:53 +0000 (UTC)
Message-ID: <a7b7ce5d-631b-c17c-1566-d3fa665de60f@redhat.com>
Date:   Wed, 10 Aug 2022 14:45:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] mm/slab_common: Deleting kobject in
 kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220810164946.148634-1-longman@redhat.com>
 <YvP0ftGOZnoB0V6O@P9FQF9L96D.corp.robot.car>
 <9b95dc38-9a3f-b9f1-80cc-c834621bd81c@redhat.com>
In-Reply-To: <9b95dc38-9a3f-b9f1-80cc-c834621bd81c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 14:27, Waiman Long wrote:
> On 8/10/22 14:10, Roman Gushchin wrote:
>> On Wed, Aug 10, 2022 at 12:49:46PM -0400, Waiman Long wrote:
>>> A circular locking problem is reported by lockdep due to the following
>>> circular locking dependency.
>>>
>>>    +--> cpu_hotplug_lock --> slab_mutex --> kn->active --+
>>>    |                                                     |
>>>    +-----------------------------------------------------+
>>>
>>> The forward cpu_hotplug_lock ==> slab_mutex ==> kn->active dependency
>>> happens in
>>>
>>>    kmem_cache_destroy():    cpus_read_lock(); mutex_lock(&slab_mutex);
>>>    ==> sysfs_slab_unlink()
>>>        ==> kobject_del()
>>>            ==> kernfs_remove()
>>>           ==> __kernfs_remove()
>>>               ==> kernfs_drain(): rwsem_acquire(&kn->dep_map, ...);
>>>
>>> The backward kn->active ==> cpu_hotplug_lock dependency happens in
>>>
>>>    kernfs_fop_write_iter(): kernfs_get_active();
>>>    ==> slab_attr_store()
>>>        ==> cpu_partial_store()
>>>            ==> flush_all(): cpus_read_lock()
>>>
>>> One way to break this circular locking chain is to avoid holding
>>> cpu_hotplug_lock and slab_mutex while deleting the kobject in
>>> sysfs_slab_unlink() which should be equivalent to doing a write_lock
>>> and write_unlock pair of the kn->active virtual lock.
>>>
>>> Since the kobject structures are not protected by slab_mutex or the
>>> cpu_hotplug_lock, we can certainly release those locks before doing
>>> the delete operation.
>>>
>>> Move sysfs_slab_unlink() and sysfs_slab_release() to the newly
>>> created kmem_cache_release() and call it outside the slab_mutex &
>>> cpu_hotplug_lock critical sections.
>>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   [v2] Break kmem_cache_release() helper into 2 separate ones.
>>>
>>>   mm/slab_common.c | 54 
>>> +++++++++++++++++++++++++++++++++---------------
>>>   1 file changed, 37 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>>> index 17996649cfe3..7742d0446d8b 100644
>>> --- a/mm/slab_common.c
>>> +++ b/mm/slab_common.c
>>> @@ -392,6 +392,36 @@ kmem_cache_create(const char *name, unsigned 
>>> int size, unsigned int align,
>>>   }
>>>   EXPORT_SYMBOL(kmem_cache_create);
>>>   +#ifdef SLAB_SUPPORTS_SYSFS
>>> +static void kmem_cache_workfn_release(struct kmem_cache *s)
>>> +{
>>> +    sysfs_slab_release(s);
>>> +}
>>> +#else
>>> +static void kmem_cache_workfn_release(struct kmem_cache *s)
>>> +{
>>> +    slab_kmem_cache_release(s);
>>> +}
>>> +#endif
>>> +
>>> +/*
>>> + * For a given kmem_cache, kmem_cache_destroy() should only be called
>>> + * once or there will be a use-after-free problem. The actual deletion
>>> + * and release of the kobject does not need slab_mutex or 
>>> cpu_hotplug_lock
>>> + * protection. So they are now done without holding those locks.
>>> + */
>>> +static void kmem_cache_release(struct kmem_cache *s)
>>> +{
>>> +#ifdef SLAB_SUPPORTS_SYSFS
>>> +    sysfs_slab_unlink(s);
>>> +#endif
>>> +
>>> +    if (s->flags & SLAB_TYPESAFE_BY_RCU)
>>> +        schedule_work(&slab_caches_to_rcu_destroy_work);
>>> +    else
>>> +        kmem_cache_workfn_release(s);
>>> +}
>>> +
>>>   static void slab_caches_to_rcu_destroy_workfn(struct work_struct 
>>> *work)
>>>   {
>>>       LIST_HEAD(to_destroy);
>>> @@ -418,11 +448,7 @@ static void 
>>> slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>>>       list_for_each_entry_safe(s, s2, &to_destroy, list) {
>>>           debugfs_slab_release(s);
>>>           kfence_shutdown_cache(s);
>>> -#ifdef SLAB_SUPPORTS_SYSFS
>>> -        sysfs_slab_release(s);
>>> -#else
>>> -        slab_kmem_cache_release(s);
>>> -#endif
>>> +        kmem_cache_workfn_release(s);
>>>       }
>>>   }
>>>   @@ -437,20 +463,10 @@ static int shutdown_cache(struct kmem_cache *s)
>>>       list_del(&s->list);
>>>         if (s->flags & SLAB_TYPESAFE_BY_RCU) {
>>> -#ifdef SLAB_SUPPORTS_SYSFS
>>> -        sysfs_slab_unlink(s);
>>> -#endif
>>>           list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
>>> -        schedule_work(&slab_caches_to_rcu_destroy_work);
>> Hi Waiman!
>>
>> This version is much more readable, thank you!
>>
>> But can we, please, leave this 
>> schedule_work(&slab_caches_to_rcu_destroy_work)
>> call here? I don't see a good reason to move it, do I miss something?
>> It's nice to have list_add_tail() and schedule_work() calls nearby, so
>> it's obvious we can't miss the latter.
>
> The reason that I need to move out schedule_work() as well is to make 
> sure that sysfs_slab_unlink() is called before sysfs_slab_release(). I 
> can't guarantee that if I do schedule_work() first. On the other hand, 
> moving sysfs_slab_unlink() into kmem_cache_workfn_release() introduces 
> unknown delay of when the sysfs file will be removed. I can add some 
> comment to make it more clear.

OK, I just realize that the current patch doesn't have the ordering 
guarantee either if another kmem_cache_destroy() is happening in 
parallel. I will have to push sysfs_slab_unlink() into 
kmem_cache_workfn_release() and tolerate some delay in the disappearance 
of the sysfs files. Now I can move schedule_work() back to after 
list_add_tail().

Cheers,
Longman

