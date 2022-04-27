Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C42511DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbiD0QkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243537AbiD0Qjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:39:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B14A66C9F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:36:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1njkeT-0000r5-57; Wed, 27 Apr 2022 18:36:29 +0200
Message-ID: <635905f16b2ddf1d16f36e3c0e592eb492b1faf1.camel@pengutronix.de>
Subject: Re: [RESEND PATCH v3] drm/cma-helper: Describe what a "contiguous
 chunk" actually means
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Wed, 27 Apr 2022 18:36:27 +0200
In-Reply-To: <20220427140910.1735188-1-daniel.thompson@linaro.org>
References: <20220427140910.1735188-1-daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 27.04.2022 um 15:09 +0100 schrieb Daniel Thompson:
> Since it's inception in 2012 it has been understood that the DRM GEM CMA
> helpers do not depend on CMA as the backend allocator. In fact the first
> bug fix to ensure the cma-helpers work correctly with an IOMMU backend
> appeared in 2014. However currently the documentation for
> drm_gem_cma_create() talks about "a contiguous chunk of memory" without
> making clear which address space it will be a contiguous part of.
> Additionally the CMA introduction is actively misleading because it only
> contemplates the CMA backend.
> 
> This matters because when the device accesses the bus through an IOMMU
> (and don't use the CMA backend) then the allocated memory is contiguous
> only in the IOVA space. This is a significant difference compared to the
> CMA backend and the behaviour can be a surprise even to someone who does
> a reasonable level of code browsing (but doesn't find all the relevant
> function pointers ;-) ).
> 
> Improve the kernel doc comments accordingly.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> 
> Notes:
>     RESEND is unaltered but rebased on v5.18-rc3.
>     
>     Changes in v3:
>     - Rebased on v5.17-rc2
>     - Minor improvements to wording.
>     
>     Changes in v2:
>     - Oops. I did a final proof read and accidentally committed these
>       changes as a seperate patch. This means that v1 contains only
>       one tenth of the actual patch. This is fixed in v2. Many apologies
>       for the noise!
> 
>  drivers/gpu/drm/drm_gem_cma_helper.c | 39 +++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
> index f36734c2c9e1..42abee9a0f4f 100644
> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
> @@ -26,12 +26,22 @@
>  /**
>   * DOC: cma helpers
>   *
> - * The Contiguous Memory Allocator reserves a pool of memory at early boot
> - * that is used to service requests for large blocks of contiguous memory.
> + * The DRM GEM/CMA helpers are a means to provide buffer objects that are
> + * presented to the device as a contiguous chunk of memory. This is useful
> + * for devices that do not support scatter-gather DMA (either directly or
> + * by using an intimately attached IOMMU).
>   *
> - * The DRM GEM/CMA helpers use this allocator as a means to provide buffer
> - * objects that are physically contiguous in memory. This is useful for
> - * display drivers that are unable to map scattered buffers via an IOMMU.
> + * Despite the name, the DRM GEM/CMA helpers are not hardwired to use the
> + * Contiguous Memory Allocator (CMA).
> + *
> + * For devices that access the memory bus through an (external) IOMMU then
> + * the buffer objects are allocated using a traditional page-based
> + * allocator and may be scattered through physical memory. However they
> + * are contiguous in the IOVA space so appear contiguous to devices using
> + * them.
> + *
> + * For other devices then the helpers rely on CMA to provide buffer
> + * objects that are physically contiguous in memory.
>   *
>   * For GEM callback helpers in struct &drm_gem_object functions, see likewise
>   * named functions with an _object_ infix (e.g., drm_gem_cma_object_vmap() wraps
> @@ -111,8 +121,14 @@ __drm_gem_cma_create(struct drm_device *drm, size_t size, bool private)
>   * @drm: DRM device
>   * @size: size of the object to allocate
>   *
> - * This function creates a CMA GEM object and allocates a contiguous chunk of
> - * memory as backing store.
> + * This function creates a CMA GEM object and allocates memory as backing store.
> + * The allocated memory will occupy a contiguous chunk of bus address space.
> + *
> + * For devices that are directly connected to the memory bus then the allocated
> + * memory will be physically contiguous. For devices that access through an
> + * IOMMU, then the allocated memory is not expected to be physically contiguous
> + * because having contiguous IOVAs is sufficient to meet a devices DMA
> + * requirements.
>   *
>   * Returns:
>   * A struct drm_gem_cma_object * on success or an ERR_PTR()-encoded negative
> @@ -162,9 +178,12 @@ EXPORT_SYMBOL_GPL(drm_gem_cma_create);
>   * @size: size of the object to allocate
>   * @handle: return location for the GEM handle
>   *
> - * This function creates a CMA GEM object, allocating a physically contiguous
> - * chunk of memory as backing store. The GEM object is then added to the list
> - * of object associated with the given file and a handle to it is returned.
> + * This function creates a CMA GEM object, allocating a chunk of memory as
> + * backing store. The GEM object is then added to the list of object associated
> + * with the given file and a handle to it is returned.
> + *
> + * The allocated memory will occupy a contiguous chunk of bus address space.
> + * See drm_gem_cma_create() for more details.
>   *
>   * Returns:
>   * A struct drm_gem_cma_object * on success or an ERR_PTR()-encoded negative
> 
> base-commit: b2d229d4ddb17db541098b83524d901257e93845
> --
> 2.35.1
> 


