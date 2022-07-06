Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570EB5690AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiGFR27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiGFR25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:28:57 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF90240BF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:28:56 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5C84C30A;
        Wed,  6 Jul 2022 19:28:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1657128534;
        bh=ZlWUPRClil4qnXIdp+fR5UfEwUINySgLRda1BvGZM0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OleaHpGJkxCqxMi0edhbip+w2jz5LM0UB3MzmawpmEgY4c0AHsmJUhQR7fZtK488B
         0IEaOg4igLvoisoX8YMEOLUqK7SWMn+bZwRrTfUhE4EfuG+LFuG1bXDA6mWt9764qf
         9hzvpFmYF2kYnmEjsejv8Dt2/iUSAAcazRe8P4Gs=
Date:   Wed, 6 Jul 2022 20:28:29 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] drm/gem: rename struct drm_gem_dma_object.{paddr
 => dma_addr}
Message-ID: <YsXGPfKYhPsayHpv@pendragon.ideasonboard.com>
References: <20220706124352.874528-1-dakr@redhat.com>
 <20220706124352.874528-4-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220706124352.874528-4-dakr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

Thank you for the patch.

On Wed, Jul 06, 2022 at 02:43:51PM +0200, Danilo Krummrich wrote:
> The field paddr of struct drm_gem_dma_object holds a DMA address, which
> might actually be a physical address. However, depending on the platform,
> it can also be a bus address or a virtual address managed by an IOMMU.
> 
> Hence, rename the field to dma_addr, which is more applicable.
> 
> Since 'paddr' is a very commonly used term and symbol name a simple regex
> does not do the trick. Instead, users of the struct were fixed up
> iteratively with a trial and error approach building with
> `make allyesconfig && make drivers/gpu/drm`.

Not for this patch as you've already done the work manually, but can I
recommend the excellent coccinelle tool ? Its semantic patches can very
easily rename structure members.

> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  .../arm/display/komeda/komeda_framebuffer.c   |  4 ++--
>  drivers/gpu/drm/arm/malidp_mw.c               |  2 +-
>  drivers/gpu/drm/arm/malidp_planes.c           | 12 +++++-----
>  drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c      |  2 +-
>  drivers/gpu/drm/drm_fb_dma_helper.c           | 10 ++++----
>  drivers/gpu/drm/drm_gem_dma_helper.c          | 23 +++++++++++--------
>  drivers/gpu/drm/imx/ipuv3-plane.c             |  6 ++---
>  drivers/gpu/drm/sprd/sprd_dpu.c               |  2 +-
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c        | 14 +++++------
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c        | 14 +++++------
>  drivers/gpu/drm/tidss/tidss_dispc.c           | 16 ++++++-------
>  drivers/gpu/drm/tiny/arcpgu.c                 |  2 +-
>  drivers/gpu/drm/vc4/vc4_bo.c                  |  2 +-
>  drivers/gpu/drm/vc4/vc4_gem.c                 |  8 +++----
>  drivers/gpu/drm/vc4/vc4_irq.c                 |  2 +-
>  drivers/gpu/drm/vc4/vc4_plane.c               |  4 ++--
>  drivers/gpu/drm/vc4/vc4_render_cl.c           | 14 +++++------
>  drivers/gpu/drm/vc4/vc4_txp.c                 |  2 +-
>  drivers/gpu/drm/vc4/vc4_v3d.c                 |  4 ++--
>  drivers/gpu/drm/vc4/vc4_validate.c            | 12 +++++-----
>  include/drm/drm_gem_dma_helper.h              |  4 ++--
>  21 files changed, 81 insertions(+), 78 deletions(-)

[snip]

> diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
> index 56fc1a1e7f87..8851d294bb53 100644
> --- a/drivers/gpu/drm/drm_gem_dma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_dma_helper.c

[snip]

> @@ -460,10 +461,11 @@ drm_gem_dma_prime_import_sg_table(struct drm_device *dev,
>  	if (IS_ERR(dma_obj))
>  		return ERR_CAST(dma_obj);
>  
> -	dma_obj->paddr = sg_dma_address(sgt->sgl);
> +	dma_obj->dma_addr = sg_dma_address(sgt->sgl);
>  	dma_obj->sgt = sgt;
>  
> -	DRM_DEBUG_PRIME("dma_addr = %pad, size = %zu\n", &dma_obj->paddr, attach->dmabuf->size);
> +	DRM_DEBUG_PRIME("dma_addr = %pad, size = %zu\n", &dma_obj->dma_addr,
> +							 attach->dmabuf->size);

The second line should be aligned left, just right of the opening
parenthesis.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
>  	return &dma_obj->base;
>  }

[snip]

-- 
Regards,

Laurent Pinchart
