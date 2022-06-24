Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B3A55990C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiFXMC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiFXMCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:02:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525907E01C;
        Fri, 24 Jun 2022 05:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoX6/v3y0Yztswql2GXtnl8OJ4FsYbq5J0ayqwo6TPgyTPey+cOHUTeVM/k0KN8Mj2tzpBAe1EoTucGqgIVJ4GOm3eK5yMtJTNFhEMw0d6Yn0IByjp9XE+MYapp6qDbP7s259fFxaV01/AjOqPpinnWGtJkSEwbWQGZ3IHUMVepcrAdj+OWCjj9AW7py1L3/isTpxaGrhYlrNZnBUN6bsdPkQ2ViC4IlQOcmLKVL5RiqUN//YlvjnHsYHPA1Wc9l0kEIWRys4O/vO8ZmFYS4CJMRi+PYK3v4wUnBOnhSOQmgJZ/UukAp+/fjRUw/acaTRGH8AVQwrKS7gMleVUtauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SH/guYvs0GAdp6XiHJbifz6fjAZGiA/KfdD748KwUwY=;
 b=fGOq6QWsCgARPMpcR/7Mr9Cvtm/BCsaEAis4mcwm6doexG43sILeCihcrXUe1IKma1D5OcsncA7BFRs572J6C2rLqKSyLdLTnmVtZwaqJrhY2eAARWdCw2fzZd24EbMP68TYT3R7OcLVZr/8zJXOQyYUg6SK02/kzmCQKSlD6FKbWtQ/FmOZ+kIlwOKBlZGcSyHNYGwLxrcPMgfN08Ikq8lImDsMS1vCkD9/8005AJ1teY6vGOW/E2iNF/fDSMJnlTySZNo03McG/iK6abRK1k22c7zuxU+sx6ev1prWAjcsa9Q5cBSsZ0FLWmU0JlXDPOm8xNeb/siW5dOb3b87Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH/guYvs0GAdp6XiHJbifz6fjAZGiA/KfdD748KwUwY=;
 b=Hrg5tgfKIguv/MiKYhXahqVv+86tLl1A4UmyevWgUMVyl5hw985eycSMjGHkfVARaFo2vOmvM/H3gsPjFLNUeoOrNZSVgK5gWez/yx8wdbC8vsMC2C2+Mag2aKyiOw2fW4D2RYGum3TCjjPMIcUnI1nTZ33eVAeDBCU3U7gLIWE=
Received: from SN7PR04CA0171.namprd04.prod.outlook.com (2603:10b6:806:125::26)
 by BL0PR02MB4292.namprd02.prod.outlook.com (2603:10b6:208:4b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 12:02:14 +0000
Received: from SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:125:cafe::2f) by SN7PR04CA0171.outlook.office365.com
 (2603:10b6:806:125::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Fri, 24 Jun 2022 12:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0034.mail.protection.outlook.com (10.97.5.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 12:02:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Jun 2022 05:02:11 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Jun 2022 05:02:11 -0700
Envelope-to: git@xilinx.com,
 a.zummo@towertech.it,
 alexandre.belloni@bootlin.com,
 robh+dt@kernel.org,
 srinivas.neeli@amd.com,
 neelisrinivas18@gmail.com,
 krzysztof.kozlowski+dt@linaro.org,
 devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 git@amd.com,
 robh@kernel.org
Received: from [10.140.6.39] (port=57958 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1o4i0p-0009E0-8b; Fri, 24 Jun 2022 05:02:11 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <srinivas.neeli@amd.com>,
        <neelisrinivas18@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <sgoud@xilinx.com>,
        <shubhraj@xilinx.com>
CC:     <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>, <git@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V9 1/3] dt-bindings: rtc: zynqmp: Add clock information
Date:   Fri, 24 Jun 2022 17:32:01 +0530
Message-ID: <20220624120203.2817457-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8478f60c-230f-4b07-f24f-08da55d96045
X-MS-TrafficTypeDiagnostic: BL0PR02MB4292:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eGYCInTfyG9h5yuqGuP7CUWIWJdb+34Whn3nurlfCsLa6hM+HjfQGBoiRj4IgNJNR9UoW6jQDZv8U3+LUGSm5VLO8g8vP24ZKZhf7iDwgQi0CGGS1FdG7Ko6/8g5qhHU46NDJUlqB0kB0RbxV5n8Brt+i1o2Seqr3NR9D7r9GkhhngT2eaHpeQO35ANgp3F6Z/V/4rX6MqujjZeEAJHOwD8itn5F9SNjYKyxhHxYCe3uCAH+p5i4vVQUJLau7ueucBuU++N6L+hCQe5IUu15wtuJoQN4VzAKQFhOYw9DOWEX+VOdFh6pFDVIwcPnh7BwFWRLR2aN7LpalVaEjuCrxH83RNpHYDkWXp6nDYOnhNVSyfW/UwP2928zw5cRCoM/I92RAHfHSx7wulUpKpTzp6kpHC/9zRZCYthKr1IipV9yGSVC4HB64ku/4WwaH/2SOLKicdCL+IzZyJSQ+cP/Yc8yUMv5oKsppn9U0t4kkfa0xnA/nPUNg0Jh+myPamniHbQUbuvpfvIj8U9Hz5zRwyeB95p7G+Lcts+2vx3O9hRJbar/XigRpqb9vFVjossGMXqLv3CfulmqhKiCr7+qod0Nyeuam/J/TggYvgFtnVSU7Zzy/RmxQf4uuX9KJhRIqz3j0O6PY3hFFM5LH1cNWHoTpQdPOoSEzsLVvK26xWntx4jx2kaNjbZeDgh3sizyMytySXykq8Y3NDwVZyHvpvZLM7zv4lZNq+r/4H0DLI/NyOEZP5ZQsoX/6vKR2CQz9XiqNSNP5pgVOzZS2Fk/tz1nOU4FhDr8IA0ivXKq4BbRZygVo7nxzaT7FXmMOVIE1SHf/wGiEd8IrV2Ifi1qoEnH/16HTTkOSVQlgoPPZr8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(36840700001)(40470700004)(46966006)(9786002)(2616005)(2906002)(8936002)(47076005)(6666004)(7416002)(26005)(44832011)(70206006)(7696005)(4326008)(54906003)(36756003)(70586007)(40460700003)(6636002)(8676002)(5660300002)(110136005)(316002)(356005)(40480700001)(336012)(478600001)(186003)(426003)(1076003)(83380400001)(82740400003)(82310400005)(41300700001)(36860700001)(7636003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 12:02:13.6870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8478f60c-230f-4b07-f24f-08da55d96045
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4292
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added clock information and deprecated calibration support.

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in V9:
-Updated clock information in clock-names.
Changes in V8:
-None
Changes in V7:
-None
Changes in V6:
-Removed dtc warnings.
Changes in V5:
-Removed quotes and _clk suffix from clocknames.
Changes in V4:
- Deprecated calibrtion support
Changes in V3:
- New patch
---
 .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml     | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
index bdb72d3ddf2a..9dfe2cc5966a 100644
--- a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
@@ -23,8 +23,15 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: rtc
+
   interrupts:
-    minItems: 2
+    maxItems: 2
 
   interrupt-names:
     items:
@@ -39,6 +46,7 @@ properties:
     minimum: 0x1
     maximum: 0x1FFFFF
     default: 0x198233
+    deprecated: true
 
 required:
   - compatible
@@ -61,5 +69,7 @@ examples:
         interrupts = <0 26 4>, <0 27 4>;
         interrupt-names = "alarm", "sec";
         calibration = <0x198233>;
+        clock-names = "rtc_clk";
+        clocks = <&rtc_clk>;
       };
     };
-- 
2.25.1

