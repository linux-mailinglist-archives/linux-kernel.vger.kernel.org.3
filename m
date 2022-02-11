Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C54B2985
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349692AbiBKP7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:59:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbiBKP7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:59:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9BB1CF;
        Fri, 11 Feb 2022 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644595186; x=1676131186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RDag2sLQw7yjw60O76iuryrZarkSSGzwMGlkJnfbYWw=;
  b=g9ZG3QMwssXFJ0XuzgaOpM5c/OoRNJfWjEae1lvjiNg2a8MPRsXTCNQ9
   epa4HbMIZuvD6LMyPyns1ajK/AO6G92NgCQruPhMgiwzUdRIXou0JlQ2p
   4PHyJXUEP5ODVw6wLLG9L2Va8utMZ+sUMd+uhEA8HjLGN8gceTqDzUect
   uC3jWm1422rmf0vXGWkOLOTXb40xJrudg81dBqucJp2IUd8ohTh12S4oU
   gpEohKCQJySDO1YI7axbqiqjKwHuBgqoRQ7oyxSZjf0Ek6pLJUsZGBhvl
   YJ7uF4CKPghEFh+Igju9fOK9g54os0Aq0F+e9FbfdK8hjzAKbf1bRL3eU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="233308011"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="233308011"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 07:59:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="602407145"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 07:59:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nIYJo-003Usa-NZ;
        Fri, 11 Feb 2022 17:58:44 +0200
Date:   Fri, 11 Feb 2022 17:58:44 +0200
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
Subject: Re: [PATCH v5 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
Message-ID: <YgaHtHZws8GOUPAk@smile.fi.intel.com>
References: <20220211143358.3112958-1-javierm@redhat.com>
 <20220211143358.3112958-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211143358.3112958-2-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 03:33:53PM +0100, Javier Martinez Canillas wrote:
> Pull the per-line conversion logic into a separate helper function.
> 
> This will allow to do line-by-line conversion in other helpers that
> convert to a gray8 format.

for-loop vs. while-loop is not critical, so
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
> 
> Changes in v5:
> - Add Thomas Zimmermann's Reviewed-by to patch #1.
> 
> Changes in v3:
> - Add a drm_fb_xrgb8888_to_gray8_line() helper function (Thomas Zimmermann)
> 
>  drivers/gpu/drm/drm_format_helper.c | 31 ++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index 0f28dd2bdd72..b981712623d3 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -464,6 +464,21 @@ void drm_fb_xrgb8888_to_xrgb2101010_toio(void __iomem *dst,
>  }
>  EXPORT_SYMBOL(drm_fb_xrgb8888_to_xrgb2101010_toio);
>  
> +static void drm_fb_xrgb8888_to_gray8_line(u8 *dst, const u32 *src, unsigned int pixels)
> +{
> +	unsigned int x;
> +
> +	for (x = 0; x < pixels; x++) {
> +		u8 r = (*src & 0x00ff0000) >> 16;
> +		u8 g = (*src & 0x0000ff00) >> 8;
> +		u8 b =  *src & 0x000000ff;
> +
> +		/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
> +		*dst++ = (3 * r + 6 * g + b) / 10;
> +		src++;
> +	}
> +}
> +
>  /**
>   * drm_fb_xrgb8888_to_gray8 - Convert XRGB8888 to grayscale
>   * @dst: 8-bit grayscale destination buffer
> @@ -484,8 +499,9 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_xrgb2101010_toio);
>  void drm_fb_xrgb8888_to_gray8(void *dst, unsigned int dst_pitch, const void *vaddr,
>  			      const struct drm_framebuffer *fb, const struct drm_rect *clip)
>  {
> -	unsigned int len = (clip->x2 - clip->x1) * sizeof(u32);
> -	unsigned int x, y;
> +	unsigned int linepixels = clip->x2 - clip->x1;
> +	unsigned int len = linepixels * sizeof(u32);
> +	unsigned int y;
>  	void *buf;
>  	u8 *dst8;
>  	u32 *src32;
> @@ -508,16 +524,7 @@ void drm_fb_xrgb8888_to_gray8(void *dst, unsigned int dst_pitch, const void *vad
>  	for (y = clip->y1; y < clip->y2; y++) {
>  		dst8 = dst;
>  		src32 = memcpy(buf, vaddr, len);
> -		for (x = clip->x1; x < clip->x2; x++) {
> -			u8 r = (*src32 & 0x00ff0000) >> 16;
> -			u8 g = (*src32 & 0x0000ff00) >> 8;
> -			u8 b =  *src32 & 0x000000ff;
> -
> -			/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
> -			*dst8++ = (3 * r + 6 * g + b) / 10;
> -			src32++;
> -		}
> -
> +		drm_fb_xrgb8888_to_gray8_line(dst8, src32, linepixels);
>  		vaddr += fb->pitches[0];
>  		dst += dst_pitch;
>  	}
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


