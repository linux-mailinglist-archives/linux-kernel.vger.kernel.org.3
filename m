Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068634C00AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiBVR5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiBVR5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:57:42 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B22BDE5C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:57:13 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id a6so15381414oid.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rfmaBXDNF2dcfkVI4GZHzIMW5mn3jOrlYCzlPPScMHQ=;
        b=kpvqMMTu4zQ5/Qjh5pIG3UjKhzitX43hxeJ4qKO7/VsGjllS4xqFbl9MQz5ejboL43
         NMKgqtotlR6vpU6Pjjjf2otFX5LduwdIdT94S7izpri+t9rQ4jjHzkfeXKQuhaLLlsbs
         cdkQnxBMgZSSDix3DyCdBdzqtDSVoNXiU0gJqGCidjJkE5l1+WTxtGK28x6dqqr2qB0K
         /89Ma96s/C+5YW1hZIL8HWvurtyOIF/bQfxWT4gskpY1w4hcanwKqkRAfD0vHGJba8mY
         kgJ7hX0tJ1n8upJ2025RbQRteMmFT6LAwZCtNVcOWAocaNnyaBYI3UWqipfbwWm7B/If
         367A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rfmaBXDNF2dcfkVI4GZHzIMW5mn3jOrlYCzlPPScMHQ=;
        b=FCFE5nz6mRcDAsM8JcqAOdkyUUFrYP221kHkX7xJxlMvVRvw3iq8Z5eVpY8Z6/ksUz
         M9o/71f56TQMT/LH4UXUMdHvXkTotYfZy9SCjvO374U2eUC5uf5tXNxwnZPoSCTU8WkX
         ZPNjYdUj2ishsHpMnm1W4Hcp4C8FMvcBmXMODBb/8ikMGAp5V304l0L9qanWh3juAVOG
         iMl9YimEgdcw6kz44tfyLW6ToxloA1hD6mo5kQV79Khn+uv9IvXhv1mqEHSTDP6OcDdF
         befgsIs26jZx/XY+v3oagSniJko3rUwtmCJqJp3d+m7Vzk6AOUTu0ADe58tWVyj4KKQO
         jqGQ==
X-Gm-Message-State: AOAM532zp1/Qo1KhK83uKbIDPVpVVjNX3+mA5jv9cCUpFTj3R8CGoeGe
        Q9b4710LTfOyV5ieWRzQwmQHyA==
X-Google-Smtp-Source: ABdhPJxfanSWm6mS3pAMGDzvvvoc7Di46iARnR31cY2yD0zBOAlaSXe7Ly0XMyJAPvZNoSjaiyIbAg==
X-Received: by 2002:a05:6808:2386:b0:2d5:47e8:521a with SMTP id bp6-20020a056808238600b002d547e8521amr1446220oib.232.1645552632587;
        Tue, 22 Feb 2022 09:57:12 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id bj38sm5963664oib.20.2022.02.22.09.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 09:57:12 -0800 (PST)
Date:   Tue, 22 Feb 2022 09:59:12 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V4 2/4] leds: Add pm8350c support to Qualcomm LPG driver
Message-ID: <YhUkcH1dYXPDXA01@ripper>
References: <1645509309-16142-1-git-send-email-quic_c_skakit@quicinc.com>
 <1645509309-16142-3-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645509309-16142-3-git-send-email-quic_c_skakit@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 Feb 21:55 PST 2022, Satya Priya wrote:

> Add pm8350c compatible and lpg_data to the driver.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> Changes in V2:
>  - Added const for lpg_channel_data[] struct.
> 
> Changes in V3:
>  - Correct the num_channels and add respective base addresses.
> 
> Changes in V4:
>  - Remove .pwm_9bit_mask, add .triled_base and .triled_mask.

This changed the patch quite a bit. In general when this happen I would
suggest that you don't keep previously acquired Reviewed-bys.

Regards,
Bjorn

> 
>  drivers/leds/rgb/leds-qcom-lpg.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index c1ad678..ab29610 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -1374,9 +1374,22 @@ static const struct lpg_data pm8150l_lpg_data = {
>  	},
>  };
>  
> +static const struct lpg_data pm8350c_pwm_data = {
> +	.triled_base = 0xef00,
> +
> +	.num_channels = 4,
> +	.channels = (const struct lpg_channel_data[]) {
> +		{ .base = 0xe800, .triled_mask = BIT(7) },
> +		{ .base = 0xe900, .triled_mask = BIT(6) },
> +		{ .base = 0xea00, .triled_mask = BIT(5) },
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
