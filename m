Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D60D5986F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344151AbiHRPG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344150AbiHRPGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:06:54 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF6877554;
        Thu, 18 Aug 2022 08:06:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8rmfXkfOI+vgbShaeok3R65bLFiqjXcEgkvLSieu0kmbqcevg4/7h68QBGLw/cQcHtRJLNFITD9iNMdYCSMYDhtO8BH6SFJKlwlFcvYIUrACb6KsJlXDDx/fyo5RgIVbX3XN7Lg9sout3r/o3rZGzU00CWlrk7pN+r1kncf+AB/7C7O760cYDIDS6rl58iaiMq+oyNWm8cpTwHaVEbs2cUnTzleShoIrq24+H0PBsTiwlRvywkzl22a6y+VL33UjnDx35wvElAPU5HSFISUg2sHE5wQGAPwgpJxS5GuNJNWDD4FK7naTKqIRbn3TCZO8mHhbR+QMkvw4GVHOyvMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg4DJCjOA/zkWLnbAoEaUxIQxBhEHzCCNXce2UuRXeo=;
 b=Xrp/LVKftjR9CJLwZkE+BOVTwgnBP3amNHbwfWUftdtQpyJteb/JHYNQPSQ+hGnuecc0Il0PckWiJ/n7IpAi6y83xhGrap0Go+7Hhs68JZ9kKddvPczYaMJxxIjz2kjPh7y/ooXrA/Ix9ZYWplp7jo0I404H2Pr8RR+9qu9yum5lWeiDfPo84N/CdKFAQox8Bdx+HNYhJGv/q9q2xWbWlRXhDhba9zb2M4KGw6fxrBao2CVeRUUknm8d+4rZapJ3lJ+Njul8zL6N9h3AwiOyNpLzW/U+cuSREqCY89erBNNIoE4PG+zK/+h5YGtYAYejIl4viQhXHCuI0tUx4ytEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg4DJCjOA/zkWLnbAoEaUxIQxBhEHzCCNXce2UuRXeo=;
 b=Ua9BQaoY+kcTYQ48inbXXMPDXVZMFWQb1nBUlJGMZimAYfNYMVoPfyQzCOL6yn/SuBbNWaq8gQ851HNeonXOKsF957Y2X0PvAOKwiHvqsVUctg+sLGwrXGOiij3GIw7XQlnE1Udojh/1iw9wDlvKJOo62g1iiFA4KTQOvGe7Etg=
Received: from BN9PR03CA0177.namprd03.prod.outlook.com (2603:10b6:408:f4::32)
 by CY4PR02MB2678.namprd02.prod.outlook.com (2603:10b6:903:124::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 15:06:48 +0000
Received: from BN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::bc) by BN9PR03CA0177.outlook.office365.com
 (2603:10b6:408:f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Thu, 18 Aug 2022 15:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT049.mail.protection.outlook.com (10.13.2.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Thu, 18 Aug 2022 15:06:47 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Aug 2022 08:06:42 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Aug 2022 08:06:42 -0700
Envelope-to: git@xilinx.com,
 linux@roeck-us.net,
 krzysztof.kozlowski+dt@linaro.org,
 wim@linux-watchdog.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org,
 git@amd.com
Received: from [172.23.66.193] (port=45740 helo=xhdsneeli40u.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1oOh6X-0001z5-Rw; Thu, 18 Aug 2022 08:06:42 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <linux@roeck-us.net>, <krzysztof.kozlowski+dt@linaro.org>,
        <wim@linux-watchdog.org>, <michal.simek@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>, <srinivas.neeli@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <git@xilinx.com>, <git@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH V2] dt-bindings: watchdog: Convert Xilinx watchdog bindings to json-schema
Date:   Thu, 18 Aug 2022 20:36:37 +0530
Message-ID: <20220818150637.815-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e474de7-9bec-4382-271d-08da812b45d1
X-MS-TrafficTypeDiagnostic: CY4PR02MB2678:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/cjwekRlnHeOAJpJ13aEynpOYODjL6fBUeIqfLD1XPu8f/oxMdnVeWNJielzOsj8RzsJC8G11ePQAWVEi67RuG0/jiQJAsZO8mFNvbZziGO3IW9gDiwm7dstX4I5hcU+Nyz+G1M2hYXNvgD6fmpWwIGLe9CFcsHZLymfMdzEJYG9d+MoHRR0tSDpWr377RsXSP7kjkt6MiOqUn5BPWmgiS4LNAr9KhCYXeL8vLg4FEx+rI1I+eCL7bN3aVhPPskPJK1fI0YXkSoxRVUMpwLaSULDsWdSX9HsjbT3xWy2uSlPFjOdt7LvXTL4BcSApGOT1GOxxePL46p81B0ypEkLyX0hx1BR9dMIiprg/xIqvZF1RjAaeygBHVHAgvGtp9UipzKFPXrbuR5uRd3Q2L6omeJSmqmybfmhBEBHlrL1uUOrD9uKL7glLfrOnJSvo34KLAzfcQzImhVn0tQhGXKUJP7vSij3MHRD9xJFGR6H8Z66p8P+zj/R0h9tTw6ogRNUvVoUEYMxSZBaYG+0bgCGfcCz1EFRi3Xn67539MlxYaLCTue2TY+F551qt2agLuwH70/sOctrSnDPJb5K7JEILRgIi8Y4O1Z894nJEuiS0fQNEigmdlHkpJUSK2mkshSRkHBl1wCl3pNTI+gEOIglMIiLWwvrD0VijKJQoqVyy0syB3nm2sXIHwe30PztEfkWvN2RO5vzI8Ks48kP2l6jinkm77Q6CLoLOifB2DbeP12jX05dx66t2Lxn3zwzGDyWkRaPhGToBA4mH5g306D1jY5Zc05HCsAzBLnHfCq3r2lKaJwdLVVtTQ4epywUU8LKG8Q8cypjvLNhRXDuI9yaQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(6666004)(7696005)(478600001)(966005)(26005)(41300700001)(83380400001)(36860700001)(186003)(336012)(426003)(1076003)(2616005)(47076005)(107886003)(44832011)(2906002)(8936002)(5660300002)(9786002)(40460700003)(82310400005)(40480700001)(54906003)(110136005)(316002)(70206006)(70586007)(4326008)(8676002)(7049001)(7636003)(356005)(82740400003)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 15:06:47.9852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e474de7-9bec-4382-271d-08da812b45d1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2678
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Xilinx watchdog bindings to DT schema format using json-schema

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
---
Changes in V2:
- Updated file name with compatible.
- Added subsystem name in subject prefix.
- Address minior comments.
---
 .../bindings/watchdog/of-xilinx-wdt.txt       | 26 -------
 .../watchdog/xlnx,xps-timebase-wdt.yaml       | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
deleted file mode 100644
index c6ae9c9d5e3e..000000000000
--- a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Xilinx AXI/PLB soft-core watchdog Device Tree Bindings
----------------------------------------------------------
-
-Required properties:
-- compatible		: Should be "xlnx,xps-timebase-wdt-1.00.a" or
-			  "xlnx,xps-timebase-wdt-1.01.a".
-- reg			: Physical base address and size
-
-Optional properties:
-- clocks		: Input clock specifier. Refer to common clock
-			  bindings.
-- clock-frequency	: Frequency of clock in Hz
-- xlnx,wdt-enable-once	: 0 - Watchdog can be restarted
-			  1 - Watchdog can be enabled just once
-- xlnx,wdt-interval	: Watchdog timeout interval in 2^<val> clock cycles,
-			  <val> is integer from 8 to 31.
-
-Example:
-axi-timebase-wdt@40100000 {
-	clock-frequency = <50000000>;
-	compatible = "xlnx,xps-timebase-wdt-1.00.a";
-	clocks = <&clkc 15>;
-	reg = <0x40100000 0x10000>;
-	xlnx,wdt-enable-once = <0x0>;
-	xlnx,wdt-interval = <0x1b>;
-} ;
diff --git a/Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml b/Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
new file mode 100644
index 000000000000..493a1c954707
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/xlnx,xps-timebase-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx AXI/PLB softcore and window Watchdog Timer
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
+  - Srinivas Neeli <srinivas.neeli@xilinx.com>
+
+description:
+  The Timebase watchdog timer(WDT) is a free-running 32 bit counter.
+  WDT uses a dual-expiration architecture. After one expiration of
+  the timeout interval, an interrupt is generated and the WDT state
+  bit is set to one in the status register. If the state bit is not
+  cleared (by writing a one to the state bit) before the next
+  expiration of the timeout interval, a WDT reset is generated.
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    enum:
+      - xlnx,xps-timebase-wdt-1.01.a
+      - xlnx,xps-timebase-wdt-1.00.a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency:
+    description: Frequency of clock in Hz
+
+  xlnx,wdt-interval:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Watchdog timeout interval
+    minimum: 8
+    maximum: 32
+
+  xlnx,wdt-enable-once:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description: If watchdog is configured as enable once,
+                 then the watchdog cannot be disabled after
+                 it has been enabled.
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@40100000 {
+      compatible = "xlnx,xps-timebase-wdt-1.00.a";
+      reg = <0x40100000 0x1000>;
+      clock-frequency = <50000000>;
+      clocks = <&clkc 15>;
+      xlnx,wdt-enable-once = <0x0>;
+      xlnx,wdt-interval = <0x1b>;
+    };
+...
-- 
2.17.1

