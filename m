Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD544B9685
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiBQDRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:17:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiBQDRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:17:43 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA341244655;
        Wed, 16 Feb 2022 19:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645067849; x=1676603849;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ltDwN4iGmvMN5UU3I6oxuEr6jl6hMOfWElYOFtFmTc0=;
  b=ydN5N5SqwVyDR1WH7jVBSaWQDprdDqLRXwPjnsfxEtiyo0S5CA4YfSuo
   CpJq1n6/UOp3LiA9ngyjgt17rco6+RImKHby7rlKcM9QQutkJ0tKdBupr
   hOgGN+sbHIN63vHjx30OL333jYlgidKnj7BW4+Z3OZCjl92G2Pna/HGAB
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Feb 2022 19:17:29 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 19:17:29 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 19:17:28 -0800
Received: from [10.111.174.92] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 16 Feb
 2022 19:17:25 -0800
Message-ID: <f7c3f941-2fb8-e10a-bd5a-6031e6a52171@quicinc.com>
Date:   Wed, 16 Feb 2022 19:17:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [REPOST PATCH v4 12/13] drm/msm/dsi: add mode valid callback for
 dsi_mgr
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>
CC:     Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Abhinav Kumar" <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <dri-devel@lists.freedesktop.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <freedreno@lists.freedesktop.org>
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-13-vkoul@kernel.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220210103423.271016-13-vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
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
> Add a mode valid callback for dsi_mgr for checking mode being valid in
> case of DSC. For DSC the height and width needs to be multiple of slice,
> so we check that here
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dsi/dsi.h         |  2 ++
>   drivers/gpu/drm/msm/dsi/dsi_host.c    | 26 ++++++++++++++++++++++++++
>   drivers/gpu/drm/msm/dsi/dsi_manager.c | 12 ++++++++++++
>   3 files changed, 40 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
> index 16cd9b2fce86..580a1e6358bf 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.h
> @@ -114,6 +114,8 @@ int msm_dsi_host_power_on(struct mipi_dsi_host *host,
>   int msm_dsi_host_power_off(struct mipi_dsi_host *host);
>   int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
>   				  const struct drm_display_mode *mode);
> +enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
> +					    const struct drm_display_mode *mode);
>   struct drm_panel *msm_dsi_host_get_panel(struct mipi_dsi_host *host);
>   unsigned long msm_dsi_host_get_mode_flags(struct mipi_dsi_host *host);
>   struct drm_bridge *msm_dsi_host_get_bridge(struct mipi_dsi_host *host);
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 7e9913eff724..438c80750682 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -2552,6 +2552,32 @@ int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
>   	return 0;
>   }
>   
> +enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
> +					    const struct drm_display_mode *mode)
> +{
> +	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
> +	struct msm_display_dsc_config *dsc = msm_host->dsc;
> +	int pic_width = mode->hdisplay;
> +	int pic_height = mode->vdisplay;
> +
> +	if (!msm_host->dsc)
> +		return MODE_OK;
> +
> +	if (pic_width % dsc->drm->slice_width) {
> +		pr_err("DSI: pic_width %d has to be multiple of slice %d\n",
> +		       pic_width, dsc->drm->slice_width);
> +		return MODE_H_ILLEGAL;
> +	}
> +
> +	if (pic_height % dsc->drm->slice_height) {
> +		pr_err("DSI: pic_height %d has to be multiple of slice %d\n",
> +		       pic_height, dsc->drm->slice_height);
> +		return MODE_V_ILLEGAL;
> +	}
> +
> +	return MODE_OK;
> +}
> +
>   struct drm_panel *msm_dsi_host_get_panel(struct mipi_dsi_host *host)
>   {
>   	return of_drm_find_panel(to_msm_dsi_host(host)->device_node);
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index f19bae475c96..e7f6cc88f7a4 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -575,6 +575,17 @@ static void dsi_mgr_bridge_mode_set(struct drm_bridge *bridge,
>   		msm_dsi_host_set_display_mode(other_dsi->host, adjusted_mode);
>   }
>   
> +static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,
> +						      const struct drm_display_info *info,
> +						      const struct drm_display_mode *mode)
> +{
> +	int id = dsi_mgr_bridge_get_id(bridge);
> +	struct msm_dsi *msm_dsi = dsi_mgr_get_dsi(id);
> +	struct mipi_dsi_host *host = msm_dsi->host;
> +
> +	return msm_dsi_host_check_dsc(host, mode);
> +}
> +
>   static const struct drm_connector_funcs dsi_mgr_connector_funcs = {
>   	.detect = dsi_mgr_connector_detect,
>   	.fill_modes = drm_helper_probe_single_connector_modes,
> @@ -596,6 +607,7 @@ static const struct drm_bridge_funcs dsi_mgr_bridge_funcs = {
>   	.disable = dsi_mgr_bridge_disable,
>   	.post_disable = dsi_mgr_bridge_post_disable,
>   	.mode_set = dsi_mgr_bridge_mode_set,
> +	.mode_valid = dsi_mgr_bridge_mode_valid,
>   };
>   
>   /* initialize connector when we're connected to a drm_panel */
