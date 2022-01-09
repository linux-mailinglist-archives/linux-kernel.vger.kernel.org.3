Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929E2488AF1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiAIRUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbiAIRUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:20:10 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA67C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 09:20:10 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id EA2B61F43827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641748809;
        bh=XbjoPukDEoUvDU4TFiTwRRclizzVf6F0QTryuVNFJlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aNYsm0laRFxDlubfdShB5XHQPIbuYkIroD1XMDXImrF5oHIAgqNKRvcOeJpFIpd/c
         AqxjzqjRSMlgWbTl1IJwW98VcqvomqNssUGbtmcmcWAgEEMS7Vc2ypVgVus7u0z9ji
         9wBza1PA2yFfAxpMigQD0gOrjY8Xzn47R6REkMIqo7wq+s8+zWXs7dxRutVmRcDlE4
         ODrJwlFUfUdvoEm7NeF8piQFfQN2lILSlZS0/o2cI7zcHzrg2OZeGCnYSAhb61Qn+1
         GnV4hkfIY8aLc4ofgJF3FwbYGljqcb7NdXxuzvTYkK3fbqaPkUvVQxYtXQvYLf94fo
         ZzhiVf73Vgw6Q==
Date:   Sun, 9 Jan 2022 12:20:03 -0500
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm/panfrost: Handle IDVS_GROUP_SIZE feature
Message-ID: <YdsZQzzZ2qm7J58x@maud>
References: <20220109171254.3183-1-alyssa.rosenzweig@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109171254.3183-1-alyssa.rosenzweig@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbase dt-bindings say that tasks are sent to cores in groups of N + 1,
where N is the value here. So our old behaviour sends tasks in groups of
1; the new behaviour sends tasks in groups of 16. I assume this has
performance implications but no conformance implications.

Searching GitHub, I can't find any device trees that set
idvs-group-size out of the many random Android forks people have
uploaded, so I don't think this will matter for any production device.
(Was this a workaround for preproduction silicon? or FPGAs? or was this
an option for the sake of having an option?)

On Sun, Jan 09, 2022 at 12:12:54PM -0500, Alyssa Rosenzweig wrote:
> The IDVS group size feature was missing. It is used on some Bifrost and
> Valhall GPUs, and is the last kernel-relevant Bifrost feature we're
> missing.
> 
> This feature adds an extra IDVS group size field to the JM_CONFIG
> register. In kbase, the value is configurable via the device tree; kbase
> uses 0xF as a default if no value is specified. Until we find a device
> demanding otherwise, let's always set the 0xF default on devices which
> support this feature mimicking kbase's behaviour.
> 
> As JM_CONFIG is an undocumented register, it's not clear to me what
> happens if we fail to include this handling. Index-driven vertex shading
> already works on Bifrost boards with this feature without this handling.
> Perhaps this has performance implications? Patch untested for the
> moment, wanted to give Steven a chance to comment.
> 
> Applies on top of my feature clean up series which should go in first.
> (That's pure cleaunp, this is a behaviour change RFC needing
> discussion.)
> 
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_features.h | 3 +++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c      | 3 +++
>  drivers/gpu/drm/panfrost/panfrost_regs.h     | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_features.h b/drivers/gpu/drm/panfrost/panfrost_features.h
> index 34f2bae1ec8c..36fadcf9634e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_features.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_features.h
> @@ -20,6 +20,7 @@ enum panfrost_hw_feature {
>  	HW_FEATURE_AARCH64_MMU,
>  	HW_FEATURE_TLS_HASHING,
>  	HW_FEATURE_THREAD_GROUP_SPLIT,
> +	HW_FEATURE_IDVS_GROUP_SIZE,
>  	HW_FEATURE_3BIT_EXT_RW_L2_MMU_CONFIG,
>  };
>  
> @@ -74,6 +75,7 @@ enum panfrost_hw_feature {
>  	BIT_ULL(HW_FEATURE_FLUSH_REDUCTION) | \
>  	BIT_ULL(HW_FEATURE_PROTECTED_MODE) | \
>  	BIT_ULL(HW_FEATURE_PROTECTED_DEBUG_MODE) | \
> +	BIT_ULL(HW_FEATURE_IDVS_GROUP_SIZE) | \
>  	BIT_ULL(HW_FEATURE_COHERENCY_REG))
>  
>  #define hw_features_g76 (\
> @@ -87,6 +89,7 @@ enum panfrost_hw_feature {
>  	BIT_ULL(HW_FEATURE_COHERENCY_REG) | \
>  	BIT_ULL(HW_FEATURE_AARCH64_MMU) | \
>  	BIT_ULL(HW_FEATURE_TLS_HASHING) | \
> +	BIT_ULL(HW_FEATURE_IDVS_GROUP_SIZE) | \
>  	BIT_ULL(HW_FEATURE_3BIT_EXT_RW_L2_MMU_CONFIG))
>  
>  #define hw_features_g31 (\
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index bbe628b306ee..50c8922694d7 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -145,6 +145,9 @@ static void panfrost_gpu_init_quirks(struct panfrost_device *pfdev)
>  		quirks |= (COHERENCY_ACE_LITE | COHERENCY_ACE) <<
>  			   JM_FORCE_COHERENCY_FEATURES_SHIFT;
>  
> +	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_IDVS_GROUP_SIZE))
> +		quirks |= JM_DEFAULT_IDVS_GROUP_SIZE << JM_IDVS_GROUP_SIZE_SHIFT;
> +
>  	if (quirks)
>  		gpu_write(pfdev, GPU_JM_CONFIG, quirks);
>  
> diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
> index 6c5a11ef1ee8..16e776cc82ea 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_regs.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
> @@ -208,6 +208,7 @@
>  #define JM_MAX_JOB_THROTTLE_LIMIT	0x3F
>  #define JM_FORCE_COHERENCY_FEATURES_SHIFT 2
>  #define JM_IDVS_GROUP_SIZE_SHIFT	16
> +#define JM_DEFAULT_IDVS_GROUP_SIZE	0xF
>  #define JM_MAX_IDVS_GROUP_SIZE		0x3F
>  
>  
> -- 
> 2.34.1
> 
