Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920EE549B73
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244619AbiFMSZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbiFMSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:25:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEF4A76DE;
        Mon, 13 Jun 2022 07:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4fr2C2aG8DXZlUtOPVXFQg3abOvynQUo1V8nxfhx0cBdceGlJ9yGlrKEOusOvMEDFPWlwzkUX0+Y62SZphjmctQF8Lv5XE2Bf/REjurYKUDNvpkuN+USJaqz1/Lmn5rMofh6OiUQuzuyaxkN3KBAFuxv0OAWvapBS9TOZo1GAVeJG9clhbteuNHh7W6V+buXdhFnnAsrOsCruECkbOINDypPWyJ4uF4bOHs+iTzYbESop2PUU+O+voFtp2HP7/HGwNIGEhJufQvTHHtuCJLIEObtH5Whc0HDmj885mef/mBYWa5X8GGPFsFewpiGJzHPkgipBivDHxDS9mfYDFL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFehFNcus93WEme+cHXr1XPKQlnJKnpItDN0snfAh5s=;
 b=Xbvndu+GAV+5ccNyHCCQle7+49guJvpvG7fgx6AAxrbZujxpg0ajq9zPU/XRB+ZjsxL6WmYUyHwti32dxj1K+LmfQKnE4qmoW4bFIS1RZDx6Pw4GQkKFet2qNTYYDxeLIu/duGQiVB1aB7gCTr4suShgE/QhPo8klbmo3C1THnvaZZulJafgE7q3AsSMYNWxhtEExa9uoBmMZeI5w6YKlPnDdOg3IMKIKMIXcFu3HoEiDfG8WgwdNXkYxdHtia4CHNxCMLDHHd0M0cmCSbLABA+d9ACACSPgkOqHhtnwyWnX1exH9PSBcbJpl/1Y14jmGHMwAS765sBAwRuQ+1Gedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=opensource.wdc.com
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFehFNcus93WEme+cHXr1XPKQlnJKnpItDN0snfAh5s=;
 b=it9KQcK+3cjRoBnQDxSnRaJ5AyNAaaIeNHrA7sUQjOEcbXcEF2EwLocNaAdPU24kistG5+pdWHRYuqBRPM4pOIOqs3wToe8dekd8f1SZ7JXCnqF4+hN3zXR3AfajUEF+GBB1lNFxP2Hc6ff29+NiOQWVHEIp6MlZ7kDviapOlH4=
Received: from DM3PR11CA0016.namprd11.prod.outlook.com (2603:10b6:0:54::26) by
 BL0PR02MB4772.namprd02.prod.outlook.com (2603:10b6:208:52::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.15; Mon, 13 Jun 2022 14:31:37 +0000
Received: from DM3NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::c4) by DM3PR11CA0016.outlook.office365.com
 (2603:10b6:0:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 14:31:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT040.mail.protection.outlook.com (10.13.5.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 14:31:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Jun 2022 07:31:35 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Jun 2022 07:31:35 -0700
Envelope-to: git@xilinx.com,
 damien.lemoal@opensource.wdc.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=39540 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1o0l6M-00098T-DV; Mon, 13 Jun 2022 07:31:34 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <damien.lemoal@opensource.wdc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-ide@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>
CC:     <git@xilinx.com>, <sivadur@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH V3] dt-bindings: ata: ahci-ceva: convert to yaml
Date:   Mon, 13 Jun 2022 20:01:20 +0530
Message-ID: <20220613143120.6936-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8785ae1-6c2b-4615-eb65-08da4d496c29
X-MS-TrafficTypeDiagnostic: BL0PR02MB4772:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB477240AC74D95D4C70345E4DD4AB9@BL0PR02MB4772.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onD914akgMOZjMFtMDr6/eQtXl3qAyhn4TFZcsHcQfC9w/X1LSUvqNuUpRaHd8iyKvUzkq0YxP9EB9EsUklYbsthhUQMRUQXt2gDE8ZnmRzNwVZsWU737+8b6XLcJqMyhTZeLgfka1pAh7MM4RRlf/vkiO1bwf7t9ICJ2Rst8UeWS+/duA61c9YxcK3f4YYII8fG6GDuKyFu+p4ITp+z9YyoFKFtaY9+FlqNSXdYME7B20GGo19epNJp/yLHiSl15gagwKpaT7MVVlhIn0zXQG3hzlNiFWryZ/uJm9nWigsj52BPGo0esGA3uCjpV09Qt6oV24q5cOYHjQN5H32IZncQXQybnKtf/bZ1EekbGwBwoQzFoI7SdEixZnxVqUlRncN5318/Sfxp976a/sQ2p4pr0H51dxo1aMCUaQ9efDvJI7j5h2txGBZp78kFFcTdJuivGD/09rSrYdx9LOhexDrCZMPDtOUH/hLrV/WXRR6WQ6JIeelYF9uQgcF9OZEVpfiP0eqDnIJMjrCjwzDNLYqFOEL3WsAd8Y9M3xw/QnmN/kvuKm5LtgN2N3bIwE8/EdJhEA3rCuYoq/mqGSVDt3QadcTmx5FPY3J+/2oV3PwQdGt2pR0yoGlG+GLTj8n6vAFBK1aXAzU1lmzzqWFdMQiBVE866tI7bDaSsr5+vzaNkzqmpS5jJCFsoKpVw7j/4ARxcKmZw4HLIAV9g9wUDcW2sWaxNOjJ1NRJ2praf2RXL2IoKBawSJovvqtWwVT+UJftDxzHVpYliEzoA30bTfuquGkTjWiwNNF7ma8N5QF7OuVeVupsA9XIeGFphHV2ZRUrsR9v7M0VRErI+1jr9w==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(2906002)(508600001)(966005)(8676002)(82310400005)(36860700001)(6636002)(40460700003)(316002)(70586007)(7696005)(26005)(70206006)(6666004)(110136005)(4326008)(54906003)(36756003)(2616005)(83380400001)(186003)(1076003)(426003)(47076005)(107886003)(336012)(9786002)(8936002)(356005)(5660300002)(44832011)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 14:31:36.8046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8785ae1-6c2b-4615-eb65-08da4d496c29
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4772
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ahci-ceva doc to yaml.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 .../devicetree/bindings/ata/ahci-ceva.txt     |  63 ------
 .../devicetree/bindings/ata/ahci-ceva.yaml    | 191 ++++++++++++++++++
 2 files changed, 191 insertions(+), 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.txt
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.yaml

diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
deleted file mode 100644
index bfb6da0281ec..000000000000
--- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-Binding for CEVA AHCI SATA Controller
-
-Required properties:
-  - reg: Physical base address and size of the controller's register area.
-  - compatible: Compatibility string. Must be 'ceva,ahci-1v84'.
-  - clocks: Input clock specifier. Refer to common clock bindings.
-  - interrupts: Interrupt specifier. Refer to interrupt binding.
-  - ceva,p0-cominit-params: OOB timing value for COMINIT parameter for port 0.
-  - ceva,p1-cominit-params: OOB timing value for COMINIT parameter for port 1.
-			The fields for the above parameter must be as shown below:
-			ceva,pN-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;
-			CINMP : COMINIT Negate Minimum Period.
-			CIBGN : COMINIT Burst Gap Nominal.
-			CIBGMX: COMINIT Burst Gap Maximum.
-			CIBGMN: COMINIT Burst Gap Minimum.
-  - ceva,p0-comwake-params: OOB timing value for COMWAKE parameter for port 0.
-  - ceva,p1-comwake-params: OOB timing value for COMWAKE parameter for port 1.
-			The fields for the above parameter must be as shown below:
-			ceva,pN-comwake-params = /bits/ 8 <CWBGMN CWBGMX CWBGN CWNMP>;
-			CWBGMN: COMWAKE Burst Gap Minimum.
-			CWBGMX: COMWAKE Burst Gap Maximum.
-			CWBGN: COMWAKE Burst Gap Nominal.
-			CWNMP: COMWAKE Negate Minimum Period.
-  - ceva,p0-burst-params: Burst timing value for COM parameter for port 0.
-  - ceva,p1-burst-params: Burst timing value for COM parameter for port 1.
-			The fields for the above parameter must be as shown below:
-			ceva,pN-burst-params = /bits/ 8 <BMX BNM SFD PTST>;
-			BMX: COM Burst Maximum.
-			BNM: COM Burst Nominal.
-			SFD: Signal Failure Detection value.
-			PTST: Partial to Slumber timer value.
-  - ceva,p0-retry-params: Retry interval timing value for port 0.
-  - ceva,p1-retry-params: Retry interval timing value for port 1.
-			The fields for the above parameter must be as shown below:
-			ceva,pN-retry-params = /bits/ 16 <RIT RCT>;
-			RIT:  Retry Interval Timer.
-			RCT:  Rate Change Timer.
-
-Optional properties:
-  - ceva,broken-gen2: limit to gen1 speed instead of gen2.
-  - phys: phandle for the PHY device
-  - resets: phandle to the reset controller for the SATA IP
-
-Examples:
-	ahci@fd0c0000 {
-		compatible = "ceva,ahci-1v84";
-		reg = <0xfd0c0000 0x200>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 133 4>;
-		clocks = <&clkc SATA_CLK_ID>;
-		ceva,p0-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
-		ceva,p0-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
-		ceva,p0-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
-		ceva,p0-retry-params = /bits/ 16 <0x0216 0x7F06>;
-
-		ceva,p1-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
-		ceva,p1-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
-		ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
-		ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
-		ceva,broken-gen2;
-		phys = <&psgtr 1 PHY_TYPE_SATA 1 1>;
-		resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
-	};
diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.yaml b/Documentation/devicetree/bindings/ata/ahci-ceva.yaml
new file mode 100644
index 000000000000..f13b3286a079
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-ceva.yaml
@@ -0,0 +1,191 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/ahci-ceva.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ceva AHCI SATA Controller
+
+description: |
+  The Ceva SATA controller mostly conforms to the AHCI interface with some
+  special extensions to add functionality, is a high-performance dual-port
+  SATA host controller with an AHCI compliant command layer which supports
+  advanced features such as native command queuing and frame information
+  structure (FIS) based switching for systems employing port multipliers.
+
+maintainers:
+  - Piyush Mehta <piyush.mehta@xilinx.com>
+
+properties:
+  compatible:
+    const: ceva,ahci-1v84
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dma-coherent: true
+
+  power-domains:
+    description: |
+      Specifies a phandle to PM domain provider node.
+    maxItems: 1
+
+  ceva,p0-cominit-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 4
+    maxItems: 4
+    description: |
+      OOB timing value for COMINIT parameter for port 0.
+      The fields for the above parameter must be as shown below:-
+      ceva,p0-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;
+      CINMP  - COMINIT Negate Minimum Period.
+      CIBGN  - COMINIT Burst Gap Nominal.
+      CIBGMX - COMINIT Burst Gap Maximum.
+      CIBGMN - COMINIT Burst Gap Minimum.
+
+  ceva,p0-comwake-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 4
+    maxItems: 4
+    description: |
+      OOB timing value for COMWAKE parameter for port 0.
+      The fields for the above parameter must be as shown below:-
+      ceva,p0-comwake-params = /bits/ 8 <CWBGMN CWBGMX CWBGN CWNMP>;
+      CWBGMN - COMWAKE Burst Gap Minimum.
+      CWBGMX - COMWAKE Burst Gap Maximum.
+      CWBGN  - COMWAKE Burst Gap Nominal.
+      CWNMP  - COMWAKE Negate Minimum Period.
+
+  ceva,p0-burst-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 4
+    maxItems: 4
+    description: |
+      Burst timing value for COM parameter for port 0.
+      The fields for the above parameter must be as shown below:-
+      ceva,p0-burst-params = /bits/ 8 <BMX BNM SFD PTST>;
+      BMX  - COM Burst Maximum.
+      BNM  - COM Burst Nominal.
+      SFD  - Signal Failure Detection value.
+      PTST - Partial to Slumber timer value.
+
+  ceva,p0-retry-params:
+    $ref: /schemas/types.yaml#/definitions/uint16-array
+    minItems: 2
+    maxItems: 2
+    description: |
+      Retry interval timing value for port 0.
+      The fields for the above parameter must be as shown below:-
+      ceva,p0-retry-params = /bits/ 16 <RIT RCT>;
+      RIT - Retry Interval Timer.
+      RCT - Rate Change Timer.
+
+  ceva,p1-cominit-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 4
+    maxItems: 4
+    description: |
+      OOB timing value for COMINIT parameter for port 1.
+      The fields for the above parameter must be as shown below:-
+      ceva,p1-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;
+      CINMP  - COMINIT Negate Minimum Period.
+      CIBGN  - COMINIT Burst Gap Nominal.
+      CIBGMX - COMINIT Burst Gap Maximum.
+      CIBGMN - COMINIT Burst Gap Minimum.
+
+  ceva,p1-comwake-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 4
+    maxItems: 4
+    description: |
+      OOB timing value for COMWAKE parameter for port 1.
+      The fields for the above parameter must be as shown below:-
+      ceva,p1-comwake-params = /bits/ 8 <CWBGMN CWBGMX CWBGN CWNMP>;
+      CWBGMN - COMWAKE Burst Gap Minimum.
+      CWBGMX - COMWAKE Burst Gap Maximum.
+      CWBGN  - COMWAKE Burst Gap Nominal.
+      CWNMP  - COMWAKE Negate Minimum Period.
+
+  ceva,p1-burst-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 4
+    maxItems: 4
+    description: |
+      Burst timing value for COM parameter for port 1.
+      The fields for the above parameter must be as shown below:-
+      ceva,p1-burst-params = /bits/ 8 <BMX BNM SFD PTST>;
+      BMX  - COM Burst Maximum.
+      BNM  - COM Burst Nominal.
+      SFD  - Signal Failure Detection value.
+      PTST - Partial to Slumber timer value.
+
+  ceva,p1-retry-params:
+    $ref: /schemas/types.yaml#/definitions/uint16-array
+    minItems: 2
+    maxItems: 2
+    description: |
+      Retry interval timing value for port 1.
+      The fields for the above parameter must be as shown below:-
+      ceva,pN-retry-params = /bits/ 16 <RIT RCT>;
+      RIT - Retry Interval Timer.
+      RCT - Rate Change Timer.
+
+  ceva,broken-gen2:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      limit to gen1 speed instead of gen2.
+
+  phys:
+    description: |
+      Phandle for the PHY device.
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#stream-id-cells':
+    const: 4
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/xlnx-zynqmp-power.h>
+    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
+    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
+    #include <dt-bindings/phy/phy.h>
+
+    sata: ahci@fd0c0000 {
+        compatible = "ceva,ahci-1v84";
+        reg = <0xfd0c0000 0x200>;
+        interrupt-parent = <&gic>;
+        interrupts = <0 133 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&zynqmp_clk SATA_REF>;
+        ceva,p0-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
+        ceva,p0-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
+        ceva,p0-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
+        ceva,p0-retry-params = /bits/ 16 <0x0216 0x7F06>;
+        ceva,p1-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
+        ceva,p1-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
+        ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
+        ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
+        ceva,broken-gen2;
+        phys = <&psgtr 1 PHY_TYPE_SATA 1 1>;
+        resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
+    };
+
+...
-- 
2.17.1

