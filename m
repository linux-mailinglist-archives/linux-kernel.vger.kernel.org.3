Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3B058E38D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiHIXFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHIXFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC07B165B1
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660086343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQQjxvyb8CLjve4FfHQqn1TrKDgNJT0ViQGm4zbKbG8=;
        b=H3fcP2fPw9rZ8qh3eTghTXiLEAnTjy4Q+c850GeWFSGP8oksa31YZTr8QD/DWLaHbh91L7
        I98C8rOEQvvj+MDxGlXyOltbDmDGMRHRKyz1ve8IMI067ragWHhYU0pqcm/GbJ0V6IUAXg
        Y2acfKsEscOwSA1FnxREe3StQzc8Nm8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-Z4DTJHyIO2Kbdfdv2o53dg-1; Tue, 09 Aug 2022 19:05:39 -0400
X-MC-Unique: Z4DTJHyIO2Kbdfdv2o53dg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7E078117B0;
        Tue,  9 Aug 2022 23:05:38 +0000 (UTC)
Received: from [10.22.18.32] (unknown [10.22.18.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F910492C3B;
        Tue,  9 Aug 2022 23:05:38 +0000 (UTC)
Message-ID: <521f2fbe-3732-0829-3562-2b113eb7b7e4@redhat.com>
Date:   Tue, 9 Aug 2022 19:05:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/slab_common: Deleting kobject in kmem_cache_destroy()
 without holding slab_mutex/cpu_hotplug_lock
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220809205901.76595-1-longman@redhat.com>
 <YvLe8sZ25KiASXT1@P9FQF9L96D.corp.robot.car>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YvLe8sZ25KiASXT1@P9FQF9L96D.corp.robot.car>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 18:25, Roman Gushchin wrote:
> On Tue, Aug 09, 2022 at 04:59:01PM -0400, Waiman Long wrote:
>> A circular locking problem is reported by lockdep due to the following
>> circular locking dependency.
>>
>>    +--> cpu_hotplug_lock --> slab_mutex --> kn->active#126 --+
>>    |                                                         |
>>    +---------------------------------------------------------+
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
>> cpu_hotplug_lock critical sections.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/slab_common.c | 48 +++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 31 insertions(+), 17 deletions(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 17996649cfe3..9274fb03563e 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -392,6 +392,30 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>>   }
>>   EXPORT_SYMBOL(kmem_cache_create);
>>   
>> +#ifdef SLAB_SUPPORTS_SYSFS
>> +/*
>> + * For a given kmem_cache, kmem_cache_destroy() should only be called
>> + * once or there will be a use-after-free problem. The actual deletion
>> + * and release of the kobject does not need slab_mutex or cpu_hotplug_lock
>> + * protection. So they are now done without holding those locks.
>> + */
>> +static void kmem_cache_release(struct kmem_cache *s, bool workfn)
>> +{
>> +	if (!workfn)
>> +		sysfs_slab_unlink(s);
>> +
>> +	if (workfn || !(s->flags & SLAB_TYPESAFE_BY_RCU))
>> +		sysfs_slab_release(s);
>> +	else
>> +		schedule_work(&slab_caches_to_rcu_destroy_work);
>> +}
>> +#else
>> +static inline void kmem_cache_release(struct kmem_cache *s, bool workfn)
>> +{
>> +	slab_kmem_cache_release(s);
>> +}
>> +#endif
>> +
>>   static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>>   {
>>   	LIST_HEAD(to_destroy);
>> @@ -418,11 +442,7 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>>   	list_for_each_entry_safe(s, s2, &to_destroy, list) {
>>   		debugfs_slab_release(s);
>>   		kfence_shutdown_cache(s);
>> -#ifdef SLAB_SUPPORTS_SYSFS
>> -		sysfs_slab_release(s);
>> -#else
>> -		slab_kmem_cache_release(s);
>> -#endif
>> +		kmem_cache_release(s, true);
> Hi Waiman!
>
> As I understand, with SLAB_SUPPORTS_SYSFS kmem_cache_release() can effectively call
> into itself: first it's called with workfn == false from shutdown_cache() and
> then optionally it's scheduled to call itself from a work context with
> workfn == true just to call sysfs_slab_release(). Is it right?
>
> If !SLAB_SUPPORTS_SYSFS, shutdown_cache() optionally adds kmem_cache to the
> slab_caches_to_rcu_destroy list and calls kmem_cache_release(s, false) ==
> slab_kmem_cache_release(). How it's then removed from the list?
>
> Overall the patch is a bit hard to follow (not like this code was easy to read
> before, so can't blame the patch). But I wonder if it will make things simpler
> to decouple kmem_cache_release(workfn == true) and kmem_cache_release(workfn == false)
> into 2 different helpers? Or at least add a bold comment on how things are supposed
> to work.
>
> Thanks!

You are right. I agree that it can be hard to read. Simpler is always 
better. Will post a v2 with the change suggested.

Thanks,
Longman

