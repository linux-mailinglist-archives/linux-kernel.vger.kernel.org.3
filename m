Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F54534BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbiEZIt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245149AbiEZItU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:49:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12B1EC3D1A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:49:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B237A1477;
        Thu, 26 May 2022 01:49:18 -0700 (PDT)
Received: from [10.1.37.22] (e122027.cambridge.arm.com [10.1.37.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA9103F93E;
        Thu, 26 May 2022 01:49:15 -0700 (PDT)
Message-ID: <69f132c4-22b0-7cee-96a5-032ca745418b@arm.com>
Date:   Thu, 26 May 2022 09:49:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 8/9] drm/panfrost: Add Mali-G57 "Natt" support
Content-Language: en-GB
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org
References: <20220525145754.25866-1-alyssa.rosenzweig@collabora.com>
 <20220525145754.25866-9-alyssa.rosenzweig@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20220525145754.25866-9-alyssa.rosenzweig@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2022 15:57, Alyssa Rosenzweig wrote:
> Add the features, issues, and GPU ID for Mali-G57, a first-generation
> Valhall GPU. Other first- and second-generation Valhall GPUs should be
> similar.
> 
> v2: Split out issue list for r0p0 from newer Natt GPUs, as TTRX_3485 was
> fixed in r0p1. Unfortunately, MT8192 has a r0p0, so we do need to handle
> TTRX_3485.
> 
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_features.h | 12 ++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c      |  3 +++
>  drivers/gpu/drm/panfrost/panfrost_issues.h   |  9 +++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_features.h b/drivers/gpu/drm/panfrost/panfrost_features.h
> index 1a8bdebc86a3..7ed0cd3ea2d4 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_features.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_features.h
> @@ -106,6 +106,18 @@ enum panfrost_hw_feature {
>  	BIT_ULL(HW_FEATURE_TLS_HASHING) | \
>  	BIT_ULL(HW_FEATURE_3BIT_EXT_RW_L2_MMU_CONFIG))
>  
> +#define hw_features_g57 (\
> +	BIT_ULL(HW_FEATURE_JOBCHAIN_DISAMBIGUATION) | \
> +	BIT_ULL(HW_FEATURE_PWRON_DURING_PWROFF_TRANS) | \
> +	BIT_ULL(HW_FEATURE_XAFFINITY) | \
> +	BIT_ULL(HW_FEATURE_FLUSH_REDUCTION) | \
> +	BIT_ULL(HW_FEATURE_PROTECTED_MODE) | \
> +	BIT_ULL(HW_FEATURE_PROTECTED_DEBUG_MODE) | \
> +	BIT_ULL(HW_FEATURE_COHERENCY_REG) | \
> +	BIT_ULL(HW_FEATURE_AARCH64_MMU) | \
> +	BIT_ULL(HW_FEATURE_IDVS_GROUP_SIZE) | \
> +	BIT_ULL(HW_FEATURE_CLEAN_ONLY_SAFE))
> +
>  static inline bool panfrost_has_hw_feature(struct panfrost_device *pfdev,
>  					   enum panfrost_hw_feature feat)
>  {
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index e1a6e763d0dc..6452e4e900dd 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -201,6 +201,9 @@ static const struct panfrost_model gpu_models[] = {
>  	GPU_MODEL(g52, 0x7002),
>  	GPU_MODEL(g31, 0x7003,
>  		GPU_REV(g31, 1, 0)),
> +
> +	GPU_MODEL(g57, 0x9001,
> +		GPU_REV(g57, 0, 0)),
>  };
>  
>  static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_issues.h b/drivers/gpu/drm/panfrost/panfrost_issues.h
> index 4d41e0a13867..c5fa9e897a35 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_issues.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_issues.h
> @@ -258,6 +258,15 @@ enum panfrost_hw_issue {
>  
>  #define hw_issues_g76 0
>  
> +#define hw_issues_g57 (\
> +	BIT_ULL(HW_ISSUE_TTRX_2968_TTRX_3162) | \
> +	BIT_ULL(HW_ISSUE_TTRX_3076))
> +
> +#define hw_issues_g57_r0p0 (\
> +	BIT_ULL(HW_ISSUE_TTRX_2968_TTRX_3162) | \
> +	BIT_ULL(HW_ISSUE_TTRX_3076) | \
> +	BIT_ULL(HW_ISSUE_TTRX_3485))

There's no need to repeat the issues that are generic for g57 in the
r0p0 list. So this can be simplified to:

 #define hw_issues_g57_r0p0 (\
 	BIT_ULL(HW_ISSUE_TTRX_3485))

With that fixed:

Reviewed-by: Steven Price <steven.price@arm.com>

> +
>  static inline bool panfrost_has_hw_issue(const struct panfrost_device *pfdev,
>  					 enum panfrost_hw_issue issue)
>  {

