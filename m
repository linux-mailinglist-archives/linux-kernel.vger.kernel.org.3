Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D7848C4F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353635AbiALNhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:37:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:17380 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353672AbiALNhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641994657; x=1673530657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tNe15thysxSuAclMROXPjK3xCVI7rNteYjJI/dbvF3c=;
  b=d/fiWtrbZC0gKRuN+IrXAxVR/wP+qrA8g6bNREV58bpfJdQPVuCHeMXZ
   K97avNK3iaQD17sj8xvtZwEWh4KqwZxZxCuhxmnErvJqZK0Nhn9n8KkSO
   GSLksGGxzGOZSP9X+ymDdY5zSpGnj0JSm8qwyMJ5/zJUqgxeLGV5n24K3
   M8BMS8guNFUoUNeUJlNUG/ma1/7Vh9Q34Ct+G5RvLH57h5yu5eenSUTqR
   i7nHOiBlpFk3hJBI49e2VyvZ8UX+1xXd1Gk5hM2GJPy1OB3TmN5Zp+Fhw
   bcwWQ98Reqdh0s6BgjHLY7DxWPBO8StZLjMX//wgSx4B6HnycuyDtUUnE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="224428208"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="224428208"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 05:37:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="529175307"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.147])
  by orsmga008.jf.intel.com with SMTP; 12 Jan 2022 05:37:33 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 12 Jan 2022 15:37:32 +0200
Date:   Wed, 12 Jan 2022 15:37:32 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Ashish Arora <ashisharora.linux@outlook.com>
Cc:     "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] [PATCH - v3] drm/i915: Discard large BIOS
 framebuffers causing display corruption.
Message-ID: <Yd7ZnBlU0sjP4qcG@intel.com>
References: <31D69334-DEF9-41B7-968B-B847796926FF@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31D69334-DEF9-41B7-968B-B847796926FF@outlook.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 07:55:22AM +0000, Ashish Arora wrote:
> From: Ashish Arora <ashisharora.linux@outlook.com>
> 
> On certain 4k panels and Macs, the BIOS framebuffer is larger than what
> panel requires causing display corruption. Introduce a check for the same.

If a larger fb causes corruption then there is a real bug somewhere.

> 
> 
> Signed-off-by: Ashish Arora <ashisharora.linux@outlook.com>
> Reviewed-by: Aun-Ali Zaidi <admin@kodeit.net>
> ---
> V2 :- Use != instead of < and >
> V3 :- Mention Macs (Thanks to Orlando)
>  drivers/gpu/drm/i915/display/intel_fbdev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
> index 842c04e63..16b1c82b2 100644
> --- a/drivers/gpu/drm/i915/display/intel_fbdev.c
> +++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
> @@ -181,10 +181,10 @@ static int intelfb_create(struct drm_fb_helper *helper,
>  	int ret;
>  
>  	if (intel_fb &&
> -	    (sizes->fb_width > intel_fb->base.width ||
> -	     sizes->fb_height > intel_fb->base.height)) {
> +	    (sizes->fb_width != intel_fb->base.width ||
> +	     sizes->fb_height != intel_fb->base.height)) {
>  		drm_dbg_kms(&dev_priv->drm,
> -			    "BIOS fb too small (%dx%d), we require (%dx%d),"
> +			    "BIOS fb not valid (%dx%d), we require (%dx%d),"
>  			    " releasing it\n",
>  			    intel_fb->base.width, intel_fb->base.height,
>  			    sizes->fb_width, sizes->fb_height);
> -- 
> 2.25.1
> 

-- 
Ville Syrjälä
Intel
