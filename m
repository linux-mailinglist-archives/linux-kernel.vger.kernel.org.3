Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90815421B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiFHGEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 02:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241026AbiFHFxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74A2219C779
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 20:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654659966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YUmAGufRF5e6pAPW7PwCGUiza+JMsiV+6BcB+5BhN0c=;
        b=FTkUnM39HHsuEcVDEr7HhTY6gFbWi4jOWKos/BEkwAnz8pW9SYapkCDI0GmSnYRrIrBkS2
        1WiZe3/oRr2eHmcY1QlR0bzZQ8CnuTx/zglcqqPQ1T6u1CY0l3viSWmnOfUE6cHCDu9FTL
        zX0frTAL33dmy2AHjxvKgWhLwXkW1JM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-x8bg9Z3CM7ib8IIcEqdF6A-1; Tue, 07 Jun 2022 23:46:01 -0400
X-MC-Unique: x8bg9Z3CM7ib8IIcEqdF6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0D703806704;
        Wed,  8 Jun 2022 03:46:00 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 351622166B26;
        Wed,  8 Jun 2022 03:45:59 +0000 (UTC)
Date:   Wed, 8 Jun 2022 11:45:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/5] mm/vmalloc: Make link_va()/unlink_va() common to
 different rb_root
Message-ID: <YqAbdQ1voSCCaZtz@MiWiFi-R3L-srv>
References: <20220607093449.3100-1-urezki@gmail.com>
 <20220607093449.3100-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607093449.3100-2-urezki@gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
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
> Currently link_va() and unlik_va(), in order to figure out a tree
> type, compares a passed root value with a global free_vmap_area_root
> variable to distinguish the augmented rb-tree from a regular one. It
> is hard coded since such functions can manipulate only with specific
> "free_vmap_area_root" tree that represents a global free vmap space.
> 
> Make it common by introducing "_augment" versions of both internal
> functions, so it is possible to deal with different trees.
> 
> There is no functional change as a result of this patch.

Patch looks good to me. Looking forward to seeing the later per-cpu
vmalloc allocation patches.

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 60 +++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 48 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index be8ed06804a5..0102d6d5fcdf 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -911,8 +911,9 @@ get_va_next_sibling(struct rb_node *parent, struct rb_node **link)
>  }
>  
>  static __always_inline void
> -link_va(struct vmap_area *va, struct rb_root *root,
> -	struct rb_node *parent, struct rb_node **link, struct list_head *head)
> +__link_va(struct vmap_area *va, struct rb_root *root,
> +	struct rb_node *parent, struct rb_node **link,
> +	struct list_head *head, bool augment)
>  {
>  	/*
>  	 * VA is still not in the list, but we can
> @@ -926,7 +927,7 @@ link_va(struct vmap_area *va, struct rb_root *root,
>  
>  	/* Insert to the rb-tree */
>  	rb_link_node(&va->rb_node, parent, link);
> -	if (root == &free_vmap_area_root) {
> +	if (augment) {
>  		/*
>  		 * Some explanation here. Just perform simple insertion
>  		 * to the tree. We do not set va->subtree_max_size to
> @@ -950,12 +951,28 @@ link_va(struct vmap_area *va, struct rb_root *root,
>  }
>  
>  static __always_inline void
> -unlink_va(struct vmap_area *va, struct rb_root *root)
> +link_va(struct vmap_area *va, struct rb_root *root,
> +	struct rb_node *parent, struct rb_node **link,
> +	struct list_head *head)
> +{
> +	__link_va(va, root, parent, link, head, false);
> +}
> +
> +static __always_inline void
> +link_va_augment(struct vmap_area *va, struct rb_root *root,
> +	struct rb_node *parent, struct rb_node **link,
> +	struct list_head *head)
> +{
> +	__link_va(va, root, parent, link, head, true);
> +}
> +
> +static __always_inline void
> +__unlink_va(struct vmap_area *va, struct rb_root *root, bool augment)
>  {
>  	if (WARN_ON(RB_EMPTY_NODE(&va->rb_node)))
>  		return;
>  
> -	if (root == &free_vmap_area_root)
> +	if (augment)
>  		rb_erase_augmented(&va->rb_node,
>  			root, &free_vmap_area_rb_augment_cb);
>  	else
> @@ -965,6 +982,18 @@ unlink_va(struct vmap_area *va, struct rb_root *root)
>  	RB_CLEAR_NODE(&va->rb_node);
>  }
>  
> +static __always_inline void
> +unlink_va(struct vmap_area *va, struct rb_root *root)
> +{
> +	__unlink_va(va, root, false);
> +}
> +
> +static __always_inline void
> +unlink_va_augment(struct vmap_area *va, struct rb_root *root)
> +{
> +	__unlink_va(va, root, true);
> +}
> +
>  #if DEBUG_AUGMENT_PROPAGATE_CHECK
>  /*
>   * Gets called when remove the node and rotate.
> @@ -1060,7 +1089,7 @@ insert_vmap_area_augment(struct vmap_area *va,
>  		link = find_va_links(va, root, NULL, &parent);
>  
>  	if (link) {
> -		link_va(va, root, parent, link, head);
> +		link_va_augment(va, root, parent, link, head);
>  		augment_tree_propagate_from(va);
>  	}
>  }
> @@ -1077,8 +1106,8 @@ insert_vmap_area_augment(struct vmap_area *va,
>   * ongoing.
>   */
>  static __always_inline struct vmap_area *
> -merge_or_add_vmap_area(struct vmap_area *va,
> -	struct rb_root *root, struct list_head *head)
> +__merge_or_add_vmap_area(struct vmap_area *va,
> +	struct rb_root *root, struct list_head *head, bool augment)
>  {
>  	struct vmap_area *sibling;
>  	struct list_head *next;
> @@ -1140,7 +1169,7 @@ merge_or_add_vmap_area(struct vmap_area *va,
>  			 * "normalized" because of rotation operations.
>  			 */
>  			if (merged)
> -				unlink_va(va, root);
> +				__unlink_va(va, root, augment);
>  
>  			sibling->va_end = va->va_end;
>  
> @@ -1155,16 +1184,23 @@ merge_or_add_vmap_area(struct vmap_area *va,
>  
>  insert:
>  	if (!merged)
> -		link_va(va, root, parent, link, head);
> +		__link_va(va, root, parent, link, head, augment);
>  
>  	return va;
>  }
>  
> +static __always_inline struct vmap_area *
> +merge_or_add_vmap_area(struct vmap_area *va,
> +	struct rb_root *root, struct list_head *head)
> +{
> +	return __merge_or_add_vmap_area(va, root, head, false);
> +}
> +
>  static __always_inline struct vmap_area *
>  merge_or_add_vmap_area_augment(struct vmap_area *va,
>  	struct rb_root *root, struct list_head *head)
>  {
> -	va = merge_or_add_vmap_area(va, root, head);
> +	va = __merge_or_add_vmap_area(va, root, head, true);
>  	if (va)
>  		augment_tree_propagate_from(va);
>  
> @@ -1348,7 +1384,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
>  		 * V      NVA      V
>  		 * |---------------|
>  		 */
> -		unlink_va(va, &free_vmap_area_root);
> +		unlink_va_augment(va, &free_vmap_area_root);
>  		kmem_cache_free(vmap_area_cachep, va);
>  	} else if (type == LE_FIT_TYPE) {
>  		/*
> -- 
> 2.30.2
> 
> 

