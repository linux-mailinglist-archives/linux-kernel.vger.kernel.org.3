Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBB447B3FD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhLTTwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:52:12 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:24578 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232942AbhLTTwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640029930; x=1671565930;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JNN1uzilupz3x6T8siWug0oHtxLE5fcKr4idYesvVD0=;
  b=B6tCB1A3TyPaAjpjqRNT4j8byQWPQ0bvG6/ylSw8wnt9qSchqwFFFyi6
   tli5mgy56jh4+aRGLUTE1Pf6b9eZAwacYqpok5oROV479B9GP2iIj0MmE
   XjxpHMRBq4gz+i1yi/ujHhZ5eDAMhcxM5Uon3VD4qCCy76s/jmqHdD20b
   c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Dec 2021 11:52:07 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 11:52:07 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 11:52:07 -0800
Received: from [10.111.163.90] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 20 Dec
 2021 11:52:04 -0800
Message-ID: <68dd102a-ac6b-bbe3-64b6-53ce622ca8e5@quicinc.com>
Date:   Mon, 20 Dec 2021 11:52:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v6] drm/msm/dp: Add sc8180x DP controllers
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20211217002643.2305526-1-bjorn.andersson@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20211217002643.2305526-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/2021 4:26 PM, Bjorn Andersson wrote:
> The sc8180x has 2 DP and 1 eDP controllers, add support for these to the
> DP driver.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
> 
> Changes since v5:
> - Dropped DPU hw catalog change from the patch
> - Rebased the patch
> 
>   drivers/gpu/drm/msm/dp/dp_display.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 8d9c19dbf33e..a9f5368559b4 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -143,10 +143,21 @@ static const struct msm_dp_config sc7280_dp_cfg = {
>   	.num_descs = 2,
>   };
>   
> +static const struct msm_dp_config sc8180x_dp_cfg = {
> +	.descs = (const struct msm_dp_desc[]) {
> +		[MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> +		[MSM_DP_CONTROLLER_1] = { .io_start = 0x0ae98000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> +		[MSM_DP_CONTROLLER_2] = { .io_start = 0x0ae9a000, .connector_type = DRM_MODE_CONNECTOR_eDP },
> +	},
> +	.num_descs = 3,
> +};
> +
>   static const struct of_device_id dp_dt_match[] = {
>   	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_cfg },
>   	{ .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_cfg },
>   	{ .compatible = "qcom,sc7280-edp", .data = &sc7280_dp_cfg },
> +	{ .compatible = "qcom,sc8180x-dp", .data = &sc8180x_dp_cfg },
> +	{ .compatible = "qcom,sc8180x-edp", .data = &sc8180x_dp_cfg },
>   	{}
>   };
>   
