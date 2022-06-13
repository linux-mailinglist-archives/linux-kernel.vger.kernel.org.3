Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC19549B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243925AbiFMSbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245681AbiFMSbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:31:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11901B7DD6;
        Mon, 13 Jun 2022 07:47:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6bLmqfZohYCXM9X/NLRUjq+60uaGDC2mXCrC0UwkvXw13wkTK9mnug0MWw+EyDjReYOXpu581TzL0all+HSqMt92lRkuFbkfVP17FUNysZQTovkn46VSSKYHp9XoM8Uu1ERJvrqtV3X4dHOi9pcj4m5lVYOTZclgsR+xp3Xxfnuf1HorMSDrJlAOc2T+LWWrOJKP5noNDNn/Wz2EEtagWI3HnIbSS8IiQ/dkZLAagtqDBBQK2z/v2+xCriAiorBxFQKxgWKIJ8cH7kCCO8eeO9yRcTUvW68vp+TSOb/jsNTduCm2Ztur5FbWsehwrGlrkqt4J6IxZi4Uo2GxWOhJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ji6hZgO5KlHzuqw7B3G8kwBucs0ZtRiCQ7J/ckaoA3A=;
 b=WtXTUIz6ZZKeiO8h2P2YC3x6xDlgKuelgWWCv4fHt37in25zKnsJtmmckwIxAShrH7mzNHLhvWlamq8e72mucHepXo10t59FgKraaJLxZlXDt1LiDEjki+V4eoDkOOhsVKc/8yd5OxQExMF5byK5y86zrZggQ6l+xHjVEy4h4IndSHqyvYRFsGVp28P9X0L1jaBGpQjApSKW023pQ9RInfjCMttsW0VJaAjkvU2rBpYJu/GCQcGP751xOzCuA9qacuBjRq3DtIQ5odql340wnuKYtmsKHAnfuBcXuJYvT/f4T/KOtY/+Jrhghi3ZBOeNX1pdL7vdMUQH0Au3K72/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=opensource.wdc.com
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji6hZgO5KlHzuqw7B3G8kwBucs0ZtRiCQ7J/ckaoA3A=;
 b=Pl6N6XgiRGgrg1VLoNclT1Nl0n1DBbMjnfCScA4YiuowQ6hleMChGEXoKV29QCVI1sZTbygxAO3+UOgaFgQzqmkwZ5BK6stDKIPlKVIuKfo/Ukajz7Akbf5ukjJSf4IKGQ6DSkdpOaFAz05DiSrzvCe3vH3sJu2WMdTF1S+S4AA=
Received: from SN1PR12CA0050.namprd12.prod.outlook.com (2603:10b6:802:20::21)
 by DM8PR02MB8070.namprd02.prod.outlook.com (2603:10b6:8:17::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.15; Mon, 13 Jun 2022 14:47:03 +0000
Received: from SN1NAM02FT0057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:20:cafe::41) by SN1PR12CA0050.outlook.office365.com
 (2603:10b6:802:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14 via Frontend
 Transport; Mon, 13 Jun 2022 14:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0057.mail.protection.outlook.com (10.97.4.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 14:47:02 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Jun 2022 07:46:58 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Jun 2022 07:46:58 -0700
Envelope-to: git@xilinx.com,
 damien.lemoal@opensource.wdc.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=39544 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1o0lLF-0001rj-HX; Mon, 13 Jun 2022 07:46:58 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <damien.lemoal@opensource.wdc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-ide@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>
CC:     <git@xilinx.com>, <sivadur@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH V2] dt-bindings: ata: ahci-ceva: convert to yaml
Date:   Mon, 13 Jun 2022 20:16:51 +0530
Message-ID: <20220613144651.7300-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9481d0ac-d8d1-4027-3bad-08da4d4b93fd
X-MS-TrafficTypeDiagnostic: DM8PR02MB8070:EE_
X-Microsoft-Antispam-PRVS: <DM8PR02MB8070927785ABC6656E47F1F0D4AB9@DM8PR02MB8070.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clEpgbL0d2WLl/Tt8O98ZOvJBf/gUvI+l5Ofp3p8ZZAfEU/DJ1Wf4V+KQoIltzFSSfkwdt6O4DkG2fwosDE4J+OhI2pCIkD54j+7K1KyqfElyfdiunp1PRTpvBHp7C/YgOSq0njJ/oxqzmiUleO2tkBNSLRJm496oEnH0huEVNggt5ADPhtQhsnVDIIuS/W3AuVEsTa7iNKG2xqFIsOQZyKUw8kYpysjFp6D+fXuxGjjSyQji0F/ItfakrAb73HtZxidvFvlsTR/bg8g2zNWQ+w603QHj6MJgIZWzwtlEGzaILq5NMiVrjNXKfnVaz+Ah5D11Idj00IWfXJbymfakDw3RiCliwhAzvR0IQ/KekJTp1Y4K1J+c7TNMu/Mw8F9a3/3/XR0SBBraeaJ9RqPfJ6RSiCazhjH5UWsIF+wu5+O2GUBaGnwzXtqzsr+YG5olpaidLcbdxZUAEmxCpY9WnUGdDsrD4pFfrIOJ4dHgyobRMQ0/fch98mdDKOJRbTtpxDQyffOeG2i068bmM/MirFknulU7Bq/m1XKE8lBTDnwUJC3Zu1D5AbD7T7ktIq5nlqyogQ82ijkbdswEzzzFb1us5c+KMQi/Hfy4wX/MDhofKLcVKHVwYknIiqNvKFH/zxXqo/6apKKzcfPNkw3BqATMkGIgzsbOZ4Eh+GlIOaO/jE8gmDWYXybShU9gKLvUvkEzS8HciIZn5pJynCyR/gF9R+tdgBrmWiuCCHmhPnZ72p8Zt4E0PEzTfvGA5MsELJr1LtIDW+rZz3H+g+Az8uPSNidzzlfQN2kZo8guueCIwtRaE5OdPltm1VG2WzbG8Ohim+iYJ4JhUl3PXSgy+aLwbt/NgILlIwCZ28j9zAbr03rahwVJIt9lNg5oz/n
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(9786002)(966005)(44832011)(83380400001)(8676002)(7636003)(6636002)(110136005)(36756003)(70586007)(356005)(70206006)(40460700003)(316002)(5660300002)(54906003)(508600001)(8936002)(186003)(2616005)(4326008)(107886003)(36860700001)(2906002)(7696005)(6666004)(26005)(47076005)(426003)(82310400005)(1076003)(336012)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 14:47:02.6297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9481d0ac-d8d1-4027-3bad-08da4d4b93fd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8070
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
---
 .../devicetree/bindings/ata/ahci-ceva.txt     |  63 ------
 .../devicetree/bindings/ata/ahci-ceva.yaml    | 197 ++++++++++++++++++
 2 files changed, 197 insertions(+), 63 deletions(-)
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
index 000000000000..71f9ff0e2844
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-ceva.yaml
@@ -0,0 +1,197 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/ahci-ceva.yaml#
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
+  '#stream-id-cells':
+    const: 4
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

