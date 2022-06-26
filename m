Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A82055AF88
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 08:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiFZGpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 02:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiFZGp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 02:45:28 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F85012D27;
        Sat, 25 Jun 2022 23:45:27 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id cs6so10654912qvb.6;
        Sat, 25 Jun 2022 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4wBO1667gKspsX2YpqY0GfBWbUa/h7JEUojX9OU1G8=;
        b=UByvcb2TNDKItfrIjD5rz3SZf2VeDU9yLAZNRjDubVgR8A4kLDBmJ311JERQzBOYAu
         F6tWmnt0dzHJ3E02rX58996OK/MX9q82qrZgd/gBlVt8XbT4EuIFydnAiJ95Xg5lke21
         O8fDy/u+4vPhM51mVSbdBtobyVh4Kp+M5UHQtDG+VWEk/8JZGSaqTGnrS/YEPC6Kyw5m
         zRlKsXDqqaIVZR3gSlpFL4llpD31tAbcZ0oS6PC/DyLYMcYoR+TMa6hqHdiCP9uKC9E/
         NUHOQG1a70ifiG9aJ+msTF+WW/pnHUwl617pkt0qSQ1dk+fkeEMc1wdTg31H1FpjELgO
         kV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4wBO1667gKspsX2YpqY0GfBWbUa/h7JEUojX9OU1G8=;
        b=xkPBBH+coCPUhFIq2evGi1aQL+hIpv3BHW1riAlwwWqINEAyZhEVNorTJEv/DH5oG6
         JPbgduioe1Iwd9yfNIhyXxGdHRo/A5I4KtRt4jp8ok1zO0M6TGVvVOZJgcV+0Vmhsl2U
         bu6HTZm079lW6vICzXvPxTZJsWoHAO9b9nIaww7ig3Y2WwezIUX04yTves0axGKx/Dz3
         P5k2oyj+0ehJ52WjZ8QtLdof91nH5/VWna+b4nWabWqB37eBrCeOCHcLehUAox6lge46
         tiOzlIkaFa4pad5L4lMu8ZH0UiUWPGL2N5vuCmTYrnK1YgRSRQ4roDAMBaUB28XSK1ht
         6uUQ==
X-Gm-Message-State: AJIora88xLAWPyIn1Rqf2DAcloPnSlA13aF2ya/ZFHfekXdVyUzUASH6
        9MNT63OVaHadGuf5EqtEhjY=
X-Google-Smtp-Source: AGRyM1tlXXnd+FDbMEG2Ikw9hPM/zcmfnZtgRj3UX7hLLkPqeaX/cMvj2H5bPOAQ6pSJrV1gnoR2MQ==
X-Received: by 2002:a05:6214:27ec:b0:470:b60b:9bb9 with SMTP id jt12-20020a05621427ec00b00470b60b9bb9mr1212366qvb.83.1656225926495;
        Sat, 25 Jun 2022 23:45:26 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a76a939dbasm5914620qko.112.2022.06.25.23.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 23:45:25 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, olof@lixom.net, linux@armlinux.org.uk,
        abel.vesa@nxp.com, dev@lynxeye.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, leoyang.li@nxp.com,
        sebastian.reichel@collabora.com, cniedermaier@dh-electronics.com,
        Mr.Bossman075@gmail.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH v4 00/13] [PATCH v3 00/15] Add support for the i.MXRT1170-evk
Date:   Sun, 26 Jun 2022 02:45:10 -0400
Message-Id: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Jesse Taube (13):
  dt-bindings: arm: imx: Add i.MXRT compatible Documentation
  dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
  dt-bindings: gpio: fsl-imx-gpio: Add i.MXRT compatibles
  dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170 compatible
  dt-bindings: serial: fsl-lpuart: add i.MXRT1170 compatible
  dt-bindings: clock: imx: Add documentation for i.MXRT1170 clock
  ARM: mach-imx: Add support for i.MXRT1170
  clk: imx: Update pllv3 to support i.MXRT1170
  dt-bindings: imx: Add clock binding for i.MXRT1170
  clk: imx: Add initial support for i.MXRT1170 clock driver
  ARM: dts: imxrt1170-pinfunc: Add pinctrl binding header
  ARM: dts: imx: Add i.MXRT1170-EVK support
  ARM: imxrt_defconfig: Add i.MXRT1170

 .../devicetree/bindings/arm/fsl.yaml          |   12 +
 .../bindings/clock/fsl,imxrt1170-clock.yaml   |   57 +
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
 drivers/clk/imx/clk-imxrt1170.c               |  451 +++++
 drivers/clk/imx/clk-pllv3.c                   |   57 +-
 drivers/clk/imx/clk.h                         |    4 +
 include/dt-bindings/clock/imxrt1170-clock.h   |  282 +++
 18 files changed, 2847 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml
 create mode 100644 arch/arm/boot/dts/imxrt1170-evk.dts
 create mode 100644 arch/arm/boot/dts/imxrt1170-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imxrt1170.dtsi
 create mode 100644 drivers/clk/imx/clk-imxrt1170.c
 create mode 100644 include/dt-bindings/clock/imxrt1170-clock.h

-- 
2.36.1

