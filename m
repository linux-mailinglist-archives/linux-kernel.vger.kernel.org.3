Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DBD544E64
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245050AbiFIOJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244977AbiFIOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:09:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FD86EB16;
        Thu,  9 Jun 2022 07:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Urh11i+ZEozl9guSRb/lXWsohydZTUhcmEQ8OtCPc0n4TLnKGQaCT4H6P6NLQN4DyP0Zp7INWAcyaRp+R5nl2ttdqHrQpjKad9xmCQwqk8jpdFTlTfMxeRUlEdvAhMvl/nRwMSXQZ3g7cRAavk/qS+AROZAeNXrNYbc4NCpc5T2ydwZRercD2R1vXqIamXBW7mgTe5ebl60krqj599AGIts3171S116TdsUz+POQ1dmqEsN9uhWiYihjWOAiW+WmHCfsOWCDVpKxLp+hcNDw0pt9T1JOI9MRwHOHSqa1cKMcewQ0mQzMU7sqKFra0kBxuvITHh9xo539M0+BAKgInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyUfGslklbNd8KuGHlItuCW6J46vykdY5dAsSI4P060=;
 b=KfTA2iHtAduixMv7KOPsk7do1+q34bXdWN8L06D7OPIg+oxN7r6aNIThSt3whgy/FM9Syv7w8Q/4OaYtB4fp1nIaeDoE0ajsILQ9iBy0jkNtdQV0U7dhxuZFdHsNI5YB4TZ2lk0ySqs21wfq72zuhtpa4ky7l/h2Kc1CEg24Ijy33hwfDaKuM+eWUc8iUuTMa/pXnbGfAYouIVGFaXRyNQcl33iWaU6F1SDanbUZzJUjISbhUdywp99DYMDeP8Acwq2TXg/pkBRfq9Fc24M1Mn8eRshHPxMQWDiMa0i0jnWlpdHv2bj9zn94ofcehrWR6G7hjZNt4mlPs2ZfCt3Tag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyUfGslklbNd8KuGHlItuCW6J46vykdY5dAsSI4P060=;
 b=opsZzSQ+0or1zSLjQyGdLywNDg1bnuvbDm3bVTea1A0C2cDRy9iez3+Yc7uePMKaq3bx/8xMZokMmryuvh1Wk7u93cfZM4uZYHjXQrr5VHhrPwFIYvFv1bNOM1fwGpcSkAGPY/k2rHXzaFo1mbwgFOjUTS1k0KENG2Q7/eGYWjs=
Received: from BN6PR1401CA0002.namprd14.prod.outlook.com
 (2603:10b6:405:4b::12) by CY4PR02MB2406.namprd02.prod.outlook.com
 (2603:10b6:903:b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Thu, 9 Jun
 2022 14:08:56 +0000
Received: from BN1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::78) by BN6PR1401CA0002.outlook.office365.com
 (2603:10b6:405:4b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Thu, 9 Jun 2022 14:08:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT044.mail.protection.outlook.com (10.13.2.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 9 Jun 2022 14:08:55 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 9 Jun 2022 07:08:46 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 9 Jun 2022 07:08:46 -0700
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
Received: from [10.140.6.39] (port=38176 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1nzIq5-0001FS-MU; Thu, 09 Jun 2022 07:08:46 -0700
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
Subject: [PATCH V6 1/2] dt-bindings: rtc: zynqmp: Add clock information
Date:   Thu, 9 Jun 2022 19:38:32 +0530
Message-ID: <20220609140833.1784738-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8c66ee1-aeea-483f-8fb5-08da4a21976c
X-MS-TrafficTypeDiagnostic: CY4PR02MB2406:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB2406590BD1909352B88095C6AFA79@CY4PR02MB2406.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bAELTAoCa5oZrJy9X6KXLDHetKccL+HeaPP2ZyM1PGzOXaK/IFNCRoC5bqN67tBa+/WD9nt3+8t9DT2OtIweCygMvFtFniU/8a36/AaMI7srbLoW7199nOADZI9QUfKKEpNZPAZLA0LmzmhR2snDcb/ILaCCV01zQVdNzj2jqAwVG8zh75o9wz8ZqhbIofkQkjWTdZ5SA65pG1WWjm324EIynIfJo25XKTUXGdHizvoIJ6v1CuXz50L2ELtQuEqDGWEhEhSaePgJknk+IBCbPfG9GgzhJsB2B4svnOOqP0/J4HznLMkttIsQVm56cdu3WmZUMOF7q22XqdnBTrhb1oRphQ2TmIg9Ac6ofrqLId3kA/+pPxvEZaJHZb54yL4A89b+7lx9mxFUheF6YvThhSObmNgvPibuaIHzsrelRq1C0dXe/33T3+yUexS2nnchML/+PUZexIuQGvPsz5GUoNgmkZGUDOK7E6TI7NvKDHDKFXwqFVUbeg8OW4OWQZChGDTs5H+Vo8b9StmWgb506Bq3/u5WOdQw4N1d8/NUtbLcfXoy/6tuaJyOGLI+yt7BgtTgEGnRweh5sNvn+nlCRI5hHgBpUQob4MwTLpVfVN/Soz4ihz1UhvrfIL2T4yAxKiTrPTNsQOiL0czUQWNE0mLbkfmgQkjtRyvlkoOVMt+xB3DXXvw26LhSBM9q1NqtXt2xr0DaCeeIVete45YlDJluBudAvz3C6yhd8bS49k=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(186003)(5660300002)(107886003)(36860700001)(2906002)(4326008)(316002)(8676002)(70586007)(70206006)(6666004)(83380400001)(7636003)(7696005)(44832011)(82310400005)(110136005)(336012)(47076005)(40460700003)(54906003)(9786002)(8936002)(26005)(508600001)(7416002)(36756003)(356005)(1076003)(426003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:08:55.9790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c66ee1-aeea-483f-8fb5-08da4a21976c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2406
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

