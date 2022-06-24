Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E8E559831
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiFXKvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiFXKvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:51:33 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A6D77067
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:51:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a11so2335487ljb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VVdVoriFTTZ0urHLWQjQBVbWJmfMU1gs2MgGoST5750=;
        b=NYt0TzaHSKuRUcJMGZ85sOZjvH/B3EqCmReyoezpxdGCDG/DJ+yrMZzNKU47s2tXuX
         VRGQ4rb2WHn8yJXElXGzyF0/GHl8lHnnHJ7PD9WV3ueCnSAseuYFc3c0aVUv1BfdH/5f
         JPVrTRpoX90LlbMXJ/Ni9Pm1QFanKmxKzT1CNRXBstrgc+O+8SgBOqtFAdKRu5C+q3AF
         fzQAhaJwVvCKmvaZUWeca2B5s0P0MRlxQCQ/QxXPnseFqqDqr99bOE72u0SpcI6fgCuR
         fVS7Y4DS2U//Ls9Jt84YMWEBnLAvIqIrRtzONYCeH+KVJfXE+Fkv0gZaNuRPXBx9MadE
         VDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VVdVoriFTTZ0urHLWQjQBVbWJmfMU1gs2MgGoST5750=;
        b=mIkJdjcqHh0mNegMQ3M9/o0UIZHhFPwP7S3SQ5+Lwm+UK2ANiBLPHCBezc2WXJbv4j
         p/l5NBYaVbTW7It1e48Gs6JwO28eRqlIK8/bcb+6dIsjjkCwekuVt5NFEaf2Aj7wp3hR
         cUlQGmCnqyfVQGb3k03D1sAcRbmBQY3y/0uFPCyNNpIORGotZitqLl8zLahFlVpFCEHk
         OHOmt6o3NjDgRmZ4tIedxoVZdtQi+eaw0IjVuomZiXbupb8jTK0EV56O2nZtFdanB0GQ
         tyhpSIhhBR3YxcKNeBNoKQeeqqwznU7+j9mbw+N1jsADASSHcUnQSiPrhSV3Yterv33p
         y6pQ==
X-Gm-Message-State: AJIora8c8N6kShh6Jxi1s/WoLi1uzON/myTup9xPNjjCnRN9Ti7/I6ai
        h6zQ61H1XwECT81H66uh9fk=
X-Google-Smtp-Source: AGRyM1uK6P85QaCG7dgDniX4DuVUpbVWnR7BSyMDhgyXgZ/DWLG/dluwFErL+aRNM3KUQp5Rk7nxkA==
X-Received: by 2002:a2e:934f:0:b0:24f:ea1:6232 with SMTP id m15-20020a2e934f000000b0024f0ea16232mr7283981ljh.135.1656067889625;
        Fri, 24 Jun 2022 03:51:29 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id z9-20020a0565120c0900b004793240041esm304778lfu.277.2022.06.24.03.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 03:51:29 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 24 Jun 2022 12:51:27 +0200
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm: fix racing of vb->va when kasan enabled
Message-ID: <YrWXL8ZeE7VK31Rz@pc638.lan>
References: <Yq+PMWlARgDhv8uL@pc638.lan>
 <CAGWkznHPdk_yqn2GWPDJaT32+4MnFLnRjdjBkaFv9BLMh4yM=g@mail.gmail.com>
 <CA+KHdyXpdow7SYsbq_7F0zDd5-nYGi6db7R11R3--g3gUu-59w@mail.gmail.com>
 <CAGWkznE5cFfdtmQ2j57goWtpfPGYPsd5Oi3pvb9vcfifodR9OQ@mail.gmail.com>
 <YrGO4cae/03r3PzP@pc638.lan>
 <CAGWkznFdZ1_jrSWSOPkSDyLY1OSodZBy6MTfdwPKo3VoW67GBg@mail.gmail.com>
 <YrHVsryZlnpO/Vha@pc638.lan>
 <CAGWkznEha+6aPi6hoqzSt0ZKpY2_0P4gFx-OFxufqDt6sZc9kw@mail.gmail.com>
 <CAGWkznFx87C=z0ELALyBXdd=CNHAebG3oMNBbeGTC_j50xrYLw@mail.gmail.com>
 <YrWRnSTeDYNFl0wr@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrWRnSTeDYNFl0wr@pc638.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Wed, Jun 22, 2022 at 11:15 AM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> > >
> > > On Tue, Jun 21, 2022 at 10:29 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > > On Tue, Jun 21, 2022 at 5:27 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > >
> > > > > > > On Mon, Jun 20, 2022 at 6:44 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > Is it easy to reproduce? If so could you please describe the steps? As i see
> > > > > > > > > > the freeing of the "vb" is RCU safe whereas vb->va is not. But from the first
> > > > > > > > > > glance i do not see how it can accessed twice. Hm..
> > > > > > > > > It was raised from a monkey test on A13_k515 system and got 1/20 pcs
> > > > > > > > > failed. IMO, vb->va which out of vmap_purge_lock protection could race
> > > > > > > > > with a concurrent ra freeing within __purge_vmap_area_lazy.
> > > > > > > > >
> > > > > > > > Do you have exact steps how you run "monkey" test?
> > > > > > > There are about 30+ kos inserted during startup which could be a
> > > > > > > specific criteria for reproduction. Do you have doubts about the test
> > > > > > > result or the solution?
> > > > > > > >
> > > > > > I do not have any doubt about your test results, so if you can trigger it
> > > > > > then there is an issue at least on the 5.4.161-android12 kernel.
> > > > > >
> > > > > > 1. With your fix we get expanded mutex range, thus the worst case of vmalloc
> > > > > > allocation can be increased when it fails and repeat. Because it also invokes
> > > > > > the purge_vmap_area_lazy() that access the same mutex.
> > > > > I am not sure I get your point. _vm_unmap_aliases calls
> > > > > _purge_vmap_area_lazy instead of purge_vmap_area_lazy. Do you have any
> > > > > other solutions? I really don't think my patch is the best way as I
> > > > > don't have a full view of vmalloc mechanism.
> > > > >
> > > > Yep, but it holds the mutex:
> > I still don't get how _purge_vmap_area_lazy hold vmap_purge_lock?
> >
> The user has to take the mutex if it invokes the __purge_vmap_area_lazy()
> function.
> 
> > > >
> > > > <snip>
> > > > mutex_lock(&vmap_purge_lock);
> > > > purge_fragmented_blocks_allcpus();
> > > > if (!__purge_vmap_area_lazy(start, end) && flush)
> > > >         flush_tlb_kernel_range(start, end);
> > > > mutex_unlock(&vmap_purge_lock);
> > > > <snip>
> > > >
> > > > I do not have a solution yet. I am trying still to figure out how you can
> > > > trigger it.
> > > >
> > > > <snip>
> > > >         rcu_read_lock();
> > > >         list_for_each_entry_rcu(vb, &vbq->free, free_list) {
> > > >                 spin_lock(&vb->lock);
> > > >                 if (vb->dirty && vb->dirty != VMAP_BBMAP_BITS) {
> > > >                         unsigned long va_start = vb->va->va_start;
> > > > <snip>
> > > >
> > > > so you say that "vb->va->va_start" can be accessed twice. I do not see
> > > > how it can happen. The purge_fragmented_blocks() removes "vb" from the
> > > > free_list and set vb->dirty to the VMAP_BBMAP_BITS to prevent purging
> > > > it again. It is protected by the spin_lock(&vb->lock):
> > > >
> > > > <snip>
> > > > spin_lock(&vb->lock);
> > > > if (vb->free + vb->dirty == VMAP_BBMAP_BITS && vb->dirty != VMAP_BBMAP_BITS) {
> > > >         vb->free = 0; /* prevent further allocs after releasing lock */
> > > >         vb->dirty = VMAP_BBMAP_BITS; /* prevent purging it again */
> > > >         vb->dirty_min = 0;
> > > >         vb->dirty_max = VMAP_BBMAP_BITS;
> > > > <snip>
> > > >
> > > > so the VMAP_BBMAP_BITS is set under spinlock. The _vm_unmap_aliases() checks it:
> > > >
> > > > <snip>
> > > > list_for_each_entry_rcu(vb, &vbq->free, free_list) {
> > > >         spin_lock(&vb->lock);
> > > >         if (vb->dirty && vb->dirty != VMAP_BBMAP_BITS) {
> > > >                 unsigned long va_start = vb->va->va_start;
> > > >                 unsigned long s, e;
> > > > <snip>
> > > >
> > > > if the "vb->dirty != VMAP_BBMAP_BITS". I am missing your point here?
> > > Could the racing be like bellowing scenario?  vb->va accessed in [2]
> > > has been freed in [1]
> > >
> > > _vm_unmap_aliases
> > >                 _vm_unmap_aliases
> > > {
> > >                                {
> > >               list_for_each_entry_rcu(vb, &vbq->free, free_list) {
> > >              __purge_vmap_area_lazy
> > >                      spin_lock(&vb->lock);
> > >                                 merge_or_add_vmap_area
> > >                      if (vb->dirty) {
> > >
> > > kmem_cache_free(vmap_area_cachep, va)[1]
> > >                             unsigned long va_start = vb->va->va_start;
> > > [2]
> > 
> > reformat the racing graph
> >  _vm_unmap_aliases
> >                              _vm_unmap_aliases
> >  {
> >                                               {
> >             list_for_each_entry_rcu(vb, &vbq->free, free_list) {
> >                    __purge_vmap_area_lazy
> >                       spin_lock(&vb->lock);
> >                                         merge_or_add_vmap_area
> >                       if (vb->dirty) {
> > 
> > kmem_cache_free(vmap_area_cachep, va)[1]
> >                              unsigned long va_start = vb->va->va_start; [2]
> > 
> > > >
> > > > > >
> > > > > > 2. You run 5.4.161-android12 kernel what is quite old. Could you please
> > > > > > retest with latest kernel? I am asking because on the latest kernel with
> > > > > > CONFIG_KASAN i am not able to reproduce it.
> > > > > >
> > > > > > I do a lot of: vm_map_ram()/vm_unmap_ram()/vmalloc()/vfree() in parallel
> > > > > > by 64 kthreads on my 64 CPUs test system.
> > > > > The failure generates at 20s from starting up, I think it is a rare timing.
> > > > > >
> > > > > > Could you please confirm that you can trigger an issue on the latest kernel?
> > > > > Sorry, I don't have an available latest kernel for now.
> > > > >
> > > > Can you do: "gdb ./vmlinux", execute "l *_vm_unmap_aliases+0x164" and provide
> > > > output?
> > Sorry, I have lost the vmlinux with KASAN enabled and just got some
> > instructions from logs.
> >
> > 0xffffffd010678da8 <_vm_unmap_aliases+0x134>: sub x22, x26, #0x28
> >                x26 vbq->free
> > 0xffffffd010678dac <_vm_unmap_aliases+0x138>: lsr x8, x22, #3
> > 0xffffffd010678db0 <_vm_unmap_aliases+0x13c>: ldrb w8, [x8,x24]
> > 0xffffffd010678db4 <_vm_unmap_aliases+0x140>: cbz w8,
> > 0xffffffd010678dc0 <_vm_unmap_aliases+0x14c>
> > 0xffffffd010678db8 <_vm_unmap_aliases+0x144>: mov x0, x22
> > 0xffffffd010678dbc <_vm_unmap_aliases+0x148>: bl 0xffffffd0106c9a34
> > <__asan_report_load8_noabort>
> > 0xffffffd010678dc0 <_vm_unmap_aliases+0x14c>: ldr x22, [x22]
> > 0xffffffd010678dc4 <_vm_unmap_aliases+0x150>: lsr x8, x22, #3
> > 0xffffffd010678dc8 <_vm_unmap_aliases+0x154>: ldrb w8, [x8,x24]
> > 0xffffffd010678dcc <_vm_unmap_aliases+0x158>: cbz w8,
> > 0xffffffd010678dd8 <_vm_unmap_aliases+0x164>
> > 0xffffffd010678dd0 <_vm_unmap_aliases+0x15c>: mov x0, x22
> > 0xffffffd010678dd4 <_vm_unmap_aliases+0x160>: bl 0xffffffd0106c9a34
> > <__asan_report_load8_noabort>
> >
> Could you please test below patch if that fixes an issue on the 5.4
> kernel:
> 
> <snip>
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 4e7809408073..d5b07d7239bd 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -55,6 +55,7 @@ struct vmap_area {
>  
>  	struct rb_node rb_node;         /* address sorted rbtree */
>  	struct list_head list;          /* address sorted list */
> +	struct rcu_head rcu;
>  
>  	/*
>  	 * The following three variables can be packed, because
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a3c70e275f4e..bb8cfdb06ce6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -337,14 +337,6 @@ static LLIST_HEAD(vmap_purge_list);
>  static struct rb_root vmap_area_root = RB_ROOT;
>  static bool vmap_initialized __read_mostly;
>  
> -/*
> - * This kmem_cache is used for vmap_area objects. Instead of
> - * allocating from slab we reuse an object from this cache to
> - * make things faster. Especially in "no edge" splitting of
> - * free block.
> - */
> -static struct kmem_cache *vmap_area_cachep;
> -
>  /*
>   * This linked list is used in pair with free_vmap_area_root.
>   * It gives O(1) access to prev/next to perform fast coalescing.
> @@ -532,7 +524,7 @@ link_va(struct vmap_area *va, struct rb_root *root,
>  	}
>  
>  	/* Address-sort this list */
> -	list_add(&va->list, head);
> +	list_add_rcu(&va->list, head);
>  }
>  
>  static __always_inline void
> @@ -547,7 +539,7 @@ unlink_va(struct vmap_area *va, struct rb_root *root)
>  	else
>  		rb_erase(&va->rb_node, root);
>  
> -	list_del(&va->list);
> +	list_del_rcu(&va->list);
>  	RB_CLEAR_NODE(&va->rb_node);
>  }
>  
> @@ -721,7 +713,7 @@ merge_or_add_vmap_area(struct vmap_area *va,
>  			augment_tree_propagate_from(sibling);
>  
>  			/* Free vmap_area object. */
> -			kmem_cache_free(vmap_area_cachep, va);
> +			kfree_rcu(va, rcu);
>  
>  			/* Point to the new merged area. */
>  			va = sibling;
> @@ -748,7 +740,7 @@ merge_or_add_vmap_area(struct vmap_area *va,
>  				unlink_va(va, root);
>  
>  			/* Free vmap_area object. */
> -			kmem_cache_free(vmap_area_cachep, va);
> +			kfree_rcu(va, rcu);
>  			return;
>  		}
>  	}
> @@ -928,7 +920,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
>  		 * |---------------|
>  		 */
>  		unlink_va(va, &free_vmap_area_root);
> -		kmem_cache_free(vmap_area_cachep, va);
> +		kfree_rcu(va, rcu);
>  	} else if (type == LE_FIT_TYPE) {
>  		/*
>  		 * Split left edge of fit VA.
> @@ -969,7 +961,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
>  			 * a first allocation (early boot up) when we have "one"
>  			 * big free space that has to be split.
>  			 */
> -			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
> +			lva = kmalloc(sizeof(struct vmap_area), GFP_NOWAIT);
>  			if (!lva)
>  				return -1;
>  		}
> @@ -1064,8 +1056,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  
>  	might_sleep();
>  
> -	va = kmem_cache_alloc_node(vmap_area_cachep,
> -			gfp_mask & GFP_RECLAIM_MASK, node);
> +	va = kmalloc_node(sizeof(struct vmap_area), gfp_mask & GFP_RECLAIM_MASK, node);
>  	if (unlikely(!va))
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -1091,12 +1082,12 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	preempt_disable();
>  	if (!__this_cpu_read(ne_fit_preload_node)) {
>  		preempt_enable();
> -		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
> +		pva = kmalloc_node(sizeof(struct vmap_area), GFP_KERNEL, node);
>  		preempt_disable();
>  
>  		if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
>  			if (pva)
> -				kmem_cache_free(vmap_area_cachep, pva);
> +				kfree_rcu(pva, rcu);
>  		}
>  	}
>  
> @@ -1145,7 +1136,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
>  			size);
>  
> -	kmem_cache_free(vmap_area_cachep, va);
> +	kfree_rcu(va, rcu);
>  	return ERR_PTR(-EBUSY);
>  }
>  
> @@ -1870,7 +1861,7 @@ static void vmap_init_free_space(void)
>  	 */
>  	list_for_each_entry(busy, &vmap_area_list, list) {
>  		if (busy->va_start - vmap_start > 0) {
> -			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> +			free = kzalloc(sizeof(struct vmap_area), GFP_NOWAIT);
>  			if (!WARN_ON_ONCE(!free)) {
>  				free->va_start = vmap_start;
>  				free->va_end = busy->va_start;
> @@ -1885,7 +1876,7 @@ static void vmap_init_free_space(void)
>  	}
>  
>  	if (vmap_end - vmap_start > 0) {
> -		free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> +		free = kzalloc(sizeof(struct vmap_area), GFP_NOWAIT);
>  		if (!WARN_ON_ONCE(!free)) {
>  			free->va_start = vmap_start;
>  			free->va_end = vmap_end;
> @@ -1903,11 +1894,6 @@ void __init vmalloc_init(void)
>  	struct vm_struct *tmp;
>  	int i;
>  
> -	/*
> -	 * Create the cache for vmap_area objects.
> -	 */
> -	vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);
> -
>  	for_each_possible_cpu(i) {
>  		struct vmap_block_queue *vbq;
>  		struct vfree_deferred *p;
> @@ -1922,7 +1908,7 @@ void __init vmalloc_init(void)
>  
>  	/* Import existing vmlist entries. */
>  	for (tmp = vmlist; tmp; tmp = tmp->next) {
> -		va = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> +		va = kzalloc(sizeof(struct vmap_area), GFP_NOWAIT);
>  		if (WARN_ON_ONCE(!va))
>  			continue;
>  
> @@ -3256,7 +3242,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  		goto err_free2;
>  
>  	for (area = 0; area < nr_vms; area++) {
> -		vas[area] = kmem_cache_zalloc(vmap_area_cachep, GFP_KERNEL);
> +		vas[area] = kzalloc(sizeof(struct vmap_area), GFP_KERNEL);
>  		vms[area] = kzalloc(sizeof(struct vm_struct), GFP_KERNEL);
>  		if (!vas[area] || !vms[area])
>  			goto err_free;
> @@ -3376,8 +3362,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  			if (vas[area])
>  				continue;
>  
> -			vas[area] = kmem_cache_zalloc(
> -				vmap_area_cachep, GFP_KERNEL);
> +			vas[area] = kzalloc(sizeof(struct vmap_area), GFP_KERNEL);
>  			if (!vas[area])
>  				goto err_free;
>  		}
> @@ -3388,7 +3373,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  err_free:
>  	for (area = 0; area < nr_vms; area++) {
>  		if (vas[area])
> -			kmem_cache_free(vmap_area_cachep, vas[area]);
> +			kfree_rcu(vas[area], rcu);
>  
>  		kfree(vms[area]);
>  	}
> <snip>
> 
> 
> --
> Uladzislau Rezki
>
OK. I was checking the sources of the 5.19 kernel that is why i did not
see how vb->va can be accessed twice. Indeed on the 5.4 kernel there was
a bug and it was fixed in the v5.13-rc1.

<snip>
commit ad216c0316ad6391d90f4de0a7f59396b2925a06
Author: Vijayanand Jitta <vjitta@codeaurora.org>
Date:   Thu Apr 29 22:59:07 2021 -0700

    mm: vmalloc: prevent use after free in _vm_unmap_aliases
    
    A potential use after free can occur in _vm_unmap_aliases where an already
    freed vmap_area could be accessed, Consider the following scenario:
    
    Process 1                                               Process 2
    
    __vm_unmap_aliases                                      __vm_unmap_aliases
            purge_fragmented_blocks_allcpus                         rcu_read_lock()
                    rcu_read_lock()
                            list_del_rcu(&vb->free_list)
                                                                            list_for_each_entry_rcu(vb .. )
            __purge_vmap_area_lazy
                    kmem_cache_free(va)
                                                                                    va_start = vb->va->va_start
    
    Here Process 1 is in purge path and it does list_del_rcu on vmap_block and
    later frees the vmap_area, since Process 2 was holding the rcu lock at
    this time vmap_block will still be present in and Process 2 accesse it and
    thereby it tries to access vmap_area of that vmap_block which was already
    freed by Process 1 and this results in use after free.
    
    Fix this by adding a check for vb->dirty before accessing vmap_area
    structure since vb->dirty will be set to VMAP_BBMAP_BITS in purge path
    checking for this will prevent the use after free.
    
    Link: https://lkml.kernel.org/r/1616062105-23263-1-git-send-email-vjitta@codeaurora.org
    Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
    Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 612a3790cfd4..51874a341ab0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2040,7 +2040,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
                rcu_read_lock();
                list_for_each_entry_rcu(vb, &vbq->free, free_list) {
                        spin_lock(&vb->lock);
-                       if (vb->dirty) {
+                       if (vb->dirty && vb->dirty != VMAP_BBMAP_BITS) {
                                unsigned long va_start = vb->va->va_start;
                                unsigned long s, e;
<snip>

Please apply that patch on your 5.4 kernel and then confirm if it fixes
your issue.

--
Uladzislau Rezki
