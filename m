Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95BC532A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbiEXMVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbiEXMVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:21:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B484F7C;
        Tue, 24 May 2022 05:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7HEhevGy7LYGanmOPB+G3szJ+t815oI/cY0i4rDjZXaew41rOH7T+iy8O2HxviDCDW9YTO0whBfLsBhdPk6uWQ7QlPyxUebTqMMlMS2bQOd+t/gcZ9tJ+p3GZ1E+HSbZbrJeKwXgBuEa2hIVtXN2faVHXimn1bxpjpxBYm7qmStjWwAwFr5VyV0uIp5agu65iYZRvhmDeVMXSgIQR4ggPRl5J8dBEgSjRwAlWMu/4U/0y7YnWaAxg5mZDKzahCk1Y2WTDMKPxkDrSB2aDG4JUZHdNFHk2djY/oixYj4UPHEDzTnZLOa1Js+7Sw6FPOeCT+lODb4tq4XPS1tXhfKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwAsKsKjSIlW32+M4OZDPCayWEKvwMWrA7D12OaW9Ss=;
 b=SvTXwbHv2FzFj7pik3qJkojRo8x2sPEo9eFBXJcB8Gg3qDwqjMF3QeD4wcef7BdNB/HuOuHc9lwpvnaePsa8vVVRPWGja9hSanFFrthbDobFXx3xqRpmOf4CLJEsOdlNEc/8KPAg2AtA54hl9wS+8Isue/PwdCH3xn5zzmzLxX3Ia20cEkuyo6jpbEKocVy1X2N/X57sVQPj3gGPnKYuzW+hsIEooCDYk9uDMiZAlhpw89IKkrb+jdF+ILIQVg2USoITr5myTXuA8IPbRhmWLi3H4N2C+ywvUUvV/k8VY3lwfF8o6/Ga7ME6VDw0tH0DCv9jb7Y+UsxRNIP4D0rgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwAsKsKjSIlW32+M4OZDPCayWEKvwMWrA7D12OaW9Ss=;
 b=X7GYadD/HCVzxwTbwuhofjbRNe5G7bUCsNS/obU6nzNubY8gJKJeXudsrSm8Bjdk1bJrYfz0bF/wA9+WrAgEwhN3NNYW323FIfEgrxcn4A5Fq6UJXSSGFae1nTZEZDxl4Jiq4rlbQQXbL4kzcOSw2Zmzv/WHQ3urQL5rb519jBY=
Received: from DM5PR07CA0063.namprd07.prod.outlook.com (2603:10b6:4:ad::28) by
 BYAPR02MB5671.namprd02.prod.outlook.com (2603:10b6:a03:9c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.19; Tue, 24 May 2022 12:20:59 +0000
Received: from DM3NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::62) by DM5PR07CA0063.outlook.office365.com
 (2603:10b6:4:ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 24 May 2022 12:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT052.mail.protection.outlook.com (10.13.5.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 12:20:58 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 May 2022 05:20:57 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 May 2022 05:20:57 -0700
Envelope-to: git@xilinx.com,
 a.zummo@towertech.it,
 alexandre.belloni@bootlin.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.66.193] (port=41286 helo=xhdsneeli40u.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1ntTWy-000DAp-HF; Tue, 24 May 2022 05:20:56 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <michal.simek@xilinx.com>,
        <sgoud@xilinx.com>, <shubhraj@xilinx.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH V4 1/2] dt-bindings: rtc: zynqmp: Add clock information
Date:   Tue, 24 May 2022 17:50:49 +0530
Message-ID: <20220524122050.48553-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c18fea3-4042-49f1-efef-08da3d7fdbf9
X-MS-TrafficTypeDiagnostic: BYAPR02MB5671:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB5671739661795A2F34B68E09AFD79@BYAPR02MB5671.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QH4wnfoaaospvlzVo+LfJzImUHRUvpG6EndkRc1+GpLG8rWSRQIlnk3Xid689CynyW69H4qY39h8OQneBbW8PnT7vCS2GNGMyaHBINPWpIIUgrMzHB3yIKBFHw08sADNRzg6sFLhU5MR/vBoc74AfEIqFEX9kFYnS5eZpICweiLBeDYPfiyE6qciSkLeELAAWnCaIqwYqf1yIgaDmXXBygA+Rxe01OUm52r2xmx9HTdLuqTxsnLynOw9PrySdFWJNM4EgZBOnGTrYLrzbkK45AaQoDfT0Z2txJvTrtS9Sshf3a+IG8U2ubl8bB/vA3fxmP4gpPWP4B9h+FQDRrQlZslBg2iCXpL+FXdKOpjTMBCq6sem6fQr/4YZ6IHIPn/XL8OZ/UMBEevxY23ymRIx/VGVmtGVb40fYa5gzYaDWl/UrxNHF1fSpijNN5SUMvoD/7QHW9AxvaECwn1EWQv1z77UJEo862Sd+fqIqaxk6mH6FRbnWc7tdeAfO1yfsBq+8+lwXWfHxBAr6Jt1DaU1sySCbMYSrQb1691UlECyQ5swVrI1HCFB7JhaHfBp+nf0JYFjzkLk9D9YUxiGK6PkBA2PjUV4wgSTT+01FywzTZRdzMZwMIqdDcPmb2UhfdDKhReZtDM59Dx1EjpfLIQLJGRbSgr54+5xm619shtpgh/F8BnAFAoEVrrQWLjIu7Cz2Ao1/NDecbaXxpG49fcLYWhpiLL+72lKWEpooN1tDnM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(110136005)(5660300002)(36756003)(508600001)(2906002)(70206006)(70586007)(82310400005)(4326008)(40460700003)(356005)(6636002)(8676002)(54906003)(26005)(7636003)(9786002)(2616005)(1076003)(426003)(336012)(186003)(44832011)(316002)(47076005)(107886003)(83380400001)(36860700001)(8936002)(7696005)(6666004)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 12:20:58.6140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c18fea3-4042-49f1-efef-08da3d7fdbf9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5671
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
Changes in V4:
- Deprecated calibrtion support
Changes in V3:
- New patch
---
 .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml      | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
index bdb72d3ddf2a..de617707854e 100644
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
+      - const: "rtc_clk"
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

