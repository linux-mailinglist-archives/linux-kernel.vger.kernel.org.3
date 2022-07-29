Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD7E58509E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiG2NNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbiG2NNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:13:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D381B56BB6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:12:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8D88868AA6; Fri, 29 Jul 2022 15:12:48 +0200 (CEST)
Date:   Fri, 29 Jul 2022 15:12:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] drm/nouveau/ttm: Stop calling into swiotlb
Message-ID: <20220729131248.GA27137@lst.de>
References: <20220728220545.163763-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728220545.163763-1-lyude@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lyude, and thanks for taking a look.

> -#if IS_ENABLED(CONFIG_SWIOTLB) && IS_ENABLED(CONFIG_X86)
> -	need_swiotlb = is_swiotlb_active(dev->dev);
> -#endif
> -
>  	ret = ttm_device_init(&drm->ttm.bdev, &nouveau_bo_driver, drm->dev->dev,
> -				  dev->anon_inode->i_mapping,
> -				  dev->vma_offset_manager, need_swiotlb,
> -				  drm->client.mmu.dmabits <= 32);
> +			      dev->anon_inode->i_mapping,
> +			      dev->vma_offset_manager,
> +			      nouveau_drm_use_coherent_gpu_mapping(drm),
> +			      drm->client.mmu.dmabits <= 32);

This will break setups for two reasons:

 - swiotlb is not only used to do device addressing limitations, so
   this will not catch the case of interconnect addressing limitations
   or forced bounce buffering which used used e.g. in secure VMs.
 - we might need bouncing for any DMA address below the physical
   address limit of the CPU

But more fundamentally the use_dma32 argument to ttm_device_init
is rather broken, as the onlyway to get a memory allocation that
fits the DMA addressing needs of a device is to use the proper
DMA mapping helpers. i.e. ttm_pool_alloc_page really needs to use
dma_alloc_pages instead of alloc_pages as a first step.  That way
all users of the TTM pool will always get dma addressable pages
and there is no need to guess the addressing limitations.

The use_dma_alloc is then only needed for users that require coherent
memory and are willing to deal with the limitations that this entails
(e.g. no way to get at the page struct).

>  	if (ret) {
>  		NV_ERROR(drm, "error initialising bo driver, %d\n", ret);
>  		return ret;
> -- 
> 2.35.3
---end quoted text---
