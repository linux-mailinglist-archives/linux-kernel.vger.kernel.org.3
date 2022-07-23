Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D0957F035
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 18:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbiGWQFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 12:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiGWQFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 12:05:18 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EFBB4A0;
        Sat, 23 Jul 2022 09:05:17 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id i4so5468040qvv.7;
        Sat, 23 Jul 2022 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NiBXHZtiNNzM7sHjjwSiAophF4Tu0dmf3XqMGID1JOM=;
        b=gRlQXzeTLOdtN2sYz2mwN+kdfbohHDPBoWrR0vt1QqZOpEJf8qWYqJRApWT4AkkEHB
         6ZoJLwk8Y1qqD13NypUe8ZMHXPlF1Xwmc2i5NmYyBHI0y4TvgsSgalxdx6dUL8EywhSp
         4/aWAKZZgvp04WaLmJDXV8yuQuriLEYblcQYgGrLRJ7xeGvJeIP0wPmXhABQ5YVhoRE0
         xhfn+BdA2s6sKDw+gBi5LY99iqqIAfJY7rdx8YiiaWSGvGoeS8/iG04REyKb6sydRN1E
         TH+iAD9qOBlL+3KlUuK3K7/tqGMQOF4YBW0rbsfTla3SQYI9WhINmzVgIMgDTDwmVJs8
         uQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NiBXHZtiNNzM7sHjjwSiAophF4Tu0dmf3XqMGID1JOM=;
        b=Bhp1rCrwcATYDEK3Vhm28BPTBLf+1Bkxpx0umqdBe/rgfQPICyx+NGSTLe9pxhrwHS
         0309qaGF7R5pqdH2vy7IKnH9nWAkwGRKGyrIrSbN3VU9Ti0mmDDswBC5EdYQAk0dVbe2
         srbfLkMxdas4Xp1+II/FsXIAvl7dhYp04AueP6dmdpyw+uzFfRdNFh248ipl9tt6KcPN
         hdJg4nqOdD7TwUuRrgIJxNvCqIeak3YGKVtNov3LXIOv6ZpYqM9msz4aKcIMg3Xk7W2t
         G7YVA2KQypc+ZC6r53Nlqen0+QR2AclnkiaRGhyi9Ac9+EV93CfbRMbK/awzARMW3p8C
         bl4g==
X-Gm-Message-State: AJIora9PmePQ5LnY/KdZ3Tq7e1jKmkZI2iemctzghuHomm6CUs/U9TFU
        xj/i5YHN2iAkAxvK7J2hweE=
X-Google-Smtp-Source: AGRyM1tFGvEAl9/tyu4hF4NNXrnTxNm3w9+iEprFORt+uxL5yPCUzTz4QtHT1LgBfv2VcIgWE/nRvw==
X-Received: by 2002:ad4:5c62:0:b0:473:4585:292f with SMTP id i2-20020ad45c62000000b004734585292fmr4330419qvh.16.1658592316875;
        Sat, 23 Jul 2022 09:05:16 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87f44000000b0031eb3af3ffesm4935046qtk.52.2022.07.23.09.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 09:05:15 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, Mr.Bossman075@gmail.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v5 00/12] Add support for the i.MXRT1170-evk
Date:   Sat, 23 Jul 2022 12:05:01 -0400
Message-Id: <20220723160513.271692-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch continues support for the imxrt series now with the imxrt1170

This patch contains:
- Update to imxrt_defconfig
- Devicetree
- Clock driver
- Pinctrl driver
- New pll

This patch also updates some documentation for both imxrt1170 an 1050.

The i.MXRT1170 has a vast array of features including two cores. 2 Ethernet, 2 USB phy, and a 2d gpu.

It also is featured in a new google coral board
https://coral.ai/products/dev-board-micro
Not affiliated unfortunately.

---
V1 -> V2:
 - Add 3 new commits in documentation
 - Fix spelling
---

Jesse Taube (12):
  dt-bindings: arm: imx: Add i.MXRT compatible Documentation
  dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
  dt-bindings: gpio: fsl-imx-gpio: Add i.MXRT compatibles
  dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170 compatible
  dt-bindings: serial: fsl-lpuart: add i.MXRT1170 compatible
  ARM: mach-imx: Add support for i.MXRT1170
  clk: imx: Update pllv3 to support i.MXRT1170
  dt-bindings: imx: Add clock binding for i.MXRT1170
  clk: imx: Add initial support for i.MXRT1170 clock driver
  ARM: dts: imxrt1170-pinfunc: Add pinctrl binding header
  ARM: dts: imx: Add i.MXRT1170-EVK support
  ARM: imxrt_defconfig: Add i.MXRT1170

 .../devicetree/bindings/arm/fsl.yaml          |   12 +
 .../bindings/gpio/fsl-imx-gpio.yaml           |    2 +
 .../bindings/mmc/fsl-imx-esdhc.yaml           |    4 +
 .../bindings/serial/fsl-lpuart.yaml           |    3 +
 .../devicetree/bindings/timer/fsl,imxgpt.yaml |    2 +
 arch/arm/boot/dts/Makefile                    |    3 +-
 arch/arm/boot/dts/imxrt1170-evk.dts           |  110 ++
 arch/arm/boot/dts/imxrt1170-pinfunc.h         | 1561 +++++++++++++++++
 arch/arm/boot/dts/imxrt1170.dtsi              |  276 +++
 arch/arm/configs/imxrt_defconfig              |   17 +
 arch/arm/mach-imx/mach-imxrt.c                |    1 +
 drivers/clk/imx/Kconfig                       |    7 +
 drivers/clk/imx/Makefile                      |    1 +
 drivers/clk/imx/clk-imxrt1170.c               |  749 ++++++++
 drivers/clk/imx/clk-pllv3.c                   |   57 +-
 drivers/clk/imx/clk.h                         |   11 +
 include/dt-bindings/clock/imxrt1170-clock.h   |  282 +++
 17 files changed, 3091 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/imxrt1170-evk.dts
 create mode 100644 arch/arm/boot/dts/imxrt1170-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imxrt1170.dtsi
 create mode 100644 drivers/clk/imx/clk-imxrt1170.c
 create mode 100644 include/dt-bindings/clock/imxrt1170-clock.h

-- 
2.36.1

