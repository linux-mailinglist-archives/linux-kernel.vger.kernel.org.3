Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C1B5A0733
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 04:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiHYCPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 22:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHYCPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 22:15:11 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8559D17A8C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 19:15:08 -0700 (PDT)
Date:   Thu, 25 Aug 2022 10:14:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661393706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cpOx6dVV78jhXar+JPpWdb6xb0voKCMB3o04WKJhLiU=;
        b=tewPSVKgpBLdkLATs2Z1i+GU7HBTFWe6AwRsxt6en2hisViLYRkjth3UBtqR0ckiKKk1FP
        Ctq6a3PTjZcfLVPFGwj9wSYoIVUd1C010B8ZDEWkS46ENTqRbk/64rwvs3+Ny7vUzCNpSX
        s72KUYPFCQ2LuGdlxDucOuUiKagNhco=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Remove the unused param "struct drm_buddy *mm"
Message-ID: <20220825021441.GA8819@chq-T47>
References: <20220627085405.221435-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220627085405.221435-1-cai.huoqing@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 6月 22 16:54:04, Cai Huoqing wrote:
> Remove the param "struct drm_buddy *mm" which is unused in
> the function drm_block_alloc()/drm_block_free().
Just ping this patch
> 
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> ---
>  drivers/gpu/drm/drm_buddy.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index 11bb59399471..192c8b99fb43 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c
> @@ -11,10 +11,8 @@
>  
>  static struct kmem_cache *slab_blocks;
>  
> -static struct drm_buddy_block *drm_block_alloc(struct drm_buddy *mm,
> -					       struct drm_buddy_block *parent,
> -					       unsigned int order,
> -					       u64 offset)
> +static struct drm_buddy_block *
> +drm_block_alloc(struct drm_buddy_block *parent, unsigned int order, u64 offset)
>  {
>  	struct drm_buddy_block *block;
>  
> @@ -32,8 +30,7 @@ static struct drm_buddy_block *drm_block_alloc(struct drm_buddy *mm,
>  	return block;
>  }
>  
> -static void drm_block_free(struct drm_buddy *mm,
> -			   struct drm_buddy_block *block)
> +static void drm_block_free(struct drm_buddy_block *block)
>  {
>  	kmem_cache_free(slab_blocks, block);
>  }
> @@ -131,7 +128,7 @@ int drm_buddy_init(struct drm_buddy *mm, u64 size, u64 chunk_size)
>  		root_size = rounddown_pow_of_two(size);
>  		order = ilog2(root_size) - ilog2(chunk_size);
>  
> -		root = drm_block_alloc(mm, NULL, order, offset);
> +		root = drm_block_alloc(NULL, order, offset);
>  		if (!root)
>  			goto out_free_roots;
>  
> @@ -151,7 +148,7 @@ int drm_buddy_init(struct drm_buddy *mm, u64 size, u64 chunk_size)
>  
>  out_free_roots:
>  	while (i--)
> -		drm_block_free(mm, mm->roots[i]);
> +		drm_block_free(mm->roots[i]);
>  	kfree(mm->roots);
>  out_free_list:
>  	kfree(mm->free_list);
> @@ -172,7 +169,7 @@ void drm_buddy_fini(struct drm_buddy *mm)
>  
>  	for (i = 0; i < mm->n_roots; ++i) {
>  		WARN_ON(!drm_buddy_block_is_free(mm->roots[i]));
> -		drm_block_free(mm, mm->roots[i]);
> +		drm_block_free(mm->roots[i]);
>  	}
>  
>  	WARN_ON(mm->avail != mm->size);
> @@ -191,14 +188,14 @@ static int split_block(struct drm_buddy *mm,
>  	BUG_ON(!drm_buddy_block_is_free(block));
>  	BUG_ON(!drm_buddy_block_order(block));
>  
> -	block->left = drm_block_alloc(mm, block, block_order, offset);
> +	block->left = drm_block_alloc(block, block_order, offset);
>  	if (!block->left)
>  		return -ENOMEM;
>  
> -	block->right = drm_block_alloc(mm, block, block_order,
> +	block->right = drm_block_alloc(block, block_order,
>  				       offset + (mm->chunk_size << block_order));
>  	if (!block->right) {
> -		drm_block_free(mm, block->left);
> +		drm_block_free(block->left);
>  		return -ENOMEM;
>  	}
>  
> @@ -257,8 +254,8 @@ static void __drm_buddy_free(struct drm_buddy *mm,
>  
>  		list_del(&buddy->link);
>  
> -		drm_block_free(mm, block);
> -		drm_block_free(mm, buddy);
> +		drm_block_free(block);
> +		drm_block_free(buddy);
>  
>  		block = parent;
>  	}
> -- 
> 2.25.1
> 
