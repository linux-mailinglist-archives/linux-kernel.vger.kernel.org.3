Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D706D54C285
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346286AbiFOHOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiFOHOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:14:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D9F4160A;
        Wed, 15 Jun 2022 00:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5YBL4FCvQSo+WM2J1ytcRH/MOPjZ3ipcDEA8NBgFAU0kocQb/wJz2gmb0J7ZYYHcTj920LkeOY6hUqHagd1YH738VBqj4fFlL8P+o4p5ScGoArX+9WUcPk4ISpQeDwLE16n5RebQt+ouJpRdzduRbXhF6OQjJIljH7TQnewpMWKpguCxQKgdHeImxcK/v8hQVsROm4AEy4PJsk+XdAQfWbaLz5i5J5Rcoxg3cUX7OQJrbvURyJtr2djk0+6rgNBVsNxX5T5RoQ8uf4dxFu4V9NcwydkjgeS8rbXi7Eyl0hxRGQM8qnt+8CQPdOi0KRS1c5gTJjydvM/JnuTTbjS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZcC5DXa7UVTyqVZGYOhVOsBp0tOBhbCaSj+rGp9OaI=;
 b=F6xEybr0Gq7WsxrWXq6G1A1eX5fsF/LPlwsSFl3bx0ATS2M8i+f3ut1F6u+biCVNopkkw3ROz8mHPHp5V0hVr5sONbqqectFUOmgtphG+GPNVfFxmjG7bOEXewaLBbtLG5U1WkSgeKmMMXFV+o+BAAPLZHG0DPIPhTyUWq0j42hsCYvqLFXdAEErbhSAfz9NY8KGg5JxXkR8H2ho3CkP7N6kEsx9CCJclWjcTDdahByGl/bk0zi/XmpOkQAB/GkewQygwoAiRyqpd7dooVV9zBoLr/a5ISxaWRvvkt6YLBAYB0V8yzqLwnmJAH7lCVWBc7UXaAYJrdqcu4+GkaZBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=opensource.wdc.com
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZcC5DXa7UVTyqVZGYOhVOsBp0tOBhbCaSj+rGp9OaI=;
 b=Bhyce0ivxxAFQ64e/bg7E/wvq+9NyPnvBxac3ZX1DBAKw8dd5qnVeIhRr8sVAKWPcYNTKlJE7dUFReO7xLA2898E97DD07Y9lNlwPzw4sE1nC3o23Xy5JQz3Hjmp0q/OgkcIdsATobUtGKTUp2vQqU056vnTVYTspTfOlmK2wwc=
Received: from SN2PR01CA0084.prod.exchangelabs.com (2603:10b6:800::52) by
 PH7PR02MB8883.namprd02.prod.outlook.com (2603:10b6:510:1fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Wed, 15 Jun
 2022 07:14:31 +0000
Received: from SN1NAM02FT0019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:800:0:cafe::64) by SN2PR01CA0084.outlook.office365.com
 (2603:10b6:800::52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Wed, 15 Jun 2022 07:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0019.mail.protection.outlook.com (10.97.4.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Wed, 15 Jun 2022 07:14:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 15 Jun 2022 00:14:28 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 15 Jun 2022 00:14:28 -0700
Envelope-to: git@xilinx.com,
 damien.lemoal@opensource.wdc.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=41014 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1o1NER-00082U-LR; Wed, 15 Jun 2022 00:14:28 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <damien.lemoal@opensource.wdc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-ide@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>
CC:     <git@xilinx.com>, <sivadur@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH V4] dt-bindings: ata: ahci-ceva: convert to yaml
Date:   Wed, 15 Jun 2022 12:44:10 +0530
Message-ID: <20220615071410.12499-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a021426d-9452-4710-6dd6-08da4e9eb0de
X-MS-TrafficTypeDiagnostic: PH7PR02MB8883:EE_
X-Microsoft-Antispam-PRVS: <PH7PR02MB8883EB7E669FDE8DB5BB8A63D4AD9@PH7PR02MB8883.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18SkVn2ky1JfzKPbyFuv1pAZEIB5c8oA9NZ00vimfOZ2w4kdruVu4a1TpLNCzIrenXzH0DLh3FGIMSUfK+9DxUjzC9/tGqL7RXH6M9XPqyyZ1PjfsXKHEmaA9unBhZGxqwKhzjVmQh+RVekU+jgJoQ3DOoVQOogfx0QdxKWyzJDjrMw8DbdJPcJol3+IBmwj+MEW0Op1xQW5Pk68FqCwwKoin9Z3f+BX33YdHokS5YIBdbHW+2azOvIDdaEU0WvLPt4P/TbSFzTBP3V19PIehVpE749ZHgigwBbVt5HgjQK9toI/21Y0ZptWDUDav5us2/NOS8D5jUc1pSh17jMK1M9EGK2nutA486LmLzjSH6gJ8QTi/p17O+Y83v1+NnDuhqpp5hbiJIlvA2q2HkZfFtgN6t+JDvT6PCcsROikj7xWGm63NFH5njUYMMwgw8GxP4CcAOUKhzIU0FHruBX/FCR+5kKATITYhUchrYVtEFAlb64me9Yqowmj2z/yV//7Uu839X7VzVovZCkVeFOuAIc5s2KdR/T3agPNCXqyXgiEHuaIIjmMtuSdsbZObich0VylR9aHcmuda7yIdP1dIZXU2+Z1xKs6ntisOYUrvSn+8tg9Mdvo3Jmpe3uq++4ae1lHUjemW8FNcqcGxuwKN3uvHvfB9OZrTiQzyzOhDXbwvPqByQ7xRttpkfNUaM0Pc7j2Zyc5QUzI0BrIuRfL77mdEavc95eSZsg+65EpmNLzcPzF+yC7525BWmqQag3s19d8QGvOA2xdoTIzkcdDNkY5NstOLf/tY622ON61q69OsFg9UpX1DnBt7exre4TgPrjALJPR6JrlgYGM3uSBeQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(30864003)(44832011)(36860700001)(7636003)(6636002)(8936002)(9786002)(356005)(5660300002)(40460700003)(966005)(83380400001)(508600001)(186003)(1076003)(2616005)(54906003)(110136005)(82310400005)(6666004)(2906002)(26005)(7696005)(8676002)(70586007)(70206006)(4326008)(47076005)(107886003)(426003)(316002)(36756003)(336012)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 07:14:30.4731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a021426d-9452-4710-6dd6-08da4e9eb0de
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8883
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
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
---
 .../devicetree/bindings/ata/ahci-ceva.txt     |  63 ------
 .../devicetree/bindings/ata/ahci-ceva.yaml    | 182 ++++++++++++++++++
 2 files changed, 182 insertions(+), 63 deletions(-)
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
index 000000000000..b8adf46eade4
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-ceva.yaml
@@ -0,0 +1,182 @@
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

