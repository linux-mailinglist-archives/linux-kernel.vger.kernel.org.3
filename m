Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C1F58E32C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiHIW0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiHIW0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:26:17 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6C35D0FF
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:26:14 -0700 (PDT)
Date:   Tue, 9 Aug 2022 15:25:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660083972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hOnt2Z7v85TLJ7c4EagfbuOt1hNBAIsJlwJaIbi0B/k=;
        b=Rxnb7nBzIHrkN8GbjZULOtGCCexNPdqnvEmPDG5K/SP7Ugt2QYQYtVR1qWLBe0mggDxdJo
        EdcQXS/P8LMsRN+FfCYXKckwQLMJyom1+ULCj6DcSB/xOQgTX/E0GtgJWJrDkZ0XzC0fGD
        xMRaZwT1xiA+Rt7WT19Ek5pZbPbC1wc=
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
Subject: Re: [PATCH] mm/slab_common: Deleting kobject in kmem_cache_destroy()
 without holding slab_mutex/cpu_hotplug_lock
Message-ID: <YvLe8sZ25KiASXT1@P9FQF9L96D.corp.robot.car>
References: <20220809205901.76595-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809205901.76595-1-longman@redhat.com>
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

On Tue, Aug 09, 2022 at 04:59:01PM -0400, Waiman Long wrote:
> A circular locking problem is reported by lockdep due to the following
> circular locking dependency.
> 
>   +--> cpu_hotplug_lock --> slab_mutex --> kn->active#126 --+
>   |                                                         |
>   +---------------------------------------------------------+
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
>  mm/slab_common.c | 48 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 17996649cfe3..9274fb03563e 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -392,6 +392,30 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>  }
>  EXPORT_SYMBOL(kmem_cache_create);
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
>  static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>  {
>  	LIST_HEAD(to_destroy);
> @@ -418,11 +442,7 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>  	list_for_each_entry_safe(s, s2, &to_destroy, list) {
>  		debugfs_slab_release(s);
>  		kfence_shutdown_cache(s);
> -#ifdef SLAB_SUPPORTS_SYSFS
> -		sysfs_slab_release(s);
> -#else
> -		slab_kmem_cache_release(s);
> -#endif
> +		kmem_cache_release(s, true);

Hi Waiman!

As I understand, with SLAB_SUPPORTS_SYSFS kmem_cache_release() can effectively call
into itself: first it's called with workfn == false from shutdown_cache() and
then optionally it's scheduled to call itself from a work context with
workfn == true just to call sysfs_slab_release(). Is it right?

If !SLAB_SUPPORTS_SYSFS, shutdown_cache() optionally adds kmem_cache to the
slab_caches_to_rcu_destroy list and calls kmem_cache_release(s, false) ==
slab_kmem_cache_release(). How it's then removed from the list?

Overall the patch is a bit hard to follow (not like this code was easy to read
before, so can't blame the patch). But I wonder if it will make things simpler
to decouple kmem_cache_release(workfn == true) and kmem_cache_release(workfn == false)
into 2 different helpers? Or at least add a bold comment on how things are supposed
to work.

Thanks!
