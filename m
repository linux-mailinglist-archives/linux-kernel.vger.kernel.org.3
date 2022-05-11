Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C761F523FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348309AbiEKVrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348305AbiEKVrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:47:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EED12A71C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:47:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq30so5863672lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vPqUaWvZXZKnmGUQXo3o8HWjCBaEdx/hLpZVWxWIg6A=;
        b=VlYZan+g729kG4DW6LpsbEVFbLiMVgEIFx7Y8DtrJ1Mz3i9C6try9uPqAz1RsWeF+u
         IvuRju7q/iFn4cn0lcVbeXtModoBnOl8urYcgITZXMHN3zOW1lQPxPxOngjAuHudO94l
         xRwS2UCdYayL199dli/W/nMwXPgkHBP4PL7jP3x2tTMmBT4vP5FjEViedTqw+bV3Te2X
         nB9gkjmAJbxBtcnQgfcS8foQfBGZ40DUIRiBqT5ApdvWEIoLRsEcl+p4Oh62vDkotKcX
         6RVSu28I6UE2FDKqRHxcTET7eZE39EpMzZLNgDJ+gWOR9Zaphs+4aC2iTAyG3DCAmaak
         2TiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vPqUaWvZXZKnmGUQXo3o8HWjCBaEdx/hLpZVWxWIg6A=;
        b=LLY+cI+kN2ntT+EZJJ6/PG4tJG45QPmGp3h+5cHoUKlTBZw4xIiyZMEIeOHDfL8MRL
         9xs+MEt7nhO4iwOC21X3qboCjVhaqZB3lPxrKfMaHkxZHj8chDOYUms5fn9ctIKmjvT/
         uRlefUDCF4rk7tasb2UafWGfWu2gUbeyCKkzu58OIrQoSAbwS/+pxTXEAIWLh9Vh9+3J
         v1Omh3SkSQ8adhlGG7N9uWStnwzIhvObZcVeE3zyk9U52L82OZpXO3YQ2WTIChOP1OwL
         E7EVuPEee2WjtpjiINEgieGmIUEUNa7brWBQFQR1RPJ2+/+FPkdmXdnqr41zVzlfvojF
         ynYA==
X-Gm-Message-State: AOAM530QKyrt1jxUWoVu88H7VtmbG1X/oaCjUBAs3WIpasDG7hOJdbud
        8rABI67L3iNRlzNSPncByB32Xw==
X-Google-Smtp-Source: ABdhPJzIwVBIj2d9VX3HZ9zZTroVr83w4yWjyOePmlc+Xo6OtJWduZ46ZgYSk0NY9o7wHbnM4mLtmQ==
X-Received: by 2002:a05:6512:3b1:b0:471:f9e9:d8d1 with SMTP id v17-20020a05651203b100b00471f9e9d8d1mr22580685lfp.72.1652305658604;
        Wed, 11 May 2022 14:47:38 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b19-20020ac24113000000b0047255d211d2sm458083lfi.257.2022.05.11.14.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 14:47:38 -0700 (PDT)
Message-ID: <e12933c9-0439-410b-e691-0fa444c71011@linaro.org>
Date:   Thu, 12 May 2022 00:47:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4] drm/msm/dp: Always clear mask bits to disable
 interrupts at dp_ctrl_reset_irq_ctrl()
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1652305225-1048-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1652305225-1048-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 00:40, Kuogee Hsieh wrote:
> dp_catalog_ctrl_reset() will software reset DP controller. But it will
> not reset programmable registers to default value. DP driver still have
> to clear mask bits to interrupt status registers to disable interrupts
> after software reset of controller. This patch removes the enable flag
> condition checking to always clear mask bits of interrupt status
> registers to disable interrupts if enable flag is false.
> 
> This patch also will fix the potential problem happen at system suspend where
> dp_ctrl_reset_irq_ctrl() was called to try to disable HPD related irqs but
> the irq is still unmasked unexpectedly

Why is it unmasked? Especially unexpectedly.

> and can come in while system are
> suspending. This leads to bus hangs if the irq is handled after we power down
> the DP hardware because we run the irq handler and access a device register
> assuming that no irq could ever come in if we powered down the device. We
> don't know when the irq will be handled though, so it's possible the irq is
> pending from before we disable the irq in the hardware.

Please split into two patches.

> 
> Changes in v2:
> -- add more details commit text
> 
> Changes in v3:
> -- add synchrons_irq()
> -- add atomic_t suspended
> 
> Changes in v4:
> -- correct Fixes's commit ID
> 
> Fixes: 989ebe7bc446 ("drm/msm/dp: do not initialize phy until plugin interrupt received")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_ctrl.c    |  9 +++++++--
>   drivers/gpu/drm/msm/dp/dp_display.c | 18 ++++++++++++++++++
>   2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index af7a80c..f3e333e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1389,8 +1389,13 @@ void dp_ctrl_reset_irq_ctrl(struct dp_ctrl *dp_ctrl, bool enable)
>   
>   	dp_catalog_ctrl_reset(ctrl->catalog);
>   
> -	if (enable)
> -		dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
> +	/*
> +	 * all dp controller programmable registers will not
> +	 * be reset to default value after DP_SW_RESET
> +	 * therefore interrupt mask bits have to be updated
> +	 * to enable/disable interrupts
> +	 */
> +	dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
>   }
>   
>   void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index c388323..c34dbfc 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -98,6 +98,8 @@ struct dp_display_private {
>   	struct dp_ctrl    *ctrl;
>   	struct dp_debug   *debug;
>   
> +	atomic_t suspended;

Usage of atomic_t signifies that something is wrong here. Bool should be 
enough here.

> +
>   	struct dp_usbpd_cb usbpd_cb;
>   	struct dp_display_mode dp_mode;
>   	struct msm_dp dp_display;
> @@ -187,6 +189,11 @@ static int dp_add_event(struct dp_display_private *dp_priv, u32 event,
>   	int pndx;
>   
>   	spin_lock_irqsave(&dp_priv->event_lock, flag);
> +	if (atomic_read(&dp_priv->suspended)) {
> +		spin_unlock_irqrestore(&dp_priv->event_lock, flag);
> +		return -EPERM;

Why EPERM?

> +	}
> +
>   	pndx = dp_priv->event_pndx + 1;
>   	pndx %= DP_EVENT_Q_MAX;
>   	if (pndx == dp_priv->event_gndx) {
> @@ -454,6 +461,13 @@ static void dp_display_host_deinit(struct dp_display_private *dp)
>   		dp->dp_display.connector_type, dp->core_initialized,
>   		dp->phy_initialized);
>   
> +	if (!dp->core_initialized) {

Can this happen?

> +		DRM_DEBUG_DP("DP core not initialized\n");
> +		return;
> +	}
> +
> +	synchronize_irq(dp->irq);

Why? If you need to run with IRQs disabled, you can use 
suspend_late/early_resume. But generally it should be enough to check 
for the !suspended in the IRQ.

> +
>   	dp_ctrl_reset_irq_ctrl(dp->ctrl, false);
>   	dp_aux_deinit(dp->aux);
>   	dp_power_deinit(dp->power);
> @@ -1362,6 +1376,8 @@ static int dp_pm_resume(struct device *dev)
>   		dp->dp_display.connector_type, dp->core_initialized,
>   		dp->phy_initialized, dp_display->power_on);
>   
> +	atomic_set(&dp->suspended, 0);
> +
>   	/* start from disconnected state */
>   	dp->hpd_state = ST_DISCONNECTED;
>   
> @@ -1431,6 +1447,8 @@ static int dp_pm_suspend(struct device *dev)
>   		dp->dp_display.connector_type, dp->core_initialized,
>   		dp->phy_initialized, dp_display->power_on);
>   
> +	atomic_inc(&dp->suspended);
> +
>   	/* mainlink enabled */
>   	if (dp_power_clk_status(dp->power, DP_CTRL_PM))
>   		dp_ctrl_off_link_stream(dp->ctrl);


-- 
With best wishes
Dmitry
