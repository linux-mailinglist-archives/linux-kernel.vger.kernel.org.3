Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D66E47BBA0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhLUISU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:18:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40080 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbhLUISR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:18:17 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BL8IAVn091851;
        Tue, 21 Dec 2021 02:18:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640074690;
        bh=SNfL/XSVVO8Qq8yWmhGRclrb0+LUC/rNWGrtwtycHyM=;
        h=From:To:CC:Subject:Date;
        b=d5Qrw/R2pGydJN59HNsKhfQoBZ8tTSqMKbYad/WZ7nbE2l0byziZVbw2xHvZDncKv
         5TeMvUHKqvdTNhTfCm60oi/k8zTV02bsLqstniJcX8JX14wHdvx/GlU2Ra9eb01KQh
         JxoVAfX63ZXmGjL+oQJorU5ZjPddFYllF5SF0ZNY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BL8IAp9029989
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Dec 2021 02:18:10 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Dec 2021 02:18:10 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Dec 2021 02:18:10 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BL8I7o8010607;
        Tue, 21 Dec 2021 02:18:08 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 0/5] J721S2: Add initial support
Date:   Tue, 21 Dec 2021 13:48:01 +0530
Message-ID: <20211221081806.7836-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The J721S2 SoC belongs to the K3 Multicore SoC architecture platform,
providing advanced system integration in automotive ADAS applications and
industrial applications requiring AI at the network edge. This SoC extends
the Jacinto 7 family of SoCs with focus on lowering system costs and power
while providing interfaces, memory architecture and compute performance for
single and multi-sensor applications.

Some highlights of this SoC are:

* Dual Cortex-A72s in a single cluster, three clusters of lockstep capable
dual Cortex-R5F MCUs, Deep-learning Matrix Multiply Accelerator(MMA), C7x
floating point Vector DSP.
* 3D GPU: Automotive grade IMG BXS-4-64
* Vision Processing Accelerator (VPAC) with image signal processor and
Depth and Motion Processing Accelerator (DMPAC)
* Two CSI2.0 4L RX plus one eDP/DP, two DSI Tx, and one DPI interface.
* Two Ethernet ports with RGMII support.
* Single 4 lane PCIe-GEN3 controllers, USB3.0 Dual-role device subsystems,
* Up to 20 MCANs, 5 McASP, eMMC and SD, OSPI/HyperBus memory controller,
QSPI, I3C and I2C, eCAP/eQEP, eHRPWM, MLB among other peripherals.
* Hardware accelerator blocks containing AES/DES/SHA/MD5 called SA2UL
management.
* Chips and Media Wave521CL H.264/H.265 encode/decode engine

See J721S2 Technical Reference Manual (SPRUJ28 – NOVEMBER 2021)
for further details: http://www.ti.com/lit/pdf/spruj28

- bootlog:
 https://pastebin.ubuntu.com/p/nHQxf6Yg3N/

The following series of patches depend on,
- http://lists.infradead.org/pipermail/linux-arm-kernel/2021-December/700936.html
- https://patchwork.kernel.org/project/linux-dmaengine/list/?series=583035
- https://patchwork.kernel.org/project/linux-phy/list/?series=574093


Changes since v3:
- Removed unused alaises and changed the alias for
  main_uart8 to serial2
- Moved the aliases to board dts file

Changes since v2:
- Removed mux.h and phy.h header files that were
  unused.

Changes since v1:
- Picked up Rob Herring's acked-bys for patches 1 and 2
- Removed unnecessary header file in patch 3

Aswath Govindraju (5):
  dt-bindings: arm: ti: Add bindings for J721s2 SoC
  dt-bindings: pinctrl: k3: Introduce pinmux definitions for J721S2
  arm64: dts: ti: Add initial support for J721S2 SoC
  arm64: dts: ti: Add initial support for J721S2 System on Module
  arch: arm64: ti: Add support J721S2 Common Processor Board

 .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 430 ++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 937 ++++++++++++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 302 ++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 174 ++++
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi         | 167 ++++
 include/dt-bindings/pinctrl/k3.h              |   3 +
 8 files changed, 2021 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2.dtsi

-- 
2.17.1

