Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFE54D891A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiCNQbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbiCNQbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:31:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F3512ACD;
        Mon, 14 Mar 2022 09:30:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so6006181wme.5;
        Mon, 14 Mar 2022 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XvhrMTIMvKzPGRJgmngvFLAfyO2VzTvVeYWKjcIpGxA=;
        b=e3Sah/Di09yh5ceRUwRXYNtdeD4LgUZUDEv4lgZApVQ9EiAuyz3bem7EmaGfSLDu6p
         FeToxKOAq+aDXzDUC5tLjoLP/JO6pb9LER4kJ+k/NSjYb0BY2+Z/LKiIqW9L7zS+z8Fm
         walWjQ0D2fQ7qjarnBog9+z2VbBw/A+iRyhArLY80DIHNaDVPyxugLP4H8Fbssz10geb
         029xSVHE5uJoLt8JUyOIYN4Ho5cRbtizTB19zaSNlvzAUoqzb4pObw3CREBgpeOPgxo4
         L8DdPofEYV6GG98O3/P/xy0WsFiRN1DzRNMSZBtGDkEWeHzyH9uMGTXdfcOleqmgowqv
         ShYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XvhrMTIMvKzPGRJgmngvFLAfyO2VzTvVeYWKjcIpGxA=;
        b=lh37NjMKVisuwAc5T9EsWNBN6ppC3Jh+RSIlPmPGw3O2OizxpB2kZmCcDkLKRrPPkl
         wCRWLHev/aHlChbFZZg/XJAGNjOna0Y6ajOMgozfXNJvIwgcvRbNhdJSFFJ/xyUssUPp
         J6pZ3KThECvg+nQd72aHHjene/Ip6yJ/froUJ2yvf1zYqM3BMCRH5t51cIvDRbdy5FOn
         E5QVOQjQdUIYjtvR752zE3rfFiDPU5DCqzLNFOBCIvlAKKuyv2rShHRE80hOreO7KE+M
         5BBJeBSfM8+udN8+fO2/Y4AdvFmOjIboY6M4YeDEyug5O24HeyylQ53wJ0yenX0w8WDF
         a+cw==
X-Gm-Message-State: AOAM532jhWSlu7Mi6eqws0l67Teap1N7zhns3GcpRtM0VYEsp5f+zysr
        8yj5Ub+UhtUn6FNAvsAcc/0=
X-Google-Smtp-Source: ABdhPJyFNTB3mLdxXVKW9CXVu9oHJ446cfD46sOj4wFh4o9HnBId3wNCqgcQb+12uGlh3N5FH/1Veg==
X-Received: by 2002:a05:600c:21c3:b0:389:ee24:caf2 with SMTP id x3-20020a05600c21c300b00389ee24caf2mr45862wmj.20.1647275405179;
        Mon, 14 Mar 2022 09:30:05 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d680a000000b001f1dabec837sm13476817wru.113.2022.03.14.09.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:30:04 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     max.krummenacher@toradex.com
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Alistair Francis <alistair@alistair23.me>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Douglas Anderson <dianders@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Johann Neuhauser <jneuhauser@dh-electronics.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Li Yang <leoyang.li@nxp.com>, Lucas Stach <dev@lynxeye.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Olof Johansson <olof@lixom.net>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: [PATCH v1 00/14] ARM: dts: imx6dl-colibri: Misc improvements and newly added carriers
Date:   Mon, 14 Mar 2022 17:29:44 +0100
Message-Id: <20220314162958.40361-1-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a general update of the Colibri iMX6 device tree files.

The Toradex Colibri family is composed of a SoM that can be plugged on
various carrier boards, with carrier boards allowing multiple optional
accessories (e.g. display, camera, ...).

The device tree sources are structured into a SoM dtsi and a carrier dts
which then includes the SoM dtsi. The SoM dtsi defines and enables the
functionality self contained on the SoM and prepares for functionality
provided by the carrier HW or accessories, so that the carrier dts then
can enable or amend nodes provided. Accessories are enabled in overlays
depending on HW configuration.

The series improves the existing Colibri Evaluation Board device tree and
adds new device trees for the Aster, Iris, and Iris V2 carrier boards.

Additionally it drops the dedicated device tree for SoM V1.1 HW used in a
Evaluation board. The regular device tree works well in that combination.
The higher SD card speed possible with SoM V1.1 would require HW
modification on the carrier board.

Improvements:
- Specifies GPIO line names for use with libgpiod.
- Disables optional accessories. They would be enabled in overlays
  depending on HW configuration.
- Lower power consumption after poweroff.
- Move more functionality into the SoM dtsi file to reduce code
  duplication.
- General cleanup to adhere to dtbs bindings and missed alphabetically
  ordering.

Fixes:
- Copy/paste error in i2c2 pinmuxing resulting in i2c2 being
  nonfunctional.

Adds:
- imx6dl-colibri-aster.dtb: used for a Colibri iMX6 mated in an Aster
  carrier board.
- imx6dl-colibri-iris.dtb: used for a Colibri iMX6 mated in an
  Iris V1.x carrier board.
- imx6dl-colibri-iris-v2.dtb: used for a Colibri iMX6 mated in an
  Iris V2.x carrier board.

Drops:
- imx6dl-colibri-v1_1-eval-v3.dtb, imx6dl-colibri-eval-v3.dtb is good
  enough.


Max Krummenacher (13):
  dt-bindings: arm: fsl: imx6dl-colibri: Drop dedicated v1.1 bindings
  dt-bindings: arm: fsl: Add carriers for toradex,colibri-imx6dl
  ARM: dts: imx6dl-colibri: Drop dedicated v1.1 device tree
  ARM: dts: imx6dl-colibri: Fix I2C pinmuxing
  ARM: dts: imx6dl-colibri: Disable add-on accessories
  ARM: dts: imx6dl-colibri: Command pmic to standby for poweroff
  ARM: dts: imx6dl-colibri: Add additional pingroups
  ARM: dts: imx6dl-colibri: Move common nodes to SoM dtsi
  ARM: dts: imx6dl-colibri: Cleanup
  ARM: dts: imx6dl-colibri: Add usdhc1 sleep pin configuration
  ARM: dts: imx6dl-colibri: Add support for Toradex Iris carrier boards
  ARM: dts: imx6dl-colibri: Add support for Toradex Aster carrier board
  ARM: imx_v6_v7_defconfig: Enable the ADC part of the STMPE MFD

Oleksandr Suvorov (1):
  ARM: dts: imx6dl-colibri: Add gpio-line-names

 .../devicetree/bindings/arm/fsl.yaml          |  11 +-
 arch/arm/boot/dts/Makefile                    |   4 +-
 arch/arm/boot/dts/imx6dl-colibri-aster.dts    | 113 +++
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts  | 110 +--
 arch/arm/boot/dts/imx6dl-colibri-iris-v2.dts  |  46 ++
 arch/arm/boot/dts/imx6dl-colibri-iris.dts     | 152 ++++
 .../boot/dts/imx6dl-colibri-v1_1-eval-v3.dts  |  31 -
 .../boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi    |  44 -
 arch/arm/boot/dts/imx6qdl-colibri.dtsi        | 771 ++++++++++++++----
 arch/arm/configs/imx_v6_v7_defconfig          |   1 +
 10 files changed, 919 insertions(+), 364 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-aster.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-iris.dts
 delete mode 100644 arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
 delete mode 100644 arch/arm/boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi

-- 
2.20.1

