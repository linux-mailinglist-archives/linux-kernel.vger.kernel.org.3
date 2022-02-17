Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472B14BAC89
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbiBQWYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:24:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343846AbiBQWY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:24:29 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63282BB01
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:24:14 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 4so1116805oil.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/neFhOJyXKG5xSPOlx3CJHDkEqEd9BRroYvm8Izt9PU=;
        b=sYKcZLjYBIoEo8liVjK/NRa/cSfQMrW3EijXiy4Gakbj3BtmY1jTwBXZjgSm1KwYvw
         EUbw9qFK1Vis7+Hn8aLBdvJXtLaqo/KtJudsA5aapscIzSc+eLy9CuN27UAerGmKiZvw
         diOIyVr9vCMyCf+4jLgVKfUqhXcVfZg3t11inoh1V2nqpb0VyfiDWvz1qPUc7JjFhPj/
         4OmoXMJb14GlZEAzFIoUVlJPpBLSMD6w4h29JdMio6mIafyrmJJfZNjMcS5XBhBm2dGe
         ka6IbIduW9AfZdcOCpq1ckB9ClPUd8UBs8K3gmoB1UrDwBARBlw03epOB2JJQ/inDZ/D
         vkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/neFhOJyXKG5xSPOlx3CJHDkEqEd9BRroYvm8Izt9PU=;
        b=6ZV+vMGadPY/TwhJLN5puCgdUXPjAlHRftL8En0DUFIgLUQL83jXFt8fQTVqkoeJvT
         2RX5Z+mo2tpRQmON7fbWizLVq+ehBq3zpYR+O26vyDBXKWLImNvg7Zz18ny13ScFtVUI
         KYch8MjEtOLC9E7LGgOykxpAAMERGpVmRxuAy8lEby3GU32AGU+OO76VdfRBEhcox6iV
         LjbltUG108mIWqxKkIGBAS8UY/uXjmqIkcE8B6TCOVd3xs34Xd2NZHJBsyBbM7ZThMGY
         K6i7TBq41ILzCYV3Gxt0j0nP3ENDxv54GsRwPF09deTKZANwUKn8+kbSq3xedCghVEbk
         85TA==
X-Gm-Message-State: AOAM533YTxcbfsg7gBBU1IJTnfTRVbn0azodsqTl61/m+jI0Q2hc0Sff
        354QOBybiQYGqTLXGyQDJuUUlA==
X-Google-Smtp-Source: ABdhPJyAHPTbyHfEMbFh3qbEs6lUXgioZ89TvaZDWuHOUNgl2HglyEel/rwjbbS0NIYVNx5zst55qw==
X-Received: by 2002:a05:6808:238f:b0:2ce:df34:1812 with SMTP id bp15-20020a056808238f00b002cedf341812mr3789990oib.147.1645136653688;
        Thu, 17 Feb 2022 14:24:13 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id w13sm545096ooj.5.2022.02.17.14.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 14:24:13 -0800 (PST)
Date:   Thu, 17 Feb 2022 14:26:20 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, mka@chromium.org,
        swboyd@chromium.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, satya priya <skakit@codeaurora.org>
Subject: Re: [PATCH V3 2/4] leds: Add pm8350c support to Qualcomm LPG driver
Message-ID: <Yg7LjJFi51cmDUQr@ripper>
References: <1635507893-25490-1-git-send-email-quic_c_skakit@quicinc.com>
 <1635507893-25490-3-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635507893-25490-3-git-send-email-quic_c_skakit@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29 Oct 04:44 PDT 2021, Satya Priya wrote:

> From: satya priya <skakit@codeaurora.org>
> 
> Add pm8350c compatible and lpg_data to the driver.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>

Sorry for the OCD, but I would really like for you to capitalize 's' and
'p' in your name.

> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in V2:
>  - Added const for lpg_channel_data[] struct.
> 
> Changes in V3:
>  - Correct the num_channels and add respective base addresses.
> 
>  drivers/leds/rgb/leds-qcom-lpg.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index 45ef4ec..ad99a9b 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -1275,9 +1275,22 @@ static const struct lpg_data pm8150l_lpg_data = {
>  	},
>  };
>  
> +static const struct lpg_data pm8350c_pwm_data = {
> +	.pwm_9bit_mask = BIT(2),

As you might have seen in v12 I dropped pwm_9bit_mask.

> +

Afaict there's a tri-channel current sink in pm8350c as well, so you
should have:

        .triled_base = 0xef00,

And then associated .triled_mask in the relevant channels.

Regards,
Bjorn

> +	.num_channels = 4,
> +	.channels = (const struct lpg_channel_data[]) {
> +		{ .base = 0xe800 },
> +		{ .base = 0xe900 },
> +		{ .base = 0xea00 },
> +		{ .base = 0xeb00 },
> +	},
> +};
> +
>  static const struct of_device_id lpg_of_table[] = {
>  	{ .compatible = "qcom,pm8150b-lpg", .data = &pm8150b_lpg_data },
>  	{ .compatible = "qcom,pm8150l-lpg", .data = &pm8150l_lpg_data },
> +	{ .compatible = "qcom,pm8350c-pwm", .data = &pm8350c_pwm_data },
>  	{ .compatible = "qcom,pm8916-pwm", .data = &pm8916_pwm_data },
>  	{ .compatible = "qcom,pm8941-lpg", .data = &pm8941_lpg_data },
>  	{ .compatible = "qcom,pm8994-lpg", .data = &pm8994_lpg_data },
> -- 
> 2.7.4
> 
