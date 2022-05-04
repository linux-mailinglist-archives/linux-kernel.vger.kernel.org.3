Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8039351AD12
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377147AbiEDSlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377079AbiEDSlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:41:45 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C195029E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:38:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w1so3840038lfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VDj+h4V23SXKlruYDD3RGIbbcHLL5wjAWDq/F5foLqE=;
        b=fxjXjRbPxX0+juWMAepDKZlUcCaSCPxxuzNTXL/t1cwBxfS5s2tjysAoHlG3Z67/7R
         XL2oup6dBfxm30lTRgo8OIwVvvc3Wey04GuG7Vb/BzbHV9UwXBemXCx5r2q6SqEAqeEU
         D9vmaG0dBfIjkmy51e5WuulFFGzZ6A/ZTJDV1vQbEiBil8Up9kTCSI2yPBj/jPtV4ZT3
         OeV0t8JKfTeTvqiCBUVYCb6xBarrjSwc+726v+pjx1/wKJS2WyK3HVpGymESkVavXbMg
         BM1/r/DDv2pCN+hcuanvYGk/YgHOCr5bcy6DFbmISlx+GYBjpT5NZ6l1mlj4J8qDjXus
         1KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VDj+h4V23SXKlruYDD3RGIbbcHLL5wjAWDq/F5foLqE=;
        b=fUnqB6N6iwmh1tGBWBnk4z7WpD0924+OJjr2M+9q/fBHMs03FDoZQKsr8W3yLDSMDy
         Xq8ieR17imrwqCffaLFgeTyfbPONewihkoJnofFYmHPPmrm2Fvx2vH0DxiUX8gu+f9mt
         /TXvzofK4yEunC3P9Hq/ayYwszpmY339EezrpbR8D5QjVdpm20Y4lkOqkaNuRBchyKEu
         N1UBuDRP+wZt7ol4DbMYvxK+E/axHU+JEYyJepo2CEMtBOq7YePiAnkiv3E0CDcj0NjC
         BrewKFFawbytiSm8nlReEouHyaiGtAkyxsntJFJtLwMChtVvdAJp7vAzkhOOLBnuHb/n
         Ka+w==
X-Gm-Message-State: AOAM53326XCCWjwMIIGyyipGEBWHj5GbqS6/yl+Hxzp337jhNoAaEN2n
        FX5S95g23On+AIoXkOOUBv/ovw==
X-Google-Smtp-Source: ABdhPJyI5erUXW0RKxsHAT4wZDIOhnHXaMT1ZI70tUjd1MU7r4fGr09Jg5RPwZvekympeq5jP9071g==
X-Received: by 2002:a05:6512:22cf:b0:473:a41f:155f with SMTP id g15-20020a05651222cf00b00473a41f155fmr7171873lfu.227.1651689487107;
        Wed, 04 May 2022 11:38:07 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y20-20020ac24214000000b0047255d21168sm1270671lfh.151.2022.05.04.11.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 11:38:06 -0700 (PDT)
Message-ID: <834eeda0-12b0-3f16-8ca2-89175c1de186@linaro.org>
Date:   Wed, 4 May 2022 21:38:05 +0300
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

Let's do it properly:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

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
