Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618624C662E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiB1JzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiB1JzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:55:05 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7448B1C92D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:54:26 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 365B93FC9E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646042065;
        bh=mna9J1nBg6HOMnow2P6fMcSmE8VXg1IqnH2FURdKmp0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=f/OD2VNO+nXtSZLHFiS1/91UX0fGEmAPWyWnDrf4xz5X/SY5YAZawiScUYFg5m3r9
         beVPIrBsISVvy0hOr3ZQu0FGpHszTy1K3vFxFLMKbUdbkF5uUMB99IkxRaNe0j4GiQ
         b5nhxTkUnMbClnZq07HtAMQtQl4sEwK00QJrkCmCYdJtu4UEDHpnL4Ovepm3uYXs1j
         /MSLJVhfznzVOJkltXzdez+UisBUAj4aSKOgL/RD88xXFL49Wq9iMD5FigQZvOfYc3
         Ndx6+HZhor5K1SUaIXLDz892YkNsWvzubD3Kw4oOTmzLmMmwM3E8joXjRoVxWlz341
         YUjLtJdHtgA9w==
Received: by mail-wm1-f72.google.com with SMTP id 7-20020a1c1907000000b003471d9bbe8dso3966450wmz.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mna9J1nBg6HOMnow2P6fMcSmE8VXg1IqnH2FURdKmp0=;
        b=GN8O0Bhccizj8G7xedWoTID6on/QPvdHXRImOYhmPFs5jw1Qb3H3yUUY20VmfIZhbj
         RjGs5mtlNG6db1Ca2vxmNgLEPtcwM2Or7cxhNZSO4y/885Yu7xaHhqYIa2Kpa92aHIg8
         utA1cuBzN/snKwPY5VyNt1gC5ns4bh4NywEkOhD81CraKjXQwNvm8k62KI0X3uR+j/Zk
         a9G3T2147vtb+dygzJakdYSHflR0nTRq0Ew+GshVviZdas38LIJr3R+oF/S2Hc13+nlL
         EBFXIk87yba6zpBmJxHD2w3FJO71J4ocet1q1RFGrtkPc6vYTyR9hyz4348tCoaasew9
         7C+A==
X-Gm-Message-State: AOAM533wZezwaq0a0+SMKcCsh6uxcp2ahawv8BvCM+smFolfmtDqKlzp
        evWExwX8P6BsuHTadVTu9sHjxsmipYvzkmrI1f2sxXEJRb43eiikLvAR5IIzFrA2VK3RBID8+xX
        MIHLmXjkonPDiRyncNC/eB0klclsX6Q9AhbuqMZHLpw==
X-Received: by 2002:a05:6000:162f:b0:1ed:bbef:f7b9 with SMTP id v15-20020a056000162f00b001edbbeff7b9mr15608220wrb.379.1646042064787;
        Mon, 28 Feb 2022 01:54:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwF4VDklq4C5zzM72nwt08X01T/IfVu/GQ6QrQbbkJljUbB9HduFrRm9IjGHQBgzq6rkjLXyQ==
X-Received: by 2002:a05:6000:162f:b0:1ed:bbef:f7b9 with SMTP id v15-20020a056000162f00b001edbbeff7b9mr15608187wrb.379.1646042064370;
        Mon, 28 Feb 2022 01:54:24 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d598a000000b001efab095615sm4434539wri.29.2022.02.28.01.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:54:23 -0800 (PST)
Message-ID: <fc3186ce-f731-a7c1-e958-b0071125b32c@canonical.com>
Date:   Mon, 28 Feb 2022 10:54:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: Add sata nodes to rk356x
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        "devicetree @ vger . kernel . org Damien Le Moal" 
        <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>
References: <20220227182800.275572-1-linux@fw-web.de>
 <20220227182800.275572-4-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227182800.275572-4-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2022 19:28, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> RK356x supports up to 3 sata controllers which were compatible with the
> existing snps,dwc-ahci binding.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes in v3:
>   - fix combphy error by moving sata0 to rk3568.dtsi
>   - remove clock-names and interrupt-names
> changes in v2:
>   - added sata0 + 1, but have only tested sata2
> ---
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 14 +++++++++++++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 26 ++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 5b0f528d6818..2a2f65899d47 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -8,6 +8,19 @@
>  / {
>  	compatible = "rockchip,rk3568";
>  
> +	sata0: sata@fc000000 {
> +		compatible = "snps,dwc-ahci";
> +		reg = <0 0xfc000000 0 0x1000>;
> +		clocks = <&cru ACLK_SATA0>, <&cru CLK_SATA0_PMALIVE>,
> +			 <&cru CLK_SATA0_RXOOB>;
> +		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +		phys = <&combphy0 PHY_TYPE_SATA>;
> +		phy-names = "sata-phy";
> +		ports-implemented = <0x1>;
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		status = "disabled";
> +	};
> +
>  	pipe_phy_grf0: syscon@fdc70000 {
>  		compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
>  		reg = <0x0 0xfdc70000 0x0 0x1000>;
> @@ -114,3 +127,4 @@ power-domain@RK3568_PD_PIPE {
>  		#power-domain-cells = <0>;
>  	};
>  };
> +

No need for new line here,

> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 7cdef800cb3c..484c5ace718a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -230,6 +230,32 @@ scmi_shmem: sram@0 {
>  		};
>  	};
>  
> +	sata1: sata@fc400000 {
> +		compatible = "snps,dwc-ahci";
> +		reg = <0 0xfc400000 0 0x1000>;
> +		clocks = <&cru ACLK_SATA1>, <&cru CLK_SATA1_PMALIVE>,
> +			 <&cru CLK_SATA1_RXOOB>;

clock-names should be added. Also to bindings.


Best regards,
Krzysztof
