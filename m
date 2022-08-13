Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7511591B33
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbiHMPBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiHMPBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:01:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CD1E09D
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 08:01:05 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bh13so3092037pgb.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=QiqCev7SjvOWKNNl+hDjUBDJkQvgTrLbkZw98Qqxk70=;
        b=ERPwgAquhldV9Lao9bt3DOyrwIEOHvpV8mjiwyMqzztYaV+Qs7fDZ9aLffZ+ffWj6B
         LD0oToVrrj1+879zUEzE2gvNyg0vkYBHCrQ3ohRL6H5Eh9c+AmjTwVZeoGOuzeHUIX4/
         UidNqrwhKyeAn5hMG9kXmqFfta60uv62Q44DJ1lt3ynXGZa4Lk153zK5mir2cVvrOZRZ
         84d5RiT30TGVFAfc92D7dKWSXnOpAEkq3gJs7x2pMtCzvgIgOh7yhR7u/cqewFAYioYv
         7NDTpv2WaQKwVVzb2XxOVY4q7dNmBHYNRSFJRr2nhOuugNwYkAIsDIzbq+fZcEJlKn4C
         9jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=QiqCev7SjvOWKNNl+hDjUBDJkQvgTrLbkZw98Qqxk70=;
        b=tjd+TUNFwVfLnbdDwDgwX7YV6oc5Mhq1nFWlpR2OgsCX2B0vA4Up0BH8ElXgitJnCU
         Cr7mKVTNAZge6+Xbtg+bu+rM+Dt83E0I31/KCNLibJf6S6s6wibte5KnWCqu1z0DUFux
         3DQibLGtxOKr+0bPAyDi5pkFdpOW6b2il/WAqk+OKaFbnA5tyRxSPjLEtZZBsAQldfty
         OHidXPf+cGfi53YvYuxApPk1GoMFmiOQ3KjJTb+eWy3CmhnqKjRxTyO5k4eGhr8d2Gng
         7vL03sGdr/8nS8t/8AaomAL4cX0agWauWflKFpByDe03OtSzcg6eHW8wMLp7PDQQmHqf
         EC0Q==
X-Gm-Message-State: ACgBeo3VU9oRh3o5JNk5Llyqm0gdqe6TkRG7H6P1Vvv+eY1f+tKFwu6C
        amHoBslxwkzpGDkBFtVJWpw=
X-Google-Smtp-Source: AA6agR5olXFk9GY/Fk0KTm+LgbNHC4nyJYZJobVnKm6MiOqEFVE8HFrztfSEmVpGNCBc1epxFziCQA==
X-Received: by 2002:a63:5a4d:0:b0:41b:7702:635f with SMTP id k13-20020a635a4d000000b0041b7702635fmr7249032pgm.111.1660402865394;
        Sat, 13 Aug 2022 08:01:05 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b00172543d7cdcsm2623630pli.91.2022.08.13.08.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 08:01:04 -0700 (PDT)
Date:   Sun, 14 Aug 2022 00:00:58 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/slab_common: Deleting kobject in
 kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock
Message-ID: <Yve8qkl2NjtnA6nF@hyeyoo>
References: <20220812183033.346425-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812183033.346425-1-longman@redhat.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 02:30:33PM -0400, Waiman Long wrote:
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

Maybe you mean this?

        /* but everyone should wait for draining */
        wait_event(root->deactivate_waitq,
                   atomic_read(&kn->active) == KN_DEACTIVATED_BIAS);


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
> -- 
> 2.31.1
> 

little bit complicated but looks good to me.
Thank you for fixing this.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
