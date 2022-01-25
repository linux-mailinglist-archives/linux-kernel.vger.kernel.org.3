Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF36E49B4BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575897AbiAYNPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:15:42 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59916 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575755AbiAYNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:11:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20PDBOJC027551;
        Tue, 25 Jan 2022 07:11:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643116284;
        bh=3laI8uf4l1oE5apYqmyKgRj1kR0orsQwsHKD/LYGTYg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yMcVtuBQVWR+wGm2BHeh0ZgUMPX25IzVxk644a9kO6sLv8UwePVHuwejiAxkWuC8q
         xPmZCkTM3Zzgx8n98WAhbV3nu9eqz1kq2cHOHsfffZ1WoOFs0ZkL7QPUKlZ6HkD9AA
         ntvwwJNfHqwiycwV4tQyIvJ+gsEhQwDLOGyWaPIA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20PDBOt3008674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jan 2022 07:11:24 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 25
 Jan 2022 07:11:24 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 25 Jan 2022 07:11:24 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20PDBE38032789;
        Tue, 25 Jan 2022 07:11:22 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH 3/6] arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support of OSPI
Date:   Tue, 25 Jan 2022 18:41:10 +0530
Message-ID: <20220125131113.727-4-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220125131113.727-1-a-govindraju@ti.com>
References: <20220125131113.727-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for two instance of OSPI in J721S2 SoC.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 7521963719ff..569db20f356f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -299,4 +299,44 @@
 			ti,cpts-periodic-outputs = <2>;
 		};
 	};
+
+	fss: syscon@47000000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x0 0x47000000 0x0 0x100>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ospi0: spi@47040000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x47040000 0x00 0x100>,
+			      <0x5 0x0000000 0x1 0x0000000>;
+			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 109 5>;
+			assigned-clocks = <&k3_clks 109 5>;
+			assigned-clock-parents = <&k3_clks 109 7>;
+			assigned-clock-rates = <166666666>;
+			power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		ospi1: spi@47050000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x47050000 0x00 0x100>,
+			      <0x7 0x0000000 0x1 0x0000000>;
+			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 110 5>;
+			power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+	};
 };
-- 
2.17.1

