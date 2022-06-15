Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15054C7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344885AbiFOLup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbiFOLul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:50:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9C64AE0F;
        Wed, 15 Jun 2022 04:50:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z7so15701525edm.13;
        Wed, 15 Jun 2022 04:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nIRvc0ONAOH4KeBatJrKu9r/BO2Atl4Fv8lTxvlA9V4=;
        b=XjFqVY5CjGeNsB4WO+15swlrY97cAoa/7Rr9ZXozRJgxzZWMOXI5tZU0Amtmeiu5LF
         rcGhGa+P/QC3zD9MRnEzwEnx55MOtR0GLLjdZi9Mu179EsRnjvK1Te9aATm5pcJ/HcaD
         FzPO70IytC5LTDJzuGgtcLSVChuUWGfTwdYdB7d2vqQCnEWc5/PTRSDa8ejx6Lso17GE
         f7LQZFg5ZhzzLwF47PYp0uMF/DV2PWTZkj5ukqelBNW0q5oZzDLnOefL1Q+tI0hfSCdi
         Dt9qUcXf07N32MJXfeS0RtZERhwcTTKAQ8eMYBcBEM6lcLkqZSUa5L61XBd8tprD+Rdq
         APgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nIRvc0ONAOH4KeBatJrKu9r/BO2Atl4Fv8lTxvlA9V4=;
        b=2N4pVuxvZUkXc3mZVcCE4NOV/BR6fxgAEzHQaef5tTGLoxjmDFd64a2jz1iIao3Q2J
         Rwg09tHVrAkynUbbkz7JbRyqHD2gqzAZX6W+UWb6UrOIZkSXl2aIT5ThobzdSeSwoK+5
         oZskiBf8i5XigMYx2lN6Wum+gLDP8k8d3VRNuGh8Gx+Z1dA+3PQPxCwvooebyZwBPrV8
         1aU4NKPN7VT6MqbdhoMor8O+3Fl5JUkPT7R6ANJnwbXkJYZege9JiWiz9CBkVEAF80+4
         Kc3jafy1eMNAS+Hgpye3NL9NFuLR1462/Ih0FHG5ziGhmTJVvpmoSgGfVAO5FwmwGdiJ
         gkCQ==
X-Gm-Message-State: AOAM530TYyplJX4gUH2USOwUs1w7iyB8WkjQ+trSNctLBz8NNbzDdD1y
        XjetbeE/Vz/CKE3s7PWLD0c=
X-Google-Smtp-Source: AGRyM1vmlsVma0i28k6gG0bFleMQyWIMb/6Gu8tm/KbSZmxHGGV+NkhwsaKkn15fwpNDrrj+HLVxdA==
X-Received: by 2002:a05:6402:3482:b0:42d:e063:7c1d with SMTP id v2-20020a056402348200b0042de0637c1dmr12500732edc.40.1655293839096;
        Wed, 15 Jun 2022 04:50:39 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:50:38 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: [PATCH v2 00/18] ARM: dts: imx6q-apalis: Misc improvements and newly added carrier
Date:   Wed, 15 Jun 2022 13:49:48 +0200
Message-Id: <20220615115006.45672-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>


This is a general update of the Apalis iMX6 device tree files.

The Toradex Apalis family is composed of a SoM that can be plugged on
various carrier boards, with carrier boards allowing multiple optional
accessories (e.g. display, camera, ...).

The device tree sources are structured into a SoM dtsi and a carrier dts
which then includes the SoM dtsi. The SoM dtsi defines and enables the
functionality self contained on the SoM and prepares for functionality
provided by the carrier HW or accessories, so that the carrier dts then
can enable or amend nodes provided. Accessories are enabled in overlays
depending on HW configuration.

The series improves the existing Apalis carrier board device trees and
adds a new device trees for the Ixora V1.2 carrier board.

Improvements:
- Specifies GPIO line names for use with libgpiod.
- Disables optional accessories. They would be enabled in overlays
  depending on HW configuration.
- Lower power consumption after poweroff.
- Move more functionality into the SoM dtsi file to reduce code
  duplication.
- General cleanup to adhere to dtbs bindings and missed alphabetically
  ordering.
- PWM backlight for backlights with inverted logic on its PWM input.

Fixes:
- STMPE ADC not functional due to wrong node name in dts.

Adds:
- imx6q-apalis-ixora-v1.2.dtb: used for a Apalis iMX6 mated in an Ixora
  V1.2 carrier board.
- Adds disable support for a OV5640 MIPI-CSI2 Camera and a ADV7280
  Video ADC on a parallel video input.


Changes in v2:
- Moved cleanup for things added in earlier commits of the series to
  the those commit rather than cleaning up later.
- Added reviewed-by tags
- Fixed '-' vs. '_' in node name as pointed out by Fabio
- Added "adv,force-bt656-4" property as suggested by Fabio.
- Added commit "ARM: dts: imx6q-apalis: move gpio-keys to SoM dtsi"
  and followed that in the commit adding the Ixora V1.2.
- Rebased on top of imx/dt, 5.19-rc1

Denys Drozdov (1):
  ARM: dts: imx6q-apalis: Clean-up sd card support

Max Krummenacher (11):
  dt-bindings: arm: fsl: Add carrier for toradex,apalis-imx6q
  Revert "ARM: dts: imx6qdl-apalis: Avoid underscore in node name"
  ARM: dts: imx6q-apalis: Add gpio-line-names
  ARM: dts: imx6q-apalis: Command pmic to standby for poweroff
  ARM: dts: imx6q-apalis: Move Atmel MXT touch ctrl to SoM dtsi
  ARM: dts: imx6q-apalis: move gpio-keys to SoM dtsi
  ARM: dts: imx6q-apalis: Disable HDMI
  ARM: dts: imx6q-apalis: Add support for Toradex Ixora V1.2 carrier
    boards
  ARM: dts: imx6q-apalis: backlight pwm: Simplify inverted backlight
  ARM: dts: imx6q-apalis: backlight pwm: Adapt brightness steps
  ARM: dts: imx6q-apalis: Cleanup

Oleksandr Suvorov (6):
  ARM: dts: imx6q-apalis: Move parallel rgb interface to SoM dtsi
  ARM: dts: imx6q-apalis: Move pinmux groups to SoM dtsi
  ARM: dts: imx6q-apalis: Add LVDS panel support
  ARM: dts: imx6q-apalis: Disable stmpe touchscreen
  ARM: dts: imx6q-apalis: Add ov5640 mipi csi camera
  ARM: dts: imx6q-apalis: Add adv7280 video input

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 127 +---
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 263 +-------
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts | 276 ++++++++
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 113 +---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 638 ++++++++++++++----
 7 files changed, 837 insertions(+), 582 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts

-- 
2.20.1

