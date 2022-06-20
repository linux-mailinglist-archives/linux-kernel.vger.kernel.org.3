Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F8B5520AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbiFTPZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244385AbiFTPY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:24:58 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E66EC41
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655738600; x=1687274600;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3RspoLTY/aaq8/GIIo7KFRfdh26vFE0QgbvyI/ESV+s=;
  b=jgshVBAA74ljjw6wiOxwrXeghDQwb8+x61QEWpBob83Nh6K5x1PSm73H
   RDWtwhI7w7JcCrfRb0L42t24evegaUA4Mb7pVgjG1cOZaTRDiETRp9rsS
   Y1Eh5ZupvilZlkiJiWeijeEB3n1BiXn7YH5jkOohX9K0DG9vtllKQ+YXa
   k=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 20 Jun 2022 08:23:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 08:23:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 08:23:18 -0700
Received: from [10.110.14.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 08:23:18 -0700
Message-ID: <8cc1d090-3f5a-8b30-0bf2-ccb4c9eda176@quicinc.com>
Date:   Mon, 20 Jun 2022 08:23:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/3] drm/msm/dp: Get rid of
 dp_ctrl_on_stream_phy_test_report()
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        Sean Paul <sean@poorly.run>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>
References: <20220617204750.2347797-1-swboyd@chromium.org>
 <20220617204750.2347797-4-swboyd@chromium.org>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <20220617204750.2347797-4-swboyd@chromium.org>
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


On 6/17/2022 1:47 PM, Stephen Boyd wrote:
> This API isn't really more than a couple lines now that we don't store
> the pixel_rate to the struct member. Inline it into the caller.
>
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 40 ++++++++++++--------------------
>   1 file changed, 15 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index e114521af2e9..d04fddb29fdf 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1582,34 +1582,15 @@ static bool dp_ctrl_send_phy_test_pattern(struct dp_ctrl_private *ctrl)
>   	return success;
>   }
>   
> -static int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
> +static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
>   {
>   	int ret;
> -	struct dp_ctrl_private *ctrl;
>   	unsigned long pixel_rate;
>   
> -	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
> -
> -	pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
> -	ret = dp_ctrl_enable_stream_clocks(ctrl, pixel_rate);
> -	if (ret) {
> -		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
> -		return ret;
> -	}
> -
> -	dp_ctrl_send_phy_test_pattern(ctrl);
> -
> -	return 0;
> -}
> -
> -static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
> -{
> -	int ret = 0;
> -
>   	if (!ctrl->link->phy_params.phy_test_pattern_sel) {
>   		drm_dbg_dp(ctrl->drm_dev,
>   			"no test pattern selected by sink\n");
> -		return ret;
> +		return 0;
>   	}
>   
>   	/*
> @@ -1624,12 +1605,21 @@ static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
>   	}
>   
>   	ret = dp_ctrl_on_link(&ctrl->dp_ctrl);
> -	if (!ret)
> -		ret = dp_ctrl_on_stream_phy_test_report(&ctrl->dp_ctrl);
> -	else
> +	if (ret) {
>   		DRM_ERROR("failed to enable DP link controller\n");
> +		return ret;
> +	}
>   
> -	return ret;
> +	pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
> +	ret = dp_ctrl_enable_stream_clocks(ctrl, pixel_rate);
> +	if (ret) {
> +		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	dp_ctrl_send_phy_test_pattern(ctrl);
> +
> +	return 0;
>   }
>   
>   void dp_ctrl_handle_sink_request(struct dp_ctrl *dp_ctrl)
