Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1953C4B29A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350101AbiBKQFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:05:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349786AbiBKQFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:05:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D983812C;
        Fri, 11 Feb 2022 08:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644595513; x=1676131513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pTgOuzm7jCaTfwCYp5a9jm8xnylwK40ORkaUjtK0E8Y=;
  b=kN/YkMu85heGD3bXcZuGqY6z1dtqZI4xa8w0JVXPOTqrF6GN5pwC36wI
   mxIzCoDX+fmNFvJ/e1gu1iirJ1kPR/hvOxmlHd+KWxGbyiuy2+1NqhkBX
   sH/BBeOatzMdp0rbAp/hIm90hh+bQngolHkOeYHbM/9Lzwhp4b7hDDXXK
   cIEG6tt87coJIDdXGiXEnaJ0cbYAH8Q0mz/zefbSMLwU3MBD97lqxNOIn
   Ja64W38NxDRBAqtZIdFig+z0RBoo+jW0b/l7zdolq2vCVh+fhXYOv/Lcc
   HP31EFWDOzJBTKWfD2S8rzjWXSQylS5NBvu0Ms+E8S2WO586B4dmjfN8I
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249504903"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="249504903"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:05:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="500817793"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:05:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nIYP6-003Uy5-Hr;
        Fri, 11 Feb 2022 18:04:12 +0200
Date:   Fri, 11 Feb 2022 18:04:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v5 2/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_mono_reversed()
Message-ID: <YgaI/Kz8hl1Nut+V@smile.fi.intel.com>
References: <20220211143358.3112958-1-javierm@redhat.com>
 <20220211143358.3112958-3-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211143358.3112958-3-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 03:33:54PM +0100, Javier Martinez Canillas wrote:
> Add support to convert from XR24 to reversed monochrome for drivers that
> control monochromatic display panels, that only have 1 bit per pixel.
> 
> The function does a line-by-line conversion doing an intermediate step
> first from XR24 to 8-bit grayscale and then to reversed monochrome.
> 
> The drm_fb_gray8_to_mono_reversed_line() helper was based on code from
> drivers/gpu/drm/tiny/repaper.c driver.


I believe there is enough room for (micro-)optimizations (like moving out
invariant conditionals from the loop), but since it's almost a direct copy
of the existing code let's improve it later on.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
> 
> Changes in v5:
> - Use drm_WARN_ON* macros instead of deprecated ones (Thomas Zimmermann)
> 
> Changes in v4:
> - Rename end_offset to end_len (Thomas Zimmermann)
> - Warn once if dst_pitch is not a multiple of 8 (Thomas Zimmermann)
> - Drop drm_fb_gray8_to_mono_reversed() that's not used (Thomas Zimmermann)
> - Allocate single buffer for both copy cma memory and gray8 (Thomas Zimmermann)
> - Add Thomas Zimmermann Reviewed-by tag to patch adding XR24 -> mono helper.
> 
> Changes in v3:
> - Also add a drm_fb_xrgb8888_to_mono_reversed() helper (Thomas Zimmermann)
> - Split lines copy to drm_fb_gray8_to_mono_reversed_line() (Thomas Zimmermann)
> - Handle case where the source buffer is not aligned to 8 (Thomas Zimmermann)
> 
>  drivers/gpu/drm/drm_format_helper.c | 110 ++++++++++++++++++++++++++++
>  include/drm/drm_format_helper.h     |   4 +
>  2 files changed, 114 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index b981712623d3..bc0f49773868 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -12,9 +12,11 @@
>  #include <linux/slab.h>
>  #include <linux/io.h>
>  
> +#include <drm/drm_device.h>
>  #include <drm/drm_format_helper.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_fourcc.h>
> +#include <drm/drm_print.h>
>  #include <drm/drm_rect.h>
>  
>  static unsigned int clip_offset(const struct drm_rect *clip, unsigned int pitch, unsigned int cpp)
> @@ -591,3 +593,111 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
>  	return -EINVAL;
>  }
>  EXPORT_SYMBOL(drm_fb_blit_toio);
> +
> +static void drm_fb_gray8_to_mono_reversed_line(u8 *dst, const u8 *src, unsigned int pixels,
> +					       unsigned int start_offset, unsigned int end_len)
> +{
> +	unsigned int xb, i;
> +
> +	for (xb = 0; xb < pixels; xb++) {
> +		unsigned int start = 0, end = 8;
> +		u8 byte = 0x00;

> +		if (xb == 0 && start_offset)
> +			start = start_offset;

Just to point out again, this is 100% invariant and may be moved out.

> +		if (xb == pixels - 1 && end_len)
> +			end = end_len;

This one almost, can be moved out after refactoring.

> +		for (i = start; i < end; i++) {
> +			unsigned int x = xb * 8 + i;
> +
> +			byte >>= 1;
> +			if (src[x] >> 7)
> +				byte |= BIT(7);
> +		}
> +		*dst++ = byte;
> +	}
> +}
> +
> +/**
> + * drm_fb_xrgb8888_to_mono_reversed - Convert XRGB8888 to reversed monochrome
> + * @dst: reversed monochrome destination buffer
> + * @dst_pitch: Number of bytes between two consecutive scanlines within dst
> + * @src: XRGB8888 source buffer
> + * @fb: DRM framebuffer
> + * @clip: Clip rectangle area to copy
> + *
> + * DRM doesn't have native monochrome support.
> + * Such drivers can announce the commonly supported XR24 format to userspace
> + * and use this function to convert to the native format.
> + *
> + * This function uses drm_fb_xrgb8888_to_gray8() to convert to grayscale and
> + * then the result is converted from grayscale to reversed monohrome.
> + */
> +void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *vaddr,
> +				      const struct drm_framebuffer *fb, const struct drm_rect *clip)
> +{
> +	unsigned int linepixels = drm_rect_width(clip);
> +	unsigned int lines = clip->y2 - clip->y1;
> +	unsigned int cpp = fb->format->cpp[0];
> +	unsigned int len_src32 = linepixels * cpp;
> +	struct drm_device *dev = fb->dev;
> +	unsigned int start_offset, end_len;
> +	unsigned int y;
> +	u8 *mono = dst, *gray8;
> +	u32 *src32;
> +
> +	if (drm_WARN_ON(dev, fb->format->format != DRM_FORMAT_XRGB8888))
> +		return;
> +
> +	/*
> +	 * The reversed mono destination buffer contains 1 bit per pixel
> +	 * and destination scanlines have to be in multiple of 8 pixels.
> +	 */
> +	if (!dst_pitch)
> +		dst_pitch = DIV_ROUND_UP(linepixels, 8);
> +
> +	drm_WARN_ONCE(dev, dst_pitch % 8 != 0, "dst_pitch is not a multiple of 8\n");
> +
> +	/*
> +	 * The cma memory is write-combined so reads are uncached.
> +	 * Speed up by fetching one line at a time.
> +	 *
> +	 * Also, format conversion from XR24 to reversed monochrome
> +	 * are done line-by-line but are converted to 8-bit grayscale
> +	 * as an intermediate step.
> +	 *
> +	 * Allocate a buffer to be used for both copying from the cma
> +	 * memory and to store the intermediate grayscale line pixels.
> +	 */
> +	src32 = kmalloc(len_src32 + linepixels, GFP_KERNEL);
> +	if (!src32)
> +		return;
> +
> +	gray8 = (u8 *)src32 + len_src32;
> +
> +	/*
> +	 * For damage handling, it is possible that only parts of the source
> +	 * buffer is copied and this could lead to start and end pixels that
> +	 * are not aligned to multiple of 8.
> +	 *
> +	 * Calculate if the start and end pixels are not aligned and set the
> +	 * offsets for the reversed mono line conversion function to adjust.
> +	 */
> +	start_offset = clip->x1 % 8;
> +	end_len = clip->x2 % 8;
> +
> +	vaddr += clip_offset(clip, fb->pitches[0], cpp);
> +	for (y = 0; y < lines; y++) {
> +		src32 = memcpy(src32, vaddr, len_src32);
> +		drm_fb_xrgb8888_to_gray8_line(gray8, src32, linepixels);
> +		drm_fb_gray8_to_mono_reversed_line(mono, gray8, dst_pitch,
> +						   start_offset, end_len);
> +		vaddr += fb->pitches[0];
> +		mono += dst_pitch;
> +	}
> +
> +	kfree(src32);
> +}
> +EXPORT_SYMBOL(drm_fb_xrgb8888_to_mono_reversed);
> diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
> index b30ed5de0a33..0b0937c0b2f6 100644
> --- a/include/drm/drm_format_helper.h
> +++ b/include/drm/drm_format_helper.h
> @@ -43,4 +43,8 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
>  		     const void *vmap, const struct drm_framebuffer *fb,
>  		     const struct drm_rect *rect);
>  
> +void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *src,
> +				      const struct drm_framebuffer *fb,
> +				      const struct drm_rect *clip);
> +
>  #endif /* __LINUX_DRM_FORMAT_HELPER_H */
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


