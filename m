Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5001E53CDBA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344213AbiFCRFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344207AbiFCRFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:05:14 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C751E4D;
        Fri,  3 Jun 2022 10:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoaT4S2XxktNdg4avSqRF/8Z35Yw4NEUEsD1fMgQ2D67XqpSbtBlD7NliZia+Qo7/oduRFq7IWTuZoFpoFhrcIe+j+qf7MXImXLwLZfsCAKeaTZQo2eX1vsNPCrw7FysdxJQWSYtbvCAqbSnDxs2FDFGmpUNxWBny16kaEIWihH5+QITUIrkZv6ksxY19Kk2pwibZxlib1W3JM4g9m6RxkGywEnPyXR8Dga7nqdJnNmyR2v89ONkmoMpx2tQDLlnlhVv88cMzIZrKDVXKwgLVfa+E/ZVW5johMNPgnsz0s0fd9Yt9hS8N+XLW/ROADjk42I91RuGATOhfbTp+9zCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Cx9kVe35ogRH9oo8yLpM9TcHba9nJQ/gkniXEujeRw=;
 b=c/XdLbdKbEKdhoUhPD+gUfVG6dXE7z7nx33ZGcmzisTMpkVe93HXg1wgD4EgoXuzOXKp1zNApGhLUYoDFRbSh/ftYVfrrshd3fRWN9QXEAixZMgrH/MetuLWz1OHjj2q9a+c7t3iDb1FENQvijJ54zFjs50YRhqjIWYKKZ36NSfiIKCVnOn96dZV9NyXbWUhev+YbAooZBQGFWguaPrS7XnhbhAP3rQ5UShcIOODWjhi6nphaqDHaufbvDcYmBfAbbEwdTpd6GCO7BA640EYjpeP8ktfBjW8K/BhFu/MixW4AV4CwUt+Jf+eFkp55yCVHaQGNg+yIoc0KAM9Ac+svQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Cx9kVe35ogRH9oo8yLpM9TcHba9nJQ/gkniXEujeRw=;
 b=sMyMq0CbjTp164JxbEPirKLIsZhMUIIuNOT+yLSzRALr9fEycg7atPhViNKvaPECtICcZZ0eAb+X/1RAPsNRW3+PKMrgbUbEYgNoSUrpAG6WZCTcwAwpdPoyr9c4QilKhfyJIvE4J4Aakm0SGmKhQlFhDbF4Q68dkRjthK794rI=
Received: from DM5PR13CA0029.namprd13.prod.outlook.com (2603:10b6:3:7b::15) by
 SA1PR02MB8621.namprd02.prod.outlook.com (2603:10b6:806:1fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Fri, 3 Jun 2022 17:05:09 +0000
Received: from DM3NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::48) by DM5PR13CA0029.outlook.office365.com
 (2603:10b6:3:7b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.6 via Frontend
 Transport; Fri, 3 Jun 2022 17:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT036.mail.protection.outlook.com (10.13.5.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 17:05:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Jun 2022 10:05:06 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Jun 2022 10:05:06 -0700
Envelope-to: git@xilinx.com,
 a.zummo@towertech.it,
 alexandre.belloni@bootlin.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linux-rtc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Received: from [172.23.66.193] (port=44716 helo=xhdsneeli40u.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1nxAjQ-000GsV-Fm; Fri, 03 Jun 2022 10:05:05 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <sgoud@xilinx.com>,
        <shubhraj@xilinx.com>
CC:     <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <git@xilinx.com>, Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH V5 1/2] dt-bindings: rtc: zynqmp: Add clock information
Date:   Fri, 3 Jun 2022 22:34:31 +0530
Message-ID: <20220603170432.26605-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be4f516f-d42f-4099-c79e-08da458336f9
X-MS-TrafficTypeDiagnostic: SA1PR02MB8621:EE_
X-Microsoft-Antispam-PRVS: <SA1PR02MB862105C4DA2231FF212A97C5AFA19@SA1PR02MB8621.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87IFXHTHQs31/UZHwITGbiE2PE0Kwn0U5me0UOraQGbEcbQEpwI1ITmGdTt41ydtavA5lorNdDfKmGDk4IRl7O/Kem/hxCD5cOQdEnITEAgYM79ROQ2ooYsBIFZzkyQkxtVhm20x7lqqrF9Qg7eY48cP3XBv0/BKP/YC7dbjaBaaT9Qt9j8RkAdnJJ8CqPc5kuDOvyTt36Nv+RICoZN6ZbAcCHlZr28IrVUO7ev+WYe+HPWhrWIQ3C0gPxiYzdQqyLtES96+QHCXTroXF7E+bgp3UU7niiJ101hkRV3aDClg4jJlhGDS70RfV+AgbDwRdvTTOSPMuEgCETiLAeM6VDIUcbZ03phZD/zln4cvphZM5X6CH8zZ6+wulyfR3hPyEGgskRnw5tLfeYuys6EC7upmWMogVjhuklQhI5p6zftRPtoPOp8LCpchtV6rGynIgTQPQuoI6rNi7qMDtb39b0myl6GHycodYgZooDLkSmSPYJi91Iad1tou+xiOWW7ZWnJYSUISRPCteUc1aAFWbZLEkOoccCIlIy1la3oxWAw11T0YmG67mRmiZZMkIO5CHV794t8vJmADj4q2XrNt3KzEkXNDF8guF5DCfGk2xwXpXl3yQ2aXZwazzr6lp+RXmRMcbjoeqHLuleAn75RticxkbYWNYBvGCTLJcsql/wqKW8x9OB0PdBAJuZ6oo5wwBBs4zxZFKrXjc7qOaTBGvnBMzC3zdVbhYiSVXWtBNnY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(336012)(186003)(2906002)(44832011)(426003)(4326008)(40460700003)(1076003)(107886003)(9786002)(47076005)(8936002)(356005)(7636003)(6666004)(83380400001)(508600001)(7696005)(5660300002)(8676002)(316002)(36756003)(6636002)(36860700001)(26005)(54906003)(110136005)(70206006)(70586007)(2616005)(82310400005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 17:05:09.0780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be4f516f-d42f-4099-c79e-08da458336f9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8621
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
---
Changes in V5:
-Removed quotes and _clk suffix from clocknames.
Changes in V4:
- Deprecated calibrtion support
Changes in V3:
- New patch
---
 .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml      | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
index bdb72d3ddf2a..bf2a0c3d5244 100644
--- a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
@@ -23,6 +23,14 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    items:
+      - description: rtc_clk is the operating frequency of crystal.
+
+  clock-names:
+    items:
+      - const: rtc
+
   interrupts:
     minItems: 2
 
@@ -39,6 +47,7 @@ properties:
     minimum: 0x1
     maximum: 0x1FFFFF
     default: 0x198233
+    deprecated: true
 
 required:
   - compatible
@@ -61,5 +70,7 @@ examples:
         interrupts = <0 26 4>, <0 27 4>;
         interrupt-names = "alarm", "sec";
         calibration = <0x198233>;
+        clock-names = "rtc_clk";
+        clocks = <&rtc_clk>;
       };
     };
-- 
2.17.1

