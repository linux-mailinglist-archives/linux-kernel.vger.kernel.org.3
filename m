Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6181659A5D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350981AbiHSTBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350237AbiHSTBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:01:18 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3232D107ACB;
        Fri, 19 Aug 2022 12:01:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27JJ10vq063362;
        Fri, 19 Aug 2022 14:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660935660;
        bh=B0GyyDIv0+db6vwPTHBKUOdCp2QNB9F/EVLw0Np21EQ=;
        h=From:To:CC:Subject:Date;
        b=il8DOw1ij+SeYVtbm0pnDGtsvOGb+dpCfXnjuDFp2HrSxKc7u9UXotk2fLgHD01xk
         1kfxLugUIa7w5Ju/fWSsaCu5zmaGjD29f2B3fy7vjEfMIYrQp1Qz56gzjyYm6WxeFB
         jFtgXjYHr3bDLJhNNLrS9SPg0yUATx8oYvMatIV8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27JJ10wj126787
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Aug 2022 14:01:00 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 19
 Aug 2022 14:01:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 19 Aug 2022 14:01:00 -0500
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27JJ0tbH056422;
        Fri, 19 Aug 2022 14:00:56 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH 0/4] Add initial support for J784s4 SoC
Date:   Sat, 20 Aug 2022 00:30:50 +0530
Message-ID: <20220819190054.31348-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The J784S4 SoC belongs to the K3 Multicore SoC architecture platform,
providing advanced system integration in automotive ADAS applications
and industrial applications requiring AI at the network edge. This SoC
extends the Jacinto 7 family of SoCs with focus on high performance
providing significant levels of processing power, graphics capability,
video and imaging processing, virtualization and coherent memory
support.

Some highlights of this SoC are:

* Eight Cortex-A72s in dual clusters, four clusters of lockstep capable
  dual Cortex-R5F MCUs, Deep-learning Matrix Multiply Accelerator(MMA),
  four C7x floating point Vector DSP.
* 3D GPU: Automotive grade IMG BXS-4-64
* Two Vision Processing Accelerator (VPAC) with image signal processor
  and Depth and Motion Processing Accelerator (DMPAC)
* Three CSI2.0 4L RX plus one eDP/DP, two DSI Tx and one DPI interface.
* Two RGMII/RMII interfaces,
* Integrated ethernet switch supporting up to 8 external ports,
* Two 4 lane PCIe-GEN3 controllers, USB3.0 Dual-role device subsystems,
* Up to 20 MCANs, 5 McASP, eMMC and SD, OSPI/HyperBus memory controller,
  QSPI, I3C and I2C, eCAP/eQEP, eHRPWM, MLB among other peripherals.
* Hardware accelerator blocks containing AES/DES/SHA/MD5 called SA2UL
  management.

See J784S4 Technical Reference Manual (SPRUJ52 - JUNE 2022)
for further details: http://www.ti.com/lit/zip/spruj52

Apurva Nandan (4):
  dt-bindings: arm: ti: Add bindings for J784s4 SoC
  dt-bindings: pinctrl: k3: Introduce pinmux definitions for J784s4
  arm64: dts: ti: Add initial support for J784s4 SoC
  arch: arm64: ti: Add support for J784s4 EVM board

 .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 602 +++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 939 ++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 301 ++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi         | 287 ++++++
 include/dt-bindings/pinctrl/k3.h              |   3 +
 7 files changed, 2140 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4.dtsi

-- 
2.17.1

