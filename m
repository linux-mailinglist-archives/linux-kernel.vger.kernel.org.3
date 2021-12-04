Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAB146829F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbhLDGON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 01:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhLDGOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 01:14:10 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACCAC061751;
        Fri,  3 Dec 2021 22:10:45 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id n15so5718314qta.0;
        Fri, 03 Dec 2021 22:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2y+NRJ7svIZ+rgMQarZRA08rcjgtgtlNK005rFTBnO8=;
        b=oCW5h9YbVD3xWTwD/r6FDGB6pVZSXrsNXcDZ4vToSs318kVcBqr+5LzUuE7h56xI/c
         mHULahNy/eanaoCEOKfH6xl8snMIGR2ucioL3GrL3SiBuh+RpE9rm7l9m23p2Cyn5Bxn
         IeVhTKyS9ykH27GJizJLOYIg8BEYdqllpsaSYFnlGtJFq7va+Iho7KK4jqBKtsu/525f
         cgxAwG2YFVKgDMLlcQMySH7Nsm5sfhXA6GzxMR2pmE2NjiblDcuK4qrypThhf9bG6NAV
         Igag/JHukF8iwV0d2fRZTFUq9J8WkVTsLcpmNWedogWDVD5QSkYaKeqowVHO3y5GWIhC
         FvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2y+NRJ7svIZ+rgMQarZRA08rcjgtgtlNK005rFTBnO8=;
        b=KJ+KPfFq2C9XC6TF+oTUWl+hZeDYBgDNW3IpysVaBoThWa+ODHgXfhqZEpd+c4bMRS
         h7wJe42VzD9PzOOEP6N5VZtjoiCV++vyl0zVA12MBDRsA4A8cd2QxE7PfOO3FulQxCaP
         1ktuf0scIZpEd9oXO40M7f+O4dj7+ttMLLicZykLbhHnuegoDHKtHP3liuEZRm6NAX/M
         zcBcqfpPSPdJUg/VzXiP6KRy5SeYuWCRsubq2HUCYrLjSKoclK5/UuLALEdN8BC0DCuO
         gpadJpOG9FHnChEHq7DjGpuj+XhWWnRbQl/FaXosPqux/zva+yhhaHNruZ4I00XXbQy8
         L9ag==
X-Gm-Message-State: AOAM532Q55TY6WuOznVN6jpOgqP20rrGXz2zDRCfsUFvTUit2JIcCidg
        cEp0vwhxfirbYoacC+P2y3k=
X-Google-Smtp-Source: ABdhPJzbdfO1SVtq8ihUjdqgA3IO6zUvebShhKS4AAh4E8/m5BHSo6LWcukk6nx/eXMq14zfFDvwzQ==
X-Received: by 2002:ac8:5fc5:: with SMTP id k5mr25847656qta.502.1638598244298;
        Fri, 03 Dec 2021 22:10:44 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id l1sm3500913qkp.125.2021.12.03.22.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 22:10:43 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, Mr.Bossman075@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v4 00/13] Add initial support for the i.MXRTxxxx SoC family starting from i.IMXRT1050 SoC.
Date:   Sat,  4 Dec 2021 01:10:29 -0500
Message-Id: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains:
- i.MXRT10xx family infrastructure
- i.MXRT1050 pinctrl driver adaption
- i.MXRT1050 clock driver adaption
- i.MXRT1050 sd-card driver adaption
- i.MXRT1050 uart driver adaption
- i.MXRT1050-evk basic support

The i.MXRTxxxx family that could have support by Linux actually spreads
from i.MXRT1020 to i.MXRT1170 with the first one supporting 1 USB OTG &
100M ethernet with a cortex-M7@500Mhz up to the latter with i.MXRT1170
with cortex-M7@1Ghz and cortex-M4@400Mhz, 2MB of internal SRAM, 2D GPU,
2x 1Gb and 1x 100Mb ENET. The i.MXRT family is NXP's answer to
STM32F7XX, as it uses only simple SDRAM, it gives the chance of a 4 or
less layer PCBs. Seeing that these chips are comparable to the
STM32F7XXs which have linux ported to them it seems reasonable to add
support for them.

Giving Linux support to this family should ease the development process,
instead of using a RTOS they could use Embedded Linux allowing for more
portability, ease of design and will broaden the scope of people using
embedded linux.

The EVK has very little SDRAM, generally 32MB starting from
i.MXRT1020(the lowest P/N), although the i.MXRT1160/70 provide instead
64MB of SDRAM for more functionality.

At the moment we do not support XIP for either u-boot or Linux but it
should be done in the future. XIP will also save SDRAM.

Another interesting fact is the amount of internal SRAM, as the P/N
increases the SRAM will reach up to 2MB(some could be for cache and
some would be for video).

Also, some parts have embed flash of 4MB that can be used for
u-boot/Linux, if both correctly sized it will leave the SDRAM free.

External flash can be Quad SPI and HyperFlash, so throughput would be
decent.

The i.MXRT11xx series supports MIPI interface too.

The family in general provide CAN bus, audio I/O, 1 or more
USB(otg/host), 1 or more 100Mb/1Gb ethernet, camera interface, sd-card.

All this can be used for simple GUIs, web-servers, point-of-sale
stations, etc.

Giulio Benetti (5):
  ARM: imx: add initial support for i.MXRT10xx family
  pinctrl: freescale: Add i.MXRT1050 pinctrl driver support
  dt-bindings: imx: Add clock binding for i.MXRT1050
  ARM: dts: imx: add i.MXRT1050-EVK support
  ARM: imxrt1050_defconfig: add i.MXRT1050 defconfig

Jesse Taube (8):
  dt-bindings: pinctrl: add i.MXRT1050 pinctrl binding doc
  ARM: dts: imxrt1050-pinfunc: Add pinctrl binding header
  dt-bindings: clock: imx: Add documentation for i.MXRT clock
  clk: imx: Add initial support for i.MXRT clock driver
  dt-bindings: serial: fsl-lpuart: add i.MXRT compatible
  tty: serial: fsl_lpuart: add i.MXRT support
  dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT compatible string
  mmc: sdhci-esdhc-imx: Add sdhc support for i.MXRT series

 .../bindings/clock/imxrt-clock.yaml           |  67 ++
 .../bindings/mmc/fsl-imx-esdhc.yaml           |   1 +
 .../bindings/pinctrl/fsl,imxrt1050.yaml       |  79 ++
 .../bindings/serial/fsl-lpuart.yaml           |   1 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/imxrt1050-evk.dts           |  72 ++
 arch/arm/boot/dts/imxrt1050-pinfunc.h         | 993 ++++++++++++++++++
 arch/arm/boot/dts/imxrt1050.dtsi              | 154 +++
 arch/arm/configs/imxrt_defconfig              |  35 +
 arch/arm/mach-imx/Kconfig                     |   7 +
 arch/arm/mach-imx/Makefile                    |   2 +
 arch/arm/mach-imx/mach-imxrt.c                |  19 +
 drivers/clk/imx/Kconfig                       |   5 +
 drivers/clk/imx/Makefile                      |   1 +
 drivers/clk/imx/clk-imxrt1050.c               | 156 +++
 drivers/mmc/host/sdhci-esdhc-imx.c            |   4 +
 drivers/pinctrl/freescale/Kconfig             |   7 +
 drivers/pinctrl/freescale/Makefile            |   1 +
 drivers/pinctrl/freescale/pinctrl-imxrt1050.c | 349 ++++++
 drivers/tty/serial/fsl_lpuart.c               |   8 +
 include/dt-bindings/clock/imxrt1050-clock.h   |  73 ++
 21 files changed, 2036 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imxrt-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050.yaml
 create mode 100644 arch/arm/boot/dts/imxrt1050-evk.dts
 create mode 100644 arch/arm/boot/dts/imxrt1050-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imxrt1050.dtsi
 create mode 100644 arch/arm/configs/imxrt_defconfig
 create mode 100644 arch/arm/mach-imx/mach-imxrt.c
 create mode 100644 drivers/clk/imx/clk-imxrt1050.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imxrt1050.c
 create mode 100644 include/dt-bindings/clock/imxrt1050-clock.h

-- 
2.34.0

