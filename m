Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6FB5283A3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbiEPL7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiEPL7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:59:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C8B1583E;
        Mon, 16 May 2022 04:59:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d6so17960964ede.8;
        Mon, 16 May 2022 04:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJWpG604hVqKAeqVG3rB3o4ceVANYTYv7tF5CAO/kdk=;
        b=Jzxsr2hPhy0ETsv25gjnmcL/zG3n2i4OIDZJoG3qAV7Jk4CT/iGiOHE/XP0smSySD0
         UWPdqk0WkjN2uxucNgE3f34WeS0vAMRNp9QASXeLMC8Xt7uLrD/qRmVzUHOB/qkeFVKg
         GBePV/Ald33VVLB2UEzmtJSYkY4Z68oumqdpo2B92fhd0p8X8stdGs/tSFUc0eUQzeaB
         z0dkH1Xei/mbNEDvbNcUnJvzZpBCjX61mSGYVcy1G5hpdeyq4XDcmmy7XrHaLvJVeBzZ
         mIGdSX2rhMOmz8ng24XYgbHErzUKH9gxd5IR5t2sKjb7LMlA8ZgTzRZrBr2j0bNm2nMW
         dg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJWpG604hVqKAeqVG3rB3o4ceVANYTYv7tF5CAO/kdk=;
        b=qA17qAPZV+gHFtrxAlOj0pdWBSE8GTgdXQBXNPsLV4HYo+vvQVcPL7BULemEzB/obd
         841zMwIfgnJL0F4knSJKANzLCtl+38viDIyRKwR7KLuDNz1HeY1JGTPCfSRUNlkAbbqO
         hVl+FIu2e7VvX8pj23Ut38SWSmuJMMT2IrWOq15WE/G8vLTLphFwQNR3I+2KLTiUCx23
         Izsbe84bjLDUimdb1fJ3uEe0XxQuKWaq0ZI30kiJMz3Oz4WWJJQ+mP6gwyuqyVoiUCkz
         0POOR4H98dTDk4N7RVYaKzTSIEwEHccpyNkkWPzai3swC7DjNRzA7yEccX73U7ng1qw6
         +X9g==
X-Gm-Message-State: AOAM531KccC6nL/ktxoZRBS1k2mFqps9heam6V0HOEbg/ZZ91amhuhmW
        kl4T+JGju4G5bMRf2DK8dYynjgdsUaM=
X-Google-Smtp-Source: ABdhPJyVtXrvnTtQsnVTM/zp1S4ocgsMp3U0juyQ8F3KkqeH5e/nRfIKnUXkifIEftjj8iYExvYPmA==
X-Received: by 2002:aa7:d454:0:b0:428:8fe8:b8cf with SMTP id q20-20020aa7d454000000b004288fe8b8cfmr12887809edr.328.1652702357802;
        Mon, 16 May 2022 04:59:17 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:17 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: [PATCH v1 00/17] ARM: dts: imx6q-apalis: Misc improvements and newly added carrier
Date:   Mon, 16 May 2022 13:58:28 +0200
Message-Id: <20220516115846.58328-1-max.oss.09@gmail.com>
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


Shawn, this patchset reworks a lot of the imx6qdl-apalis. Commit
fa51e1dc4b91 ("ARM: dts: imx6qdl-apalis: Fix sgtl5000 detection issue")
which is in imx/fixes also touches the file.
To keep the rebasing work minimal I based the series on top of imx/dt,
but did additionally cherry-pick commit fa51e1dc4b91.
Is this the way to go in such circumstances?

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



Denys Drozdov (1):
  ARM: dts: imx6q-apalis: Clean-up sd card support

Max Krummenacher (10):
  dt-bindings: arm: fsl: Add carrier for toradex,apalis-imx6q
  Revert "ARM: dts: imx6qdl-apalis: Avoid underscore in node name"
  ARM: dts: imx6q-apalis: Add gpio-line-names
  ARM: dts: imx6q-apalis: Command pmic to standby for poweroff
  ARM: dts: imx6q-apalis: Move Atmel MXT touch ctrl to SoM dtsi
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
 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 117 +---
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 263 +-------
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts | 290 ++++++++
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 103 +--
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 623 ++++++++++++++----
 7 files changed, 840 insertions(+), 558 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts

-- 
2.20.1

