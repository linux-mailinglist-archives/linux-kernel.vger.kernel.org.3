Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEBA57CE7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiGUPEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGUPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:04:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE90E84ED4;
        Thu, 21 Jul 2022 08:04:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id va17so3718246ejb.0;
        Thu, 21 Jul 2022 08:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZY3t0NZGuTXsMWoX5QYWqWMtkxGTr+i/nc1XlDM8Y4=;
        b=NmgQ5WvuD8XqtCLLQuc6YUtqO0ImP9P0gljqHUyvnWjzwyFODmpUxqKyeGPpAc9cXC
         Yb5y2d5LWhWPIY4F/+7CH4r/8gGB/HM9GVwBsWsXHyE5jms4sSkSwE6lyuCaWSF450WD
         EdCxSH0zb68yesikhcpmtdXjhpdpLSBGyP279WP5/CHD9tXIayCrsVAhuKP82sP6NI2x
         pEOVEKiAcq+YN6aQUgOICVdp+1bTikZF7+UVgAOGVZBpqK3tAztbVluyVm0RM9YIkym6
         cb1zde7IGcSvaL0JptydfsA2H/6GyOikZZwFVu8Qr8DeJ+FoT5FmPShXTQ+PQnyaTjaU
         QbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZY3t0NZGuTXsMWoX5QYWqWMtkxGTr+i/nc1XlDM8Y4=;
        b=QF6coiZ9Kuvpb39jEWrFGrypaJqFF5+jf1cw+FgMoHYke9xjOsOb+uznuxkiwivBM+
         kXTnIeCI6QZdOCQsn6meJ7OPon8X+fgoqHlY1RV3qqu2x9ianMFsy8kLVEp4weX/oYdO
         4ZdgOpPqRvtYJfmoIsZr79ZZWItSSNm6BI0RQFGSos1+lY6A27/qli4BzU8itDaj0SnR
         J3/p4zcAumzaPNaTfunsqj9WYc/Yh3MpULSVfcoVOmEqEZXArDN6Xrr7CO9JDjIbTq1P
         LcNpwbAJOiHVRzBAE8QAwy1buM5hvm/PTE02vebb6ZOlT74o/9FPiE4tBAodLwtSKLnM
         HB2g==
X-Gm-Message-State: AJIora+pvn4KCYUS6TMIOPXE2eVh2fCdBjXqUkH826i0Mzs6kiXMYORs
        upz/MxzhuGdKqYx/Kmavsrk=
X-Google-Smtp-Source: AGRyM1tx4qgDiPlw73OnGDJULo2qk1SNBkaYXmyBBcKtmntG8pWEIhoIv9VtYkaGcyjuJQmc48QmDQ==
X-Received: by 2002:a17:907:75ce:b0:72b:305f:5985 with SMTP id jl14-20020a17090775ce00b0072b305f5985mr40127216ejc.527.1658415841341;
        Thu, 21 Jul 2022 08:04:01 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-13-89.dynamic.telemach.net. [86.58.13.89])
        by smtp.gmail.com with ESMTPSA id w17-20020a056402071100b0043aa17dc199sm1097785edx.90.2022.07.21.08.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:04:00 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@kernel.org>
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
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
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
Subject: Re: [PATCH 1/6] ARM: refresh defconfig files
Date:   Thu, 21 Jul 2022 17:03:56 +0200
Message-ID: <2073800.OBFZWjSADL@jernej-laptop>
In-Reply-To: <20220721141325.2413920-2-arnd@kernel.org>
References: <20220721141325.2413920-1-arnd@kernel.org> <20220721141325.2413920-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 21. julij 2022 ob 16:13:20 CEST je Arnd Bergmann napisal(=
a):
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> A lot of Kconfig options have changed over the years, and we tend
> to not do a blind 'make defconfig' to refresh the files, to ensure
> we catch options that should not have gone away.
>=20
> I used some a bit of scripting to only rework the bits where an
> option moved around in any of the defconfig files, without also
> dropping any of the other lines, to make it clearer which options
> we no longer have.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/configs/am200epdkit_defconfig    |  26 ++---
>  arch/arm/configs/aspeed_g4_defconfig      |  16 +--
>  arch/arm/configs/aspeed_g5_defconfig      |  16 +--
>  arch/arm/configs/assabet_defconfig        |   8 +-
>  arch/arm/configs/at91_dt_defconfig        |  10 +-
>  arch/arm/configs/axm55xx_defconfig        |  22 ++--
>  arch/arm/configs/badge4_defconfig         |   8 +-
>  arch/arm/configs/bcm2835_defconfig        |  36 +++----
>  arch/arm/configs/cerfcube_defconfig       |  16 +--
>  arch/arm/configs/clps711x_defconfig       |   2 +-
>  arch/arm/configs/cm_x300_defconfig        |  26 ++---
>  arch/arm/configs/cns3420vb_defconfig      |  18 ++--
>  arch/arm/configs/colibri_pxa270_defconfig |  32 +++---
>  arch/arm/configs/colibri_pxa300_defconfig |  10 +-
>  arch/arm/configs/collie_defconfig         |  20 ++--
>  arch/arm/configs/corgi_defconfig          |  44 ++++----
>  arch/arm/configs/davinci_all_defconfig    |  26 ++---
>  arch/arm/configs/dove_defconfig           |  28 ++---
>  arch/arm/configs/ep93xx_defconfig         |  16 +--
>  arch/arm/configs/eseries_pxa_defconfig    |  26 ++---
>  arch/arm/configs/exynos_defconfig         |  20 ++--
>  arch/arm/configs/ezx_defconfig            |  72 ++++++-------
>  arch/arm/configs/footbridge_defconfig     |  14 +--
>  arch/arm/configs/h3600_defconfig          |  10 +-
>  arch/arm/configs/h5000_defconfig          |  18 ++--
>  arch/arm/configs/hackkit_defconfig        |   4 +-
>  arch/arm/configs/hisi_defconfig           |  24 ++---
>  arch/arm/configs/imx_v4_v5_defconfig      |   8 +-
>  arch/arm/configs/imx_v6_v7_defconfig      |   8 +-
>  arch/arm/configs/integrator_defconfig     |   2 +-
>  arch/arm/configs/iop32x_defconfig         |  20 ++--
>  arch/arm/configs/jornada720_defconfig     |  10 +-
>  arch/arm/configs/keystone_defconfig       |  62 +++++------
>  arch/arm/configs/lart_defconfig           |   6 +-
>  arch/arm/configs/lpc18xx_defconfig        |  12 +--
>  arch/arm/configs/lpc32xx_defconfig        |   8 +-
>  arch/arm/configs/lpd270_defconfig         |   6 +-
>  arch/arm/configs/lubbock_defconfig        |  10 +-
>  arch/arm/configs/magician_defconfig       |  30 +++---
>  arch/arm/configs/mainstone_defconfig      |   4 +-
>  arch/arm/configs/milbeaut_m10v_defconfig  |   6 +-
>  arch/arm/configs/mini2440_defconfig       |   6 +-
>  arch/arm/configs/mmp2_defconfig           |  28 ++---
>  arch/arm/configs/moxart_defconfig         |  18 ++--
>  arch/arm/configs/mps2_defconfig           |  14 +--
>  arch/arm/configs/multi_v4t_defconfig      |   4 +-
>  arch/arm/configs/multi_v5_defconfig       |  12 +--
>  arch/arm/configs/multi_v7_defconfig       |  62 +++++------
>  arch/arm/configs/mv78xx0_defconfig        |  32 +++---
>  arch/arm/configs/mvebu_v5_defconfig       |  28 ++---
>  arch/arm/configs/mvebu_v7_defconfig       |   2 +-
>  arch/arm/configs/mxs_defconfig            |   4 +-
>  arch/arm/configs/neponset_defconfig       |  24 ++---
>  arch/arm/configs/netwinder_defconfig      |  10 +-
>  arch/arm/configs/nhk8815_defconfig        |   6 +-
>  arch/arm/configs/omap1_defconfig          |  74 ++++++-------
>  arch/arm/configs/omap2plus_defconfig      |  16 +--
>  arch/arm/configs/orion5x_defconfig        |  32 +++---
>  arch/arm/configs/oxnas_v6_defconfig       |  14 +--
>  arch/arm/configs/palmz72_defconfig        |  14 +--
>  arch/arm/configs/pcm027_defconfig         |  22 ++--
>  arch/arm/configs/pleb_defconfig           |   6 +-
>  arch/arm/configs/pxa168_defconfig         |  18 ++--
>  arch/arm/configs/pxa255-idp_defconfig     |  10 +-
>  arch/arm/configs/pxa3xx_defconfig         |  18 ++--
>  arch/arm/configs/pxa910_defconfig         |  22 ++--
>  arch/arm/configs/pxa_defconfig            | 126 +++++++++++-----------
>  arch/arm/configs/qcom_defconfig           |  60 +++++------
>  arch/arm/configs/realview_defconfig       |   8 +-
>  arch/arm/configs/rpc_defconfig            |  18 ++--
>  arch/arm/configs/s3c2410_defconfig        |   8 +-
>  arch/arm/configs/s3c6400_defconfig        |   2 +-
>  arch/arm/configs/s5pv210_defconfig        |   4 +-
>  arch/arm/configs/sama5_defconfig          |   8 +-
>  arch/arm/configs/sama7_defconfig          |   8 +-
>  arch/arm/configs/shannon_defconfig        |   8 +-
>  arch/arm/configs/simpad_defconfig         |  18 ++--
>  arch/arm/configs/socfpga_defconfig        |   4 +-
>  arch/arm/configs/spear13xx_defconfig      |  16 +--
>  arch/arm/configs/spear3xx_defconfig       |  10 +-
>  arch/arm/configs/spear6xx_defconfig       |   8 +-
>  arch/arm/configs/spitz_defconfig          |  44 ++++----
>  arch/arm/configs/stm32_defconfig          |  14 +--
>  arch/arm/configs/sunxi_defconfig          |   2 +-

=46or sunxi:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  arch/arm/configs/tct_hammer_defconfig     |  12 +--
>  arch/arm/configs/tegra_defconfig          |  18 ++--
>  arch/arm/configs/trizeps4_defconfig       |  58 +++++-----
>  arch/arm/configs/u8500_defconfig          |   2 +-
>  arch/arm/configs/versatile_defconfig      |   4 +-
>  arch/arm/configs/vexpress_defconfig       |   4 +-
>  arch/arm/configs/vf610m4_defconfig        |   2 +-
>  arch/arm/configs/viper_defconfig          |  28 ++---
>  arch/arm/configs/vt8500_v6_v7_defconfig   |   2 +-
>  arch/arm/configs/xcep_defconfig           |  30 +++---
>  arch/arm/configs/zeus_defconfig           |  26 ++---



