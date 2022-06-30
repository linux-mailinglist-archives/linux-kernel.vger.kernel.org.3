Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144825623A7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbiF3T4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiF3T4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:56:49 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62DD44A35
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:56:47 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id be10so682729oib.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gboqnFzZ9ZxrTwUZ6WoU6968NwUUgD1UzCCueja8BgY=;
        b=I+h5q/QxmSgU2Xn6TLqFpiyXdlVZ919B4FJoNbgwmk3sIYwyarHIJ86nxrcCPpb4bx
         skrcEy4pYPPBpeyQ1AZBHx6JFHj1QPOSRFane0fNyRGpyUw7JRHile4y4wW+LwZ+4cLR
         TtP+sgAkSVRz1HyjXn/kXfjEux0Otz6kKePg0OcIH3zXSQlALgV4tTeRSM/DOPpQo19X
         rGpzy00/i/JIATf27P0BP+zVeKhX/Bwtadr5N5mzgHGEqhzc92VcosxKBojsre483aVd
         lC4wlpP73Mkc7S2Y0uYP6Eft2e1UTg5GXMFDNKi73aHrH4xzizt0caA1BfUFp0VNk5Tc
         7prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gboqnFzZ9ZxrTwUZ6WoU6968NwUUgD1UzCCueja8BgY=;
        b=LRFBv/gAVt+JT2uL5k+feGaetJhn1ch5FYYwfkSOthRAWFsfwmR8lly1UsgOb5L1yv
         wp/NRKjB4R4vaMfPJhdb1h3M1VOil7NDqHi9StCbaWpl21xTlqUtt7rJ+RA+xfyxXDkK
         ca7JCbrSaIz8ZxJhHXhqoWToQDqpEva11uX2cAMAfoePrHyhaUkn1dnu452g7zk5KnKu
         v4VrENrehqmT/0zm54iBaMWAgQtMYMcb3Pmq6rrIyWiOdV7P9+/8/vy7pxbOdbkDSCC4
         6XuxEF/lSS9k3BuTKF6x6Sben6zI/pDH6ESU68bkktHkPpxhr/0e1imQgkA5pM7nr2hi
         Af0w==
X-Gm-Message-State: AJIora+KtLME7bMKLvFjXcBEm+Efrack6wKL0jbw46O4JCKnZfr3WBfT
        xPSo0cixEhfKmhv39pkFxrZvmw==
X-Google-Smtp-Source: AGRyM1tUfOefuvaZG6KMm5IzvtBIQ0uGoQ5jBW6zY56LCV44QQt1Xp03TNrIfDW5/93qhc1L3b4jYQ==
X-Received: by 2002:a05:6808:f12:b0:335:c055:768e with SMTP id m18-20020a0568080f1200b00335c055768emr3410019oiw.186.1656619007244;
        Thu, 30 Jun 2022 12:56:47 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bl29-20020a056808309d00b0032ed2343100sm10842807oib.14.2022.06.30.12.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:56:46 -0700 (PDT)
Date:   Thu, 30 Jun 2022 14:56:44 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v3 2/4] leds: qcom-lpg: Add PM660L configuration and
 compatible
Message-ID: <Yr3//P1IHJQV3mMt@builder.lan>
References: <20220511190718.764445-1-marijn.suijten@somainline.org>
 <20220511190718.764445-2-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511190718.764445-2-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11 May 14:07 CDT 2022, Marijn Suijten wrote:

> Inherit PM660L PMIC LPG/triled block configuration from downstream
> drivers and DT sources, consisting of a triled block with automatic
> trickle charge control and source selection, three colored led channels
> belonging to the synchronized triled block and one loose PWM channel.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Pavel, please pick this change and I'll pick the dts changes through the
qcom tree.

Regards,
Bjorn

> ---
> 
> Changes since v2:
> - Constify channels struct-array (Bjorn);
> - Correct LUT size to 49 slots (Bjorn).
> 
> v2: https://lore.kernel.org/linux-leds/20220507221123.2201668-1-marijn.suijten@somainline.org/T/#u
> 
> Changes since v1:
> - Rebased to pick up pm8350c in the diff-context (Pavel).
> 
> v1: https://lore.kernel.org/linux-leds/20220504205704.699500-1-marijn.suijten@somainline.org/T/#u
> 
>  drivers/leds/rgb/leds-qcom-lpg.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index cfa3362b2457..44b0d1a563df 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -1271,6 +1271,23 @@ static int lpg_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct lpg_data pm660l_lpg_data = {
> +	.lut_base = 0xb000,
> +	.lut_size = 49,
> +
> +	.triled_base = 0xd000,
> +	.triled_has_atc_ctl = true,
> +	.triled_has_src_sel = true,
> +
> +	.num_channels = 4,
> +	.channels = (const struct lpg_channel_data[]) {
> +		{ .base = 0xb100, .triled_mask = BIT(5) },
> +		{ .base = 0xb200, .triled_mask = BIT(6) },
> +		{ .base = 0xb300, .triled_mask = BIT(7) },
> +		{ .base = 0xb400 },
> +	},
> +};
> +
>  static const struct lpg_data pm8916_pwm_data = {
>  	.num_channels = 1,
>  	.channels = (const struct lpg_channel_data[]) {
> @@ -1391,6 +1408,7 @@ static const struct lpg_data pm8350c_pwm_data = {
>  };
>  
>  static const struct of_device_id lpg_of_table[] = {
> +	{ .compatible = "qcom,pm660l-lpg", .data = &pm660l_lpg_data },
>  	{ .compatible = "qcom,pm8150b-lpg", .data = &pm8150b_lpg_data },
>  	{ .compatible = "qcom,pm8150l-lpg", .data = &pm8150l_lpg_data },
>  	{ .compatible = "qcom,pm8350c-pwm", .data = &pm8350c_pwm_data },
> -- 
> 2.36.1
> 
