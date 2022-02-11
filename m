Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7BE4B2407
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349347AbiBKLL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:11:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238944AbiBKLL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:11:57 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7460E5D;
        Fri, 11 Feb 2022 03:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644577916; x=1676113916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bjy30kX/4V6OcKJVIXtHnRN0SCGIE0PkHV4hkmZDB68=;
  b=n1/8D8QsOYVeWRfP5rqSF/Z2B6vzBm9XH759/n+aqBUHUsjBepnUT6sp
   H+JOtgnFmRQj8Rxf7kNCpgYGJWGpep9WmrRfQWDe3P1Px6zT/XOV84eVq
   vt+z9fttMMDTNkZDbl/7pZLeKUU6dq2+kFo2HMxggBHlo2YkC8tINRCkm
   2a7zhXr0UaBmJYBc7kTWNCZmnH+h+h/SAwmz9jaf/S3Salh204QRrpVLg
   wB+9c9C/xwWHXtC0ZvNGsjU3mns9kXWWmXhjirry/L2WMzhUJav99Nebe
   Z9yto4loEQZPtJBL+BL5FUaIM5oQOJrIBlybN5osyAawPScMgBA19LjnU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="312995444"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="312995444"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 03:11:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="623191994"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 03:11:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nITpG-003PxN-S9;
        Fri, 11 Feb 2022 13:10:54 +0200
Date:   Fri, 11 Feb 2022 13:10:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v4 2/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_mono_reversed()
Message-ID: <YgZEPo0ERFRloDyA@smile.fi.intel.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-3-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211091927.2988283-3-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 10:19:23AM +0100, Javier Martinez Canillas wrote:
> Add support to convert from XR24 to reversed monochrome for drivers that
> control monochromatic display panels, that only have 1 bit per pixel.
> 
> The function does a line-by-line conversion doing an intermediate step
> first from XR24 to 8-bit grayscale and then to reversed monochrome.
> 
> The drm_fb_gray8_to_mono_reversed_line() helper was based on code from
> drivers/gpu/drm/tiny/repaper.c driver.

...

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

This is invariant to the loop, can be moved out.

> +		if (xb == pixels - 1 && end_len)
> +			end = end_len;

Ditto. However it may require to factor out the following loop to a helper.

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

...

> +	/*
> +	 * The reversed mono destination buffer contains 1 bit per pixel
> +	 * and destination scanlines have to be in multiple of 8 pixels.
> +	 */
> +	if (!dst_pitch)
> +		dst_pitch = DIV_ROUND_UP(linepixels, 8);

round_up() ?

> +	WARN_ONCE(dst_pitch % 8 != 0, "dst_pitch is not a multiple of 8\n");


I would move this to the if conditional, i.e.

	if (dst_pitch)
		WARN_ONCE(dst_pitch % 8 != 0, "dst_pitch is not a multiple of 8\n");
	else
		dst_pitch = round_up(linepixels, 8);

> +	/*
> +	 * The cma memory is write-combined so reads are uncached.

CMA

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

size_add() ?

> +	if (!src32)
> +		return;

...

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

ALIGN() ?

-- 
With Best Regards,
Andy Shevchenko


