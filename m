Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B584E817A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiCZOpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiCZOo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:44:58 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028AC208244;
        Sat, 26 Mar 2022 07:43:21 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id 10so8792262qtz.11;
        Sat, 26 Mar 2022 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4EjMh1BXc6L+8+2yCB/wSo589PUQ7VAWNTCQaSkJ5DQ=;
        b=bX5hy0vhjxCbMhu+7P8AdpCsHwvPtkAzjWp8oIILb7PvQEqQPvSkMEtE8wD/zI+b4O
         A1iLDSA6UOIia18J1ieodiovWaDGODX2GAmQ03CXwXeBvvVIzteKT79vqPh1bBzg5Ov8
         1YeVjJgC+UlAujDFCZi/pcIqjXhKnbdFXi5V5ojTesq7e+tVoxZQXtTrPo6bzdprd0vh
         0J6fco6DGwJU7HGK5Ll5duDmf3vyzmPGSbla+z5IQ9HSUs8IqBCwY4CYWV36fcevaecN
         osbk0AMuA1eD9384huE9v64oB9jQDCGnctVakdgcHBnNVsj2O2hbDll3VrobpLyoLY/O
         MZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4EjMh1BXc6L+8+2yCB/wSo589PUQ7VAWNTCQaSkJ5DQ=;
        b=ohUaS0XhB0gl7XMxzthdv/T9ycGIqDUKS5H7WRHkBjKcAxyOszLQ4QDZ7+UMiXdDe9
         xGvN8YAImvYqSijfyjmjJ7nguRxieaFJPBKMMNAYda8tpZDVuZ5RX7B7s3VFQbrhLYfR
         GISUBNBdL0PKP1IH7oAnrAj9q6XhaeMpq/D92tSin/Y0UiJJRDlF821eBrPgoOEcKaty
         KC9NN9sdxM1tYwWU2Vilc6ndN8lqM12tP1B5qh6dExFHrcy5PBhemUolKjie9vbnIcEP
         xeF2lme8/fJcbrijURxMchaL1kZWe1LRkrzyXjVWmiOC0MehrvmfXEB2zs8TUpYEG56N
         sCrw==
X-Gm-Message-State: AOAM532kVXEJAqE+odD1LBC8bndw7eHahXwFYzaFUy5Tu7iM9QHZHaPw
        GRO9qIL3HP6Zaj2tSDLw1jM=
X-Google-Smtp-Source: ABdhPJxlSMIB6q5kWqyaMQn/pan1GzoHN8bORyLMAqLixcIUaE8/0GbyYu4Eju9FJ1kveap/pQmo3Q==
X-Received: by 2002:a05:622a:155:b0:2e1:cc60:8947 with SMTP id v21-20020a05622a015500b002e1cc608947mr13974558qtw.243.1648305800092;
        Sat, 26 Mar 2022 07:43:20 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id 70-20020a370649000000b0067b4cd8ffbasm4908918qkg.60.2022.03.26.07.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 07:43:18 -0700 (PDT)
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
Subject: [PATCH v1 00/12] Add support for the i.MXRT1170-evk
Date:   Sat, 26 Mar 2022 10:43:01 -0400
Message-Id: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The i.MXRT1170 has a vast array of fetures includeing two cores. 2 Ethernet, 2 USB phy, and a 2d gpu.

It also is fetured in a new google coral board
https://coral.ai/products/dev-board-micro
Not affiliated unfortunaly.

Jesse Taube (12):
  dt-bindings: arm: imx: Add i.MXRT compatible Documentation
  dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
  dt-bindings: pinctrl: add i.MXRT1170 pinctrl Documentation
  dt-bindings: clock: imx: Add documentation for i.MXRT1170 clock
  ARM: mach-imx: Add support for i.MXRT1170
  ARM: clk: imx: Update pllv3 to support i.MXRT1170
  dt-bindings: imx: Add clock binding for i.MXRT1170
  clk: imx: Add initial support for i.MXRT1170 clock driver
  pinctrl: freescale: Add i.MXRT1170 pinctrl driver support
  ARM: dts: imxrt1170-pinfunc: Add pinctrl binding header
  ARM: dts: imx: Add i.MXRT1170-EVK support
  ARM: imxrt_defconfig: Add i.MXRT1170

 .../devicetree/bindings/arm/fsl.yaml          |   12 +
 .../bindings/clock/imxrt1170-clock.yaml       |   59 +
 .../bindings/pinctrl/fsl,imxrt1170.yaml       |   77 +
 .../devicetree/bindings/timer/fsl,imxgpt.yaml |    2 +
 arch/arm/boot/dts/Makefile                    |    3 +-
 arch/arm/boot/dts/imxrt1170-evk.dts           |  126 ++
 arch/arm/boot/dts/imxrt1170-pinfunc.h         | 1561 +++++++++++++++++
 arch/arm/boot/dts/imxrt1170.dtsi              |  278 +++
 arch/arm/configs/imxrt_defconfig              |   26 +
 arch/arm/mach-imx/mach-imxrt.c                |    1 +
 drivers/clk/imx/Kconfig                       |    7 +
 drivers/clk/imx/Makefile                      |    1 +
 drivers/clk/imx/clk-imxrt1170.c               |  391 +++++
 drivers/clk/imx/clk-pllv3.c                   |   57 +-
 drivers/clk/imx/clk.h                         |    4 +
 drivers/pinctrl/freescale/Kconfig             |    7 +
 drivers/pinctrl/freescale/Makefile            |    1 +
 drivers/pinctrl/freescale/pinctrl-imxrt1170.c |  349 ++++
 include/dt-bindings/clock/imxrt1170-clock.h   |  282 +++
 19 files changed, 3241 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imxrt1170-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml
 create mode 100644 arch/arm/boot/dts/imxrt1170-evk.dts
 create mode 100644 arch/arm/boot/dts/imxrt1170-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imxrt1170.dtsi
 create mode 100644 drivers/clk/imx/clk-imxrt1170.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imxrt1170.c
 create mode 100644 include/dt-bindings/clock/imxrt1170-clock.h

-- 
2.34.1

