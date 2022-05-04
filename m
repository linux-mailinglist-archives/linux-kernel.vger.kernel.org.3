Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C267F51ACF1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377167AbiEDSiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377094AbiEDShz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:37:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D9854BD5
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:26:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 16so2706286lju.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WcSGq79606QCKFHIe92xawG76AnBIpchBNyPREMJFh8=;
        b=RURKbGYakxzaIrEtJ9aTpazHbip4v8DlxNuQ+4p5UAkCAZudwRQdESInGeQcaXhynz
         Q4Ianc7rdPV2mUeJh79YDyBjSBEKFqcEb9jNAEtGgjXUGf3/nWvXMp+nHZuSN7bNfCvu
         47ARcI+vA7xBND6soQPd2CBVJ/Fb9t0LXnybCZROluJ1Fo6Td4CxbfDOXfWm1edMC5rL
         VNXVWV0V9zoxFLjELeOSXBoEMraplR1T6iTn4//lfso6Fhn0GyPqCu7cywE5zMAKxu1V
         uK2HPN00tSbLNjVB7vjM8fRFuhTfTAJYP+n1K3agSTtwam1d0xMlGz4TLq1upH27KoP4
         fe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WcSGq79606QCKFHIe92xawG76AnBIpchBNyPREMJFh8=;
        b=nq55IqLSLWsGT0XnUD0Rv9KuWqhh6t0dbR8NelPAsny5BhyvSJmYlJfEztgJPGJRe1
         jx5vXSIeJdeINMyg+mJSvEu8WrkmmKX2olNqVhpPVd2PErP0wDiGLnQu4xJL7JCDRAm9
         pEP6hEiH4DM7mRga5/29iqqJXw7wbwmUqJDced5DPUF3E1lAzH8VzoWTHE/NFcoX6p5E
         Ah9C671e0/7t9OXNF5Nh/of72TIM7Akw7o/VXqO0fSq1ktM3SZA34R1nxZdOCsMC/7S3
         d71U5HmmQIUaJXQ4B1a/G3V5ywYwctpSgN2wN/SCecPluhxbyYZHAOpX/dLU2Z8goKaf
         pEQQ==
X-Gm-Message-State: AOAM533iKBJuoo2zW5Zw5Fk6+O4p61QRzECGpX225vGCF9tEkePuRBz3
        E91zeVYVqaTSMxBRV+s+/6/ABw==
X-Google-Smtp-Source: ABdhPJxws7eoaBBc/d8tLooGSLDO9wYMzHRjrretVeiVwsWonORpkVOxpE/ICf2zdQsZwe3x4LLDjA==
X-Received: by 2002:a05:651c:3c2:b0:24f:b91:fcba with SMTP id f2-20020a05651c03c200b0024f0b91fcbamr12865430ljp.154.1651688770938;
        Wed, 04 May 2022 11:26:10 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f24-20020a2eb5b8000000b0024f3df9f298sm1746762ljn.46.2022.05.04.11.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 11:26:10 -0700 (PDT)
Message-ID: <febc6b74-eb33-8c72-0b60-a2253d8d6dde@linaro.org>
Date:   Wed, 4 May 2022 21:26:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3] drm/msm/dp: fix event thread stuck in wait_event after
 kthread_stop()
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1651595136-24312-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1651595136-24312-1-git-send-email-quic_khsieh@quicinc.com>
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

On 03/05/2022 19:25, Kuogee Hsieh wrote:
> Event thread supposed to exit from its while loop after kthread_stop().
> However there may has possibility that event thread is pending in the
> middle of wait_event due to condition checking never become true.
> To make sure event thread exit its loop after kthread_stop(), this
> patch OR kthread_should_stop() into wait_event's condition checking
> so that event thread will exit its loop after kernal_stop().
> 
> Changes in v2:
> --  correct spelling error at commit title
> 
> Changes in v3:
> -- remove unnecessary parenthesis
> -- while(1) to replace while (!kthread_should_stop())
> 
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 570d3e5d28db ("drm/msm/dp: stop event kernel thread when DP unbind")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index c388323..da5c03a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1103,15 +1103,20 @@ static int hpd_event_thread(void *data)
>   
>   	dp_priv = (struct dp_display_private *)data;
>   
> -	while (!kthread_should_stop()) {
> +	while (1) {
>   		if (timeout_mode) {
>   			wait_event_timeout(dp_priv->event_q,
> -				(dp_priv->event_pndx == dp_priv->event_gndx),
> -						EVENT_TIMEOUT);
> +				(dp_priv->event_pndx == dp_priv->event_gndx) ||
> +					kthread_should_stop(), EVENT_TIMEOUT);
>   		} else {
>   			wait_event_interruptible(dp_priv->event_q,
> -				(dp_priv->event_pndx != dp_priv->event_gndx));
> +				(dp_priv->event_pndx != dp_priv->event_gndx) ||
> +					kthread_should_stop());
>   		}
> +
> +		if (kthread_should_stop())
> +			break;
> +
>   		spin_lock_irqsave(&dp_priv->event_lock, flag);
>   		todo = &dp_priv->event_list[dp_priv->event_gndx];
>   		if (todo->delay) {


-- 
With best wishes
Dmitry
