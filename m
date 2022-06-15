Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6587D54C88C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348584AbiFOMaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242459AbiFOMaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:30:15 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A313427F1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:30:14 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v8so2035374ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5vGAXTFss+xRVWCjnDcb7Q0fDyWMmYQS1IlIisRz3kA=;
        b=EOkJnIDxrEFF+7/lL50921cC8xj04yIhzL/gjXZ2b99hFK2rWxyrK9CAGQMtFmvcvf
         ktSx+aJ1aXXVzZYdHssvQ+iY9tweS2bkxIJDvynoAHbIP+KiqZ+o+VFZnQHlHMaeWh1H
         FopnjxWrPoqGWx0EgSR1oqfam4d36/hYw+7+qwSw8dojx8NTc4+Plcq0bv7m90zRwFb8
         sL7i915LBomiiZ1YP7udhS3T1xO330Iy9eXS26A9J5Sms7GMlxoRiQ6d0aHFwZO1VAMr
         zakJ7NDnHlnsXmcm4DGdaX+lY6lgKOFJ2SZQ33FeaUKD6OTMZIFTsnw4ohSUPk+hQii+
         F4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5vGAXTFss+xRVWCjnDcb7Q0fDyWMmYQS1IlIisRz3kA=;
        b=SUbKzyWa7XCMVF0Xwh8VBz1fV19pf+BAvSxrvDfNKvc8FLLufJCHNOoiWNO57jnvQe
         nCcQCYPC/xs973hhdnC9/JtmYmiGEgPVXauKiVV/Qh0ljCwUhffL1xRPUvFQ67bfUVTp
         r7Oi+TbK2VM7piqeL0tmcuQkhCPEPvUbBeDD1QpCcMND+FQNQf+zrdrgzuzDUC/uPibC
         wua09f/FDuksskdKNzNOB5ll0JDmvkGQBYhefZWatg0Uy3/P3j/w2ct/IC1QFpS+iOn0
         Asp6E4qVjdkYZZagJB3qDwEgn0e4gwvRTH+swyQiuqRcBqCuOMM+N8XDw8IODOouT8yx
         lHrA==
X-Gm-Message-State: AJIora+yK06C5BApbjJBGXapYkaY7oyFQDpfeG/1S7pFRthGOtOzJU6v
        65EckZUAIzQ+wrQtDXHFzmzHAw==
X-Google-Smtp-Source: AGRyM1stEKOa97MHGOwvfFGeoSt3FuS+Eu5m4yHonr0NYFdvsXzMyJYZLHDcfQQpysoq8eIb4KKNAg==
X-Received: by 2002:a05:651c:50b:b0:259:957:f2c6 with SMTP id o11-20020a05651c050b00b002590957f2c6mr4985704ljp.26.1655296212733;
        Wed, 15 Jun 2022 05:30:12 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f27-20020a19381b000000b00479050b8260sm1782521lfa.104.2022.06.15.05.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 05:30:12 -0700 (PDT)
Message-ID: <3f595dba-36e7-59ed-04d6-af1f1259b3ba@linaro.org>
Date:   Wed, 15 Jun 2022 15:30:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] drm/msm/dsi: Use single function for reset
Content-Language: en-GB
To:     Luca Weiss <luca@z3ntu.xyz>, dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220610220259.220622-1-luca@z3ntu.xyz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220610220259.220622-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2022 01:02, Luca Weiss wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> There is currently two function for performing reset: dsi_sw_reset and
> dsi_sw_reset_restore. Only difference betwean those is that latter one
> assumes that DSI controller is enabled. In contrary former one assumes
> that controller is disabled and executed during power-on. However this
> assumtion is not true mobile devices which have boot splash set up by
> boot-loader.
> 
> This patch removes dsi_sw_reset_restore and makes dsi_sw_reset disable
> DSI controller during reset sequence if it's enabled.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 48 +++++++++++++-----------------
>   1 file changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index a95d5df52653..bab2634ebd11 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1080,12 +1080,32 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>   
>   static void dsi_sw_reset(struct msm_dsi_host *msm_host)
>   {
> +	u32 ctrl;
> +
> +	ctrl = dsi_read(msm_host, REG_DSI_CTRL);
> +
> +	if (ctrl & DSI_CTRL_ENABLE) {
> +		dsi_write(msm_host, REG_DSI_CTRL, ctrl & ~DSI_CTRL_ENABLE);
> +		/*
> +		 * dsi controller need to be disabled before
> +		 * clocks turned on
> +		 */
> +		wmb();
> +	}
> +
>   	dsi_write(msm_host, REG_DSI_CLK_CTRL, DSI_CLK_CTRL_ENABLE_CLKS);
>   	wmb(); /* clocks need to be enabled before reset */
>   
> +	/* dsi controller can only be reset while clocks are running */
>   	dsi_write(msm_host, REG_DSI_RESET, 1);
>   	msleep(DSI_RESET_TOGGLE_DELAY_MS); /* make sure reset happen */
>   	dsi_write(msm_host, REG_DSI_RESET, 0);
> +	wmb(); /* controller out of reset */
> +
> +	if (ctrl & DSI_CTRL_ENABLE) {
> +		dsi_write(msm_host, REG_DSI_CTRL, ctrl);
> +		wmb();	/* make sure dsi controller enabled again */
> +	}
>   }
>   
>   static void dsi_op_mode_config(struct msm_dsi_host *msm_host,
> @@ -1478,32 +1498,6 @@ static int dsi_cmds2buf_tx(struct msm_dsi_host *msm_host,
>   	return len;
>   }
>   
> -static void dsi_sw_reset_restore(struct msm_dsi_host *msm_host)
> -{
> -	u32 data0, data1;
> -
> -	data0 = dsi_read(msm_host, REG_DSI_CTRL);
> -	data1 = data0;
> -	data1 &= ~DSI_CTRL_ENABLE;
> -	dsi_write(msm_host, REG_DSI_CTRL, data1);
> -	/*
> -	 * dsi controller need to be disabled before
> -	 * clocks turned on
> -	 */
> -	wmb();
> -
> -	dsi_write(msm_host, REG_DSI_CLK_CTRL, DSI_CLK_CTRL_ENABLE_CLKS);
> -	wmb();	/* make sure clocks enabled */
> -
> -	/* dsi controller can only be reset while clocks are running */
> -	dsi_write(msm_host, REG_DSI_RESET, 1);
> -	msleep(DSI_RESET_TOGGLE_DELAY_MS); /* make sure reset happen */
> -	dsi_write(msm_host, REG_DSI_RESET, 0);
> -	wmb();	/* controller out of reset */
> -	dsi_write(msm_host, REG_DSI_CTRL, data0);
> -	wmb();	/* make sure dsi controller enabled again */
> -}
> -
>   static void dsi_hpd_worker(struct work_struct *work)
>   {
>   	struct msm_dsi_host *msm_host =
> @@ -1520,7 +1514,7 @@ static void dsi_err_worker(struct work_struct *work)
>   
>   	pr_err_ratelimited("%s: status=%x\n", __func__, status);
>   	if (status & DSI_ERR_STATE_MDP_FIFO_UNDERFLOW)
> -		dsi_sw_reset_restore(msm_host);
> +		dsi_sw_reset(msm_host);
>   
>   	/* It is safe to clear here because error irq is disabled. */
>   	msm_host->err_work_state = 0;


-- 
With best wishes
Dmitry
