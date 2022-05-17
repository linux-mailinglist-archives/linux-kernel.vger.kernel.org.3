Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6BA5297F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiEQD1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiEQD1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:27:14 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD263FBDB;
        Mon, 16 May 2022 20:27:13 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id u35so13494470qtc.13;
        Mon, 16 May 2022 20:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OzbVhmvKVxK/u+pL6n9TauT5Oh9WvboLvLjjb1RlRk=;
        b=BgCdYpYNXu306BHOTvnmSonHejrzK3ESYT7NOSQtVzvNTIvHxN5mSL01bvIyRGGhFa
         ioL91MflFY14b5O/5cHLeEVG01wLAh9mZg2Wtv/V8pagexAb06ewVp6oMkdqN95gvBKs
         qQ6faSSfzJBMQGbrUsiEX+I05IDGLilf8TIx37xF8NWsL/CyIVo04R/b2dFQ5ta528Mn
         BvmbVVR2CSLhuwiO0a29ZHqef8p2IbCPGIM8aBW6t/81IILmjkTVzThAlUYZHO8o5k9Q
         19RQhofoUzml4kdOzKb6ifw+UxO0BGmoQDfTqugajrz/knh7Zs426k9PYZWettfylOfi
         VTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OzbVhmvKVxK/u+pL6n9TauT5Oh9WvboLvLjjb1RlRk=;
        b=C5+MkUfjNy8Dg9WiFhllwTkAhVYuznbxRAnB8c/dgnH4x7jIhUQ3zCUqC27WSaREVF
         214SYmtljDL17GBjcAQn4MUTNoFOgDHX9hqZGV0G5HQH4SEFi5bq4l5r2agG381biSOE
         uva1xM8tr/dhHQHqbgN3gGhcPjtoYceYP4UKrFrPuuPhEOAmLGjb3DV68Hl5yIMOLaeD
         eLGH2IOeonb5bmjwRSEVeshzvWolOZetRJgtB0FLS/o+YjMzNT/UBoT99lIR6ov/jNft
         J+MqURZnmGdigqDOEAS97BFj10mkvp3ngbyWC56gXpr/pIMiFe6LkWaM1ZheS9AaFGiu
         pzfg==
X-Gm-Message-State: AOAM531CJsFbarxaa9+hxKQTWmIKwKLFp2khOvJxIbuzSRhEeyUP+wsg
        9pUlnr/qQL4DQ58YchB3i/I=
X-Google-Smtp-Source: ABdhPJxFWj/rbR+PTt40M4n8xOok0WUFw9aKcl5QAMJEV26x9rlDKi1QCzRlm3in97mSogBX6aCT/Q==
X-Received: by 2002:a05:622a:392:b0:2f3:d303:dd6b with SMTP id j18-20020a05622a039200b002f3d303dd6bmr18263879qtx.484.1652758032360;
        Mon, 16 May 2022 20:27:12 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id u129-20020a372e87000000b0069fc13ce1f6sm6893635qkh.39.2022.05.16.20.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:27:11 -0700 (PDT)
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
Subject: [PATCH v3 00/15] Add support for the i.MXRT1170-evk
Date:   Mon, 16 May 2022 23:26:55 -0400
Message-Id: <20220517032710.451537-1-Mr.Bossman075@gmail.com>
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

Jesse Taube (15):
  dt-bindings: arm: imx: Add i.MXRT compatible Documentation
  dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
  dt-bindings: gpio: fsl-imx-gpio: Add i.MXRT compatibles
  dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170 compatible
  dt-bindings: serial: fsl-lpuart: add i.MXRT1170 compatible
  dt-bindings: pinctrl: add i.MXRT1170 pinctrl Documentation
  dt-bindings: clock: imx: Add documentation for i.MXRT1170 clock
  ARM: mach-imx: Add support for i.MXRT1170
  clk: imx: Update pllv3 to support i.MXRT1170
  dt-bindings: imx: Add clock binding for i.MXRT1170
  clk: imx: Add initial support for i.MXRT1170 clock driver
  pinctrl: freescale: Add i.MXRT1170 pinctrl driver support
  ARM: dts: imxrt1170-pinfunc: Add pinctrl binding header
  ARM: dts: imx: Add i.MXRT1170-EVK support
  ARM: imxrt_defconfig: Add i.MXRT1170

 .../devicetree/bindings/arm/fsl.yaml          |   12 +
 .../bindings/clock/fsl,imxrt1170-clock.yaml   |   57 +
 .../bindings/gpio/fsl-imx-gpio.yaml           |    2 +
 .../bindings/mmc/fsl-imx-esdhc.yaml           |    4 +
 .../bindings/pinctrl/fsl,imxrt1170.yaml       |   77 +
 .../bindings/serial/fsl-lpuart.yaml           |    4 +
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
 drivers/pinctrl/freescale/Kconfig             |    7 +
 drivers/pinctrl/freescale/Makefile            |    1 +
 drivers/pinctrl/freescale/pinctrl-imxrt1170.c |  349 ++++
 include/dt-bindings/clock/imxrt1170-clock.h   |  282 +++
 22 files changed, 3282 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml
 create mode 100644 arch/arm/boot/dts/imxrt1170-evk.dts
 create mode 100644 arch/arm/boot/dts/imxrt1170-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imxrt1170.dtsi
 create mode 100644 drivers/clk/imx/clk-imxrt1170.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imxrt1170.c
 create mode 100644 include/dt-bindings/clock/imxrt1170-clock.h

-- 
2.36.1

