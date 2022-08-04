Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285B9589523
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 02:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbiHDAMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 20:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiHDAMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 20:12:51 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C364B48D;
        Wed,  3 Aug 2022 17:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659571971; x=1691107971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=06hoXfj0l/m4jLS8OfPlNj8veo6ll8SvlYcusmzMU+E=;
  b=g0tPaEOKNhpaNuJQ/o4k8xjzDlJLDH0BckzZneCK8BiNQjHQCBKrJBii
   ovALH/+Po/b4QraCsnimoQJADqlQealT+7ECbwkdVS2XpUnPWtzgSOx7U
   ZM12up1l6gplWJWkXxjuBlk0R6LpOHWUm48dMxWmEBGXIcRz7uHm8JenJ
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 03 Aug 2022 17:12:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 17:12:50 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 3 Aug 2022 17:12:29 -0700
Received: from [10.38.247.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 3 Aug 2022
 17:12:25 -0700
Message-ID: <6e6aeb9d-9ced-a5b8-1461-bca9f4135b20@quicinc.com>
Date:   Wed, 3 Aug 2022 17:12:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 1/6] drm/msm/dsi: Fix number of regulators for
 msm8996_dsi_cfg
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>, Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        "Archit Taneja" <architt@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        <linux-kernel@vger.kernel.org>
References: <20220802223738.898592-1-dianders@chromium.org>
 <20220802153434.v3.1.I1056ee3f77f71287f333279efe4c85f88d403f65@changeid>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220802153434.v3.1.I1056ee3f77f71287f333279efe4c85f88d403f65@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2022 3:37 PM, Douglas Anderson wrote:
> 3 regulators are specified listed but the number 2 is specified. Fix
> it.
> 
> Fixes: 3a3ff88a0fc1 ("drm/msm/dsi: Add 8x96 info in dsi_cfg")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Will queue this for -fixes.

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - ("Fix number of regulators for msm8996_dsi_cfg") new for v2.
> 
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index 2c23324a2296..02000a7b7a18 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -109,7 +109,7 @@ static const char * const dsi_8996_bus_clk_names[] = {
>   static const struct msm_dsi_config msm8996_dsi_cfg = {
>   	.io_offset = DSI_6G_REG_SHIFT,
>   	.reg_cfg = {
> -		.num = 2,
> +		.num = 3,
>   		.regs = {
>   			{"vdda", 18160, 1 },	/* 1.25 V */
>   			{"vcca", 17000, 32 },	/* 0.925 V */
