Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1904B91BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiBPTta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:49:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238313AbiBPTtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:49:24 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3680202068;
        Wed, 16 Feb 2022 11:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645040951; x=1676576951;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uttn9/DySER6QLvzk9CdFYOB7YGwLWPHJwLCb82MXjs=;
  b=GeplCpSTgNqI3KyGVX5tJ1AdWTpynDUArU4iE34ooMR4pQTQbEe1/q18
   x6Y9+QjK0xsx3UBbaDErwX3vE6lOmrPjYCwzd2kSeW2n40cZFkq8aZo1A
   fX8hSw9azQ8RzfO0P1ag+bQQT+A6RGM752kY1sebmJKXL5ozV5Y1ylh4o
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 16 Feb 2022 11:49:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 11:49:11 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 11:49:10 -0800
Received: from [10.111.168.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 16 Feb
 2022 11:49:08 -0800
Message-ID: <a65a62ab-427f-3a5a-b633-2c457f797dab@quicinc.com>
Date:   Wed, 16 Feb 2022 11:49:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [REPOST PATCH v4 04/13] drm/msm/disp/dpu1: Add support for DSC in
 pingpong block
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-5-vkoul@kernel.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220210103423.271016-5-vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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



On 2/10/2022 2:34 AM, Vinod Koul wrote:
> In SDM845, DSC can be enabled by writing to pingpong block registers, so
> add support for DSC in hw_pp
> 
> Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>

For the sake of uniformity, please use

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c   | 32 +++++++++++++++++++
>   .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h   | 14 ++++++++
>   2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> index 55766c97c4c8..47c6ab6caf95 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> @@ -28,6 +28,9 @@
>   #define PP_FBC_MODE                     0x034
>   #define PP_FBC_BUDGET_CTL               0x038
>   #define PP_FBC_LOSSY_MODE               0x03C
> +#define PP_DSC_MODE                     0x0a0
> +#define PP_DCE_DATA_IN_SWAP             0x0ac
> +#define PP_DCE_DATA_OUT_SWAP            0x0c8
>   
>   #define PP_DITHER_EN			0x000
>   #define PP_DITHER_BITDEPTH		0x004
> @@ -245,6 +248,32 @@ static u32 dpu_hw_pp_get_line_count(struct dpu_hw_pingpong *pp)
>   	return line;
>   }
>   
> +static int dpu_hw_pp_dsc_enable(struct dpu_hw_pingpong *pp)
> +{
> +	struct dpu_hw_blk_reg_map *c = &pp->hw;
> +
> +	DPU_REG_WRITE(c, PP_DSC_MODE, 1);
> +	return 0;
> +}
> +
> +static void dpu_hw_pp_dsc_disable(struct dpu_hw_pingpong *pp)
> +{
> +	struct dpu_hw_blk_reg_map *c = &pp->hw;
> +
> +	DPU_REG_WRITE(c, PP_DSC_MODE, 0);
> +}
> +
> +static int dpu_hw_pp_setup_dsc(struct dpu_hw_pingpong *pp)
> +{
> +	struct dpu_hw_blk_reg_map *pp_c = &pp->hw;
> +	int data;
> +
> +	data = DPU_REG_READ(pp_c, PP_DCE_DATA_OUT_SWAP);
> +	data |= BIT(18); /* endian flip */
> +	DPU_REG_WRITE(pp_c, PP_DCE_DATA_OUT_SWAP, data);
> +	return 0;
> +}
> +
>   static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
>   				unsigned long features)
>   {
> @@ -256,6 +285,9 @@ static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
>   	c->ops.get_autorefresh = dpu_hw_pp_get_autorefresh_config;
>   	c->ops.poll_timeout_wr_ptr = dpu_hw_pp_poll_timeout_wr_ptr;
>   	c->ops.get_line_count = dpu_hw_pp_get_line_count;
> +	c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
> +	c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
> +	c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
>   
>   	if (test_bit(DPU_PINGPONG_DITHER, &features))
>   		c->ops.setup_dither = dpu_hw_pp_setup_dither;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
> index 89d08a715c16..12758468d9ca 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
> @@ -124,6 +124,20 @@ struct dpu_hw_pingpong_ops {
>   	 */
>   	void (*setup_dither)(struct dpu_hw_pingpong *pp,
>   			struct dpu_hw_dither_cfg *cfg);
> +	/**
> +	 * Enable DSC
> +	 */
> +	int (*enable_dsc)(struct dpu_hw_pingpong *pp);
> +
> +	/**
> +	 * Disable DSC
> +	 */
> +	void (*disable_dsc)(struct dpu_hw_pingpong *pp);
> +
> +	/**
> +	 * Setup DSC
> +	 */
> +	int (*setup_dsc)(struct dpu_hw_pingpong *pp);
>   };
>   
>   struct dpu_hw_merge_3d;
