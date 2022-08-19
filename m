Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0D459A99D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbiHSXvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243674AbiHSXvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:51:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6384112FB0;
        Fri, 19 Aug 2022 16:51:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so4817609wma.4;
        Fri, 19 Aug 2022 16:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6K+Gbut6C3SMWqkBrTWvK/kA2LBhPOCWJd8A9mugSZw=;
        b=X+1fqQVkRUblp4KR6kQj5KcuWemgxb/9Z2iRuoaU0t8ckKnPN7NEnVNwKZdP/jvHXh
         wg4E6fzr9hCqdobcCjVq7fmn+G6Mb9CAfDYkMkQbe/IjVYyMMJqXcA+jStFvaVfDCjAe
         /kd1O8Kf9KIbm2/b501QcWJumkW/XVZzC8dJcLWqSmqnBo/DPTT0JuxYx3NpVwHyi6A1
         jjIewqaaLaA+lC3ix7py13wa7/o22OO6nWDf7bDg3FJd891fvKfd86Qz4NuahwrW+L6v
         zJUvW3aEXaA/nThO3eN2jhDxbTJvp7WswHFbZx3SspIK78zOY3H44/fC00uurj1/xtSE
         wvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6K+Gbut6C3SMWqkBrTWvK/kA2LBhPOCWJd8A9mugSZw=;
        b=52K2aueEZrKY3KJqc6ejmHEUP6V+1PS6esFb6IPVMNyU6RWIoywfcQFeDBXbZLA5XT
         N8V73aMDN3Ld6gZbiI1eTpHEjzRscf0/ckR46t84y70TZ0xnWuke4M3z7CPY6bYVQ/P7
         /uTPgIF2/Mr/3xr2DoMUvWX61Q65O4BT7185Ayt+zwEJsigD79UTlVa4LlpvZkBAD7la
         PDwpUA1p5LIzDNtpd//PUs3G8SZfXlEfsVICJtiAJRtYNiK7uQK1Gqmm1LBnuzkOqf8b
         NNfpHPi4x6gnUSKSbAXUWjJ11flktkBzALWyBKw1Uj03g0xBe+tDTEweW/a+KLMyERKj
         TbSg==
X-Gm-Message-State: ACgBeo0Pm7EFs58xqMOGGSPWid1bdgMm1/KGoMYwhi5xz4l4ExYlsvNL
        /7Ne3MNceOCtqWukoA5kb10=
X-Google-Smtp-Source: AA6agR47Np9Ok78NyHzV8nhmUyE67a78+p7tAZ5Cjr/2TXypthFIBb8X6ZXHpuPJw8fcw1o8HqY8tw==
X-Received: by 2002:a05:600c:1550:b0:3a6:1d8c:247e with SMTP id f16-20020a05600c155000b003a61d8c247emr6019877wmg.63.1660953074286;
        Fri, 19 Aug 2022 16:51:14 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id r38-20020a05600c322600b003a2e92edeccsm9026113wmp.46.2022.08.19.16.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:51:13 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add analog audio output on quartz64-b
Date:   Sat, 20 Aug 2022 01:51:12 +0200
Message-ID: <10732790.V6xDz3LDya@archbook>
In-Reply-To: <20220721083301.3711-1-frattaroli.nicolas@gmail.com>
References: <20220721083301.3711-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 21. Juli 2022 10:33:00 CEST Nicolas Frattaroli wrote:
> This adds the necessary device tree changes to enable analog
> audio output on the PINE64 Quartz64 Model B with its RK809
> codec.
> 
> The headphone detection pin is left out for now because I couldn't
> get it to work and am not sure if it even matters, but for future
> reference: It's pin GPIO4 RK_PC4, named HP_DET_L_GPIO4_C4 in the
> schematic.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
> Changes since v1:
>  - use generic node name for the simple-audio-card node
> 
> ---
>  .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 32 ++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> index 02d5f5a8ca03..3897980d69d1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> @@ -42,6 +42,21 @@ led-user {
>  		};
>  	};
>  
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,name = "Analog RK809";
> +		simple-audio-card,mclk-fs = <256>;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s1_8ch>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&rk809>;
> +		};
> +	};
> +
>  	sdio_pwrseq: sdio-pwrseq {
>  		status = "okay";
>  		compatible = "mmc-pwrseq-simple";
> @@ -177,11 +192,16 @@ rk809: pmic@20 {
>  		reg = <0x20>;
>  		interrupt-parent = <&gpio0>;
>  		interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
> +		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
> +		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
> +		clock-names = "mclk";
> +		clocks = <&cru I2S1_MCLKOUT_TX>;
>  		clock-output-names = "rk808-clkout1", "rk808-clkout2";
>  
>  		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int>;
> +		pinctrl-0 = <&pmic_int>, <&i2s1m0_mclk>;
>  		rockchip,system-power-controller;
> +		#sound-dai-cells = <0>;
>  		wakeup-source;
>  		#clock-cells = <1>;
>  
> @@ -420,6 +440,16 @@ &i2c5 {
>  	status = "disabled";
>  };
>  
> +&i2s1_8ch {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2s1m0_sclktx
> +		     &i2s1m0_lrcktx
> +		     &i2s1m0_sdi0
> +		     &i2s1m0_sdo0>;
> +	rockchip,trcm-sync-tx-only;
> +	status = "okay";
> +};
> +
>  &mdio1 {
>  	rgmii_phy1: ethernet-phy@1 {
>  		compatible = "ethernet-phy-ieee802.3-c22";
> 

Gentle ping, it has been a month with no response so I assume
there's nothing egregiously wrong here.


