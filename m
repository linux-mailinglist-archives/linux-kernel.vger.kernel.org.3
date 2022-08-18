Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6446598359
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244695AbiHRMmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbiHRMmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:42:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC6BA9240;
        Thu, 18 Aug 2022 05:42:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4/23c1sLDUBIIt8y5Vs0OOVQTd9ul5f73XAcEt1x+E7NCALYcDbRT0dA3kxVr1yhk3USwAaRwsaUuSGTr8gghihrGnOWpNnuUcaw55+wS4iWANHNN0IGfzHhXk3KPaPD7rHGimuHSvDYRTgMy5B9mwiOL8xf2FyNbN0XNSKUg5Nn7kJpdoTAzDHEUOL4MgkkmBZupObQygKDe6iSokw9gsyJN44q2rif1bWkmjj0s7Rd8wSX24+vckQpvBJqw5XgVe6Z+IdP/5AWryClClcmkY3CXKPMnGM9rLYTuEvPofDFXcZlnjG7Qta9gEgf9UK5ctRwysP1VHEAg9MsdGxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Nkg+Mzt060lsDH3RPH9yA+u/DH8Ycu5+djaVBRmLHI=;
 b=cTIZVso51iP4tjdNo0yE8q98qxIQPOZnLU4ky9qQ4bfsr4mGxAQw7821ndTEqAh2awjEkjr2TOIl+MIGEVW1c1IQTXNFY2wzlz/uTOIII8xqWQvesDpt0BgpFhKY7ACON3tQUzHrJLKFUfPlHtIMPqP3Qwn9Z7xVqz3okqUtaz4XboV5qnGfIJ3dNChaEPsafHtoxNQZPCPqX4dF4e7Y6QIdCRU0vG3eJ0Nc0baxDVGqfFcsPY4dCRmI9fhsQfya5TNTAK/OR0KwznI4p8FHuFYI7Pf46cfCRMSUd3iJOFhaa6EQ96JCAbje9nRmBM8XZxtM07CSOa4igiFTFRhHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Nkg+Mzt060lsDH3RPH9yA+u/DH8Ycu5+djaVBRmLHI=;
 b=GXDjfQ/4yPkiGScrP5vLPTBg6ez3RSN6eRI/MAvtm0jzKAAQRyYvUo/vwfeojllMxtB12mdxgJNKaJCBnDb3DCIltkXoekeW2T/tv2260qjTGDxCePa9bqcGbs8/16I0jPylsr7nDC3g0pLdPjndBOrvdifbQ5VEHrFQk0gn7HM=
Received: from BN9PR03CA0176.namprd03.prod.outlook.com (2603:10b6:408:f4::31)
 by BYAPR02MB5464.namprd02.prod.outlook.com (2603:10b6:a03:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 12:42:16 +0000
Received: from BN1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::e5) by BN9PR03CA0176.outlook.office365.com
 (2603:10b6:408:f4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Thu, 18 Aug 2022 12:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT004.mail.protection.outlook.com (10.13.2.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Thu, 18 Aug 2022 12:42:15 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Aug 2022 05:42:13 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Aug 2022 05:42:13 -0700
Envelope-to: git@xilinx.com,
 linux@roeck-us.net,
 krzysztof.kozlowski+dt@linaro.org,
 wim@linux-watchdog.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org,
 git@amd.com
Received: from [172.23.66.193] (port=45678 helo=xhdsneeli40u.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1oOeqi-0007yi-Id; Thu, 18 Aug 2022 05:42:13 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <linux@roeck-us.net>, <krzysztof.kozlowski+dt@linaro.org>,
        <wim@linux-watchdog.org>, <michal.simek@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>, <srinivas.neeli@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <git@xilinx.com>, <git@amd.com>, <sgoud@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH] dt-bindings: Convert Xilinx watchdog bindings to json-schema
Date:   Thu, 18 Aug 2022 18:12:07 +0530
Message-ID: <20220818124207.61313-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06cf11bd-a4e7-4386-1866-08da811714a1
X-MS-TrafficTypeDiagnostic: BYAPR02MB5464:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AyB1hkzUfodU5gUYQ3+S3BRMuXJfSeGXdZRCJx2NuZMjfp6P0ojNBQ5TgNXUmfckHHcoQDm/acZBdrm6qkRxhCqm/xiUKxea6uyJtIohqG3/L65pYE3+S0m2V/fJxyqHijqJlNUDIyWZz6DGSeQfU79FKw2+ArDl2w2csQkoekGDi27fKhiLUeqRZs1F33dckGDZsH12dcJaN1YDqXuR5g0w3JmN5i3lvuCmACGnBwePQWTk+UzoOZS3QUx6gIgnTneaQwV3n8SiSkHUw40VD2eZ8dJfyI6s3ywDfD6tPQAUM43SwxQlVZ1hiYZgRhe6iJFm7aY6rwYB48nvznqVizTzAH1t8MvOGKLLaaTwVM/ysB9IALnHtqVJdhryVsrpHIv6ijdPwctSU2tP9PV5FziqMD4PJ2kooVC0Gfm/o4QKVvNm3VV3y780/IFoW6HUGbCpsf0c2oUki+bPbPjusO0PT5dGxgdalmOI1TZPjvDEuEkuWGXfWVmmNXqcFFEIe3EAUmEKhKkNVNj16PFEZXY6/mHm4bPVLs/vEydoVs+vLjavQRyAjafhdletRVmV2hVlZvTt9SzvJ4k2dIGEs4ET37rSWpDoQ8QccdBxq6XOHJKftesjEwDewHRQyCBNqxRrrHr/ju/VpMY/uG45a+AP7bd9rWXSwIdPJyAlHPlZGEJ2QCRDpX8XnB6LgSpJeQvvrOwmjK6wzO5BnmU9p7VGgbVUVLjko8ucy9AUDSjDcFO16I4xJugj+g/WWbVAet7NOpnTsYQimRvIolLDlS/i7fJn8MLcBfHZ1fbVKNZgb4kcu1DO0oF7iQc7qmXEusUMNQNST++t/xi+8kBfQA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(40470700004)(5660300002)(40460700003)(44832011)(478600001)(36756003)(40480700001)(107886003)(316002)(966005)(110136005)(54906003)(6666004)(41300700001)(9786002)(70586007)(2906002)(70206006)(8676002)(4326008)(8936002)(356005)(26005)(1076003)(7636003)(186003)(2616005)(7696005)(7049001)(82310400005)(47076005)(336012)(426003)(83380400001)(36860700001)(82740400003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 12:42:15.5116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cf11bd-a4e7-4386-1866-08da811714a1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5464
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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
 .../bindings/watchdog/of-xilinx-wdt.txt       | 26 -------
 .../bindings/watchdog/xlnx,xps-timebase.yaml  | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase.yaml

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
diff --git a/Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase.yaml b/Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase.yaml
new file mode 100644
index 000000000000..fd2e3f2df54c
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/xlnx,xps-timebase.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx AXI/PLB softcore and window Watchdog Timer
+
+allOf:
+  - $ref: "watchdog.yaml#"
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
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - xlnx,xps-timebase-wdt-1.01.a
+              - xlnx,xps-timebase-wdt-1.00.a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+    } ;
+...
-- 
2.17.1

