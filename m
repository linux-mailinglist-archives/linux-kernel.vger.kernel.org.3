Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93A54ADABF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377615AbiBHOFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377538AbiBHOE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:04:59 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF61C03FED0;
        Tue,  8 Feb 2022 06:04:58 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 218DIYgn060725;
        Tue, 8 Feb 2022 07:18:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644326314;
        bh=xRVcVuV8frdvsTMRMrVoTHRciwvNKY3EBpUbDlWdNAM=;
        h=From:To:CC:Subject:Date;
        b=k3viTOCSJYG7KnYiO9bBDRxt1+Hfzrzkb+i4o3WaFaGnlIqb/4PnuZowLllSGPEgb
         fJxgqqo2ppZrEpBqPPjRrfRa9eLkSIDLEhy6PaDeh+tzAoIrMqiNcI6sM32dVcC3Gh
         71IbibbS2uvkHImGdY0eGQkvnQWKsEe7DspOps4Q=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 218DIY3O101729
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Feb 2022 07:18:34 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 8
 Feb 2022 07:18:33 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 8 Feb 2022 07:18:33 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 218DIUCf117228;
        Tue, 8 Feb 2022 07:18:31 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] arm64: Initial support for Texas Instruments AM62 Platform
Date:   Tue, 8 Feb 2022 18:48:22 +0530
Message-ID: <20220208131827.1430086-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds AM62 SoC support.

The AM62 SoC family is the follow on AM335x built on K3 Multicore SoC
architecture platform, providing ultra-low-power modes, dual display,
multi-sensor edge compute, security and other BOM-saving integration.
The AM62 SoC targets broad market to enable applications such as
Industrial HMI, PLC/CNC/Robot control, Medical Equipment, Building
Automation, Appliances and more.

Some highlights of this SoC are:

* Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
  Pin-to-pin compatible options for single and quad core are available.
* Cortex-M4F for general-purpose or safety usage.
* Dual display support, providing 24-bit RBG parallel interface and
  OLDI/LVDS-4 Lane x2, up to 200MHz pixel clock support for 2K display
  resolution.
* Selectable GPUsupport, up to 8GFLOPS, providing better user experience
  in 3D graphic display case and Android.
* PRU(Programmable Realtime Unit) support for customized programmable
  interfaces/IOs.
* Integrated Giga-bit Ethernet switch supporting up to a total of two
  external ports (TSN capable).
* 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3x eMMC and SD, GPMC for
  NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
  1x CSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
* Dedicated Centralized System Controller for Security, Power, and
  Resource Management.
* Multiple low power modes support, ex: Deep sleep,Standby, MCU-only,
  enabling battery powered system design.

More details can be found in the Technical Reference Manual:
https://www.ti.com/lit/pdf/spruiv7

Log: https://controlc.com/66b0a416

Nishanth Menon (2):
  dt-bindings: arm: ti: Add bindings for AM625 SoC
  arm64: dts: ti: Add support for AM62-SK

Suman Anna (1):
  dt-bindings: pinctrl: k3: Introduce pinmux definitions for AM62

Vignesh Raghavendra (2):
  soc: ti: k3-socinfo: Add AM62x JTAG ID
  arm64: dts: ti: Introduce base support for AM62x SoC

 .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 263 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi       |  36 +++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    |  41 +++
 arch/arm64/boot/dts/ti/k3-am62.dtsi           | 104 +++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 206 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625.dtsi          | 103 +++++++
 drivers/soc/ti/k3-socinfo.c                   |   1 +
 include/dt-bindings/pinctrl/k3.h              |   3 +
 10 files changed, 765 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-sk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625.dtsi

-- 
2.35.1

