Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B7D49E2F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241444AbiA0NAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbiA0NAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:00:15 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2991C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:00:14 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso5852263wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ThKwZzEoBwxLlFAIZol3ZN4msDIng1irxNDgy0k+rvc=;
        b=ydj0/OueVnJjO8OAlorriaqhjLQotHZJEeqmyT0xqowTtn7ESjmnqrqzKnaGS+u9c1
         wudEpQIHBGi2/w3k4pV64TB3aHgAmXxTtheV50G9i2m7MBaDh3p6sGWSbN6BMwVsgGLi
         YNBFgPGd29YkQdq1uztpkLgWK8jV18DISDhOa1ENmFGhpzzDRHv/qSuAOCZ2uLn4mbb/
         PldoF15pe5iQLDtEZdA+BVU6u8Yd1Pf5wRTEpT2XYS07pXM6pnEQv/drX2fq7Iz2+wjf
         zEcqRQm3irQ61f9WeQCR9qo/QraPkxnODk5wrQTgNbBR5ZwjKMxlK308icVc30XXAw/U
         zmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ThKwZzEoBwxLlFAIZol3ZN4msDIng1irxNDgy0k+rvc=;
        b=bzEK1FHAHYAXtkpgJklv2SWTCKgE1sP44+w4ldrxEzLoNXFRLarVwgwHqJUXgUCLf/
         k1HomqQrIxgDtMNYmi1046xJV44u25oqCqvN7KqN33jTmuSASKR2KiaLrpCqpuOybVW6
         1Ww8n8A47n7Dz5W0mWQhPkDmtn3He8Daik9a0qYiXcVKVX0nh+b2OxL2JzI/eay2pcPa
         hXK8Z434PswrJqZUwx53hrrJW8Yq/ziXKVKVicikVEGAwsOx4D67ymkd9LRVrK+b4VbO
         nTJWRr5Fb2s5XVYx9IYqDQbozqmcYQujSzmgExNvxHvAJibFpq3t1tUsz4lEHS5zFL1p
         idSQ==
X-Gm-Message-State: AOAM530OUufTgRPJtB9YAXsCF1G1Ctlpuqt7HQd4vnH/RObQPNuqaFF+
        yrqMN3gPgtcaejqH6K75VgO6eM1RpXdX9Q==
X-Google-Smtp-Source: ABdhPJytoOWrwFTPO/vhPLQQlw+pOJNhOpY0awU0APR5Dw/RblEz48fpW5KA5FMrx6jC3i5IimycUQ==
X-Received: by 2002:a05:600c:3d94:: with SMTP id bi20mr11706693wmb.14.1643288412500;
        Thu, 27 Jan 2022 05:00:12 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff? ([2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff])
        by smtp.gmail.com with ESMTPSA id c13sm2169441wrv.24.2022.01.27.05.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 05:00:12 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: meson-sm1: fix wrong GPIO domain for GPIOE_2
To:     Dongjin Kim <tobetter@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <YfKPSvnFKOaLr74+@anyang>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <dcb67b4e-6a46-86a6-b21f-99263cc9ff05@baylibre.com>
Date:   Thu, 27 Jan 2022 14:00:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YfKPSvnFKOaLr74+@anyang>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/01/2022 13:25, Dongjin Kim wrote:
> GPIOE_2 is in AO domain and "<&gpio GPIOE_2 ...>" changes the state of
> GPIOZ_14 connected to INTR of 'RTL8211F' on ODROID-HC and TF_PWR_EN of
> 'FC8731' on BPI-M5
> 
> Fixes: 1f80a5cf74a6 ("arm64: dts: meson-sm1-odroid: add missing enable gpio and supply for tf_io regulator")
> Fixes: 976e920183e4 ("arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts")
> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> index 212c6aa5a3b8..5751c48620ed 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> @@ -123,7 +123,7 @@ vddio_c: regulator-vddio_c {
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <3300000>;
>  
> -		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
> +		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  		regulator-always-on;
>  
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> index bf29afac645f..d4349b355e4a 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> @@ -52,7 +52,7 @@ tf_io: gpio-regulator-tf_io {
>  		regulator-max-microvolt = <3300000>;
>  		vin-supply = <&vcc_5v>;
>  
> -		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
> +		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  		regulator-always-on;
>  
> 
Thanks for the fixes,
can you send 2 patches fixing each files instead ?

Thanks,
Neil
