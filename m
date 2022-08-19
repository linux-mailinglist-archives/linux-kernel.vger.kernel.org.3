Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8559159A9B6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241167AbiHSXxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiHSXxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:53:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415FE115234;
        Fri, 19 Aug 2022 16:53:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d16so1475687wrr.3;
        Fri, 19 Aug 2022 16:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RdfAKZQznic4l7A9/kRG5QY4nU50ENbgtfWawpPow5k=;
        b=FdD91Opw+16zzYnyUIGovktOSZ74Mk0ec0Fls9gvgH0KKtQyfCLn1m+cRxR6oysMXC
         yGGU9J9R8unA3IUtx9cpklthMvzDFYmBtj81IUHa0wlr9JQjSqTnKhweVqjLVD4urebx
         vJn6WFxZUaApyoEHQPJKAek5nLS2o0lylOv2ANdV3MfIRz9z30QqRlEkxAGXSVTc2hBF
         dMWnqWgQnk0jE53SWDCK0ouyiEKZlxXoiofbux9xYy3f0YwrcD+PsoX0bs0KF9GiTXKb
         zjDsiXn0KdR+EobU/BFLMyY/lkAPokQenlFJrRXLgjI4bdlTRosh7H6dedEuaLcEI10U
         KJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RdfAKZQznic4l7A9/kRG5QY4nU50ENbgtfWawpPow5k=;
        b=H2h4mVQhHtNJVfhqUCn96ENX9r7gZ5ZgUPn9Q/9E9tFusnCyTBKZ/aYeakqBl4DrSo
         c/WGVnJpwKp7e8fjWaiW/8CGYKvQ6fLnQKPOFp7QvS3bSMUtjaJKhiKW+/4gDHFjadZW
         pqMilxsuRFG1+Kf2w3sLW7Y6XcTIPdgPLHilKFBuTTpeqvSG7fnFQdP4mGkW+OlKmHvX
         yea8CXSNyIp8RTe2T1G47YVQ0fOdQJaMVQWiWnFjULWnWSPHfVVIrJtRdd6CyPU2NsOx
         KB7fNrFopGAw8ofGKNQa0RMYovsGG7NUD4JGTlRo3D2ChA/ucwzmhY1ec+Uqd7p+x3vu
         bM+g==
X-Gm-Message-State: ACgBeo2y+Errl69d3bmuphQm4BE+6lKorh2xf6aXdbl+xS9wcCEif7kn
        5MPdGT7SIhojA/t72BmUEtmH1cSN9xs=
X-Google-Smtp-Source: AA6agR7r9bkZln4j8hk3SwOU78qTwcgwSEjpa2V/GaN+ThnndFTR9Wd77OqlWLlU4bHd0zBIOHAD6g==
X-Received: by 2002:a05:6000:2c8:b0:221:7aea:c87f with SMTP id o8-20020a05600002c800b002217aeac87fmr5022605wry.242.1660953182731;
        Fri, 19 Aug 2022 16:53:02 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id a18-20020adfdd12000000b002205cbc1c74sm5155714wrm.101.2022.08.19.16.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:53:02 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Lower sd speed on quartz64-b
Date:   Sat, 20 Aug 2022 01:53:01 +0200
Message-ID: <830493549.YKYzsnH2yD@archbook>
In-Reply-To: <20220721044307.48641-1-frattaroli.nicolas@gmail.com>
References: <20220721044307.48641-1-frattaroli.nicolas@gmail.com>
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

On Donnerstag, 21. Juli 2022 06:43:06 CEST Nicolas Frattaroli wrote:
> The previously stated speed of sdr-104 is too high for the hardware
> to reliably communicate with some fast SD cards.
> 
> Lower this to sd-uhs-sdr50 to fix this.
> 
> Fixes: dcc8c66bef79 ("arm64: dts: rockchip: add Pine64 Quartz64-B device tree")
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> index 02d5f5a8ca03..528bb4e8ac77 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> @@ -506,7 +506,7 @@ &sdmmc0 {
>  	disable-wp;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> -	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
>  	vmmc-supply = <&vcc3v3_sd>;
>  	vqmmc-supply = <&vccio_sd>;
>  	status = "okay";
> 

Please apply. Thank you!


