Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25654501C48
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346005AbiDNUC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiDNUCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:02:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB1D3734
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:59:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x17so10896372lfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KjO7qutuK1oWFLm/iSWg0Q078FDs2tsCz+NAqsezLsQ=;
        b=WgQTMOywpmOVGqjaW2tMdnCeS3P5tDzXnO/dR9II6/D8/55RBRrG24sis1JO9vuEZy
         zH2ySwbddNCDII7Qewsui2mim/KEXaJ2GqCGNvKT40YDtM9AJ1Mrl2/IY6beN1XXiSpv
         GitsUrqJCl0a6VxN/RoziJwiRyHG1g4g9NGd6ZMckvx94JijtKCF4sTsp8xPazm/Au5O
         RVFWSxI2szGJzC3dabNHkmpoF2zaD6h3Mpa4tjK+WZ2eKH4RIN3Jc+iVWT1Q8cGQQTYR
         TO7zo/B7UmWu2Jkm8NqJf/gsah+cRGx09d+MLtBtg5b8IKvOimzTpm+PW7X7B+a2WYV7
         iLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KjO7qutuK1oWFLm/iSWg0Q078FDs2tsCz+NAqsezLsQ=;
        b=OpkB1PjE6qyx/0B3GCWzuHpSeOYba3t3RbAbRw7bh4HD4/pWo5H483jwCgh/fGGQff
         0Bl3Rz8CSE2eRlvbUvxfHLtcB1crz4k8Qs5rHvp5hBDQJNY2VjsPHEalymfjv3i5A/RU
         0mHdP9bc/mIehmaZ0GGlMzKsTppZVJzuw3/5DNvNfPMwKrF9XFNJvdkRM6HaZy5Jt2GC
         klt7AKow4Fx2MG/Vb1yd2q9taeRIhjyjlZpSE43o4PP3sCHrGHlJWrzNfKLX2UZL2pLE
         kc4OI9PzfxnzG7riMWIfwCO7GLmSQi4xqdnNEj0YCzlsye/DujOGd37ZEKv+2YxegB5P
         XCTw==
X-Gm-Message-State: AOAM531CbiF0lbWAG04zMb4HBjVfWATSz5MGqhRENC/WzPqssl35VSVR
        FVJ2hUYDSuQoncr1fGy/8gGqpg==
X-Google-Smtp-Source: ABdhPJxG24h9VEnca2r0dBBAMaP0vTXTtuXQiz9HrGReH8pCSBk399n1kfsIMWl2nG52NepnBGrAnA==
X-Received: by 2002:a05:6512:401f:b0:46d:28a:a5d3 with SMTP id br31-20020a056512401f00b0046d028aa5d3mr2821781lfb.632.1649966395900;
        Thu, 14 Apr 2022 12:59:55 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a13-20020a195f4d000000b00443a5302315sm95708lfj.30.2022.04.14.12.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 12:59:55 -0700 (PDT)
Message-ID: <be3141cb-1fa9-4a9c-6b18-c0d73b9efe80@linaro.org>
Date:   Thu, 14 Apr 2022 22:59:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3] drm/msm/dp: stop event kernel thread when DP unbind
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1649957137-24620-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1649957137-24620-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 20:25, Kuogee Hsieh wrote:
> Current DP driver implementation, event thread is kept running
> after DP display is unbind. This patch fix this problem by disabling
> DP irq and stop event thread to exit gracefully at dp_display_unbind().
> 
> Changes in v2:
> -- start event thread at dp_display_bind()
> 
> Changes in v3:
> -- disable all HDP interrupts at unbind
> -- replace dp_hpd_event_setup() with dp_hpd_event_thread_start()
> -- replace dp_hpd_event_stop() with dp_hpd_event_thread_stop()
> -- move init_waitqueue_head(&dp->event_q) to probe()
> -- move spin_lock_init(&dp->event_lock) to probe()
> 
> Fixes: e91e3065a806 ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 42 ++++++++++++++++++++++++++++---------
>   1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 01453db..0b9a96f 100644
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
> @@ -230,6 +231,29 @@ void dp_display_signal_audio_complete(struct msm_dp *dp_display)
>   	complete_all(&dp->audio_comp);
>   }
>   
> +static int hpd_event_thread(void *data);
> +
> +static int dp_hpd_event_thread_start(struct dp_display_private *dp_priv)
> +{
> +	int err = 0;
> +
> +	dp_priv->ev_tsk = kthread_run(hpd_event_thread, dp_priv, "dp_hpd_handler");
> +	if (IS_ERR(dp_priv->ev_tsk)) {
> +		DRM_ERROR("failed to create DP event thread\n");
> +		err = PTR_ERR(dp_priv->ev_tsk);
> +	}
> +	return err;

Generally the preference is for the following style:

if (error) {
    return error;
}

return 0;

It makes it clear that at the end the function succeeds.


> +}
> +
> +static void dp_hpd_event_thread_stop(struct dp_display_private *dp_priv)
> +{
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
> @@ -269,6 +293,7 @@ static int dp_display_bind(struct device *dev, struct device *master,
>   	if (rc)
>   		DRM_ERROR("Audio registration Dp failed\n");

Isn't 'goto end' missing here?

That's why it's suggested not to mix error and success paths.

>   
> +	rc = dp_hpd_event_thread_start(dp);
>   end:
>   	return rc;
>   }
> @@ -280,6 +305,9 @@ static void dp_display_unbind(struct device *dev, struct device *master,
>   	struct drm_device *drm = dev_get_drvdata(master);
>   	struct msm_drm_private *priv = drm->dev_private;
>   
> +	/* disable all HPD interrupts */
> +	dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_INT_MASK, false);

Generic nit: if we had _enable and _disable functions, one wouldn't need 
the comment here. It would be obvious from the code itself.


> +	dp_hpd_event_thread_stop(dp);
>   	dp_power_client_deinit(dp->power);
>   	dp_aux_unregister(dp->aux);
>   	priv->dp[dp->id] = NULL;
> @@ -1054,7 +1082,7 @@ static int hpd_event_thread(void *data)
>   
>   	dp_priv = (struct dp_display_private *)data;
>   
> -	while (1) {
> +	while (!kthread_should_stop()) {
>   		if (timeout_mode) {
>   			wait_event_timeout(dp_priv->event_q,
>   				(dp_priv->event_pndx == dp_priv->event_gndx),
> @@ -1132,13 +1160,6 @@ static int hpd_event_thread(void *data)
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
> @@ -1266,7 +1287,10 @@ static int dp_display_probe(struct platform_device *pdev)
>   		return -EPROBE_DEFER;
>   	}
>   
> +	/* setup event q */
>   	mutex_init(&dp->event_mutex);
> +	init_waitqueue_head(&dp->event_q);
> +	spin_lock_init(&dp->event_lock);
>   
>   	/* Store DP audio handle inside DP display */
>   	dp->dp_display.dp_audio = dp->audio;
> @@ -1441,8 +1465,6 @@ void msm_dp_irq_postinstall(struct msm_dp *dp_display)
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
