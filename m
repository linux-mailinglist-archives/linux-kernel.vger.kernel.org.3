Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9140B46D3F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhLHNHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:07:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:18613 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232257AbhLHNHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:07:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="217849145"
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="217849145"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 05:04:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="658278402"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga001.fm.intel.com with SMTP; 08 Dec 2021 05:04:17 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 08 Dec 2021 15:04:17 +0200
Date:   Wed, 8 Dec 2021 15:04:17 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     cgel.zte@gmail.com
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] drm/i915/display: Delete redundant post_mask
 assignment
Message-ID: <YbCtUZUSbEpCuDoi@intel.com>
References: <20211208074619.404138-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211208074619.404138-1-luo.penghao@zte.com.cn>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 07:46:19AM +0000, cgel.zte@gmail.com wrote:
> From: luo penghao <luo.penghao@zte.com.cn>
> 
> This value will be overwritten by the following if statement, even
> if the if is not executed, the value will not be used
> 
> The clang_analyzer complains as follows:
> 
> Value stored to 'port_mask' is never read
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> ---
>  drivers/gpu/drm/i915/display/intel_ddi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
> index bd18432..3aad0c3 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -2011,7 +2011,6 @@ void intel_ddi_sanitize_encoder_pll_mapping(struct intel_encoder *encoder)
>  			return;
>  	}
>  
> -	port_mask = BIT(encoder->port);
>  	ddi_clk_needed = encoder->base.crtc;
>  
>  	if (encoder->type == INTEL_OUTPUT_DSI) {

'port_mask' declaration could now be moved into this block.

> -- 
> 2.15.2
> 

-- 
Ville Syrjälä
Intel
