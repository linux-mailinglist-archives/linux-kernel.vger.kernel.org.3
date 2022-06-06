Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8153EC4A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbiFFPBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240149AbiFFPBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF50A322C1C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33E15614BF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 15:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CBDC34115;
        Mon,  6 Jun 2022 15:01:26 +0000 (UTC)
Date:   Mon, 6 Jun 2022 16:01:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
Subject: Re: [PATCH v2 3/4] mm: kmemleak: handle address stored in object
 based on its type
Message-ID: <Yp4Wwtg1uxZ9NLTw@arm.com>
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
 <20220603035415.1243913-4-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603035415.1243913-4-patrick.wang.shcn@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 11:54:14AM +0800, Patrick Wang wrote:
> Treat the address stored in object in different way according
> to its type:
> 
> - Only use kasan_reset_tag for virtual address
> - Only update min_addr and max_addr for virtual address
> - Convert physical address to virtual address in scan_object
> 
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
> ---
>  mm/kmemleak.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 218144392446..246a70b7218f 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -297,7 +297,9 @@ static void hex_dump_object(struct seq_file *seq,
>  	warn_or_seq_printf(seq, "  hex dump (first %zu bytes):\n", len);
>  	kasan_disable_current();
>  	warn_or_seq_hex_dump(seq, DUMP_PREFIX_NONE, HEX_ROW_SIZE,
> -			     HEX_GROUP_SIZE, kasan_reset_tag((void *)ptr), len, HEX_ASCII);
> +			     HEX_GROUP_SIZE, object->flags & OBJECT_PHYS ? ptr :
> +			     kasan_reset_tag((void *)ptr),
> +			     len, HEX_ASCII);
>  	kasan_enable_current();
>  }

This will go wrong since ptr is the actual physical address, it cannot
be dereferenced. This should only be used on virtual pointers and this
is the case already as we never print unreferenced objects from the phys
tree. What we could do though is something like an early exit from this
function (together with a comment that it doesn't support dumping such
objects):

	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
		return;

>  
> @@ -389,14 +391,15 @@ static struct kmemleak_object *lookup_object(unsigned long ptr, int alias,
>  {
>  	struct rb_node *rb = is_phys ? object_phys_tree_root.rb_node :
>  			     object_tree_root.rb_node;
> -	unsigned long untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
> +	unsigned long untagged_ptr = is_phys ? ptr : (unsigned long)kasan_reset_tag((void *)ptr);
>  
>  	while (rb) {
>  		struct kmemleak_object *object;
>  		unsigned long untagged_objp;
>  
>  		object = rb_entry(rb, struct kmemleak_object, rb_node);
> -		untagged_objp = (unsigned long)kasan_reset_tag((void *)object->pointer);
> +		untagged_objp = is_phys ? object->pointer :
> +				(unsigned long)kasan_reset_tag((void *)object->pointer);
>  
>  		if (untagged_ptr < untagged_objp)
>  			rb = object->rb_node.rb_left;

You could leave this unchanged. A phys pointer is already untagged, so
it wouldn't make any difference.

> @@ -643,16 +646,19 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>  
>  	raw_spin_lock_irqsave(&kmemleak_lock, flags);
>  
> -	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
> -	min_addr = min(min_addr, untagged_ptr);
> -	max_addr = max(max_addr, untagged_ptr + size);
> +	untagged_ptr = is_phys ? ptr : (unsigned long)kasan_reset_tag((void *)ptr);

Same here.

> +	if (!is_phys) {
> +		min_addr = min(min_addr, untagged_ptr);
> +		max_addr = max(max_addr, untagged_ptr + size);
> +	}
>  	link = is_phys ? &object_phys_tree_root.rb_node :
>  		&object_tree_root.rb_node;
>  	rb_parent = NULL;
>  	while (*link) {
>  		rb_parent = *link;
>  		parent = rb_entry(rb_parent, struct kmemleak_object, rb_node);
> -		untagged_objp = (unsigned long)kasan_reset_tag((void *)parent->pointer);
> +		untagged_objp = is_phys ? parent->pointer :
> +				(unsigned long)kasan_reset_tag((void *)parent->pointer);

And here.

>  		if (untagged_ptr + size <= untagged_objp)
>  			link = &parent->rb_node.rb_left;
>  		else if (untagged_objp + parent->size <= untagged_ptr)
> @@ -1202,7 +1208,9 @@ static bool update_checksum(struct kmemleak_object *object)
>  
>  	kasan_disable_current();
>  	kcsan_disable_current();
> -	object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
> +	object->checksum = crc32(0, object->flags & OBJECT_PHYS ? (void *)object->pointer :
> +				    kasan_reset_tag((void *)object->pointer),
> +				    object->size);

Luckily that's never called on a phys object, otherwise *object->pointer
would segfault. As for hex_dump, just return early with a warning if
that's the case.

>  	kasan_enable_current();
>  	kcsan_enable_current();
>  
> @@ -1353,6 +1361,7 @@ static void scan_object(struct kmemleak_object *object)
>  {
>  	struct kmemleak_scan_area *area;
>  	unsigned long flags;
> +	void *obj_ptr;
>  
>  	/*
>  	 * Once the object->lock is acquired, the corresponding memory block
> @@ -1364,10 +1373,15 @@ static void scan_object(struct kmemleak_object *object)
>  	if (!(object->flags & OBJECT_ALLOCATED))
>  		/* already freed object */
>  		goto out;
> +
> +	obj_ptr = object->flags & OBJECT_PHYS ?
> +		  __va((void *)object->pointer) :
> +		  (void *)object->pointer;
> +
>  	if (hlist_empty(&object->area_list) ||
>  	    object->flags & OBJECT_FULL_SCAN) {
> -		void *start = (void *)object->pointer;
> -		void *end = (void *)(object->pointer + object->size);
> +		void *start = obj_ptr;
> +		void *end = obj_ptr + object->size;
>  		void *next;
>  
>  		do {

This looks fine, assuming that the following patch adds the checks for
objects above max_low_pfn (I haven't got there yet).

-- 
Catalin
