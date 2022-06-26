Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509D655AFC6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 09:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbiFZHIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 03:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiFZHIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 03:08:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B2F12AFD;
        Sun, 26 Jun 2022 00:08:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kP/az+QVpEwR1VcQUZp8FkGsmBx3iafuErM6KQC+JzZyJSU1RQKbO4DNNQT/ogK1zMQ+UBhZzljPD8URKzLg8Ku3xJLkw6Pd/mgoGG9MLY7ygQCmikhCY6nGtWlDrTbsSxfWmIRmLNm1SAS6aOz9BGhzoXxY8rNqANZ4UvvY2NyArwoyi/e8sXDvMXNHe1zNOC5h7lR63kGQ9ssY7s31iyS3Iym0qEy6Z3JVm5EGoceOo15k0q8OLkaqjpwg5fm+pPM3CODnlLWyR3kG/DrO4MkUMdWL8bX3yW+Y9E1WziQhm5FIW+znu8CSK8Iv6y96RkikK/ppGaRoNdJrtsf2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGmINQICBnsP37Ka+yRHtTffsob9IUkB2e7BORWjNxQ=;
 b=jE+DxqPIXsHzgDMo68S47r53WHODnR7uTzmTPutVNimQdkLJsUIqrZUxuEt4KKgjQtqvFpc1g9hgr2JG+X25aAu0W6kc4qbP7qvhMmc43Obqo6bQSL8ymqNjPOYFIHpuHsQwdIU9Sm/sZ1tmkSvd0Wz7KtyfmC0jIqkJPulio22NgBAbqJQnEVCtbShbtVGSaV+ilVVC1RL+Bf3qvKrZcv2PLZIUEWleyvAg4h7y80o0fpV2FyOe5TzmaXBbeO3dTp1zJOpMMggl1RXciAYFut/92TMQ1FKP2LYfx+5qblqn1tkqY4oHjvpaEe5NFIBKJjebTL9ceH6K8ojP0hAOpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGmINQICBnsP37Ka+yRHtTffsob9IUkB2e7BORWjNxQ=;
 b=WWWEaW39qzZci8LgDWGD8pJ6VC6Ug0TsAjSWlYSIXj5EhfguHQ4K8814oPIySXYhP+i2bDlcZ9trTv5D0xmtJapNh43seil9aZnh2y1Nw0Kq6+3AEKbeus0wix2UvzfQTXODnt6Q5bcwdaacHF8Z7untHpPyZoUDEMhA4VnBlD4=
Received: from SA9PR13CA0068.namprd13.prod.outlook.com (2603:10b6:806:23::13)
 by DM6PR02MB6842.namprd02.prod.outlook.com (2603:10b6:5:223::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Sun, 26 Jun
 2022 07:08:43 +0000
Received: from SN1NAM02FT0017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:23:cafe::a6) by SA9PR13CA0068.outlook.office365.com
 (2603:10b6:806:23::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.6 via Frontend
 Transport; Sun, 26 Jun 2022 07:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0017.mail.protection.outlook.com (10.97.4.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Sun, 26 Jun 2022 07:08:43 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 26 Jun 2022 00:08:41 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 26 Jun 2022 00:08:41 -0700
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
Received: from [10.140.6.39] (port=59232 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1o5MNs-00061W-CC; Sun, 26 Jun 2022 00:08:40 -0700
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
Subject: [PATCH V10 1/3] dt-bindings: rtc: zynqmp: Add clock information
Date:   Sun, 26 Jun 2022 12:38:15 +0530
Message-ID: <20220626070817.3780977-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1b3385b-bf56-46ac-b5f6-08da5742b4a0
X-MS-TrafficTypeDiagnostic: DM6PR02MB6842:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3hHyJ9fmqhav5MZXjcaYwr/2bzJeRcYra/p4yEc9j77ssYdr9s9pMqz+pp5u5SWc/HhlUIrFbAlxFAWOHBaseRO/jbAttSOzJ21hRlnZv891Flk/+HHHXUqfFoLxQ/c5thRD2UydgUYEHoAhXS+X7oRBhaJhbfXrKmy2hAw6rT2DJmdQ/gJLrphpVOYb0KPpX1NbX6FYY+9xg5BRsw5QPTsGUtp5TOmFr6V/pDlJSNWE77ObJ3P7VNjvTw5waY1E7NdqK9lTpfiRYOSoDwMc82CoHrPpAKtPg4nhMYgjfknhnnTRbTJ6J3vAlOBfe8TvU4cv0abFDjC9E/tXYfRlQy+2ugaYgffYbKkIWLGV03UwiFjyjT43GOnW+fcuulFenMwpxEwoxmR61vrq56KY4No8dteMDdceNIAU9md+PApNbHnLTHkA3R0NCFXsTkDTpnyhnNfmmdRLb9vJqmqrn891XH7Q6InjR3GkSxBMtCXPvpImwmPBRvN+ZVvsWZhSi+n+lcNuHQf/gTul9oNtXdHZ9VJoFTx+ncMnhfCdDXgXZszhWNuH5VY5F0AKKCT1HgJ8+6K/vOX5U5a1CWPs4mb653D7aZZQYKRoBTv+o/UZQyIopbfAiAW2msMngyH0KnRAIQrRIzE1tFsOj4kAKW5xc/nT7xQwrBrCXhZRmFqdM1fzbkgnZ2Zx5lBIfSj1QJ9aw9MhH+spMdUHbaJ/6Xi0dDL5zb5/fBDsNppw2moOMPZ2T/FLv7HglnGLsF2jx0Det/fdGdO6baoKXXAMswX2My4XDPc3QqoDDew4Ukyn40MzjHZXGH/J1BuoxSKAycTBBUOXi5pbZ3Bpia+GRl49pmnPWDJgfDX+7cYIQM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(46966006)(40470700004)(110136005)(2616005)(5660300002)(36756003)(82740400003)(41300700001)(6636002)(6666004)(2906002)(47076005)(336012)(316002)(54906003)(186003)(426003)(40460700003)(82310400005)(70586007)(70206006)(356005)(83380400001)(4326008)(26005)(8676002)(1076003)(7696005)(44832011)(7636003)(36860700001)(8936002)(9786002)(7416002)(478600001)(40480700001)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2022 07:08:43.5298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b3385b-bf56-46ac-b5f6-08da5742b4a0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6842
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
Changes in V10:
-resolved dt_check error.
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
index bdb72d3ddf2a..7ed0230f6c67 100644
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
+        clock-names = "rtc";
+        clocks = <&rtc_clk>;
       };
     };
-- 
2.25.1

