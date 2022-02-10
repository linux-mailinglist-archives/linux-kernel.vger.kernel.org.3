Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A95F4B0B21
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbiBJKnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:43:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbiBJKnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:43:15 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD99CFF0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:43:16 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a25so7306620lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=chq6Chz0KIbchExNB+NjTVI9vDEBpcgZ1ZPLBHdHFFI=;
        b=qFh4nTtWbZFDBt9sPBtoIOcpQ3d4LOmQzZPy4Y8S07MKRsbAUQ138l2/S1OIZv858J
         NMT8dvyjCB6/WcfcR8EYgi6Vo9vP3PoHMCEF9Vb+DNrDKvl4igRsvEl5f021I6Uw8T0s
         wpbPtaCyOT4hcW+k2/PNm0rBFV2zhl0w/SazC6Jwo0QgPd7v/8GZvvvMScw+W73fkt+T
         pbNJkjUUx4qeedy3n2VL6uPy9yECpBcmQi4PL3aT8j3iYtSySamgewQFN9J9R0jXMe5E
         37aKxsKei1URWUBdwSibiOzUmCzA8e6+03cE+Er6kPJE1cLy3koJ2CxUN3WqrH1PStVq
         iBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=chq6Chz0KIbchExNB+NjTVI9vDEBpcgZ1ZPLBHdHFFI=;
        b=jnyuEDVj32RNIw14xUYgeLIRHRj4vMO78lnjbIa0Fu76YhJ/oWZlOV24AmjC4iKyd8
         f7XMTHsyDsUKXXmxr+4mhmZstn7h2PanNrE89d3shZTMX07ATr9oAKEe6MVcKwr8AsnH
         CPPFs4vWOs294us80V5Dn0RaNHp7/0WnMtE6VtiaINmZ/mm3TSVOryPtTwOX3c5xG6Io
         igAWEa23fLddxDGWywqBVHq19Z2Px+3V9hTHyIRKHbiEQpYsMhqWNSHdpGcc6f+mfYrI
         sSyKpXwbGeqeucPD0kWXIGzvs/uu8teRT/HfSPJO6ypuckez6TOi3GMdlue4Esxr7uNF
         EJVQ==
X-Gm-Message-State: AOAM530E7tDPq0+L03AavGM6ST4XXc29kyt8vse7beWxLkcBavo20XZ7
        FHqDagQWSNBnU57uD7w/R8kK6g==
X-Google-Smtp-Source: ABdhPJxCwgHQHmzCCi21NWhAsGNPVsNyu3AaeRPwuP/PZFdL53GmHfnLpYeV44gqhdA9pJkYJjD5/A==
X-Received: by 2002:a2e:9918:: with SMTP id v24mr4444940lji.230.1644489795039;
        Thu, 10 Feb 2022 02:43:15 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z15sm572064lfd.177.2022.02.10.02.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 02:43:14 -0800 (PST)
Message-ID: <da3285c5-0c57-e235-50f9-252b7a6044ea@linaro.org>
Date:   Thu, 10 Feb 2022 13:43:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [REPOST PATCH v4 02/13] drm/msm/dsi: Pass DSC params to drm_panel
Content-Language: en-GB
To:     Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-3-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220210103423.271016-3-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2022 13:34, Vinod Koul wrote:
> When DSC is enabled, we need to pass the DSC parameters to panel driver
> as well, so add a dsc parameter in panel and set it when DSC is enabled
> 
> Also, fetch and pass DSC configuration for DSI panels to DPU encoder,
> which will enable and configure DSC hardware blocks accordingly.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

The patch description is incorrect. We do not pass DSC parameters to the 
panel driver. Instead we fetch them from the panel. Could you please 
correct it?

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |  2 ++
>   drivers/gpu/drm/msm/dsi/dsi.c           |  5 +++++
>   drivers/gpu/drm/msm/dsi/dsi.h           |  1 +
>   drivers/gpu/drm/msm/dsi/dsi_host.c      | 22 ++++++++++++++++++++++
>   drivers/gpu/drm/msm/msm_drv.h           |  8 ++++++++
>   include/drm/drm_panel.h                 |  7 +++++++
>   6 files changed, 45 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 47fe11a84a77..ef6ddac22767 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -578,6 +578,8 @@ static int _dpu_kms_initialize_dsi(struct drm_device *dev,
>   			MSM_DISPLAY_CAP_CMD_MODE :
>   			MSM_DISPLAY_CAP_VID_MODE;
>   
> +		info.dsc = msm_dsi_get_dsc_config(priv->dsi[i]);
> +
>   		if (msm_dsi_is_bonded_dsi(priv->dsi[i]) && priv->dsi[other]) {
>   			rc = msm_dsi_modeset_init(priv->dsi[other], dev, encoder);
>   			if (rc) {
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
> index 052548883d27..3aeac15e7421 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
> @@ -20,6 +20,11 @@ bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi)
>   	return !(host_flags & MIPI_DSI_MODE_VIDEO);
>   }
>   
> +struct msm_display_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
> +{
> +	return msm_dsi_host_get_dsc_config(msm_dsi->host);
> +}
> +
>   static int dsi_get_phy(struct msm_dsi *msm_dsi)
>   {
>   	struct platform_device *pdev = msm_dsi->pdev;
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
> index c8dedc95428c..16cd9b2fce86 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.h
> @@ -152,6 +152,7 @@ int dsi_calc_clk_rate_v2(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
>   int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
>   void msm_dsi_host_snapshot(struct msm_disp_state *disp_state, struct mipi_dsi_host *host);
>   void msm_dsi_host_test_pattern_en(struct mipi_dsi_host *host);
> +struct msm_display_dsc_config *msm_dsi_host_get_dsc_config(struct mipi_dsi_host *host);
>   
>   /* dsi phy */
>   struct msm_dsi_phy;
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 27553194f9fa..7e9913eff724 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -2059,9 +2059,24 @@ int msm_dsi_host_modeset_init(struct mipi_dsi_host *host,
>   {
>   	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>   	const struct msm_dsi_cfg_handler *cfg_hnd = msm_host->cfg_hnd;
> +	struct drm_panel *panel;
>   	int ret;
>   
>   	msm_host->dev = dev;
> +	panel = msm_dsi_host_get_panel(&msm_host->base);
> +
> +	if (panel && panel->dsc) {
> +		struct msm_display_dsc_config *dsc = msm_host->dsc;
> +
> +		if (!dsc) {
> +			dsc = devm_kzalloc(&msm_host->pdev->dev, sizeof(*dsc), GFP_KERNEL);
> +			if (!dsc)
> +				return -ENOMEM;
> +			dsc->drm = panel->dsc;
> +			msm_host->dsc = dsc;
> +		}
> +	}
> +
>   	ret = cfg_hnd->ops->tx_buf_alloc(msm_host, SZ_4K);
>   	if (ret) {
>   		pr_err("%s: alloc tx gem obj failed, %d\n", __func__, ret);
> @@ -2626,3 +2641,10 @@ void msm_dsi_host_test_pattern_en(struct mipi_dsi_host *host)
>   		dsi_write(msm_host, REG_DSI_TEST_PATTERN_GEN_CMD_STREAM0_TRIGGER,
>   				DSI_TEST_PATTERN_GEN_CMD_STREAM0_TRIGGER_SW_TRIGGER);
>   }
> +
> +struct msm_display_dsc_config *msm_dsi_host_get_dsc_config(struct mipi_dsi_host *host)
> +{
> +	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
> +
> +	return msm_host->dsc;
> +}
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 384f9bad4760..e7a312edfe67 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -119,6 +119,7 @@ struct msm_display_topology {
>    *                      based on num_of_h_tiles
>    * @is_te_using_watchdog_timer:  Boolean to indicate watchdog TE is
>    *				 used instead of panel TE in cmd mode panels
> + * @dsc:		DSC configuration data for DSC-enabled displays
>    */
>   struct msm_display_info {
>   	int intf_type;
> @@ -126,6 +127,7 @@ struct msm_display_info {
>   	uint32_t num_of_h_tiles;
>   	uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
>   	bool is_te_using_watchdog_timer;
> +	struct msm_display_dsc_config *dsc;
>   };
>   
>   /* Commit/Event thread specific structure */
> @@ -365,6 +367,7 @@ void msm_dsi_snapshot(struct msm_disp_state *disp_state, struct msm_dsi *msm_dsi
>   bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi);
>   bool msm_dsi_is_bonded_dsi(struct msm_dsi *msm_dsi);
>   bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi);
> +struct msm_display_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi);
>   #else
>   static inline void __init msm_dsi_register(void)
>   {
> @@ -393,6 +396,11 @@ static inline bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi)
>   {
>   	return false;
>   }
> +
> +static inline struct msm_display_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
> +{
> +	return NULL;
> +}
>   #endif
>   
>   #ifdef CONFIG_DRM_MSM_DP
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 4602f833eb51..eb8ae9bf32ed 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -171,6 +171,13 @@ struct drm_panel {
>   	 * Panel entry in registry.
>   	 */
>   	struct list_head list;
> +
> +	/**
> +	 * @dsc:
> +	 *
> +	 * Panel DSC pps payload to be sent
> +	 */
> +	struct drm_dsc_config *dsc;
>   };
>   
>   void drm_panel_init(struct drm_panel *panel, struct device *dev,


-- 
With best wishes
Dmitry
