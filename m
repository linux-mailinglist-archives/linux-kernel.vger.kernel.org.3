Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D719F4D9C51
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348738AbiCONes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiCONen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:34:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC16443
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647351210; x=1678887210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D753HrqVmrjDKz+ykXQANBb4BzCmuVTg7aOXETg8/y0=;
  b=OlooL0ecTGHhjhIES52NH5kLKRmrhAOTel57JGDdnWFr4xieZmDwEiDm
   LojT/SGtJw1YFO7diO5JEsaBipBjz91KfpOUK3PRzczD17Uk8zcxcyRoZ
   ON8OhkwhP4biEIizt1D082qijDCJ758rZAt8WSnzoMrGha2aoNgfHx1JK
   KMN0tL0nuXtV8Q9Ly3/ZywzvYKXPy5XPCImIRk/8CHQud+hFbQvIpvzqz
   Ooj4MYSvyhZk+i662cBQ5YOHMj6DCAJ84N6WTbd30pEqP/eAOgG9VytjC
   N33mfUZhh9TsXC//mq0b0ZIY0505+HOrvO8jv0XJalq6lyqJHY+s3GUhj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281070123"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="281070123"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:33:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="498014049"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:33:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nU7I2-000HXw-GJ;
        Tue, 15 Mar 2022 15:32:42 +0200
Date:   Tue, 15 Mar 2022 15:32:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/format-helper: Rename
 drm_fb_xrgb8888_to_mono_reversed()
Message-ID: <YjCVesysvfpKNilD@smile.fi.intel.com>
References: <20220315110707.628166-1-geert@linux-m68k.org>
 <20220315110707.628166-2-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315110707.628166-2-geert@linux-m68k.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 12:07:03PM +0100, Geert Uytterhoeven wrote:
> There is no "reversed" handling in drm_fb_xrgb8888_to_mono_reversed():
> the function just converts from color to grayscale, and reduces the
> number of grayscale levels from 256 to 2 (i.e. brightness 0-127 is
> mapped to 0, 128-255 to 1).  All "reversed" handling is done in the
> repaper driver, where this function originated.
> 
> Hence make this clear by renaming drm_fb_xrgb8888_to_mono_reversed() to
> drm_fb_xrgb8888_to_mono(), and documenting the black/white pixel
> mapping.

W/ or w/o the below remark being addressed
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: bcf8b616deb87941 ("drm/format-helper: Add drm_fb_xrgb8888_to_mono_reversed()")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/gpu/drm/drm_format_helper.c | 32 ++++++++++++++---------------
>  drivers/gpu/drm/solomon/ssd130x.c   |  2 +-
>  drivers/gpu/drm/tiny/repaper.c      |  2 +-
>  include/drm/drm_format_helper.h     |  5 ++---
>  4 files changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index bc0f49773868a9b0..b68aa857c6514529 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -594,8 +594,8 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
>  }
>  EXPORT_SYMBOL(drm_fb_blit_toio);
>  
> -static void drm_fb_gray8_to_mono_reversed_line(u8 *dst, const u8 *src, unsigned int pixels,
> -					       unsigned int start_offset, unsigned int end_len)
> +static void drm_fb_gray8_to_mono_line(u8 *dst, const u8 *src, unsigned int pixels,
> +				      unsigned int start_offset, unsigned int end_len)
>  {
>  	unsigned int xb, i;
>  
> @@ -621,8 +621,8 @@ static void drm_fb_gray8_to_mono_reversed_line(u8 *dst, const u8 *src, unsigned
>  }
>  
>  /**
> - * drm_fb_xrgb8888_to_mono_reversed - Convert XRGB8888 to reversed monochrome
> - * @dst: reversed monochrome destination buffer
> + * drm_fb_xrgb8888_to_mono - Convert XRGB8888 to monochrome
> + * @dst: monochrome destination buffer (0=black, 1=white)
>   * @dst_pitch: Number of bytes between two consecutive scanlines within dst
>   * @src: XRGB8888 source buffer
>   * @fb: DRM framebuffer
> @@ -633,10 +633,10 @@ static void drm_fb_gray8_to_mono_reversed_line(u8 *dst, const u8 *src, unsigned
>   * and use this function to convert to the native format.
>   *
>   * This function uses drm_fb_xrgb8888_to_gray8() to convert to grayscale and
> - * then the result is converted from grayscale to reversed monohrome.
> + * then the result is converted from grayscale to monochrome.
>   */
> -void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *vaddr,
> -				      const struct drm_framebuffer *fb, const struct drm_rect *clip)
> +void drm_fb_xrgb8888_to_mono(void *dst, unsigned int dst_pitch, const void *vaddr,
> +			     const struct drm_framebuffer *fb, const struct drm_rect *clip)
>  {
>  	unsigned int linepixels = drm_rect_width(clip);
>  	unsigned int lines = clip->y2 - clip->y1;
> @@ -652,8 +652,8 @@ void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const v
>  		return;
>  
>  	/*
> -	 * The reversed mono destination buffer contains 1 bit per pixel
> -	 * and destination scanlines have to be in multiple of 8 pixels.
> +	 * The mono destination buffer contains 1 bit per pixel and
> +	 * destination scanlines have to be in multiple of 8 pixels.
>  	 */
>  	if (!dst_pitch)
>  		dst_pitch = DIV_ROUND_UP(linepixels, 8);
> @@ -664,9 +664,9 @@ void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const v
>  	 * The cma memory is write-combined so reads are uncached.
>  	 * Speed up by fetching one line at a time.
>  	 *
> -	 * Also, format conversion from XR24 to reversed monochrome
> -	 * are done line-by-line but are converted to 8-bit grayscale
> -	 * as an intermediate step.
> +	 * Also, format conversion from XR24 to monochrome are done
> +	 * line-by-line but are converted to 8-bit grayscale as an
> +	 * intermediate step.
>  	 *
>  	 * Allocate a buffer to be used for both copying from the cma
>  	 * memory and to store the intermediate grayscale line pixels.
> @@ -683,7 +683,7 @@ void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const v
>  	 * are not aligned to multiple of 8.
>  	 *
>  	 * Calculate if the start and end pixels are not aligned and set the
> -	 * offsets for the reversed mono line conversion function to adjust.
> +	 * offsets for the mono line conversion function to adjust.
>  	 */
>  	start_offset = clip->x1 % 8;
>  	end_len = clip->x2 % 8;
> @@ -692,12 +692,12 @@ void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const v
>  	for (y = 0; y < lines; y++) {
>  		src32 = memcpy(src32, vaddr, len_src32);
>  		drm_fb_xrgb8888_to_gray8_line(gray8, src32, linepixels);
> -		drm_fb_gray8_to_mono_reversed_line(mono, gray8, dst_pitch,
> -						   start_offset, end_len);

> +		drm_fb_gray8_to_mono_line(mono, gray8, dst_pitch, start_offset,
> +					  end_len);

Can be one line now (definition is already quite behind 80 limit).

>  		vaddr += fb->pitches[0];
>  		mono += dst_pitch;
>  	}
>  
>  	kfree(src32);
>  }
> -EXPORT_SYMBOL(drm_fb_xrgb8888_to_mono_reversed);
> +EXPORT_SYMBOL(drm_fb_xrgb8888_to_mono);
> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
> index d08d86ef07bcbe7f..caee851efd5726e7 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> @@ -458,7 +458,7 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_m
>  	if (!buf)
>  		return -ENOMEM;
>  
> -	drm_fb_xrgb8888_to_mono_reversed(buf, 0, vmap, fb, rect);
> +	drm_fb_xrgb8888_to_mono(buf, 0, vmap, fb, rect);
>  
>  	ssd130x_update_rect(ssd130x, buf, rect);
>  
> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
> index 37b6bb90e46e1fe8..a096fb8b83e99dc8 100644
> --- a/drivers/gpu/drm/tiny/repaper.c
> +++ b/drivers/gpu/drm/tiny/repaper.c
> @@ -540,7 +540,7 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb)
>  	if (ret)
>  		goto out_free;
>  
> -	drm_fb_xrgb8888_to_mono_reversed(buf, 0, cma_obj->vaddr, fb, &clip);
> +	drm_fb_xrgb8888_to_mono(buf, 0, cma_obj->vaddr, fb, &clip);
>  
>  	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
>  
> diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
> index 0b0937c0b2f6324e..55145eca07828321 100644
> --- a/include/drm/drm_format_helper.h
> +++ b/include/drm/drm_format_helper.h
> @@ -43,8 +43,7 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
>  		     const void *vmap, const struct drm_framebuffer *fb,
>  		     const struct drm_rect *rect);
>  
> -void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *src,
> -				      const struct drm_framebuffer *fb,
> -				      const struct drm_rect *clip);
> +void drm_fb_xrgb8888_to_mono(void *dst, unsigned int dst_pitch, const void *src,
> +			     const struct drm_framebuffer *fb, const struct drm_rect *clip);
>  
>  #endif /* __LINUX_DRM_FORMAT_HELPER_H */
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


