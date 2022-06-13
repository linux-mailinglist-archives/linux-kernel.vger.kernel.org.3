Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0043B549A21
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbiFMRf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242045AbiFMRew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:34:52 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4912DEE;
        Mon, 13 Jun 2022 05:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYhHLNSqQpbGxJoHzJXqWRSOUvxnoYg8bSGP554IV/UiuU9pSMrKJy96zHpG4E9NZBJIj9QfR1D+lWewk0iWjXhuxGlANTOJuaCk4VPuHTHTmSoQcuVRXAUuk3rTR72wwMRRuTd6eGciSeIkioWXQAazVlPQH3HzsGaz+4QrJNr95tkUi5JTS/KvrI0XfDeoKrVzAyH1BQQmpJbFOxiLglBDzpHbpwtIblpJ76RososX63VlXD1slRNroswsAbhLLUmFvNLiMKld45xGGWz6c+4zJV29dp15snWll/n1zQ6mG2mol7nSE6dRo8ARcXx/26q/q5vQkR5MoiusaIWlSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M9XYx+1ZYRNmofc9ryGKkuwenpDUaE0ciZSljby7EE=;
 b=GdybdHgZyCio30EsYcQBuH97M0dtdUoRjKvkfFs6ZpY8tP3q4RuUxTxeVsZz5e87zEVcRDuessbYSdN3Iaj3/y2S0uF0tNYp3Ps1nXeu8WiAXwVaL14+k/URG89+ImjHgxkMvuCC1SX5CwUTv3hyGUCGR/Ho5npaIJ/qSOWhPjB9WCFyYxRlk3kokBZ+Fitw4en21lAhMsuedFx3VBuPkto/tRKZ5I/1dDB7OXTP0QB7TzfYxWVNqnsqfPX7Txz3dATknWt6n60aHB23z4H8pK5QIq7AmrPAfOUacVuOrTrJEoHZpYQGJEBYlsghfi6Ke+bFI5DLqphp1khHaEu4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M9XYx+1ZYRNmofc9ryGKkuwenpDUaE0ciZSljby7EE=;
 b=XcKEs7GDJac7mxFx9rcIx1Y5EGrRR8in+A9hSm2SMhoBWgaGo8XK6txiwlsyHCuYvfzo5Rcnj127loPoXPgdHlhJBThZRg4DWxeY1JzVRXKXXMI0qwQ4IFmZ+SVdoiwJFA6ODZWeMtYK8LybpyP2gIPQpqBQZzu3voAIH6kQZaY=
Received: from SN7PR18CA0016.namprd18.prod.outlook.com (2603:10b6:806:f3::20)
 by CY4PR02MB2631.namprd02.prod.outlook.com (2603:10b6:903:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 12:58:49 +0000
Received: from SN1NAM02FT0063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:f3:cafe::2f) by SN7PR18CA0016.outlook.office365.com
 (2603:10b6:806:f3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20 via Frontend
 Transport; Mon, 13 Jun 2022 12:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0063.mail.protection.outlook.com (10.97.5.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 12:58:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Jun 2022 05:58:48 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Jun 2022 05:58:48 -0700
Envelope-to: git@xilinx.com,
 a.zummo@towertech.it,
 alexandre.belloni@bootlin.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 srinivas.neeli@amd.com,
 neelisrinivas18@gmail.com,
 devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.39] (port=42756 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1o0jeZ-000DQD-DM; Mon, 13 Jun 2022 05:58:47 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <sgoud@xilinx.com>,
        <shubhraj@xilinx.com>, <srinivas.neeli@amd.com>,
        <neelisrinivas18@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH V8 1/3] dt-bindings: rtc: zynqmp: Add clock information
Date:   Mon, 13 Jun 2022 18:28:34 +0530
Message-ID: <20220613125836.523449-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 999bab69-6414-43d2-a0d4-08da4d3c75ac
X-MS-TrafficTypeDiagnostic: CY4PR02MB2631:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB2631D507D1F2CCADFB84165EAFAB9@CY4PR02MB2631.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWvZhUusqYupujCTjCjJT9leB4rLSftq3wR8/CCWqYdsicZ+T/D6BNul/LlTYagMqwRFGE9lfrp5NIDd5B9miJzywOS6z/i4UwZ0DO1MdqqNpwMJqnEd024xKRoEbd1ubmS8ye7CzgGG+mmiNqWyStBaZNACErU7Qx285Vs9Vynx2QtJOPYliFHYSNThtzBU8h+w8fsZmsPhQt1+s6LToG4KX+q+fbpkI46CPauQOixZqO57vTBcRZ3lqkYUE6x0dM3q7Ih9GYtbaMASGM13MtMdk2IIkreINASodS/dYavNobudrjMvrFSOg2JytXX8UUhj9bDzWbHLunadEGaggFUItjZOGhx0Tn0eKjnn7LBW1axw5kH+Qq8nuroyRjkzC3L8ArqF22CgwPoHBoH40BXaoj4PhYl+OtWF/EF6tL7Kr0rjYhL+OlBcQrd2+VBbv33KE5hj8VM/IKeiKyx2xjKJiMXzf6i0IvYRDGBptkn1wWKkxlS0EVyahrbVaLEuL4IeBZYCSEX54DMbobO0rba1gq97X8NiLmPh0KeczNdpHhDCbHpr9i4FXicnMe3JsWAyesgPk0zUllXz2V/MhNtiODvl2S915o+whvOtlgyJU65pPO6xjk1S81I6OeRsavCW/6g+YLuImqVUGqqofq9bM1mAHVvpx73/gTB5qv/DiA9TX/PoiosWHQAB5Bn5yGvBX2fkhAGsErJj6OsXQ/6kABQSQp3J6HpYpYCw//Y=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(2906002)(8676002)(508600001)(4326008)(82310400005)(36860700001)(40460700003)(54906003)(316002)(110136005)(6666004)(70206006)(7696005)(70586007)(26005)(36756003)(2616005)(83380400001)(186003)(1076003)(426003)(47076005)(107886003)(336012)(9786002)(8936002)(356005)(7416002)(5660300002)(44832011)(7636003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 12:58:49.3189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 999bab69-6414-43d2-a0d4-08da4d3c75ac
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0063.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2631
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
index bdb72d3ddf2a..638dd1d8bb26 100644
--- a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
@@ -23,8 +23,15 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    items:
+      - description: rtc_clk is the operating frequency of crystal.
+
+  clock-names:
+    maxItems: 1
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

