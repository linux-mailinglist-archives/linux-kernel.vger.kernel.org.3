Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE0846713D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 05:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350395AbhLCEuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 23:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243582AbhLCEut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 23:50:49 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EABCC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 20:47:26 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id n8so1272800plf.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 20:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dMbrp1/GUEYJpTTFllnDy2fby0E85DxrxhIOlEwFLac=;
        b=EvUKWneKiejSmSWAOxMJQ+Ay7SrUBl6iJHYF0m/6RAh+8iT8KkVkmmezFJEOlx+TT0
         PT9OkJEq8sFYVTWdw55zGscEcbuT+sTx49S851ap4ci4BjOILfD/VU9YwfYcij3WPxH+
         FflN0mdfw76VOLBCZzu8kfXujTjM/8Nuet0kEy9nbSXwXZRW49JbILfbGhUocpI7y5B1
         zj+306FybkXPHS8bbo6hm4mEAOYHflaCk9ESgcb5+ySKAvlvZxg7gLaxiNPVt1cnjZD2
         q55OKDpkxnTKBH2YPEE4qxi0i9Az90vbBw4gC+bmuPZWJtorvUjiTP9d+TZeMNgRNPrb
         W/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dMbrp1/GUEYJpTTFllnDy2fby0E85DxrxhIOlEwFLac=;
        b=DxVwvF7a1UAXZwAp+EtT8s0M2BmHKwI/bbA0YyOHnLmhCcWoBVMV9reMKFPwX8HWvy
         PHMRtq7JMlK7Xa1z0OMPaWDi2oMfPAbiU+S026Gjo6ggHfvwDmJu/GozTEmdCB2D3xuN
         lKxb5pyrg+uGOLAMKtILZnj+o3QfXWH/oZyRDM3qBRKQ13VfoXUhMttj4qAXcd8Apdjq
         Y/tkmvVbueaQ6NZMWtp8TwCb3S2J85TDPPOYz3AANM6fE8r7fxAIQLKOCaMelgfsiW4l
         mkTEiwkvpK3GhkGxm4sNa2BNbBauULMSVnMwCW1cZPUaBXt/O3DdaCIzHgpO9eFxlFwp
         izsg==
X-Gm-Message-State: AOAM531zFgyB8wy1iyAZT9OrvUB3lnHj1S3VOp/dP+LCkPzxj5WPkEzZ
        ToGEo4cQc28DQU56hEso2naVSw==
X-Google-Smtp-Source: ABdhPJzuXOq1XkPWZW4mwuNSGbW/AqHE0hSQmocxukPGMRQLSC7uxBMLscWoKVFNorcthMQH1zjvBQ==
X-Received: by 2002:a17:90b:4b41:: with SMTP id mi1mr11346061pjb.2.1638506845915;
        Thu, 02 Dec 2021 20:47:25 -0800 (PST)
Received: from localhost ([106.201.42.111])
        by smtp.gmail.com with ESMTPSA id y28sm1386313pfa.208.2021.12.02.20.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 20:47:25 -0800 (PST)
Date:   Fri, 3 Dec 2021 10:17:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH] cpufreq: qcom-hw: Use optional irq API
Message-ID: <20211203044718.b6nqn5rcbkrnpchp@vireshk-i7>
References: <20211117020346.4088302-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117020346.4088302-1-swboyd@chromium.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-21, 18:03, Stephen Boyd wrote:
> Use platform_get_irq_optional() to avoid a noisy error message when the
> irq isn't specified. The irq is definitely optional given that we only
> care about errors that are -EPROBE_DEFER here.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index a2be0df7e174..b442d4983a22 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -382,9 +382,11 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>  	 * Look for LMh interrupt. If no interrupt line is specified /
>  	 * if there is an error, allow cpufreq to be enabled as usual.
>  	 */
> -	data->throttle_irq = platform_get_irq(pdev, index);
> -	if (data->throttle_irq <= 0)
> -		return data->throttle_irq == -EPROBE_DEFER ? -EPROBE_DEFER : 0;
> +	data->throttle_irq = platform_get_irq_optional(pdev, index);
> +	if (data->throttle_irq == -ENXIO)
> +		return 0;
> +	if (data->throttle_irq < 0)
> +		return data->throttle_irq;
>  
>  	data->cancel_throttle = false;
>  	data->policy = policy;

Applied. Thanks.

-- 
viresh
