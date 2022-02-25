Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E0B4C4436
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbiBYMEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiBYMD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:03:56 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88E21B84D1;
        Fri, 25 Feb 2022 04:03:21 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21PC3BfP096738;
        Fri, 25 Feb 2022 06:03:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645790591;
        bh=orkmC4OVbyZkosd6MecQYMNIfWC3U7JqCclX8tm13qw=;
        h=From:To:CC:Subject:Date;
        b=Cd1LqIKRYaJ1dalKwRDTORefZLJBfjW39b1sHwUbGUqXkT9r8IZWmHw4nm34/LU/E
         bDJkbsaK0AzjgaOZMwzjejYNpQoiIeQbgfygikxT0xFxl1lgoC6XL1SqY9X69l+KDn
         FeXH6c29wOTJUNTt6lMJZVllW85pJy82iPhNUZvI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21PC3BcZ045418
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Feb 2022 06:03:11 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 25
 Feb 2022 06:03:10 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 25 Feb 2022 06:03:10 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21PC36ma046680;
        Fri, 25 Feb 2022 06:03:07 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/5] arm64: Initial support for Texas Instruments AM62 Platform
Date:   Fri, 25 Feb 2022 17:32:34 +0530
Message-ID: <20220225120239.1303821-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

More details can be found in the Technical Reference Manual:
https://www.ti.com/lit/pdf/spruiv7

v3:
* Update DM firmware reserved region to at top of 512MB DDR region

v2:
* Fix GIC node to include GICC, GICH, GICV
* Trim commit message of 4/5 and update to include dtsi file split up
* Sort address ranges and update to include more peripherals
* Fix reguilator node names to meet DT spec in 5/5
* Collect Acks

v2: https://lore.kernel.org/r/20220216171815.384377-1-vigneshr@ti.com
v1: https://lore.kernel.org/r/20220208131827.1430086-1-vigneshr@ti.com

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
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 267 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi       |  36 +++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    |  41 +++
 arch/arm64/boot/dts/ti/k3-am62.dtsi           | 105 +++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 206 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625.dtsi          | 103 +++++++
 drivers/soc/ti/k3-socinfo.c                   |   1 +
 include/dt-bindings/pinctrl/k3.h              |   3 +
 10 files changed, 770 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-sk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625.dtsi

-- 
2.35.1

