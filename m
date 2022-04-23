Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D441550CC16
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiDWQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 12:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiDWQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:01:24 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E6BFD27
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:58:27 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id g30-20020a4a251e000000b0033a39d8340aso1968619ooa.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=27WRb8TAj1xwCmRX5jLJOJcOnmbBFcgubgVjuAUaE4o=;
        b=y6xW2G1XsSHeyH5DXQeveuW/+O0IFPUrGFlQdrEGfcYGVPfpVes+ogoxf7DdHI/rMa
         S8CrJLRFP05dPLdga+w21Qd116oGA0vO+lAzTSoTXebiKhah9Ph1yHMOHQgKMiaXlGiY
         5xmiiuhimxwugnQGhKahuJCYouLaT7oKHwdPdVgdnCoH2QOVmA6tPHoJqkbsvusRTQcm
         0ll1BLKmpkslmQZMJJz4FLOKBMGF0M2ilrmO+BAxwZf224P5MYKanmGke0HCiAFh1gzT
         2YStkcU3++Wqa9VF6mP3hDJz/aE5Xo7uJ4vBngiH1obS1VEWtTAwNxXBwhfuOToxYiMG
         YA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=27WRb8TAj1xwCmRX5jLJOJcOnmbBFcgubgVjuAUaE4o=;
        b=UVZJ5qMPC/AZILIlrCu+z8Dphf6uLxbAWITMT2rAy2FGTE77AfOT9U5a0YRjzQQJCL
         PfZHl+AZqfRHMb8tbWPuamPqXBhr4BX5FOMJg+Hngk20U3nNG3rA+gS5XwYMcSbhL43x
         Cm5MV8Edv3mqqI3apVlGo+G40GimH/j4jEQSfMfrqdFs5bo7Qm77tpoyjwV9S/mEy46f
         crpZzEWULXwzC7naDhoGX0m5utJFswHrLYD3rK2xm1W6Oxcf4sjvyC0uZPvza4vqM17W
         Wfjh0cltp0JVgeRiMFkWORYbccMMVB+oZzBnu8W7pZUTQraO5mU+xH7w53udhgOUyPJA
         ug6g==
X-Gm-Message-State: AOAM533xBxKwHYUZiIf8Ypqci6GxIBGFNm5u7SMyvGY97N73GpOozm/N
        vTdENylaoE+yv7kkm0JQFOCkaQ==
X-Google-Smtp-Source: ABdhPJxirqopZgxakMSnC5mL6OQFJH4GIYYrYUpo7jcz3xc42mq/IIeVQ0PA9j/DS5UivlF8dtmF+Q==
X-Received: by 2002:a4a:c294:0:b0:329:2fed:ad3f with SMTP id b20-20020a4ac294000000b003292fedad3fmr3543974ooq.4.1650729506813;
        Sat, 23 Apr 2022 08:58:26 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id a37-20020a9d2628000000b0060563c52952sm1915719otb.8.2022.04.23.08.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:58:26 -0700 (PDT)
Date:   Sat, 23 Apr 2022 10:58:24 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        quic_rjendra@quicinc.com,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add ldo_l17b regulator node
Message-ID: <YmQiIJatomyUVahR@builder.lan>
References: <1650550779-8133-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650550779-8133-1-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21 Apr 09:19 CDT 2022, Srinivasa Rao Mandadapu wrote:

> Add ldo_l17b in pm7325 regulator, which is required for
> wcd codec vdd buck supply.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> index b833ba1..17d0c05 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> @@ -113,6 +113,11 @@
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> +		vreg_l17b_1p8: ldo17 {
> +			regulator-min-microvolt = <1700000>;
> +			regulator-max-microvolt = <1900000>;

Can you confirm that this doesn't need to be in HPM mode?

Thanks,
Bjorn

> +		};
> +
>  		vdd_px_wcd9385:
>  		vdd_txrx:
>  		vddpx_0:
> -- 
> 2.7.4
> 
