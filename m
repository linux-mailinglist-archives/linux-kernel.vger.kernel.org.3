Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB04D0267
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241719AbiCGPE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243611AbiCGPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:04:11 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E606C1EC5B;
        Mon,  7 Mar 2022 07:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646665392; x=1678201392;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=umwhJdrGoC63TnJH8ZK3SWSf8crbwjpWewFR8Jdg3UA=;
  b=yJoIAlMC9/YlLI4The/YETLKcjqNk+lvefafTDFshrPPJv+lhmFNkJqF
   T0yEmatZNFfhNtakfyC0DqXW4U5EN0bAV7luKWCR03W/QY6Uy7YkTwVge
   gDSmLJPYgF3gewIHbT8xZHgN8yjhHXkVzoBHDPZqnF3WIk4x/RuPmuwcq
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Mar 2022 07:03:12 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 07:03:12 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Mar 2022 07:03:11 -0800
Received: from [10.216.32.253] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 7 Mar 2022
 07:03:05 -0800
Message-ID: <81e33d86-74f4-fead-a77e-aab5c2059996@quicinc.com>
Date:   Mon, 7 Mar 2022 20:33:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/msm/a6xx: Fix missing ARRAY_SIZE() check
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>
CC:     <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        "Rob Clark" <robdclark@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        open list <linux-kernel@vger.kernel.org>
References: <20220305173405.914989-1-robdclark@gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <20220305173405.914989-1-robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/2022 11:04 PM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>
> Fixes: f6d62d091cfd ("drm/msm/a6xx: add support for Adreno 660 GPU")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 02b47977b5c3..83c31b2ad865 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -683,19 +683,23 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
>   {
>   	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>   	const u32 *regs = a6xx_protect;
> -	unsigned i, count = ARRAY_SIZE(a6xx_protect), count_max = 32;
> -
> -	BUILD_BUG_ON(ARRAY_SIZE(a6xx_protect) > 32);
> -	BUILD_BUG_ON(ARRAY_SIZE(a650_protect) > 48);
> +	unsigned i, count, count_max;
>   
>   	if (adreno_is_a650(adreno_gpu)) {
>   		regs = a650_protect;
>   		count = ARRAY_SIZE(a650_protect);
>   		count_max = 48;
> +		BUILD_BUG_ON(ARRAY_SIZE(a650_protect) > 48);
>   	} else if (adreno_is_a660_family(adreno_gpu)) {
>   		regs = a660_protect;
>   		count = ARRAY_SIZE(a660_protect);
>   		count_max = 48;
> +		BUILD_BUG_ON(ARRAY_SIZE(a660_protect) > 48);
> +	} else {
> +		regs = a6xx_protect;
> +		count = ARRAY_SIZE(a6xx_protect);
> +		count_max = 32;
> +		BUILD_BUG_ON(ARRAY_SIZE(a6xx_protect) > 32);
>   	}
>   
>   	/*
Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>

-Akhil.
