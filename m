Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA66E5B13B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 06:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiIHEZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 00:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiIHEZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 00:25:11 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF573F310;
        Wed,  7 Sep 2022 21:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egJPf1JQ6pQW2SUOGjUSbICkD8oKYWfLNU2qylfueWdANxyjVMPW4DPuFbpIESCEHGGJ9TEsVxqgqkBNsKnyyxK/+FMrFLZxFmZTl48+cGaXFE+iX1+T5uHODCzDC8yCrGPx1XMqEsEeewla6Q3c4TqmFb/ngqc131JyB7iPbt+eV0OnZLOJSw/ejr1T86QrWGme1YUOe9X68qTM/UlYfjAEOj5Pgdc/WMHzIZRLRLjg92GyjoAX5f/zljFdLGm0F+rzAm1u941GMw4jI9dvHbsdn9MRF4WqE4dG3h8l8NaXYlm0EWwVRxE76sinLDoaxeODqNNNEmBjOmryrc5f9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNgq/gBjrIImodgMAj3hp+1BRtrQtN5eg+MQh5MhSSg=;
 b=NibHLuEa1iCT5fALIQknuiyRqjIeQnNhfcRJA0IYQUpLTc0Hauo0GWUZUZ+HHknGW4FHsLC6ze2q+s4/0ypLdBVhAcNgGFPQZfsAV7IImZN/4yqeedXh4xmMaU4EqbC89XnH0VJ0rYb1ZBIN9O/gHtfY6tIXC/FRhS7E1Fa0o8NqZ8SI8MXVH+HnZA+SMgQzlWezdWNMzihWYADOsAxZd5JOcq3HNmwxhv/0q4udeaK59eEzDD8b+TzNbfn7KdprLPl0NXjuBEbIhh3eANPzTXSYNLRNDe3t9wLvUzAr3FACBR7rJgoDopi7oZjnU/l3L/L5MZ/i1/GEx/AasrwSww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNgq/gBjrIImodgMAj3hp+1BRtrQtN5eg+MQh5MhSSg=;
 b=kw9M1kzmMkUMyumNpA2io5IDW4+Vx7OFNUJykkmp3aOXaZLrmXE0ZYzZ9yb2BzmlCAyzEVjbiWve/xHsL1Ab9HaqOhoVicw0dYoeXpA2l2IPMt6AYcvp8sL/UTOZ/L7YJdUsQyPzO6mQhvE7EeLblovjvIoFSIqS75uawOM6UYE=
Received: from DS7PR03CA0252.namprd03.prod.outlook.com (2603:10b6:5:3b3::17)
 by BN9PR12MB5081.namprd12.prod.outlook.com (2603:10b6:408:132::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 8 Sep
 2022 04:25:01 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::2c) by DS7PR03CA0252.outlook.office365.com
 (2603:10b6:5:3b3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Thu, 8 Sep 2022 04:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 04:25:01 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 23:24:59 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/4] dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
Date:   Thu, 8 Sep 2022 09:54:43 +0530
Message-ID: <20220908042444.2866731-4-appana.durga.kedareswara.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|BN9PR12MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: a8181405-0bfd-40dd-2958-08da915218f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWovrFBEaI19AzIW0L9R1RtqDgNj/XjG8n6Ru6pdqbIPb/YmOunL0YYgyn/D/crG/mBTf34hL1JOBiFmdVabUVqX1XuEdyRaJmPjyAOeelMgt9lytJJDESuajPRYrKpuG+r4IZSkRR1qWKmIZ/RrSC7b6U5i2gSL9X7ltc8e2hJ7nsMasry5ljbPEpgV9qDXG9RVznpDvoHUlwLuUEAaaxnH2XTr/VeZkmmpp9+zyXi3BAzsDxpyJ3cTigDlDT4tugXHW50Nvh40EeW2lXM3+dwEHI1kshsNHvJehj34Vs+mNynjQsQThh7VhzekMSg80OtRsKs/1q4nE6af8SZ7ro5Ul0Z30YKhQ4XvxYGpQwZ6tOnYhiWfl8J0rm/iFUe8xtdYdlt/Hr3nhBi6rQ4Q+xc4QcW8wmBt/HF/+ai9/NLfhkjViBSCcmGRSDPBSAHV8EXeYWPeOArjchpRfCbFYci6cbuwp+nSTZ+wVgD3dsZ513HezaHPh+PEDG8uvSIfCJkaqHW93AeY3vqCsSGoqFnPeWF2noHRQUpDp6THOBAphCH5g4RNUM5S6BorEtvo9tDD4mF4Qs+QAUIa2IF5njJ+W5C+tFu+Tc7rhy8ECgM9K9+2KrQW3Dx7vmbtrr6pegeJK/DxgblWvrDbWKyv2tRFAvAvAvbQmcoHWEakNHvL2H7u1cMKh3wUtAKwv7ck/tXY/CJgGgFj2qCiKrDtWULzKWbA9T7F4UNTkknJ2xEfy8KQw0SdITPQMFAxJtKsuWO8n3byoDY6o/k/4HJ4QRd/gP31aw1tWijzS4+ud4FmO1IKDyj+Vh68ZCMDoslhgVwvqmrm28nTX2eelsi7LfRdo3KyzCgCQRw52edIrTkHUb+QsOLPtKvjugCYMz6/59fTqEXjSo3qa02U1dzbSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(40470700004)(46966006)(36840700001)(41300700001)(1076003)(186003)(40480700001)(6666004)(47076005)(478600001)(966005)(2616005)(26005)(82310400005)(81166007)(336012)(426003)(16526019)(82740400003)(86362001)(921005)(110136005)(40460700003)(356005)(5660300002)(83380400001)(316002)(54906003)(36860700001)(4326008)(8676002)(8936002)(2906002)(103116003)(70586007)(36756003)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 04:25:01.7056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8181405-0bfd-40dd-2958-08da915218f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Triple Modular Redundancy(TMR) Inject core provides functional fault
injection by changing selected MicroBlaze instructions, which provides the
possibility to verify that the TMR subsystem error detection and fault
recovery logic is working properly.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v3:
--> Added Krzysztof Reviewed by.
Changes for v2:
--> Added minimum and maximum values for xlnx,magic1 property as suggested
by Michal.
--> Fixed 80 char limit in description as suggested by Michal.

 .../bindings/misc/xlnx,tmr-inject.yaml        | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
new file mode 100644
index 000000000000..1b6020e4ec27
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,tmr-inject.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Triple Modular Redundancy(TMR) Inject IP
+
+maintainers:
+  - Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
+
+description: |
+  The Triple Modular Redundancy(TMR) Inject core provides functional fault
+  injection by changing selected MicroBlaze instructions, which provides the
+  possibility to verify that the TMR subsystem error detection and fault
+  recovery logic is working properly.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,tmr-inject-1.0
+
+  reg:
+    maxItems: 1
+
+  xlnx,magic:
+    minimum: 0
+    maximum: 255
+    description: |
+      Magic number, When configured it allows the controller to perform
+      recovery.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - xlnx,magic
+
+additionalProperties: false
+
+examples:
+  - |
+    fault-inject@44a30000 {
+        compatible = "xlnx,tmr-inject-1.0";
+        reg = <0x44a10000 0x10000>;
+        xlnx,magic = <0x46>;
+    };
-- 
2.25.1

