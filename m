Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7564A550033
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbiFQWuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbiFQWuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:50:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C7159322
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 15:50:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s6so8876789lfo.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 15:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xOxkF4mzeYd1/+qHSn88D6dzTW2RY4MuLGzz276BBWI=;
        b=q3KoGTIiJaI8clsa4c1ULBUqNwFn85K8GrBZS94T8WSePXvIt6Kv4irUSQ6LRchwSy
         U31y2j3v5RLYshU0GD2pVEryFHf0FzBrdfC92zhwiClFbRNeO8pvUazKliUl9PkitCCX
         XSy+9pb2Rw7qbPoBbYKLsTtnFhH8nQtW/j163QaDo4KPnjMB/fi2eOomoPYcnXO/NOOQ
         lhkO4HZBpIkaFAH8FimyyyoQsto2Uzq2NfHBfr5FA5NWfOZ5fd2py+NLoTpva4b41ro2
         4CR8biFvWt6yRtfwVqbTGgXhkDq+x0f3HNKJFUxp5jItWeF28yDucUP2dhJIcBMHi3rO
         yLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xOxkF4mzeYd1/+qHSn88D6dzTW2RY4MuLGzz276BBWI=;
        b=ogPBmdvJFQ/pfDpFZFU2t8nzsAcgGTCfAXwnwmD9FhoTnSXBtQcB1PWfK36wGvOzVm
         XWlNzgb3WgSi1A/O9E74u2SzT6deD3l5tP45YR52H7H5pKm9A/KMnHkyxOquCSZ9rNtJ
         7AzNBIOmYK6arOraV4pmvuN15r4C9qer1shCXPV1MxS9YftdIFz8CTrxu624yn1W0xIg
         PNvgkz5R0s7LKKGHdVFyxAuF6DwzqVBZVTJzNqNqIpmo1pwJ/bdLZUpdoBWP8i4IrcgE
         UqbjsNCCbPW3cLoOpT+S397ae2ngA5BI17VIn3912UZUgRlvkDOVJIRu7pcCHMRZ/ww6
         Fi4Q==
X-Gm-Message-State: AJIora8HJCGEFpacO/oDbM5CaI9huibPp/zaslee2rBJCMbVRQ2nhthE
        FD045OXyfQjJ8Rjht+uybK/phw==
X-Google-Smtp-Source: AGRyM1sbhZsF9OvwGOTigG+v3++nQ+M6/Hvpvsg/tOgLGXFwRYDF8Hd3y4QNNmjUVwmb6jT/u5EXIg==
X-Received: by 2002:a05:6512:3081:b0:47e:da1e:725f with SMTP id z1-20020a056512308100b0047eda1e725fmr6886324lfd.176.1655506217824;
        Fri, 17 Jun 2022 15:50:17 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a19-20020a056512201300b0047d479884b8sm796969lfb.27.2022.06.17.15.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 15:50:17 -0700 (PDT)
Message-ID: <ddddcb1d-46c6-4903-3a8a-83bc96ece159@linaro.org>
Date:   Sat, 18 Jun 2022 01:50:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] drm/msm/dp: Reorganize code to avoid forward
 declaration
Content-Language: en-GB
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
References: <20220617204750.2347797-1-swboyd@chromium.org>
 <20220617204750.2347797-2-swboyd@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220617204750.2347797-2-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2022 23:47, Stephen Boyd wrote:
> Let's move these functions around to avoid having to forward declare
> dp_ctrl_on_stream_phy_test_report(). Also remove
> dp_ctrl_reinitialize_mainlink() forward declaration because we're doing
> that sort of task.
> 
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 104 +++++++++++++++----------------
>   1 file changed, 50 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 703249384e7c..bd445e683cfc 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1238,8 +1238,6 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
>   	return -ETIMEDOUT;
>   }
>   
> -static int dp_ctrl_reinitialize_mainlink(struct dp_ctrl_private *ctrl);
> -
>   static int dp_ctrl_link_train(struct dp_ctrl_private *ctrl,
>   			int *training_step)
>   {
> @@ -1534,38 +1532,6 @@ static int dp_ctrl_link_maintenance(struct dp_ctrl_private *ctrl)
>   	return ret;
>   }
>   
> -static int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl);
> -
> -static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
> -{
> -	int ret = 0;
> -
> -	if (!ctrl->link->phy_params.phy_test_pattern_sel) {
> -		drm_dbg_dp(ctrl->drm_dev,
> -			"no test pattern selected by sink\n");
> -		return ret;
> -	}
> -
> -	/*
> -	 * The global reset will need DP link related clocks to be
> -	 * running. Add the global reset just before disabling the
> -	 * link clocks and core clocks.
> -	 */
> -	ret = dp_ctrl_off(&ctrl->dp_ctrl);
> -	if (ret) {
> -		DRM_ERROR("failed to disable DP controller\n");
> -		return ret;
> -	}
> -
> -	ret = dp_ctrl_on_link(&ctrl->dp_ctrl);
> -	if (!ret)
> -		ret = dp_ctrl_on_stream_phy_test_report(&ctrl->dp_ctrl);
> -	else
> -		DRM_ERROR("failed to enable DP link controller\n");
> -
> -	return ret;
> -}
> -
>   static bool dp_ctrl_send_phy_test_pattern(struct dp_ctrl_private *ctrl)
>   {
>   	bool success = false;
> @@ -1618,6 +1584,56 @@ static bool dp_ctrl_send_phy_test_pattern(struct dp_ctrl_private *ctrl)
>   	return success;
>   }
>   
> +static int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
> +{
> +	int ret;
> +	struct dp_ctrl_private *ctrl;
> +
> +	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
> +
> +	ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
> +
> +	ret = dp_ctrl_enable_stream_clocks(ctrl);
> +	if (ret) {
> +		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	dp_ctrl_send_phy_test_pattern(ctrl);
> +
> +	return 0;
> +}
> +
> +static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
> +{
> +	int ret = 0;
> +
> +	if (!ctrl->link->phy_params.phy_test_pattern_sel) {
> +		drm_dbg_dp(ctrl->drm_dev,
> +			"no test pattern selected by sink\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * The global reset will need DP link related clocks to be
> +	 * running. Add the global reset just before disabling the
> +	 * link clocks and core clocks.
> +	 */
> +	ret = dp_ctrl_off(&ctrl->dp_ctrl);
> +	if (ret) {
> +		DRM_ERROR("failed to disable DP controller\n");
> +		return ret;
> +	}
> +
> +	ret = dp_ctrl_on_link(&ctrl->dp_ctrl);
> +	if (!ret)
> +		ret = dp_ctrl_on_stream_phy_test_report(&ctrl->dp_ctrl);
> +	else
> +		DRM_ERROR("failed to enable DP link controller\n");
> +
> +	return ret;
> +}
> +
>   void dp_ctrl_handle_sink_request(struct dp_ctrl *dp_ctrl)
>   {
>   	struct dp_ctrl_private *ctrl;
> @@ -1815,26 +1831,6 @@ static int dp_ctrl_link_retrain(struct dp_ctrl_private *ctrl)
>   	return dp_ctrl_setup_main_link(ctrl, &training_step);
>   }
>   
> -static int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
> -{
> -	int ret;
> -	struct dp_ctrl_private *ctrl;
> -
> -	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
> -
> -	ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
> -
> -	ret = dp_ctrl_enable_stream_clocks(ctrl);
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
>   int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl, bool force_link_train)
>   {
>   	int ret = 0;


-- 
With best wishes
Dmitry
