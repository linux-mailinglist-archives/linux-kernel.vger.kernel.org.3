Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B54B593063
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbiHOOBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241073AbiHOOBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC582A478
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660572072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bc2CaX7Vyv8jSZVbk9O/eBQgCcbOhmOwLMqxv9AfCMo=;
        b=co8OATdcPpmIc0u4Kd0nPwn9Y1qhsySE1c+XbOEc7dWjSJ2y99kHbaEQkeJiUczayoVxWD
        TP0DVCV+iIt2QMLVlzYSRKLjAtxqrGs4wGC5TcCUcp+rBKw8kiPZufe9k8CzlGWTzQ1p6W
        LZYb2hW6O94wc95u72joXG2oOrXkyYw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113--DWdlP5gMXKGfAzb3eMupw-1; Mon, 15 Aug 2022 10:01:11 -0400
X-MC-Unique: -DWdlP5gMXKGfAzb3eMupw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 675FC100AF8F;
        Mon, 15 Aug 2022 14:01:09 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14A60403178;
        Mon, 15 Aug 2022 14:01:08 +0000 (UTC)
Message-ID: <1b10858e-7dd7-75bf-3366-8ccdb48652ac@redhat.com>
Date:   Mon, 15 Aug 2022 10:01:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] mm/slab_common: Deleting kobject in
 kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220812183033.346425-1-longman@redhat.com>
 <Yve8qkl2NjtnA6nF@hyeyoo>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yve8qkl2NjtnA6nF@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/22 11:00, Hyeonggon Yoo wrote:
> On Fri, Aug 12, 2022 at 02:30:33PM -0400, Waiman Long wrote:
>> A circular locking problem is reported by lockdep due to the following
>> circular locking dependency.
>>
>>    +--> cpu_hotplug_lock --> slab_mutex --> kn->active --+
>>    |                                                     |
>>    +-----------------------------------------------------+
>>
>> The forward cpu_hotplug_lock ==> slab_mutex ==> kn->active dependency
>> happens in
>>
>>    kmem_cache_destroy():	cpus_read_lock(); mutex_lock(&slab_mutex);
>>    ==> sysfs_slab_unlink()
>>        ==> kobject_del()
>>            ==> kernfs_remove()
>> 	      ==> __kernfs_remove()
>> 	          ==> kernfs_drain(): rwsem_acquire(&kn->dep_map, ...);
> Maybe you mean this?
>
>          /* but everyone should wait for draining */
>          wait_event(root->deactivate_waitq,
>                     atomic_read(&kn->active) == KN_DEACTIVATED_BIAS);
>
This is part of the kernfs_drain() operation. However, I am focusing on 
the behavior of the pseudo lock that causes the lockdep splat in the 
first place. That is why I am showcasing the rwsem_acquire() call here.


>> The backward kn->active ==> cpu_hotplug_lock dependency happens in
>>
>>    kernfs_fop_write_iter(): kernfs_get_active();
>>    ==> slab_attr_store()
>>        ==> cpu_partial_store()
>>            ==> flush_all(): cpus_read_lock()
>>
>> One way to break this circular locking chain is to avoid holding
>> cpu_hotplug_lock and slab_mutex while deleting the kobject in
>> sysfs_slab_unlink() which should be equivalent to doing a write_lock
>> and write_unlock pair of the kn->active virtual lock.
>>
>> Since the kobject structures are not protected by slab_mutex or the
>> cpu_hotplug_lock, we can certainly release those locks before doing
>> the delete operation.
>>
>> Move sysfs_slab_unlink() and sysfs_slab_release() to the newly
>> created kmem_cache_release() and call it outside the slab_mutex &
>> cpu_hotplug_lock critical sections. There will be a slight delay
>> in the deletion of sysfs files if kmem_cache_release() is called
>> indirectly from a work function.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>
>>   [v3] Move sysfs_slab_unlink() out to kmem_cache_release() and move
>>        schedule_work() back right after list_add_tail().
>>
>>   mm/slab_common.c | 45 +++++++++++++++++++++++++++++----------------
>>   1 file changed, 29 insertions(+), 16 deletions(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 17996649cfe3..07b948288f84 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -392,6 +392,28 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>>   }
>>   EXPORT_SYMBOL(kmem_cache_create);
>>   
>> +#ifdef SLAB_SUPPORTS_SYSFS
>> +/*
>> + * For a given kmem_cache, kmem_cache_destroy() should only be called
>> + * once or there will be a use-after-free problem. The actual deletion
>> + * and release of the kobject does not need slab_mutex or cpu_hotplug_lock
>> + * protection. So they are now done without holding those locks.
>> + *
>> + * Note that there will be a slight delay in the deletion of sysfs files
>> + * if kmem_cache_release() is called indrectly from a work function.
>> + */
>> +static void kmem_cache_release(struct kmem_cache *s)
>> +{
>> +	sysfs_slab_unlink(s);
>> +	sysfs_slab_release(s);
>> +}
>> +#else
>> +static void kmem_cache_release(struct kmem_cache *s)
>> +{
>> +	slab_kmem_cache_release(s);
>> +}
>> +#endif
>> +
>>   static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>>   {
>>   	LIST_HEAD(to_destroy);
>> @@ -418,11 +440,7 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>>   	list_for_each_entry_safe(s, s2, &to_destroy, list) {
>>   		debugfs_slab_release(s);
>>   		kfence_shutdown_cache(s);
>> -#ifdef SLAB_SUPPORTS_SYSFS
>> -		sysfs_slab_release(s);
>> -#else
>> -		slab_kmem_cache_release(s);
>> -#endif
>> +		kmem_cache_release(s);
>>   	}
>>   }
>>   
>> @@ -437,20 +455,11 @@ static int shutdown_cache(struct kmem_cache *s)
>>   	list_del(&s->list);
>>   
>>   	if (s->flags & SLAB_TYPESAFE_BY_RCU) {
>> -#ifdef SLAB_SUPPORTS_SYSFS
>> -		sysfs_slab_unlink(s);
>> -#endif
>>   		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
>>   		schedule_work(&slab_caches_to_rcu_destroy_work);
>>   	} else {
>>   		kfence_shutdown_cache(s);
>>   		debugfs_slab_release(s);
>> -#ifdef SLAB_SUPPORTS_SYSFS
>> -		sysfs_slab_unlink(s);
>> -		sysfs_slab_release(s);
>> -#else
>> -		slab_kmem_cache_release(s);
>> -#endif
>>   	}
>>   
>>   	return 0;
>> @@ -465,14 +474,16 @@ void slab_kmem_cache_release(struct kmem_cache *s)
>>   
>>   void kmem_cache_destroy(struct kmem_cache *s)
>>   {
>> +	int refcnt;
>> +
>>   	if (unlikely(!s) || !kasan_check_byte(s))
>>   		return;
>>   
>>   	cpus_read_lock();
>>   	mutex_lock(&slab_mutex);
>>   
>> -	s->refcount--;
>> -	if (s->refcount)
>> +	refcnt = --s->refcount;
>> +	if (refcnt)
>>   		goto out_unlock;
>>   
>>   	WARN(shutdown_cache(s),
>> @@ -481,6 +492,8 @@ void kmem_cache_destroy(struct kmem_cache *s)
>>   out_unlock:
>>   	mutex_unlock(&slab_mutex);
>>   	cpus_read_unlock();
>> +	if (!refcnt && !(s->flags & SLAB_TYPESAFE_BY_RCU))
>> +		kmem_cache_release(s);
>>   }
>>   EXPORT_SYMBOL(kmem_cache_destroy);
>>   
>> -- 
>> 2.31.1
>>
> little bit complicated but looks good to me.
> Thank you for fixing this.
>
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>
Thanks for the review.

Cheers,
Longman

