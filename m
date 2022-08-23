Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA37259E634
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbiHWPlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243510AbiHWPkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:40:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B765283C47
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:34:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 45F511FB68;
        Tue, 23 Aug 2022 11:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661254407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hH3pElKLVEACEg6paPrYzIjRh821NDe2aASfVrh8O7w=;
        b=V5iMWzi+6jSrWL6e9jNE3QUQCxfoXWLwEkwCfaiPi62PeYZbeiHod98X2YPiTp7s/BvyFG
        YEOBGoDscpuJOjpdgvg1YAfVNIvWxrmG74i4kaLXolEwfEGBTNTWzIMR2OlYVAMr+NHAtk
        gKNzfo333vX6J7dsDW2Z3agk5Ve+qtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661254407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hH3pElKLVEACEg6paPrYzIjRh821NDe2aASfVrh8O7w=;
        b=2ctTKiNDfrGEki/5hmuPX4OGQMQN8GoXLbGhKHaidvbZUpq7g7kQfViFPn1aAK/AmA7Bdi
        ZSe2rbE0ewz6IdDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16ACA13A89;
        Tue, 23 Aug 2022 11:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /mfiBAe7BGMKLgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 23 Aug 2022 11:33:27 +0000
Message-ID: <093f6a32-40f8-78ea-0070-600cfe08a3dd@suse.cz>
Date:   Tue, 23 Aug 2022 13:33:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3] mm/slab_common: Deleting kobject in
 kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock
To:     Waiman Long <longman@redhat.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220812183033.346425-1-longman@redhat.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220812183033.346425-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
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

On 8/12/22 20:30, Waiman Long wrote:
> A circular locking problem is reported by lockdep due to the following
> circular locking dependency.
> 
>   +--> cpu_hotplug_lock --> slab_mutex --> kn->active --+
>   |                                                     |
>   +-----------------------------------------------------+
> 
> The forward cpu_hotplug_lock ==> slab_mutex ==> kn->active dependency
> happens in
> 
>   kmem_cache_destroy():	cpus_read_lock(); mutex_lock(&slab_mutex);
>   ==> sysfs_slab_unlink()
>       ==> kobject_del()
>           ==> kernfs_remove()
> 	      ==> __kernfs_remove()
> 	          ==> kernfs_drain(): rwsem_acquire(&kn->dep_map, ...);
> 
> The backward kn->active ==> cpu_hotplug_lock dependency happens in
> 
>   kernfs_fop_write_iter(): kernfs_get_active();
>   ==> slab_attr_store()
>       ==> cpu_partial_store()
>           ==> flush_all(): cpus_read_lock()
> 
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
> cpu_hotplug_lock critical sections. There will be a slight delay
> in the deletion of sysfs files if kmem_cache_release() is called
> indirectly from a work function.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Thanks, added to slab.git for-6.0/fixes

> ---
> 
>  [v3] Move sysfs_slab_unlink() out to kmem_cache_release() and move
>       schedule_work() back right after list_add_tail().
> 
>  mm/slab_common.c | 45 +++++++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 17996649cfe3..07b948288f84 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -392,6 +392,28 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>  }
>  EXPORT_SYMBOL(kmem_cache_create);
>  
> +#ifdef SLAB_SUPPORTS_SYSFS
> +/*
> + * For a given kmem_cache, kmem_cache_destroy() should only be called
> + * once or there will be a use-after-free problem. The actual deletion
> + * and release of the kobject does not need slab_mutex or cpu_hotplug_lock
> + * protection. So they are now done without holding those locks.
> + *
> + * Note that there will be a slight delay in the deletion of sysfs files
> + * if kmem_cache_release() is called indrectly from a work function.
> + */
> +static void kmem_cache_release(struct kmem_cache *s)
> +{
> +	sysfs_slab_unlink(s);
> +	sysfs_slab_release(s);
> +}
> +#else
> +static void kmem_cache_release(struct kmem_cache *s)
> +{
> +	slab_kmem_cache_release(s);
> +}
> +#endif
> +
>  static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>  {
>  	LIST_HEAD(to_destroy);
> @@ -418,11 +440,7 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>  	list_for_each_entry_safe(s, s2, &to_destroy, list) {
>  		debugfs_slab_release(s);
>  		kfence_shutdown_cache(s);
> -#ifdef SLAB_SUPPORTS_SYSFS
> -		sysfs_slab_release(s);
> -#else
> -		slab_kmem_cache_release(s);
> -#endif
> +		kmem_cache_release(s);
>  	}
>  }
>  
> @@ -437,20 +455,11 @@ static int shutdown_cache(struct kmem_cache *s)
>  	list_del(&s->list);
>  
>  	if (s->flags & SLAB_TYPESAFE_BY_RCU) {
> -#ifdef SLAB_SUPPORTS_SYSFS
> -		sysfs_slab_unlink(s);
> -#endif
>  		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
>  		schedule_work(&slab_caches_to_rcu_destroy_work);
>  	} else {
>  		kfence_shutdown_cache(s);
>  		debugfs_slab_release(s);
> -#ifdef SLAB_SUPPORTS_SYSFS
> -		sysfs_slab_unlink(s);
> -		sysfs_slab_release(s);
> -#else
> -		slab_kmem_cache_release(s);
> -#endif
>  	}
>  
>  	return 0;
> @@ -465,14 +474,16 @@ void slab_kmem_cache_release(struct kmem_cache *s)
>  
>  void kmem_cache_destroy(struct kmem_cache *s)
>  {
> +	int refcnt;
> +
>  	if (unlikely(!s) || !kasan_check_byte(s))
>  		return;
>  
>  	cpus_read_lock();
>  	mutex_lock(&slab_mutex);
>  
> -	s->refcount--;
> -	if (s->refcount)
> +	refcnt = --s->refcount;
> +	if (refcnt)
>  		goto out_unlock;
>  
>  	WARN(shutdown_cache(s),
> @@ -481,6 +492,8 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  out_unlock:
>  	mutex_unlock(&slab_mutex);
>  	cpus_read_unlock();
> +	if (!refcnt && !(s->flags & SLAB_TYPESAFE_BY_RCU))
> +		kmem_cache_release(s);
>  }
>  EXPORT_SYMBOL(kmem_cache_destroy);
>  

