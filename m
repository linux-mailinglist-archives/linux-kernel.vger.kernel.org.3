Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58E25B1390
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 06:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiIHEZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 00:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIHEY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 00:24:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A437A29819;
        Wed,  7 Sep 2022 21:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOaTF6jTgSouQ/Ft34Z3E0Vjtz1RpqOUPW+34OMy9gO12kvfzameD7HrWosKTy7A1cTYG0bbRLPwWUDUFXHoocX4YJlFj0cd8GDk+zHxel7wEZNYreoQszdsOps8PuztvFnFX7OMwLVeF0+DVbqLo4iXk0bVxMqWlJ5rCPpP6Ihtgs3IybALrM/kMiuUjD8ycahgCLQeRcUnf6bHzJ03ycb2BFfqpp1jXYt+VvQLIhUc1C/GOBUXC14aEl8HWvusCldr+A5qjLsnzBwrgxBPd67FhuDOp/2+OQcnKu4jG5vsJParBsf1hyiJzXZv9vEaiI3SUHvHfnVIf8YGe8cddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fRNrDBjU+Xi6Q0mBfmSV7zV6Y0Nos7jIK7OZYoNHWo=;
 b=aexmZ9XcfawrZLNtVvMOhnyX4Z+UvaC95N7FHxD1YMwM7HDpmooC4jOpnzChmIgTawh0A387SUGXFv7Sz26K+hXnDG3xF3E81PAZP7v75v1E7DHsMv0mTaCTasAo8dIMhYRAK8wRRdbaafNV+0eQlp2aPvVcENme59wRTrwmZb7H0mzUt93y7Lp7ZUOudkJkq5oYDOA+jFMxLAB/QwSDaxPmNf7n25t211DwwnG0dT1PSeCogD4XsoYyLI1FmwhajhPErdHFV/CQAWdq50/H70GTPDD083j9q1o7AMjeGHwopz8O6YkTCTJE6gqKhcoSVimZv4XUAUokcKZ+2X+y/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fRNrDBjU+Xi6Q0mBfmSV7zV6Y0Nos7jIK7OZYoNHWo=;
 b=HrNs8aWIE8wk8j1+J8wYM5mDPQ1XINUbjcQHbqEhVg48kmu3J7yyxUoHC+4QV/6lfuW57lUIwvVnAUvgnN1/WgTOEWRR3n5a3Yn6vkGyoxIhjrvynRKs4xrxumESMeR5DV2qb3C4vAi8/1u4GmjjlaCEcg00zlpNMncFlVknVoQ=
Received: from DS7PR07CA0010.namprd07.prod.outlook.com (2603:10b6:5:3af::29)
 by BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 04:24:53 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::99) by DS7PR07CA0010.outlook.office365.com
 (2603:10b6:5:3af::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Thu, 8 Sep 2022 04:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 04:24:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 23:24:51 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: misc: tmr-manager: Add device-tree binding for TMR Manager
Date:   Thu, 8 Sep 2022 09:54:41 +0530
Message-ID: <20220908042444.2866731-2-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908042444.2866731-1-appana.durga.kedareswara.rao@amd.com>
References: <20220908042444.2866731-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|BL1PR12MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b71039f-eef8-4be1-6fb1-08da915213ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDSuSOQLEvR5n8cyoyNRlmKrtTddaj729zYln3joNp24uPbDOaNcyJDC6iH6UakK6ymzgNq/NkT6aUzwhX0oaYH80tKqMiz9Nc7r+k2Ry74gJG4S5Nhr0Epf5Bi9do+9X4iDaXKMzXZ5EnI9n3lZZP9o3d46YFHyTwKp9Rev+T9wkSgHK0b1ZnjCuXiHWaSpAQSKL2qMmnDEuNrNdaumVLD44S+HLLJ6vbJiReTsypaKuBKCkTeLWbHvV6RqPJuyE6P7gb/5FGm1Xzv6bg32ncHwdmRV8fJzFXl+yr5azsk4WI85avFfGyG2OqqmVZNr340OGAE9j1Q1ofKukteJoMe5dMzVnDVePzxwLYR6q/d4lvoodW0CrMqA/N4ODK/IEFZWKOg3Q+DpbhjeMibUflmB3Go+qKcHJYTuQbLNL4Eod1tYO2cDe+3nxUiT/JqHl9tnPOGUuF+EqrgkyBaZdVWseSl/Pp/XwxNCF1DMbQ+WxG0rwhztgXOUKI9xcbt9oj3hBr+L4PzMw/UpaQm91bm9obIKZx+noztgBcXXfUB0IFsBJkxlK1NPwq8lIjarjD3vvATZ5RP25GGdfAvR9i6s7vHNryLvHhxB2l3CwIi/TUprMbd0yZQFNL0Olj/xrfd1qHbAghZkC6frXt8Q71h9aYCAYltRqVLlCmnGZkKtOMtSx8K+YYL4gGfBFj16lPdFibskGzbguOU+4SV6v77Bl6aNn0Irsr7YiI5j/ZP83ST8+gE5NzmVRYjoqLgMG1kgpPBfzugGcqckM7cgiltyIM0NoUC3zF76CkqO2Xil7KUa86rpaLimS6+wtOaUnVvsC2yvxAwV0sQtvveNQ6buW/5qLaf76RduU1Q7Y5SisNb10m+lLE3gBWoy+h2TDMrKSrNYSE3r6HBaezNgXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(40470700004)(316002)(40480700001)(36756003)(82740400003)(41300700001)(82310400005)(81166007)(356005)(921005)(54906003)(36860700001)(110136005)(103116003)(4326008)(478600001)(70206006)(47076005)(5660300002)(70586007)(8676002)(83380400001)(966005)(336012)(426003)(16526019)(8936002)(86362001)(186003)(2616005)(2906002)(6666004)(26005)(40460700003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 04:24:53.3148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b71039f-eef8-4be1-6fb1-08da915213ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Triple Modular Redundancy(TMR) subsystem contains three microblaze cores,
subsystem is fault-tolerant and continues to operate nominally after
encountering an error. Together with the capability to detect and recover
from errors, the implementation ensures the reliability of the entire
subsystem.  TMR Manager is responsible for performing recovery of the
subsystem detects the fault via a break signal it invokes microblaze
software break handler which calls the tmr manager driver api to
update the error count and status.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v3:
--> Added Krzysztof Reviewed by.
Changes for v2:
--> Added minimum and maximum values for xlnx,magic1 property as suggested
by Michal.
--> Fixed 80 char limit in description as suggested by Michal.

 .../bindings/misc/xlnx,tmr-manager.yaml       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
new file mode 100644
index 000000000000..27de12147a52
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,tmr-manager.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Triple Modular Redundancy(TMR) Manager IP
+
+maintainers:
+  - Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
+
+description: |
+  The Triple Modular Redundancy(TMR) Manager is responsible for handling the
+  TMR subsystem state, including fault detection and error recovery. The core
+  is triplicated in each of the sub-blocks in the TMR subsystem, and provides
+  majority voting of its internal state.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,tmr-manager-1.0
+
+  reg:
+    maxItems: 1
+
+  xlnx,magic1:
+    minimum: 0
+    maximum: 255
+    description:
+      Magic byte 1, When configured it allows the controller to perform
+      recovery.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - xlnx,magic1
+
+additionalProperties: false
+
+examples:
+  - |
+    tmr-manager@44a10000 {
+        compatible = "xlnx,tmr-manager-1.0";
+        reg = <0x44a10000 0x10000>;
+        xlnx,magic1 = <0x46>;
+    };
-- 
2.25.1

