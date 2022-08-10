Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17D58E9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiHJJfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiHJJfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:35:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A096CF46
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:35:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43ECD3458C;
        Wed, 10 Aug 2022 09:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660124099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQSwjPiKaiGHj/f8V1/GnqkouaKOzplWk5CMp2oq4Fk=;
        b=emeQYDqj0tovgbYqATK72rnUukDw5gKb++2YT8oC4dMxVGmfNN+fzty2iU0NzgUdwL4BIU
        ZoLMeDxbZ+De2FePQ8bdzBkFL58oyYlRLoekB3c/ce9+aGencVeznxWfKQovcCZRQzdvyl
        VKnnrRZS/DLV1PIDoDd29Pp8DVl9afY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660124099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQSwjPiKaiGHj/f8V1/GnqkouaKOzplWk5CMp2oq4Fk=;
        b=xNzhxFxRGPBn3fYPhoVReqHx1UBBH6BtRfLUMZfU/KFeq1VwT9PyFzjaFo2irA5YPiXTJy
        tMF3+ylRot+pNsDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D719813AB3;
        Wed, 10 Aug 2022 09:34:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mPEvM8J782JRIQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 10 Aug 2022 09:34:58 +0000
Message-ID: <48b66d90-34ae-8666-d9ee-2d36c82a6653@suse.cz>
Date:   Wed, 10 Aug 2022 11:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] mm/slab_common: Deleting kobject in kmem_cache_destroy()
 without holding slab_mutex/cpu_hotplug_lock
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Xin Long <lucien.xin@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220809205901.76595-1-longman@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220809205901.76595-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 22:59, Waiman Long wrote:
> A circular locking problem is reported by lockdep due to the following
> circular locking dependency.
> 
>    +--> cpu_hotplug_lock --> slab_mutex --> kn->active#126 --+
>    |                                                         |
>    +---------------------------------------------------------+

This sounded familiar and I've found a thread from January:

https://lore.kernel.org/all/388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com/

But that seemed to be specific to RHEL-8 RT kernel and not reproduced 
with mainline. Is it different this time? Can you share the splats?

> One way to break this circular locking chain is to avoid holding
> cpu_hotplug_lock and slab_mutex while deleting the kobject in
> sysfs_slab_unlink() which should be equivalent to doing a write_lock
> and write_unlock pair of the kn->active virtual lock.
> 
> Since the kobject structures are not protected by slab_mutex or the
> cpu_hotplug_lock, we can certainly release those locks before doing
> the delete operation.
> 
> Move sysfs_slab_unlink() and sysfs_slab_release() to the newly
> created kmem_cache_release() and call it outside the slab_mutex &
> cpu_hotplug_lock critical sections.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   mm/slab_common.c | 48 +++++++++++++++++++++++++++++++-----------------
>   1 file changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 17996649cfe3..9274fb03563e 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -392,6 +392,30 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>   }
>   EXPORT_SYMBOL(kmem_cache_create);
>   
> +#ifdef SLAB_SUPPORTS_SYSFS
> +/*
> + * For a given kmem_cache, kmem_cache_destroy() should only be called
> + * once or there will be a use-after-free problem. The actual deletion
> + * and release of the kobject does not need slab_mutex or cpu_hotplug_lock
> + * protection. So they are now done without holding those locks.
> + */
> +static void kmem_cache_release(struct kmem_cache *s, bool workfn)
> +{
> +	if (!workfn)
> +		sysfs_slab_unlink(s);
> +
> +	if (workfn || !(s->flags & SLAB_TYPESAFE_BY_RCU))
> +		sysfs_slab_release(s);
> +	else
> +		schedule_work(&slab_caches_to_rcu_destroy_work);
> +}
> +#else
> +static inline void kmem_cache_release(struct kmem_cache *s, bool workfn)
> +{
> +	slab_kmem_cache_release(s);
> +}
> +#endif
> +
>   static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>   {
>   	LIST_HEAD(to_destroy);
> @@ -418,11 +442,7 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>   	list_for_each_entry_safe(s, s2, &to_destroy, list) {
>   		debugfs_slab_release(s);
>   		kfence_shutdown_cache(s);
> -#ifdef SLAB_SUPPORTS_SYSFS
> -		sysfs_slab_release(s);
> -#else
> -		slab_kmem_cache_release(s);
> -#endif
> +		kmem_cache_release(s, true);
>   	}
>   }
>   
> @@ -437,20 +457,10 @@ static int shutdown_cache(struct kmem_cache *s)
>   	list_del(&s->list);
>   
>   	if (s->flags & SLAB_TYPESAFE_BY_RCU) {
> -#ifdef SLAB_SUPPORTS_SYSFS
> -		sysfs_slab_unlink(s);
> -#endif
>   		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
> -		schedule_work(&slab_caches_to_rcu_destroy_work);
>   	} else {
>   		kfence_shutdown_cache(s);
>   		debugfs_slab_release(s);
> -#ifdef SLAB_SUPPORTS_SYSFS
> -		sysfs_slab_unlink(s);
> -		sysfs_slab_release(s);
> -#else
> -		slab_kmem_cache_release(s);
> -#endif
>   	}
>   
>   	return 0;
> @@ -465,14 +475,16 @@ void slab_kmem_cache_release(struct kmem_cache *s)
>   
>   void kmem_cache_destroy(struct kmem_cache *s)
>   {
> +	int refcnt;
> +
>   	if (unlikely(!s) || !kasan_check_byte(s))
>   		return;
>   
>   	cpus_read_lock();
>   	mutex_lock(&slab_mutex);
>   
> -	s->refcount--;
> -	if (s->refcount)
> +	refcnt = --s->refcount;
> +	if (refcnt)
>   		goto out_unlock;
>   
>   	WARN(shutdown_cache(s),
> @@ -481,6 +493,8 @@ void kmem_cache_destroy(struct kmem_cache *s)
>   out_unlock:
>   	mutex_unlock(&slab_mutex);
>   	cpus_read_unlock();
> +	if (!refcnt)
> +		kmem_cache_release(s, false);
>   }
>   EXPORT_SYMBOL(kmem_cache_destroy);
>   

