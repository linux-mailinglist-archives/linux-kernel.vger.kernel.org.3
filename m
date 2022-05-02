Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7775517415
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386266AbiEBQU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382720AbiEBQUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:20:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59FCE0C4
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:17:20 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1555C474;
        Mon,  2 May 2022 18:17:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1651508239;
        bh=c+lFCqqrxYQkBT4Dk1RtT/1nSh3E7EO4tZr2yzZYmYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6VHAMn3IuCnmDyXupcm1VxxL/fCaJsfOpOk0BF0ok1Be+zl9cuHuaV22sUgCMHKI
         PMCTsRA/pWv3s+s2mjByj5GDWvJGUkQ+3/NZp/TYckr7YjPguUgoH4gG3sL0jj5GVU
         vSiid340Eer6gfojKpc20F0j1AM1OLozPtI9WYA4=
Date:   Mon, 2 May 2022 19:17:18 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] drm: Allow simpledrm to setup its emulated FB as
 firmware provided
Message-ID: <YnAEDlikr+d8cvy4@pendragon.ideasonboard.com>
References: <20220502153900.408522-1-javierm@redhat.com>
 <20220502153900.408522-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220502153900.408522-4-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

Thank you for the patch.

On Mon, May 02, 2022 at 05:39:00PM +0200, Javier Martinez Canillas wrote:
> Indicate to fbdev subsystem that the registered framebuffer is provided by
> the system firmware, so that it can handle accordingly. For example, would
> unregister the FB devices if asked to remove the conflicting framebuffers.
> 
> Add a new DRM_FB_FW field to drm_fbdev_generic_setup() options parameter.
> Drivers can use this to indicate the FB helper initialization that the FB
> registered is provided by the firmware, so it can be configured as such.
> 
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/drm_fb_helper.c  |  9 +++++++++
>  drivers/gpu/drm/tiny/simpledrm.c |  2 +-
>  include/drm/drm_fb_helper.h      | 10 ++++++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index fd0084ad77c3..775e47c5de1f 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1891,6 +1891,10 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper,
>  		/* don't leak any physical addresses to userspace */
>  		info->flags |= FBINFO_HIDE_SMEM_START;
>  
> +	/* Indicate that the framebuffer is provided by the firmware */
> +	if (fb_helper->firmware)
> +		info->flags |= FBINFO_MISC_FIRMWARE;
> +
>  	/* Need to drop locks to avoid recursive deadlock in
>  	 * register_framebuffer. This is ok because the only thing left to do is
>  	 * register the fbdev emulation instance in kernel_fb_helper_list. */
> @@ -2512,6 +2516,8 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
>   *
>   * * DRM_FB_BPP: bits per pixel for the device. If the field is not set,
>   *   @dev->mode_config.preferred_depth is used instead.
> + * * DRM_FB_FW: if the framebuffer for the device is provided by the
> + *   system firmware.
>   *
>   * This function sets up generic fbdev emulation for drivers that supports
>   * dumb buffers with a virtual address and that can be mmap'ed.
> @@ -2538,6 +2544,7 @@ void drm_fbdev_generic_setup(struct drm_device *dev, unsigned int options)
>  {
>  	struct drm_fb_helper *fb_helper;
>  	unsigned int preferred_bpp = DRM_FB_GET_OPTION(DRM_FB_BPP, options);
> +	bool firmware = DRM_FB_GET_OPTION(DRM_FB_FW, options);
>  	int ret;
>  
>  	drm_WARN(dev, !dev->registered, "Device has not been registered.\n");
> @@ -2570,6 +2577,8 @@ void drm_fbdev_generic_setup(struct drm_device *dev, unsigned int options)
>  		preferred_bpp = 32;
>  	fb_helper->preferred_bpp = preferred_bpp;
>  
> +	fb_helper->firmware = firmware;

I'd get rid of the local variable and write

	fb_helper->firmware = DRM_FB_GET_OPTION(DRM_FB_FW, options);

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
>  	ret = drm_fbdev_client_hotplug(&fb_helper->client);
>  	if (ret)
>  		drm_dbg_kms(dev, "client hotplug ret=%d\n", ret);
> diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
> index f5b8e864a5cd..5dcc21ea6180 100644
> --- a/drivers/gpu/drm/tiny/simpledrm.c
> +++ b/drivers/gpu/drm/tiny/simpledrm.c
> @@ -901,7 +901,7 @@ static int simpledrm_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	drm_fbdev_generic_setup(dev, 0);
> +	drm_fbdev_generic_setup(dev, DRM_FB_SET_OPTION(DRM_FB_FW, 1));
>  
>  	return 0;
>  }
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index 740f87560102..77a72d55308d 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -44,6 +44,7 @@ enum mode_set_atomic {
>  };
>  
>  #define DRM_FB_BPP_MASK GENMASK(7, 0)
> +#define DRM_FB_FW_MASK GENMASK(8, 8)
>  
>  /* Using the GNU statement expression extension */
>  #define DRM_FB_OPTION(option, value)				\
> @@ -197,6 +198,15 @@ struct drm_fb_helper {
>  	 * See also: @deferred_setup
>  	 */
>  	int preferred_bpp;
> +
> +	/**
> +	 * @firmware:
> +	 *
> +	 * Set if the driver indicates to the FB helper initialization that the
> +	 * framebuffer for the device being registered is provided by firmware,
> +	 * so that it can pass this on when registering the framebuffer device.
> +	 */
> +	bool firmware;
>  };
>  
>  static inline struct drm_fb_helper *

-- 
Regards,

Laurent Pinchart
