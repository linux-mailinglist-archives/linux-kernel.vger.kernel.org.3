Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D32655119D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbiFTHiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239417AbiFTHiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:38:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E29F63D4;
        Mon, 20 Jun 2022 00:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES+qmnRAInmL7wVkD66U0ubVyIbxlHk2QHxSUhyiv0MGl0+IUfcVfKeaxTJP0Tt9aiHTuamk5iujTaFYhm978LebtqzqPKOvz2CkH7bPUaVbWTrJmxbiBmBq2V5KTLvyVbOzqhdOBnw8Jzwhx9aZctyAxV1d8I9Wgs0UebSEZGQIRFbaQy55y34rz0/zQHt+xhQ/HslrknQpalfI44+f5VCM9JJfvznCPer7MrfLJ7Lu8OZT36mdp+epkjuHQuEaAbqbODhIjfgT76uwj9jhuqbNEGtzOcjHXSE4kmcTRl/RtMPbxWXRr16oq2+IVEuLsRuO46I/V47H8HTsx1hwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLT3PanEnHO/wLRHYEF616JRfHNw4PspCfmwCS27HEY=;
 b=CnlnwOHs5yIy2b5mUi0IesNETJ0XNff/vB/fZq11wYE4yluozHFj3pM9c5oYBXbdvWQLjfL7LGxaRuXPunQG0XhsjRz48GV7zhPRE/bvu2TtAJk6zFFrJ7WLblsMnvgZi8QT6aV1hgOT6W8R5M+t2jZ95/0RkBAjyipCFG/HrGmdNvorQ1JDURfEqfOOGfqwHJYrz7I2yFUmt80PXyRZZ3UlAeYa3iv4fp35KadpiZcZlpOK7rb7BPUrTtXeDcTkaWq1KlaGVCMlAVZ/+CHYftkZkmMXAVYLi1m21tfpYxPEejRJfVB4k2CEmJpTNGNfkZ30TB7fWGOt+cP47CgJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=opensource.wdc.com
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLT3PanEnHO/wLRHYEF616JRfHNw4PspCfmwCS27HEY=;
 b=fyzRIQY50DdWm99dAMAWbKGXSNq3mvWc7eBCeOlxPeaFLSpc5pHqOVulOjFQVhm0UHfEA3BtJ/Tpn+NZdDzoYhm37on0zlqk8JMs+HODD4gxv/G5hxr0l6lcYqX2oFiMwq6MqRXZVfe0zOBPilJIZDQ9pzc+mWXYlgTLx7AumrQ=
Received: from BN9PR03CA0265.namprd03.prod.outlook.com (2603:10b6:408:ff::30)
 by BL0PR02MB4916.namprd02.prod.outlook.com (2603:10b6:208:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Mon, 20 Jun
 2022 07:38:04 +0000
Received: from BN1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::59) by BN9PR03CA0265.outlook.office365.com
 (2603:10b6:408:ff::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19 via Frontend
 Transport; Mon, 20 Jun 2022 07:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT042.mail.protection.outlook.com (10.13.2.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 07:38:04 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 20 Jun 2022 00:37:43 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 20 Jun 2022 00:37:43 -0700
Envelope-to: git@xilinx.com,
 damien.lemoal@opensource.wdc.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.60] (port=44304 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1o3Byg-000GVR-Iy; Mon, 20 Jun 2022 00:37:43 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <damien.lemoal@opensource.wdc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-ide@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>
CC:     <git@xilinx.com>, <sivadur@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH V5] dt-bindings: ata: ahci-ceva: convert to yaml
Date:   Mon, 20 Jun 2022 13:07:17 +0530
Message-ID: <20220620073717.3079-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cf09194-c9c4-4472-1dc6-08da528fcfdb
X-MS-TrafficTypeDiagnostic: BL0PR02MB4916:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB4916ABB62A190C162465FDAED4B09@BL0PR02MB4916.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+3OCzP+GcKHcEnK4pz7CjATjOsuEK/Hn/5pWR3PUcdl1qG3CDF2+/YcuHSHKQmd192MrCWlQIdKRiOWGTqUtCp7tE/VhITXmkKqLoAC4XcgRavJRNZYpK+Y2A3+pnhnjwZCS2RcekjNq6cuCRfNwsAjL1iK5KumcU2GM2dDKsy72bHtj3ckqsh/V2ibIhML3yDIqLanToxF8IJAwMSd49yAXxibHoaWDlRLF80fr/NUxCyQc+ubC7h75GWP6vd97+mrFQMpIiAdQF4CmovPQvnp9wU4+tGL6bJ+K+EXzW2milojjSWksMjWloO0OxLBy6yIzvk7Y2ES28b+bUcBOKlIzkGn/g8f2MIWHwBiKDbIjx3ezYYNeq9n44H0/VMqPeutaUghULbIjjxgCL14qgd8I/4qGhxX4KNyMB2u1nbzxLQ9Ds6oWD/2uw19Nqb1A3dA4OtgyWZyaoH/SUApjMMRbSBdvsrc6i/Le8mpFtZ9RAhFRzHdAWeq4kqmC17meRU8dhBCZFbGjfSYTZRbdw3GC0nwbpymtgiE4K29aUCsFcC+i5MfmMFqPNDEZ2UIybHUcAJnuTQlD/fquaxZ+ZcUXY3u/w+oSzfM8G8R0huwerlxyV6SYtYmVXZAKfYTdI4cT96RKD2nQeeoaJHsAN+/un8/URFPzvZoIe4LZ95xm0FackGWbD5GdHTH5f5nwSr2giI5qO59CT8Jbytz7rG+BsJD8jYNORCXgqWWqg29fgd9yZzbLuh0y9a93gn6fftk2nCrmw8Mxf8liqmDJ5BEMio6+4JN4e5KnTbK4HEZ5H+tZgA4ugptWhwoj4GcqEYcUasxnqKjffHIHU/Kqg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(110136005)(9786002)(8936002)(426003)(6636002)(54906003)(47076005)(36756003)(966005)(498600001)(107886003)(40460700003)(316002)(36860700001)(336012)(1076003)(2616005)(6666004)(83380400001)(7696005)(7636003)(5660300002)(44832011)(30864003)(26005)(8676002)(4326008)(70586007)(70206006)(82310400005)(356005)(2906002)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 07:38:04.5985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf09194-c9c4-4472-1dc6-08da528fcfdb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4916
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
Changes for V2:
- Corrected the patch --prefix V3 to V2.
- Added Required properties.

Changes for V3:
- Skip patch --prefix [PATCH V3] as already sent.

Changes for V4:
- Addressed Rob review comments:-
 - Update params description
 - Removed description from common properties.
 - Deleted deprecated property.
- Warning generated from: 'make dtbs_check'
 - Thanks Rob: We are aware of these warnings,
   but they are unrelated to this patch.

Changes for V5:
- Addressed Rob review comments:-
 - Upadte the file name with ceva,ahci-1v84.yaml
 - Fix dtbs_check warnings: added iommu and phy-name property.
---
 .../devicetree/bindings/ata/ahci-ceva.txt     |  63 ------
 .../bindings/ata/ceva,ahci-1v84.yaml          | 189 ++++++++++++++++++
 2 files changed, 189 insertions(+), 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.txt
 create mode 100644 Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml

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
diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
new file mode 100644
index 000000000000..9b31f864e071
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
@@ -0,0 +1,189 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/ceva,ahci-1v84.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ceva AHCI SATA Controller
+
+maintainers:
+  - Piyush Mehta <piyush.mehta@xilinx.com>
+
+description: |
+  The Ceva SATA controller mostly conforms to the AHCI interface with some
+  special extensions to add functionality, is a high-performance dual-port
+  SATA host controller with an AHCI compliant command layer which supports
+  advanced features such as native command queuing and frame information
+  structure (FIS) based switching for systems employing port multipliers.
+
+properties:
+  compatible:
+    const: ceva,ahci-1v84
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  dma-coherent: true
+
+  interrupts:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  ceva,p0-cominit-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
+      OOB timing value for COMINIT parameter for port 0.
+      The fields for the above parameter must be as shown below:-
+      ceva,p0-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;
+    items:
+      - description: CINMP - COMINIT Negate Minimum Period.
+      - description: CIBGN - COMINIT Burst Gap Nominal.
+      - description: CIBGMX - COMINIT Burst Gap Maximum.
+      - description: CIBGMN - COMINIT Burst Gap Minimum.
+
+  ceva,p0-comwake-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
+      OOB timing value for COMWAKE parameter for port 0.
+      The fields for the above parameter must be as shown below:-
+      ceva,p0-comwake-params = /bits/ 8 <CWBGMN CWBGMX CWBGN CWNMP>;
+    items:
+      - description: CWBGMN - COMWAKE Burst Gap Minimum.
+      - description: CWBGMX - COMWAKE Burst Gap Maximum.
+      - description: CWBGN - COMWAKE Burst Gap Nominal.
+      - description: CWNMP - COMWAKE Negate Minimum Period.
+
+  ceva,p0-burst-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
+      Burst timing value for COM parameter for port 0.
+      The fields for the above parameter must be as shown below:-
+      ceva,p0-burst-params = /bits/ 8 <BMX BNM SFD PTST>;
+    items:
+      - description: BMX - COM Burst Maximum.
+      - description: BNM - COM Burst Nominal.
+      - description: SFD - Signal Failure Detection value.
+      - description: PTST - Partial to Slumber timer value.
+
+  ceva,p0-retry-params:
+    $ref: /schemas/types.yaml#/definitions/uint16-array
+    description: |
+      Retry interval timing value for port 0.
+      The fields for the above parameter must be as shown below:-
+      ceva,p0-retry-params = /bits/ 16 <RIT RCT>;
+    items:
+      - description: RIT - Retry Interval Timer.
+      - description: RCT - Rate Change Timer.
+
+  ceva,p1-cominit-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
+      OOB timing value for COMINIT parameter for port 1.
+      The fields for the above parameter must be as shown below:-
+      ceva,p1-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;
+    items:
+      - description: CINMP - COMINIT Negate Minimum Period.
+      - description: CIBGN - COMINIT Burst Gap Nominal.
+      - description: CIBGMX - COMINIT Burst Gap Maximum.
+      - description: CIBGMN - COMINIT Burst Gap Minimum.
+
+  ceva,p1-comwake-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
+      OOB timing value for COMWAKE parameter for port 1.
+      The fields for the above parameter must be as shown below:-
+      ceva,p1-comwake-params = /bits/ 8 <CWBGMN CWBGMX CWBGN CWNMP>;
+    items:
+      - description: CWBGMN - COMWAKE Burst Gap Minimum.
+      - description: CWBGMX - COMWAKE Burst Gap Maximum.
+      - description: CWBGN - COMWAKE Burst Gap Nominal.
+      - description: CWNMP - COMWAKE Negate Minimum Period.
+
+  ceva,p1-burst-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
+      Burst timing value for COM parameter for port 1.
+      The fields for the above parameter must be as shown below:-
+      ceva,p1-burst-params = /bits/ 8 <BMX BNM SFD PTST>;
+    items:
+      - description: BMX - COM Burst Maximum.
+      - description: BNM - COM Burst Nominal.
+      - description: SFD - Signal Failure Detection value.
+      - description: PTST - Partial to Slumber timer value.
+
+  ceva,p1-retry-params:
+    $ref: /schemas/types.yaml#/definitions/uint16-array
+    description: |
+      Retry interval timing value for port 1.
+      The fields for the above parameter must be as shown below:-
+      ceva,pN-retry-params = /bits/ 16 <RIT RCT>;
+    items:
+      - description: RIT - Retry Interval Timer.
+      - description: RCT - Rate Change Timer.
+
+  ceva,broken-gen2:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      limit to gen1 speed instead of gen2.
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: sata-phy
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - ceva,p0-cominit-params
+  - ceva,p0-comwake-params
+  - ceva,p0-burst-params
+  - ceva,p0-retry-params
+  - ceva,p1-cominit-params
+  - ceva,p1-comwake-params
+  - ceva,p1-burst-params
+  - ceva,p1-retry-params
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/xlnx-zynqmp-power.h>
+    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
+    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
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
-- 
2.17.1

