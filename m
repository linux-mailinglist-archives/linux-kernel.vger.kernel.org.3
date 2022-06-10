Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C555465D8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348875AbiFJLi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349072AbiFJLiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:38:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AAD72E0D;
        Fri, 10 Jun 2022 04:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlLnJUAQlsz2G6a40UiH/Rz23aBWq/pqqVsQ1y6aXWqGdj0xycdHJlhTtPQ+tL/K7nx7T8tZ5sXDQP/nLvBijg3mv328S1hq6A+rlZxJpnCV6Wg166hm+ufZfqVKq70Vu636FWYbEwyPKW4YmTZMabVdFJ1J4SSqqaYpGGfDlvqRjaPtTMM6F1js7NlywmIyvg5uUB4TsbC+EBVqBZ6GIe8OKsJf1gHSAN9RZ0HCNKCH9tPON9VUa+WaU9NnYK4oWXX+pCG+9r8wZIREpjpIsws3uGuQmdxlA4Q1GF88pvzYoqRxYAmivucSknPWu7S/tiRuqmENPFk0uiU2PG5vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV1RKnpftW3nhmBaiz1zu2KZJstojZ5o5LgSt8WE6OE=;
 b=iwsZ+Pj9R3q2Fivsby0yG3fGO9k9MXLgIntdEfYhErRcMwjZVjoU1HJPnn0yifRWKYheDqf+VxPMRonxPBm3Ez2OnpiCabuN2o25NEX6VzjWK0ykTx43aId9TDJkRlmee9AYtpVVs+qsBcN8tiso0ssQfRAvGKp+BSy6hzavj6GKGA2vcPO94g9sIrn6/L5z8jN8nB3KTZtJi3v+gMdYdGyMTZBLbVZkhzYguvpt/LH6OcPPe1MmJexC7wb4d0RwrvEVq8FZjse84mpLCC6x+HAfLAN/y5vu8JoU2cW8WNZCZGthP2B1p0ImC/QoqJtmBcMWdx9QB5qFFONJ2QdWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV1RKnpftW3nhmBaiz1zu2KZJstojZ5o5LgSt8WE6OE=;
 b=OpwlGARx8K8mzv/ObKE+MKitXtwLva386LohTIr1e5SXIwE6fHC9byIbtf75br8pc7h9ob57rgzvYfv0LlyhFXA5M4OW29wNBEo5qY36qPqS570ky6YWnVIf8HK6o1PocqUy/ebomyCPGzEmql1PTOZhcffCYw6Noub5h3GnHXM=
Received: from SN4PR0601CA0016.namprd06.prod.outlook.com
 (2603:10b6:803:2f::26) by SA0PR02MB7450.namprd02.prod.outlook.com
 (2603:10b6:806:db::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 10 Jun
 2022 11:37:22 +0000
Received: from SN1NAM02FT0025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::5b) by SN4PR0601CA0016.outlook.office365.com
 (2603:10b6:803:2f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Fri, 10 Jun 2022 11:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0025.mail.protection.outlook.com (10.97.5.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 11:37:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 10 Jun 2022 04:37:20 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 10 Jun 2022 04:37:20 -0700
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
Received: from [10.140.6.39] (port=39538 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1nzcx6-0002aq-2p; Fri, 10 Jun 2022 04:37:20 -0700
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
Subject: [PATCH V7 1/3] dt-bindings: rtc: zynqmp: Add clock information
Date:   Fri, 10 Jun 2022 17:07:07 +0530
Message-ID: <20220610113709.2646118-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e262eb3-95e4-4a2e-e503-08da4ad59567
X-MS-TrafficTypeDiagnostic: SA0PR02MB7450:EE_
X-Microsoft-Antispam-PRVS: <SA0PR02MB745037F9067CBB05C5799BF7AFA69@SA0PR02MB7450.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNqOV6phavtYSumd8TOw+xuYaYfN+m63jtLdDPWoGw1GfuN7nEtvKmzc0TVmJ3Xlp/+R+6Fg+5ZjCCtbExpyWWCHNjg0jh7/Z2JsCH3sOA5onlvXCtrnUdb16bai3IZd76vbtO36CBbphQztn8Cbhbz1XmD7a+AmodBx/eFxMXuMM9sAbZEXAfdKtF5ASpeTsPZ/QG9w43vx2WaVvTxbaYKB5TxLAsiR2rS1SYg3JBS7Y/mYlaV99XeT0Ztf3FjygZF3KNjORS+ByeGVJiAuOl1XKEVzteNxhjf6YezaKXrW+RlTwmvf3CuSHaCEZ1DzeduciMJwBJ+9rtUZbwaatViS0DG1gX69awQj+pgqxdFz9tg15H5lzm6uUz4U0i9bI2g1E86TirthdukwD1N/JK+rmzRXsXEZuULHPlvmB/fMQRMOZy/dWb2VfnBNH2gV6TcHY2Ogewk/8fDvjagYYPPcqInAfEGyTJ1JQGwnE90e9rgQbzZY/4x0o2kgR7Ybpc3WioR/nnblQnW4pzR3CPGs5dFBeVIm8EdSZvHUTPTeyna+6sp5PTQr8gQkqZ/RMuOBx7p8gDevNJ2bFXrnpCVz679N0AK67/WhC5k//BRj+NzyQNhx6DXWAa7WZUyJ9PkH+rAY9/dQ3vW5OdKu0aS5oUX4GMUjvVjNPrtadAIBZCgvRdN62p+Fs60S5PT2WhG5DHi+gik8zWE/2PDjA4xRKYPBIgsD57h5OXkmIxg=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(4326008)(336012)(36860700001)(426003)(47076005)(316002)(186003)(508600001)(70586007)(70206006)(40460700003)(83380400001)(8676002)(7696005)(7416002)(7636003)(26005)(82310400005)(356005)(1076003)(107886003)(44832011)(9786002)(5660300002)(8936002)(36756003)(6666004)(2616005)(110136005)(54906003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 11:37:22.0668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e262eb3-95e4-4a2e-e503-08da4ad59567
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7450
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

