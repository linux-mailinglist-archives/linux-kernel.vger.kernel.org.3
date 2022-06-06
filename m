Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FA053E781
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbiFFOjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239791AbiFFOjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:39:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A0BEF06B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 41B1FCE1BA5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430AEC385A9;
        Mon,  6 Jun 2022 14:39:06 +0000 (UTC)
Date:   Mon, 6 Jun 2022 15:38:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
Subject: Re: [PATCH v2 2/4] mm: kmemleak: add rbtree for objects allocated
 with physical address
Message-ID: <Yp4RgegLBhvVeaid@arm.com>
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
 <20220603035415.1243913-3-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603035415.1243913-3-patrick.wang.shcn@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 11:54:13AM +0800, Patrick Wang wrote:
> @@ -536,27 +543,32 @@ static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
>  }
>  
>  /*
> - * Remove an object from the object_tree_root and object_list. Must be called
> - * with the kmemleak_lock held _if_ kmemleak is still enabled.
> + * Remove an object from the object_tree_root (or object_phys_tree_root)
> + * and object_list. Must be called with the kmemleak_lock held _if_ kmemleak
> + * is still enabled.
>   */
>  static void __remove_object(struct kmemleak_object *object)
>  {
> -	rb_erase(&object->rb_node, &object_tree_root);
> +	rb_erase(&object->rb_node, object->flags & OBJECT_PHYS ?
> +				   &object_phys_tree_root :
> +				   &object_tree_root);

This pattern appears in a few place, I guess it's better with a macro,
say get_object_tree_root(object). But see how many are left, I have some
comments below on reducing the diff.

> @@ -709,12 +724,12 @@ static void delete_object_full(unsigned long ptr)
>   * delete it. If the memory block is partially freed, the function may create
>   * additional metadata for the remaining parts of the block.
>   */
> -static void delete_object_part(unsigned long ptr, size_t size)
> +static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
>  {
>  	struct kmemleak_object *object;
>  	unsigned long start, end;
>  
> -	object = find_and_remove_object(ptr, 1);
> +	object = find_and_remove_object(ptr, 1, is_phys);
>  	if (!object) {
>  #ifdef DEBUG
>  		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",

The previous patch introduced a check on object->flags for
delete_object_part(). I think you can just use is_phys directly now when
calling create_object().

> @@ -756,11 +771,11 @@ static void paint_it(struct kmemleak_object *object, int color)
>  	raw_spin_unlock_irqrestore(&object->lock, flags);
>  }
>  
> -static void paint_ptr(unsigned long ptr, int color)
> +static void paint_ptr(unsigned long ptr, int color, bool is_phys)
>  {
>  	struct kmemleak_object *object;
>  
> -	object = find_and_get_object(ptr, 0);
> +	object = find_and_get_object(ptr, 0, is_phys);
>  	if (!object) {
>  		kmemleak_warn("Trying to color unknown object at 0x%08lx as %s\n",
>  			      ptr,
> @@ -776,18 +791,18 @@ static void paint_ptr(unsigned long ptr, int color)
>   * Mark an object permanently as gray-colored so that it can no longer be
>   * reported as a leak. This is used in general to mark a false positive.
>   */
> -static void make_gray_object(unsigned long ptr)
> +static void make_gray_object(unsigned long ptr, bool is_phys)
>  {
> -	paint_ptr(ptr, KMEMLEAK_GREY);
> +	paint_ptr(ptr, KMEMLEAK_GREY, is_phys);
>  }
>  
>  /*
>   * Mark the object as black-colored so that it is ignored from scans and
>   * reporting.
>   */
> -static void make_black_object(unsigned long ptr)
> +static void make_black_object(unsigned long ptr, bool is_phys)
>  {
> -	paint_ptr(ptr, KMEMLEAK_BLACK);
> +	paint_ptr(ptr, KMEMLEAK_BLACK, is_phys);
>  }

We won't need any of these functions to get an 'is_phys' argument if we
make kmemleak_alloc_phys() always create gray objects (do this as one of
the first patches in the series).

>  
>  /*
> @@ -802,7 +817,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
>  	unsigned long untagged_ptr;
>  	unsigned long untagged_objp;
>  
> -	object = find_and_get_object(ptr, 1);
> +	object = find_and_get_object(ptr, 1, false);
>  	if (!object) {
>  		kmemleak_warn("Adding scan area to unknown object at 0x%08lx\n",
>  			      ptr);
> @@ -852,7 +867,7 @@ static void object_set_excess_ref(unsigned long ptr, unsigned long excess_ref)
>  	unsigned long flags;
>  	struct kmemleak_object *object;
>  
> -	object = find_and_get_object(ptr, 0);
> +	object = find_and_get_object(ptr, 0, false);
>  	if (!object) {
>  		kmemleak_warn("Setting excess_ref on unknown object at 0x%08lx\n",
>  			      ptr);
> @@ -875,7 +890,7 @@ static void object_no_scan(unsigned long ptr)
>  	unsigned long flags;
>  	struct kmemleak_object *object;
>  
> -	object = find_and_get_object(ptr, 0);
> +	object = find_and_get_object(ptr, 0, false);
>  	if (!object) {
>  		kmemleak_warn("Not scanning unknown object at 0x%08lx\n", ptr);
>  		return;

Same for these.

> @@ -993,7 +1008,7 @@ void __ref kmemleak_free_part(const void *ptr, size_t size)
>  	pr_debug("%s(0x%p)\n", __func__, ptr);
>  
>  	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
> -		delete_object_part((unsigned long)ptr, size);
> +		delete_object_part((unsigned long)ptr, size, false);
>  }
>  EXPORT_SYMBOL_GPL(kmemleak_free_part);
>  
> @@ -1034,7 +1049,7 @@ void __ref kmemleak_update_trace(const void *ptr)
>  	if (!kmemleak_enabled || IS_ERR_OR_NULL(ptr))
>  		return;
>  
> -	object = find_and_get_object((unsigned long)ptr, 1);
> +	object = find_and_get_object((unsigned long)ptr, 1, false);
>  	if (!object) {
>  #ifdef DEBUG
>  		kmemleak_warn("Updating stack trace for unknown object at %p\n",
> @@ -1063,7 +1078,7 @@ void __ref kmemleak_not_leak(const void *ptr)
>  	pr_debug("%s(0x%p)\n", __func__, ptr);
>  
>  	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
> -		make_gray_object((unsigned long)ptr);
> +		make_gray_object((unsigned long)ptr, false);
>  }
>  EXPORT_SYMBOL(kmemleak_not_leak);
>  
> @@ -1081,7 +1096,7 @@ void __ref kmemleak_ignore(const void *ptr)
>  	pr_debug("%s(0x%p)\n", __func__, ptr);
>  
>  	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
> -		make_black_object((unsigned long)ptr);
> +		make_black_object((unsigned long)ptr, false);
>  }
>  EXPORT_SYMBOL(kmemleak_ignore);

If we avoid changing make_*_object(), we won't need these anymore.

> @@ -1275,7 +1290,7 @@ static void scan_block(void *_start, void *_end,
>  		 * is still present in object_tree_root and object_list
>  		 * (with updates protected by kmemleak_lock).
>  		 */
> -		object = lookup_object(pointer, 1);
> +		object = lookup_object(pointer, 1, false);
>  		if (!object)
>  			continue;
>  		if (object == scanned)
> @@ -1299,7 +1314,7 @@ static void scan_block(void *_start, void *_end,
>  		raw_spin_unlock(&object->lock);
>  
>  		if (excess_ref) {
> -			object = lookup_object(excess_ref, 0);
> +			object = lookup_object(excess_ref, 0, false);
>  			if (!object)
>  				continue;
>  			if (object == scanned)
> @@ -1728,7 +1743,7 @@ static int dump_str_object_info(const char *str)
>  
>  	if (kstrtoul(str, 0, &addr))
>  		return -EINVAL;
> -	object = find_and_get_object(addr, 0);
> +	object = find_and_get_object(addr, 0, false);
>  	if (!object) {
>  		pr_info("Unknown object at 0x%08lx\n", addr);
>  		return -EINVAL;

I think find_and_get_object() is never called on a phys object, so you
can probably simplify these a bit. Just add an is_phys argument where
strictly necessary and maybe even add a separate function like
lookup_object_phys() to reduce the other changes.

-- 
Catalin
