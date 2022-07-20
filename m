Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C2E57B0A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbiGTGAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbiGTGAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:00:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754F2564F3;
        Tue, 19 Jul 2022 23:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJznUCwdM2bAzuDnW6+2fw5kaYPySMlstNJ70HFIAmvaIJ66uc7aLOBeIGSAvcZBQ0wD1PX7zrYQmeMDZ7SldcYf7JZoQyncwIS1/HFwMHvNMo+8XKzMdpfI1+ehBDVn0wOudlvhMTbr6ynlH77ksaMRpCgKufZ2ikfEP9+rcsUTYRS+Q4xxva1OEp55+9yqU68SdAJc0GhZgRhMUc77AXLdOlB/JvtCUhXUGlp1oA4VCyawmnA2nImGOneg0pT+W61CAnOgKwAIosVQ0ubcrDO//l/cJcm2LR+6hNDX/GN5kqWU+1oCWl1l8z2JJ0MK3r20a7Jo1S/n8XlGDQTd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Uzk8XIyjiFQI42nXx+SVpQYdvrDFISfIMkLuZp+VI0=;
 b=YgPsWT57j6+LO6raD6B4KvkRYLpsOZfCUpH134TRzBkn6oDQSmEDphrWyqCm0Vop5I9ASC2/37lYTueby76Ki4fHvHCOFzNxAcsfjjjClbIrFiZ2qXeGF3LN8coEypEsqO4Xs8iunIBZCOID9lzeG+JNyjssEh7r7wk9OYD8GLTuRZ4uc8F2lumGcKR5/6FMpDgDWKc4kqnPlfbb7361BeA0tOR7eRVuoaNVP0ifUBYt5r2EX8Tr9CV/2A0YkQYVPDwPg8tRArByY7F8dhm4cvStryQCFpBoo9TyS7zCxZdFRSrpgJXwOI6mv1UuRgnw3mjYXspLVpjwfuFy8XpG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Uzk8XIyjiFQI42nXx+SVpQYdvrDFISfIMkLuZp+VI0=;
 b=2+grspr+YcSNdTDD/8zsD3T1GLgSeHfdxUtOB2Uvd6IfArG6cXXpkEVdx2dh5028dr3R6sntgEHeOPpnCj9+hWPXv0gUVAYBVFGbsTE0NyU8EpzLsEIlTH0c86Dr2vRUD1yhPgbpuqWLPSXFZPDsTR/BjVRx9MXsMXp2vYB+8T4=
Received: from BN9PR03CA0473.namprd03.prod.outlook.com (2603:10b6:408:139::28)
 by DM5PR12MB1305.namprd12.prod.outlook.com (2603:10b6:3:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Wed, 20 Jul
 2022 06:00:29 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::f9) by BN9PR03CA0473.outlook.office365.com
 (2603:10b6:408:139::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23 via Frontend
 Transport; Wed, 20 Jul 2022 06:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 06:00:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 01:00:23 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <appanad@amd.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v2 1/4] dt-bindings: misc: tmr-manager: Add device-tree binding for TMR Manager
Date:   Wed, 20 Jul 2022 11:30:13 +0530
Message-ID: <20220720060016.1646317-2-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
References: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a938a8f-1752-42a6-68d2-08da6a15261c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1305:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlsaylSt2Net2HXVIYzgxCYAqK3J2GZBQJDnDZuKdWfGZR5jqe2kvSynGE9nzZaSGyUbfocrTOhmBYC8l4GQHkzkTeTd7Y36+7h0oZq/hDcAmaJwopvSRlXyeJe0/mELcN7QhKkTrQ954zGNHfENufL6pFTIyZeBx6dIzU7FCcqUi73/9Y9NcrUiEs2rsICLC1IUoJB76OJjN9Pht47fsrTQwy3Wglg9sgSgz/N4G3pG3/FcH3ODyNQJbcdpuoonN42MYPucg+mBRKcaOrcrb2O487/ERzEZuurCK++VZIDbvT6M/8qwxUXOgeVyoRiG7IEDR0xTBRkApxhx+5kYW+PY785W/sp9Mk8jjnxufOzMsbgyFQkemCWMk1puzlnAvQbKpLrEyurN7yvogW3aAY9b15WzUmcModjmq9GJIlIHoZypVOUSf6uPoCUPR7rzxn9puc+lQZMgysrJVgD0EG6u8Cm3IwwgoVb5Uepnf4zMesvF3IzHAIJ+gAYswuG1/dgeO+mAvdyuYJsFYT/loj856C4cvoGhZyRExHaTgwFmJyKJa1ie/l1BPKenW4MsPVfJjwPyO3Aj2G5JuWWASGAXfyYOO2S0WQIBDJGYjchht07Qmq4SvR48U6EGZmvd1CE2V2mRdTXjAXpxExN+GuwBSzCD0lTxkGScRGNwG2Xfl5dhy4rnWVLxm3W57M18HMCvU5VMIDWzOHiOh58rm/L7crf27hAL3SPhcaGt61/mepR4Ek+zLXBOTQFzGawsq8zNxpm59Q8BWJboQBzdoEn5q4PBhGs2SU8Wwrwa/5VV1O0DTsTDLFPIQSn5y4NoYvwJS/EUxl+rCI+ZY9HFDgKJrECrFiWeLy5J2R3ooA6HBKghc0ki2bDZsVmu7FOdokukLb3fwtDhAmSmlc3FkHlulE/lpzlBv7OqvnFDvpE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(36840700001)(40470700004)(36860700001)(4326008)(40480700001)(8936002)(316002)(5660300002)(82310400005)(54906003)(40460700003)(2906002)(70586007)(107886003)(16526019)(83380400001)(8676002)(70206006)(36756003)(356005)(103116003)(86362001)(41300700001)(6666004)(82740400003)(81166007)(110136005)(966005)(336012)(2616005)(186003)(47076005)(26005)(478600001)(1076003)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 06:00:28.8694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a938a8f-1752-42a6-68d2-08da6a15261c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1305
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>

Triple Modular Redundancy(TMR) subsystem contains three microblaze cores,
subsystem is fault-tolerant and continues to operate nominally after
encountering an error. Together with the capability to detect and recover
from errors, the implementation ensures the reliability of the entire
subsystem.  TMR Manager is responsible for performing recovery of the
subsystem detects the fault via a break signal it invokes microblaze
software break handler which calls the tmr manager driver api to
update the error count and status.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
Changes for v2:
--> Improved description for xlnx,magic1 property as suggested by Krzysztof.
--> Fixed style issues (indentation of example node title description
etc..)
 .../bindings/misc/xlnx,tmr-manager.yaml       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
new file mode 100644
index 000000000000..f7e6ac1d5867
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
+  - Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
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

