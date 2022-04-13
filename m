Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896124FF6FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiDMMnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiDMMmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:42:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559C31D0D3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:40:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id p15so3655689ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zFKVdhwqvB7aeF/C+fCQJ8m5WUa4wks0kbfX3z5LRGA=;
        b=kVUmIEJOVSa2rG4QhjQCm63rdkDtXgmjOT8+HbeZS4FEfQNLk1UBapZ3gdGMRgdSdt
         8bjEP5KoXaPU9n5Rcc0QPX8e92Ow74z5wQV2h1g+LenQ8df9BPos7L9ZmqN97GDEwfdb
         i0uZPTsmHBrRqOcGxBSi41jpROFFEm9AJyH38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zFKVdhwqvB7aeF/C+fCQJ8m5WUa4wks0kbfX3z5LRGA=;
        b=F9YqZ9G5XGL/CY9H0GbDxsk81pkN2ykY6E1lNSS1GxRy0ZI2dvkUh+N0s3JAS9McNO
         QOCSZDQnebjNVsQ2FXVhQ8eQq0ckHz63HraL8bcOM4g4VOQlgFSvqn7R2lqHn9HT1ulP
         6UFOHTapI4mq7soU9xXQPjgmNymJT4MKX5bzaHVADQxv7RSwa4YetBZo/K57FdTxyo84
         /dEkPz8wuLqV+iuid2YPGJnn8KtIDZO2ooac0Zd4HTlRgJzOSXUMEuVG3XG8H+pgNxNu
         eHhAMBPWqCD7m6fGEW6KqMIDJdCE1bytgzDO28ITNHsb6Fxui3qScyLqd0E24waIBnMN
         2wYQ==
X-Gm-Message-State: AOAM530z8dzc5SFQQ7S7FRjRFGNoZ0PbnrgciQTB0SZq5RXfTxiJt2vt
        zksWyPfAepqOcaxmnD4uQlNqLg==
X-Google-Smtp-Source: ABdhPJy1BPF87o/iJmH4a3RGEakNokIfqqqetDp9oGgdS3cHUlPW84nziRj/m21dyZUNEyMqpneb9Q==
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr36760541ejn.278.1649853632909;
        Wed, 13 Apr 2022 05:40:32 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (host-95-245-147-71.retail.telecomitalia.it. [95.245.147.71])
        by smtp.gmail.com with ESMTPSA id k26-20020a056402049a00b004197b0867e0sm1131779edv.42.2022.04.13.05.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 05:40:32 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:40:30 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, Li Jun <jun.li@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-evk: add pwm1/backlight support
Message-ID: <20220413124030.GB4713@tom-ThinkPad-T14s-Gen-2i>
References: <20220413102052.20207-1-tommaso.merciai@amarulasolutions.com>
 <c6fe3895-29b2-a371-ccae-c5a12c45d4f1@linaro.org>
 <20220413115810.GA4713@tom-ThinkPad-T14s-Gen-2i>
 <a4b6c158-da56-7879-04a4-558f751cb372@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4b6c158-da56-7879-04a4-558f751cb372@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 02:27:00PM +0200, Krzysztof Kozlowski wrote:
> On 13/04/2022 13:58, Tommaso Merciai wrote:
> >>> +	backlight: backlight {
> >>> +		status = "disabled";
> >>
> >> Why disabled?
> >>
> >>> +		compatible = "pwm-backlight";
> >>> +		pwms = <&pwm1 0 5000000>;
> >>> +		brightness-levels = <0 255>;
> >>> +		num-interpolated-steps = <255>;
> >>> +		default-brightness-level = <250>;
> >>> +	};
> >>> +
> >>>  	ir-receiver {
> >>>  		compatible = "gpio-ir-receiver";
> >>>  		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> >>> @@ -395,6 +404,12 @@ &wdog1 {
> >>>  	status = "okay";
> >>>  };
> >>>  
> >>> +&pwm1 {
> >>> +	pinctrl-names = "default";
> >>> +	pinctrl-0 = <&pinctrl_backlight>;
> >>> +	status = "disabled";
> >>
> >> Same here.
> >>
> >>
> >> Best regards,
> >> Krzysztof
> > 
> > Hi Krzysztof,
> > I think is better to keep disable into .dtsi and enable it at .dts
> > level.
> > What do you think about?
> 
> Why better? This is already board DTSI, not a SoC DTSI. All boards using
> it are supposed to have it available, aren't they?
> 
> Usually nodes should be disabled in a DTSI if they need some resources
> not available in that DTSI. For example if they need some supply. It's
> not the case here, right?

Hi Krzysztof,
Yes, right I check both schematics (DSI_BL_PWM). We can set PWM enable.
I'll update status in v2.

> 
> 
> Best regards,
> Krzysztof

Regards,
Tommaso

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
