Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A5500298
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiDMX2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiDMX2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:28:10 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6EF1D305
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:25:47 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q14so4011138ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6Nsu6iEBJUOTQozke1T9X3o9EC6RQLqqh+ifXlL+Otg=;
        b=oxU1a6L2fej+ORREt8jy2pSUYDiEb7FXHzFlD5XqZkoT9vlJ+LozCgxZmMrqgcDSfr
         1a8DGM+0ysjMiBbJGojfMoNCGp8q9WhDHft70NbEmHfhfZVuYe4sEkspgavjUP22zVNX
         BWSIU7zetVHDRoF5ryRqEYOtdefD4uR3wg12SpKVmFfcEh/R0c3U8F4wzOBCs/epZSzS
         g8oG3q+gYZNT3fl/rPdJg7YSETv1T9D/CQeeZtbBhiKE+kXH4oDCcmwHRG47P7g4WYgE
         jAPNk004Fx9+poamJbvMbdUqZeY6L/FQctjTzRnvLEeUz5ZY2hVJSmfCGmjGIm3/wRrd
         qvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Nsu6iEBJUOTQozke1T9X3o9EC6RQLqqh+ifXlL+Otg=;
        b=1Rfy6/HH8eaqV1CZljqkFsF5BsSQSZrmNOA4Laan4SOa34Isd2k7kL9oB2LJy/oqg5
         +ZQRAV5XiE8BMntT+LajuYRKbD3Ogfuyts4snsm0cryZMCu0rnqzzxqRlcRiLTob0Onh
         Hjx/oNR/JOGrFmnYwPkUY0Df641Hc9rgXhTLbFCB/uZYFqibOcBtWe2Fi31uya0dAOha
         FgkwpJYyI30VcXy3DNjXeIGgXJvGSYDXvu6Leqfi/761v5jhuouOw2ZJvr0/fR3l51X6
         RRuxfSb7Ee6WMDJEIVK8VYQNG7fv1HsHnhsh7T8SvLhrqPZcHE5UhGrYBuBCGBgldeaH
         mEtw==
X-Gm-Message-State: AOAM533FfT3xpOKh8ByKY6FqIIJ3zIgFhsTcySxYAT2czCzyCOEKm6qD
        luMx8nIwz3NbEaZQZGdY87AS5Q==
X-Google-Smtp-Source: ABdhPJxgmavsDFQMqV8RzqL4TViPTHyIi+lpCIERHmr2ESVyQpRZ37JzqNgzMumIegNulUpvEK0ltw==
X-Received: by 2002:a05:651c:1a20:b0:24c:8e51:8e6e with SMTP id by32-20020a05651c1a2000b0024c8e518e6emr15599ljb.479.1649892346159;
        Wed, 13 Apr 2022 16:25:46 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p25-20020a056512313900b0046b82a9582asm40204lfd.29.2022.04.13.16.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 16:25:45 -0700 (PDT)
Message-ID: <98d5edce-eec0-e618-d1c8-5b86fe44d5fc@linaro.org>
Date:   Thu, 14 Apr 2022 02:25:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm/msm/dp: stop event kernel thread when DP unbind
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1649883865-9012-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1649883865-9012-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 00:04, Kuogee Hsieh wrote:
> Current DP driver implementation, event thread is kept running
> after DP display is unbind. This patch fix this problem by disabling
> DP irq and stop event thread to exit gracefully at dp_display_unbind().
> 
> Changes in v2:
> -- start event thread at dp_display_bind()
> 
> Fixes: e91e3065a806 ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 40 +++++++++++++++++++++++++++----------
>   1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 01453db..943e4f1 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -113,6 +113,7 @@ struct dp_display_private {
>   	u32 hpd_state;
>   	u32 event_pndx;
>   	u32 event_gndx;
> +	struct task_struct *ev_tsk;
>   	struct dp_event event_list[DP_EVENT_Q_MAX];
>   	spinlock_t event_lock;
>   
> @@ -230,6 +231,31 @@ void dp_display_signal_audio_complete(struct msm_dp *dp_display)
>   	complete_all(&dp->audio_comp);
>   }
>   
> +static int hpd_event_thread(void *data);
> +
> +static void dp_hpd_event_setup(struct dp_display_private *dp_priv)
> +{
> +	init_waitqueue_head(&dp_priv->event_q);
> +	spin_lock_init(&dp_priv->event_lock);

This can go to dp_probe()

> +
> +	dp_priv->ev_tsk = kthread_run(hpd_event_thread, dp_priv, "dp_hpd_handler");
> +
> +	if (IS_ERR(dp_priv->ev_tsk))
> +		DRM_ERROR("failed to create DP event thread\n");
> +}
> +
> +static void dp_hpd_event_stop(struct dp_display_private *dp_priv)
> +{
> +	if (IS_ERR(dp_priv->ev_tsk))
> +		return;
> +
> +	kthread_stop(dp_priv->ev_tsk);
> +
> +	/* reset event q to empty */
> +	dp_priv->event_gndx = 0;
> +	dp_priv->event_pndx = 0;
> +}
> +
>   static int dp_display_bind(struct device *dev, struct device *master,
>   			   void *data)
>   {
> @@ -269,6 +295,7 @@ static int dp_display_bind(struct device *dev, struct device *master,
>   	if (rc)
>   		DRM_ERROR("Audio registration Dp failed\n");
>   
> +	dp_hpd_event_setup(dp); /* start event thread */
>   end:
>   	return rc;
>   }
> @@ -280,6 +307,8 @@ static void dp_display_unbind(struct device *dev, struct device *master,
>   	struct drm_device *drm = dev_get_drvdata(master);
>   	struct msm_drm_private *priv = drm->dev_private;
>   
> +	disable_irq(dp->irq);
> +	dp_hpd_event_stop(dp); /* stop event thread */
>   	dp_power_client_deinit(dp->power);
>   	dp_aux_unregister(dp->aux);
>   	priv->dp[dp->id] = NULL;
> @@ -1054,7 +1083,7 @@ static int hpd_event_thread(void *data)
>   
>   	dp_priv = (struct dp_display_private *)data;
>   
> -	while (1) {
> +	while (!kthread_should_stop()) {
>   		if (timeout_mode) {
>   			wait_event_timeout(dp_priv->event_q,
>   				(dp_priv->event_pndx == dp_priv->event_gndx),
> @@ -1132,13 +1161,6 @@ static int hpd_event_thread(void *data)
>   	return 0;
>   }
>   
> -static void dp_hpd_event_setup(struct dp_display_private *dp_priv)
> -{
> -	init_waitqueue_head(&dp_priv->event_q);
> -	spin_lock_init(&dp_priv->event_lock);
> -
> -	kthread_run(hpd_event_thread, dp_priv, "dp_hpd_handler");
> -}
>   
>   static irqreturn_t dp_display_irq_handler(int irq, void *dev_id)
>   {
> @@ -1441,8 +1463,6 @@ void msm_dp_irq_postinstall(struct msm_dp *dp_display)
>   
>   	dp = container_of(dp_display, struct dp_display_private, dp_display);
>   
> -	dp_hpd_event_setup(dp);
> -
>   	dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 100);
>   }
>   


-- 
With best wishes
Dmitry
