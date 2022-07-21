Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE6557D2BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiGURqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiGURqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:46:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A241849B4E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:46:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso1214320wmm.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=9Iej/WYKS186ZTIm2THeqOrl8G6w6VDAXbCGSBDKlsE=;
        b=jhIuTJl9aRW4WFl89NsrDCv9dQz8pHZl66IFjsHxjMixSgJz9lLzwOibDGwkTLJ5Fl
         wVnDPPZXZ/6A1pdSNH1QWJYY18xMINsbi9WAFTw1CUL7cPTsfkMatT/UzAEKp7D0PksG
         IZr2IsuDM3wSECNoZThbVAiWRWaD9AWu6MTysK80x5u3wZc5DLKOVTUWcRAQkCuafTjv
         p//5F4a+apzUzcuX7muRFACjMzOJWy9lpTf2vd8/d7c3wrPr9O2Fqq8XPEjkHuMQK9ol
         QBCsreSSVCeHMb2/E7Hib2C7nzIXnGBpJiVuH13CdD8TeKW1N/pRh2bBvH1Ju0uQw604
         0euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=9Iej/WYKS186ZTIm2THeqOrl8G6w6VDAXbCGSBDKlsE=;
        b=GjQeA9NQ6kB4ZyJCUTGbWDiN9QspUp6PTlXvnlnbVisjlNTf3ceZOGSNrVhRW/yoIW
         0KKLqh1xFzTBzFI8Y/ORmPbbh0FwLMQwKUzetNCGrxAc8L/ab+KhzYNkqQF0x3MIOg0A
         +qZIVseKPI9rRqMAKxnfhZF/WRejHROGM8F8QcwxNdKK+j6wWK/DxO6nP9zf/cw1/64I
         ITya02C6DDn6DLT+3vEy6/je4MZ8ammBm64rRA30TT5gTCZsCtBxIrxAduTBHvKnTqjc
         eksPQg2VTMT8a0GBAju37xKJUTojOLI1c2+maopJrXieWGxsItLSy63Sf4wbx/OU24k3
         nPbg==
X-Gm-Message-State: AJIora8h3Jc0hbcUWXluPZfrTNBuYF+XOgxYMJajPZ/WHvvAzaNQ2bez
        BWqw/ZDSvfLy0LBAsw+HHlBqYQ==
X-Google-Smtp-Source: AGRyM1vYT9HsyJDiMumeq6ZP0TTedC8+wfXcbSJqkoMKwtzqP0FEzOCEjPe89DYK0yAP9uR4EEYY/A==
X-Received: by 2002:a05:600c:3849:b0:3a2:e7fd:e084 with SMTP id s9-20020a05600c384900b003a2e7fde084mr8936796wmr.15.1658425567088;
        Thu, 21 Jul 2022 10:46:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4c23:a5d2:f5f6:4cd7? ([2a01:e0a:982:cbb0:4c23:a5d2:f5f6:4cd7])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b0039db31f6372sm3714925wmq.2.2022.07.21.10.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 10:46:05 -0700 (PDT)
Message-ID: <f6a9757f-7212-d5e2-be30-e2068066339c@baylibre.com>
Date:   Thu, 21 Jul 2022 19:46:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/6] ARM: defconfig cleanups
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-oxnas@groups.io, linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-sh@vger.kernel.org
References: <20220721141325.2413920-1-arnd@kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220721141325.2413920-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 16:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In the process of deprecating board files, I had to modify some defconfig
> files and ran into the same problem as everyone else that a lot of
> them are rather outdated. With some scripting, I managed to split out
> a preparation patch that puts all lines into the expected order without
> actually changing the contents.
> 
> This helped doing the cleanup separately per Kconfig option that needed
> to be addressed. I only did a small portion of the follow-up changes
> to get to the point of being able to rebase my board changes on top,
> but I did manage to address some bugs that have crept in.
> 
> If there are no objections, I'd apply this set to the arm/defconfig
> branch of the soc tree directly.
> 
>        Arnd
> 
> Arnd Bergmann (6):
>    ARM: refresh defconfig files
>    ARM: defconfig: remove irda remnants
>    ARM: defconfig: remove stale CONFIG_ZBOOT_ROM entries
>    ARM: defconfig: address renamed CONFIG_DEBUG_INFO=y
>    ARM: defconfig: remove broken CONFIG_THUMB disables
>    ARM: defconfig: kill remnants of CONFIG_LEDS
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Taichi Sugaya <sugaya.taichi@socionext.com>
> Cc: Takao Orito <orito.takao@socionext.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-aspeed@lists.ozlabs.org
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-oxnas@groups.io
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-sunxi@lists.linux.dev
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> 
>   arch/arm/configs/am200epdkit_defconfig    |  28 ++---
>   arch/arm/configs/aspeed_g4_defconfig      |  17 ++-
>   arch/arm/configs/aspeed_g5_defconfig      |  17 ++-
>   arch/arm/configs/assabet_defconfig        |  19 ++-
>   arch/arm/configs/at91_dt_defconfig        |  10 +-
>   arch/arm/configs/axm55xx_defconfig        |  26 ++--
>   arch/arm/configs/badge4_defconfig         |  17 +--
>   arch/arm/configs/bcm2835_defconfig        |  38 +++---
>   arch/arm/configs/cerfcube_defconfig       |  24 ++--
>   arch/arm/configs/clps711x_defconfig       |   6 +-
>   arch/arm/configs/cm_x300_defconfig        |  28 ++---
>   arch/arm/configs/cns3420vb_defconfig      |  20 ++--
>   arch/arm/configs/colibri_pxa270_defconfig |  41 +++----
>   arch/arm/configs/colibri_pxa300_defconfig |  12 +-
>   arch/arm/configs/collie_defconfig         |  22 ++--
>   arch/arm/configs/corgi_defconfig          |  51 ++++----
>   arch/arm/configs/davinci_all_defconfig    |  28 ++---
>   arch/arm/configs/dove_defconfig           |  32 +++--
>   arch/arm/configs/ep93xx_defconfig         |  18 ++-
>   arch/arm/configs/eseries_pxa_defconfig    |  36 ++----
>   arch/arm/configs/exynos_defconfig         |  24 ++--
>   arch/arm/configs/ezx_defconfig            |  74 ++++++------
>   arch/arm/configs/footbridge_defconfig     |  31 ++---
>   arch/arm/configs/h3600_defconfig          |  16 +--
>   arch/arm/configs/h5000_defconfig          |  20 ++--
>   arch/arm/configs/hackkit_defconfig        |  12 +-
>   arch/arm/configs/hisi_defconfig           |  24 ++--
>   arch/arm/configs/imx_v4_v5_defconfig      |  10 +-
>   arch/arm/configs/imx_v6_v7_defconfig      |   8 +-
>   arch/arm/configs/integrator_defconfig     |   2 +-
>   arch/arm/configs/iop32x_defconfig         |  23 ++--
>   arch/arm/configs/ixp4xx_defconfig         |   1 -
>   arch/arm/configs/jornada720_defconfig     |  16 +--
>   arch/arm/configs/keystone_defconfig       |  64 +++++-----
>   arch/arm/configs/lart_defconfig           |  21 ++--
>   arch/arm/configs/lpc18xx_defconfig        |  16 ++-
>   arch/arm/configs/lpc32xx_defconfig        |  12 +-
>   arch/arm/configs/lpd270_defconfig         |  11 +-
>   arch/arm/configs/lubbock_defconfig        |  21 ++--
>   arch/arm/configs/magician_defconfig       |  41 +++----
>   arch/arm/configs/mainstone_defconfig      |  15 ++-
>   arch/arm/configs/milbeaut_m10v_defconfig  |   6 +-
>   arch/arm/configs/mini2440_defconfig       |   8 +-
>   arch/arm/configs/mmp2_defconfig           |  32 +++--
>   arch/arm/configs/moxart_defconfig         |  20 ++--
>   arch/arm/configs/mps2_defconfig           |  18 ++-
>   arch/arm/configs/multi_v4t_defconfig      |   6 +-
>   arch/arm/configs/multi_v5_defconfig       |  14 +--
>   arch/arm/configs/multi_v7_defconfig       |  62 +++++-----
>   arch/arm/configs/mv78xx0_defconfig        |  36 +++---
>   arch/arm/configs/mvebu_v5_defconfig       |  32 +++--
>   arch/arm/configs/mvebu_v7_defconfig       |   4 +-
>   arch/arm/configs/mxs_defconfig            |   6 +-
>   arch/arm/configs/neponset_defconfig       |  30 ++---
>   arch/arm/configs/netwinder_defconfig      |  18 +--
>   arch/arm/configs/nhk8815_defconfig        |   8 +-
>   arch/arm/configs/omap1_defconfig          |  80 ++++++-------
>   arch/arm/configs/omap2plus_defconfig      |  17 ++-
>   arch/arm/configs/orion5x_defconfig        |  36 +++---
>   arch/arm/configs/oxnas_v6_defconfig       |  14 +--
>   arch/arm/configs/palmz72_defconfig        |  16 ++-
>   arch/arm/configs/pcm027_defconfig         |  24 ++--
>   arch/arm/configs/pleb_defconfig           |   8 +-
>   arch/arm/configs/pxa168_defconfig         |  22 ++--
>   arch/arm/configs/pxa255-idp_defconfig     |  21 ++--
>   arch/arm/configs/pxa3xx_defconfig         |  20 ++--
>   arch/arm/configs/pxa910_defconfig         |  26 ++--
>   arch/arm/configs/pxa_defconfig            | 140 ++++++++++------------
>   arch/arm/configs/qcom_defconfig           |  62 +++++-----
>   arch/arm/configs/realview_defconfig       |   8 +-
>   arch/arm/configs/rpc_defconfig            |  20 ++--
>   arch/arm/configs/s3c2410_defconfig        |  12 +-
>   arch/arm/configs/s3c6400_defconfig        |   4 +-
>   arch/arm/configs/s5pv210_defconfig        |   6 +-
>   arch/arm/configs/sama5_defconfig          |   8 +-
>   arch/arm/configs/sama7_defconfig          |   8 +-
>   arch/arm/configs/shannon_defconfig        |  10 +-
>   arch/arm/configs/simpad_defconfig         |  29 ++---
>   arch/arm/configs/socfpga_defconfig        |   8 +-
>   arch/arm/configs/spear13xx_defconfig      |  18 +--
>   arch/arm/configs/spear3xx_defconfig       |  12 +-
>   arch/arm/configs/spear6xx_defconfig       |  10 +-
>   arch/arm/configs/spitz_defconfig          |  51 ++++----
>   arch/arm/configs/stm32_defconfig          |  18 ++-
>   arch/arm/configs/sunxi_defconfig          |   2 +-
>   arch/arm/configs/tct_hammer_defconfig     |  14 +--
>   arch/arm/configs/tegra_defconfig          |  20 ++--
>   arch/arm/configs/trizeps4_defconfig       |  66 +++++-----
>   arch/arm/configs/u8500_defconfig          |   2 +-
>   arch/arm/configs/versatile_defconfig      |   4 +-
>   arch/arm/configs/vexpress_defconfig       |   8 +-
>   arch/arm/configs/vf610m4_defconfig        |   2 +-
>   arch/arm/configs/viper_defconfig          |  30 +++--
>   arch/arm/configs/vt8500_v6_v7_defconfig   |   2 +-
>   arch/arm/configs/xcep_defconfig           |  32 +++--
>   arch/arm/configs/zeus_defconfig           |  28 ++---
>   arch/arm64/configs/defconfig              |   2 +-
>   arch/sh/configs/ecovec24_defconfig        |   2 -
>   100 files changed, 989 insertions(+), 1189 deletions(-)
> 

For oxnas:

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
