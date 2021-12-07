Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85AB46B558
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhLGINR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:13:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36472 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbhLGIM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:12:59 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B789I9R087038;
        Tue, 7 Dec 2021 02:09:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638864558;
        bh=TCiHl2x3fY3eqeyroFneXAUcg0ImC3InhBB5UNFXINU=;
        h=From:To:CC:Subject:Date;
        b=r3M0AJi5S069WhszidsbC+yUHBy5m1yDABFa8edk1boBnz925qhU2x6V32BC2/TTr
         xdVH+LAkE87/lLNww9LEDV69rKwOyHitJkk0ymtm15klU8lfpm7YOr1xd++NpE8i1h
         WLG/GIw0luLK5UUe118G0o989Y/q1fkwS0TN5mU8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B789IVA098452
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Dec 2021 02:09:18 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Dec 2021 02:09:08 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Dec 2021 02:09:08 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B7895qW046083;
        Tue, 7 Dec 2021 02:09:05 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v3 0/5] J721S2: Add initial support
Date:   Tue, 7 Dec 2021 13:38:59 +0530
Message-ID: <20211207080904.14324-1-a-govindraju@ti.com>
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
  https://pastebin.ubuntu.com/p/crVdPwQZYt/

The following series of patches depend on,
- http://lists.infradead.org/pipermail/linux-arm-kernel/2021-December/700936.html
- https://patchwork.kernel.org/project/linux-dmaengine/list/?series=583035
- https://patchwork.kernel.org/project/linux-phy/list/?series=574093

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
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 421 ++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 937 ++++++++++++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 302 ++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 175 ++++
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi         | 189 ++++
 include/dt-bindings/pinctrl/k3.h              |   3 +
 8 files changed, 2035 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2.dtsi

-- 
2.17.1

