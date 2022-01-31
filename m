Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95EA4A52B0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiAaW5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiAaW5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:57:04 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915E6C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:57:04 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so3598996oot.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oODN0Uk0tb4z+k/tcsIYqCzdWivsspufHSeSYWs4aEI=;
        b=Z8coT0FXIYfkmXeBxSF7o24CDRscc7injxOVCgpWW3j7t+NT2v+/kZ7zof2beQp20e
         l22pipxS0YI5RevYjjMVIWQsEUkB570muFAlHL1TtbA9VnkYb3eWXYgHHEeZodPpi5ei
         5Hsqvx6Lr7jMXU3D8n/KthMtxSpN6pt3u1gPKHNR7eKYfDDpLpjJfie13UmjBVwk4svS
         5qQG+6TNKr4jjegqwdOPdNste+UD6KMjceWweAv2njwmlIb8NP1bMVx+BjkuOQ+LQMr9
         zHMhFvTOnRhsXI81c2ejX1QC/dXbcuhMdkbdZPQT2v6CriRec84KUukr5TN241QX8Aa1
         mLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oODN0Uk0tb4z+k/tcsIYqCzdWivsspufHSeSYWs4aEI=;
        b=47yPlP2QCZciG1QcpXlalPlbmGBf1F01DMOMbrLdHDrkGuqHl3nmmrIJuaMOXQuK4x
         y1GWvU/H3vHcTQlqAli6zccdSpauxTbCHbhLisgnmSIUb5gx3yE5p6hg9ELLLFqOCbzz
         MowW8B+6umlujSVThUpnrleBHfpPm2Olte/IViIjQ/NLEwS2xGwtsqQ3cjNI5Rg7C7OB
         xEjhdTkZaM5ILKO9lTYg/Z+63B4MnMJ0CU3l0LwOQlZregI/bckMfxfmC4DZiu3/sr28
         tm0YmhWuUmr7nOyrnpB85+IRmOYZcJCp4VUSfxlIjq5r7z9g487cVqz/g74Njz3Ez7pq
         hHFw==
X-Gm-Message-State: AOAM5316DSFt/1GyNTxDCMAkaUEBmDDyLu46aaUajwsUvay++22PakpI
        7pFOhaC/QsPWiOlLfLO1cpUbTg==
X-Google-Smtp-Source: ABdhPJx6aRuzauskRXmUzwFXRr4Xere12tBRTGPP0zZVoozfA79LCVhExz6c06Yktv8izKHbJwcmgw==
X-Received: by 2002:a9d:6858:: with SMTP id c24mr12959487oto.318.1643669823814;
        Mon, 31 Jan 2022 14:57:03 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id 21sm3832985otj.71.2022.01.31.14.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:57:03 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:57:01 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Eric Anholt <eric@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] drm/msm/adreno: Add support for Adreno 8c Gen 3
Message-ID: <YfhpPRS5dRsoNE//@builder.lan>
References: <20220119205012.v2.1.Ibac66e1e0e565313bc28f192e6c94cb508f205eb@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119205012.v2.1.Ibac66e1e0e565313bc28f192e6c94cb508f205eb@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19 Jan 09:21 CST 2022, Akhil P Oommen wrote:

> Add support for "Adreno 8c Gen 3" gpu along with the necessary speedbin
> support.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
> 
> Changes in v2:
> - Fix a bug in adreno_cmp_rev()
> 
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 21 ++++++++++++++----
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 34 +++++++++++++++++++++++++++---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 10 +++++++--
>  3 files changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 51b8377..9268ce3 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -10,7 +10,6 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/devfreq.h>
> -#include <linux/nvmem-consumer.h>
>  #include <linux/soc/qcom/llcc-qcom.h>
>  
>  #define GPU_PAS_ID 13
> @@ -1734,6 +1733,18 @@ static u32 a618_get_speed_bin(u32 fuse)
>  	return UINT_MAX;
>  }
>  
> +static u32 adreno_7c3_get_speed_bin(u32 fuse)
> +{
> +	if (fuse == 0)
> +		return 0;
> +	else if (fuse == 117)
> +		return 0;
> +	else if (fuse == 190)

Depending on your answer below this isn't an adreno_7c3 speed bin. I
think you should name this function adreno_635_get_speed_bin().

> +		return 1;
> +
> +	return UINT_MAX;
> +}
> +
>  static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
>  {
>  	u32 val = UINT_MAX;
> @@ -1741,6 +1752,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
>  	if (adreno_cmp_rev(ADRENO_REV(6, 1, 8, ANY_ID), rev))
>  		val = a618_get_speed_bin(fuse);
>  
> +	if (adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), rev))
> +		val = adreno_7c3_get_speed_bin(fuse);
> +
>  	if (val == UINT_MAX) {
>  		DRM_DEV_ERROR(dev,
>  			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware",
> @@ -1753,11 +1767,10 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
>  
>  static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
>  {
> -	u32 supp_hw = UINT_MAX;
> -	u32 speedbin;
> +	u32 speedbin, supp_hw = UINT_MAX;
>  	int ret;
>  
> -	ret = nvmem_cell_read_variable_le_u32(dev, "speed_bin", &speedbin);
> +	ret = adreno_read_speedbin(dev, &speedbin);
>  	/*
>  	 * -ENOENT means that the platform doesn't support speedbin which is
>  	 * fine
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 9300583..946f505 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -6,6 +6,7 @@
>   * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
>   */
>  
> +#include <linux/nvmem-consumer.h>
>  #include "adreno_gpu.h"
>  
>  bool hang_debug = false;
> @@ -317,6 +318,17 @@ static const struct adreno_info gpulist[] = {
>  		.zapfw = "a660_zap.mdt",
>  		.hwcg = a660_hwcg,
>  	}, {
> +		.rev = ADRENO_REV_SKU(6, 3, 5, ANY_ID, 190),

So Adreno 7c Gen 3 revision 190 is actually a 8c Gen 3?

Why can't we just keep the marketing guys out the kernel and name things
based on what they really are!?

Regards,
Bjorn

> +		.name = "Adreno 8c Gen 3",
> +		.fw = {
> +			[ADRENO_FW_SQE] = "a660_sqe.fw",
> +			[ADRENO_FW_GMU] = "a660_gmu.bin",
> +		},
> +		.gmem = SZ_512K,
> +		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> +		.init = a6xx_gpu_init,
> +		.hwcg = a660_hwcg,
> +	}, {
>  		.rev = ADRENO_REV(6, 3, 5, ANY_ID),
>  		.name = "Adreno 7c Gen 3",
>  		.fw = {
> @@ -365,13 +377,19 @@ static inline bool _rev_match(uint8_t entry, uint8_t id)
>  	return (entry == ANY_ID) || (entry == id);
>  }
>  
> +static inline bool _rev_match_sku(uint16_t entry, uint16_t id)
> +{
> +	return (entry == ANY_SKU) || (entry == id);
> +}
> +
>  bool adreno_cmp_rev(struct adreno_rev rev1, struct adreno_rev rev2)
>  {
>  
>  	return _rev_match(rev1.core, rev2.core) &&
>  		_rev_match(rev1.major, rev2.major) &&
>  		_rev_match(rev1.minor, rev2.minor) &&
> -		_rev_match(rev1.patchid, rev2.patchid);
> +		_rev_match(rev1.patchid, rev2.patchid) &&
> +		_rev_match_sku(rev1.sku, rev2.sku);
>  }
>  
>  const struct adreno_info *adreno_info(struct adreno_rev rev)
> @@ -445,12 +463,17 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
>  	return gpu;
>  }
>  
> +int adreno_read_speedbin(struct device *dev, u32 *speedbin)
> +{
> +	return nvmem_cell_read_variable_le_u32(dev, "speed_bin", speedbin);
> +}
> +
>  static int find_chipid(struct device *dev, struct adreno_rev *rev)
>  {
>  	struct device_node *node = dev->of_node;
>  	const char *compat;
>  	int ret;
> -	u32 chipid;
> +	u32 chipid, speedbin;
>  
>  	/* first search the compat strings for qcom,adreno-XYZ.W: */
>  	ret = of_property_read_string_index(node, "compatible", 0, &compat);
> @@ -466,7 +489,7 @@ static int find_chipid(struct device *dev, struct adreno_rev *rev)
>  			rev->minor = r;
>  			rev->patchid = patch;
>  
> -			return 0;
> +			goto done;
>  		}
>  	}
>  
> @@ -486,6 +509,11 @@ static int find_chipid(struct device *dev, struct adreno_rev *rev)
>  	dev_warn(dev, "Use compatible qcom,adreno-%u%u%u.%u instead.\n",
>  		rev->core, rev->major, rev->minor, rev->patchid);
>  
> +done:
> +	if (adreno_read_speedbin(dev, &speedbin))
> +		speedbin = ANY_SKU;
> +
> +	rev->sku = (uint16_t) (0xffff & speedbin);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index cffabe7..52bd93a 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -40,12 +40,16 @@ struct adreno_rev {
>  	uint8_t  major;
>  	uint8_t  minor;
>  	uint8_t  patchid;
> +	uint16_t sku;
>  };
>  
> -#define ANY_ID 0xff
> +#define ANY_ID	0xff
> +#define ANY_SKU 0xffff
>  
>  #define ADRENO_REV(core, major, minor, patchid) \
> -	((struct adreno_rev){ core, major, minor, patchid })
> +	((struct adreno_rev){ core, major, minor, patchid, ANY_SKU })
> +#define ADRENO_REV_SKU(core, major, minor, patchid, sku) \
> +	((struct adreno_rev){ core, major, minor, patchid, sku })
>  
>  struct adreno_gpu_funcs {
>  	struct msm_gpu_funcs base;
> @@ -324,6 +328,8 @@ adreno_iommu_create_address_space(struct msm_gpu *gpu,
>  
>  void adreno_set_llc_attributes(struct iommu_domain *iommu);
>  
> +int adreno_read_speedbin(struct device *dev, u32 *speedbin);
> +
>  /*
>   * For a5xx and a6xx targets load the zap shader that is used to pull the GPU
>   * out of secure mode
> -- 
> 2.7.4
> 
