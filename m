Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AAD4B8EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbiBPRSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:18:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiBPRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:18:46 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FA3BECDA;
        Wed, 16 Feb 2022 09:18:33 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21GHIOjY036304;
        Wed, 16 Feb 2022 11:18:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645031904;
        bh=axirFphiAe3nEeQxGnlc+Z7Vz+fnnIQ59hOJ5X8mCRY=;
        h=From:To:CC:Subject:Date;
        b=XQNmgzIs363R9g9LXFknzQi+ZhPQ6xEpgliq90GwHb0Mcazsv6PqBRxiGGtrENMlH
         zIxN9PdV7OZjiuQklmnrJbDi1LfdV5pDG8+TuC29fqn4Byz78BbulueDX9iNhkh8Ly
         mWdPgYDkXye8kLGFt7tWFBPGKTlyiCgVeBUTMFnE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21GHIOfm096442
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Feb 2022 11:18:24 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 16
 Feb 2022 11:18:24 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 16 Feb 2022 11:18:24 -0600
Received: from ula0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21GHIJjO056750;
        Wed, 16 Feb 2022 11:18:20 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] arm64: Initial support for Texas Instruments AM62 Platform
Date:   Wed, 16 Feb 2022 22:48:10 +0530
Message-ID: <20220216171815.384377-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

v2:
* Fix GIC node to include GICC, GICH, GICV
* Trim commit message of 4/5 and update to include dtsi file split up
* Sort address ranges and update to include more peripherals
* Fix reguilator node names to meet DT spec in 5/5
* Collect Acks

Boot log: https://controlc.com/c6e5a1f6

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

