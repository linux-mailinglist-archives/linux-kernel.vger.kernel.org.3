Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E7E542348
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbiFHGFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 02:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbiFHFxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3AB222E692
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 20:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654660006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KuIPAq+DImdHCS3N/V7SZ2BfS5AvPneguay+pC1vl+I=;
        b=V6s1LSHVBeGz/OWeEqZBDKjCiS1PEqI6Dvpmx+YzSu9UZYujpq1aX/B6lNJ7d2hWchNglt
        1DLM8aj+/x53Yi2AAtlPhT1yNE//Z0FcnqL2QdsYdQ/KTpQvShZBJ+jp3CiY3KUawkBvqw
        fL8JFiKWzhtw3AL8rMDgqKO8ctriVWE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-CFaYVMC_MTayd6XOciYiYA-1; Tue, 07 Jun 2022 23:46:40 -0400
X-MC-Unique: CFaYVMC_MTayd6XOciYiYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8D7F185A7B2;
        Wed,  8 Jun 2022 03:46:39 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBE171415100;
        Wed,  8 Jun 2022 03:46:38 +0000 (UTC)
Date:   Wed, 8 Jun 2022 11:46:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/5] mm/vmalloc: Extend __alloc_vmap_area() with extra
 arguments
Message-ID: <YqAbmXX7/Tujtekg@MiWiFi-R3L-srv>
References: <20220607093449.3100-1-urezki@gmail.com>
 <20220607093449.3100-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607093449.3100-3-urezki@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/22 at 11:34am, Uladzislau Rezki (Sony) wrote:
> It implies that __alloc_vmap_area() allocates only from the
> global vmap space, therefore a list-head and rb-tree, which
> represent a free vmap space, are not passed as parameters to
> this function and are accessed directly from this function.
> 
> Extend the __alloc_vmap_area() and other dependent functions
> to have a possibility to allocate from different trees making
> an interface common and not specific.
> 
> There is no functional change as a result of this patch.

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 0102d6d5fcdf..745e89eb6ca1 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1234,15 +1234,15 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
>   * overhead.
>   */
>  static __always_inline struct vmap_area *
> -find_vmap_lowest_match(unsigned long size, unsigned long align,
> -	unsigned long vstart, bool adjust_search_size)
> +find_vmap_lowest_match(struct rb_root *root, unsigned long size,
> +	unsigned long align, unsigned long vstart, bool adjust_search_size)
>  {
>  	struct vmap_area *va;
>  	struct rb_node *node;
>  	unsigned long length;
>  
>  	/* Start from the root. */
> -	node = free_vmap_area_root.rb_node;
> +	node = root->rb_node;
>  
>  	/* Adjust the search size for alignment overhead. */
>  	length = adjust_search_size ? size + align - 1 : size;
> @@ -1370,9 +1370,9 @@ classify_va_fit_type(struct vmap_area *va,
>  }
>  
>  static __always_inline int
> -adjust_va_to_fit_type(struct vmap_area *va,
> -	unsigned long nva_start_addr, unsigned long size,
> -	enum fit_type type)
> +adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> +	struct vmap_area *va, unsigned long nva_start_addr,
> +	unsigned long size, enum fit_type type)
>  {
>  	struct vmap_area *lva = NULL;
>  
> @@ -1384,7 +1384,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
>  		 * V      NVA      V
>  		 * |---------------|
>  		 */
> -		unlink_va_augment(va, &free_vmap_area_root);
> +		unlink_va_augment(va, root);
>  		kmem_cache_free(vmap_area_cachep, va);
>  	} else if (type == LE_FIT_TYPE) {
>  		/*
> @@ -1462,8 +1462,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
>  		augment_tree_propagate_from(va);
>  
>  		if (lva)	/* type == NE_FIT_TYPE */
> -			insert_vmap_area_augment(lva, &va->rb_node,
> -				&free_vmap_area_root, &free_vmap_area_list);
> +			insert_vmap_area_augment(lva, &va->rb_node, root, head);
>  	}
>  
>  	return 0;
> @@ -1474,7 +1473,8 @@ adjust_va_to_fit_type(struct vmap_area *va,
>   * Otherwise a vend is returned that indicates failure.
>   */
>  static __always_inline unsigned long
> -__alloc_vmap_area(unsigned long size, unsigned long align,
> +__alloc_vmap_area(struct rb_root *root, struct list_head *head,
> +	unsigned long size, unsigned long align,
>  	unsigned long vstart, unsigned long vend)
>  {
>  	bool adjust_search_size = true;
> @@ -1495,7 +1495,7 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
>  	if (align <= PAGE_SIZE || (align > PAGE_SIZE && (vend - vstart) == size))
>  		adjust_search_size = false;
>  
> -	va = find_vmap_lowest_match(size, align, vstart, adjust_search_size);
> +	va = find_vmap_lowest_match(root, size, align, vstart, adjust_search_size);
>  	if (unlikely(!va))
>  		return vend;
>  
> @@ -1514,7 +1514,7 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
>  		return vend;
>  
>  	/* Update the free vmap_area. */
> -	ret = adjust_va_to_fit_type(va, nva_start_addr, size, type);
> +	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size, type);
>  	if (ret)
>  		return vend;
>  
> @@ -1605,7 +1605,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  
>  retry:
>  	preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
> -	addr = __alloc_vmap_area(size, align, vstart, vend);
> +	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> +		size, align, vstart, vend);
>  	spin_unlock(&free_vmap_area_lock);
>  
>  	/*
> @@ -3886,7 +3887,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  			/* It is a BUG(), but trigger recovery instead. */
>  			goto recovery;
>  
> -		ret = adjust_va_to_fit_type(va, start, size, type);
> +		ret = adjust_va_to_fit_type(&free_vmap_area_root,
> +				&free_vmap_area_list, va, start, size, type);
>  		if (unlikely(ret))
>  			goto recovery;
>  
> -- 
> 2.30.2
> 
> 

