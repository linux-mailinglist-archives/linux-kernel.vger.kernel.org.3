Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9853358F22A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiHJSKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiHJSKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:10:19 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4FA117B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:10:17 -0700 (PDT)
Date:   Wed, 10 Aug 2022 11:10:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660155016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zTuSuFtUPwcOmTfxvlWmgCK8CoOf1NlVunoS26Fz4FY=;
        b=gjJJ5MFRjkZZC95NgeuwwqFSHUptFn8KS1MWkoVoclKZftoX+0FmDlrVunyjPPkfXhU9T/
        cVP/ahEN3OonmyObzIVeae46k5Hgx9I8tPxnzFH0GBpaDD99boO2ObPyaSP21Pxbat5W8t
        jAzAqTtQ6x8un9faFNxL1KW3y+bs2YU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/slab_common: Deleting kobject in
 kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock
Message-ID: <YvP0ftGOZnoB0V6O@P9FQF9L96D.corp.robot.car>
References: <20220810164946.148634-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810164946.148634-1-longman@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 12:49:46PM -0400, Waiman Long wrote:
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
> cpu_hotplug_lock critical sections.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  [v2] Break kmem_cache_release() helper into 2 separate ones.
> 
>  mm/slab_common.c | 54 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 17996649cfe3..7742d0446d8b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -392,6 +392,36 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>  }
>  EXPORT_SYMBOL(kmem_cache_create);
>  
> +#ifdef SLAB_SUPPORTS_SYSFS
> +static void kmem_cache_workfn_release(struct kmem_cache *s)
> +{
> +	sysfs_slab_release(s);
> +}
> +#else
> +static void kmem_cache_workfn_release(struct kmem_cache *s)
> +{
> +	slab_kmem_cache_release(s);
> +}
> +#endif
> +
> +/*
> + * For a given kmem_cache, kmem_cache_destroy() should only be called
> + * once or there will be a use-after-free problem. The actual deletion
> + * and release of the kobject does not need slab_mutex or cpu_hotplug_lock
> + * protection. So they are now done without holding those locks.
> + */
> +static void kmem_cache_release(struct kmem_cache *s)
> +{
> +#ifdef SLAB_SUPPORTS_SYSFS
> +	sysfs_slab_unlink(s);
> +#endif
> +
> +	if (s->flags & SLAB_TYPESAFE_BY_RCU)
> +		schedule_work(&slab_caches_to_rcu_destroy_work);
> +	else
> +		kmem_cache_workfn_release(s);
> +}
> +
>  static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>  {
>  	LIST_HEAD(to_destroy);
> @@ -418,11 +448,7 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>  	list_for_each_entry_safe(s, s2, &to_destroy, list) {
>  		debugfs_slab_release(s);
>  		kfence_shutdown_cache(s);
> -#ifdef SLAB_SUPPORTS_SYSFS
> -		sysfs_slab_release(s);
> -#else
> -		slab_kmem_cache_release(s);
> -#endif
> +		kmem_cache_workfn_release(s);
>  	}
>  }
>  
> @@ -437,20 +463,10 @@ static int shutdown_cache(struct kmem_cache *s)
>  	list_del(&s->list);
>  
>  	if (s->flags & SLAB_TYPESAFE_BY_RCU) {
> -#ifdef SLAB_SUPPORTS_SYSFS
> -		sysfs_slab_unlink(s);
> -#endif
>  		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
> -		schedule_work(&slab_caches_to_rcu_destroy_work);

Hi Waiman!

This version is much more readable, thank you!

But can we, please, leave this schedule_work(&slab_caches_to_rcu_destroy_work)
call here? I don't see a good reason to move it, do I miss something?
It's nice to have list_add_tail() and schedule_work() calls nearby, so
it's obvious we can't miss the latter.

Thanks!
