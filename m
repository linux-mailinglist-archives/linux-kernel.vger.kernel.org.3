Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC6B57B0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbiGTGAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237825AbiGTGAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:00:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D265B52DDE;
        Tue, 19 Jul 2022 23:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcQgbH+2TCt1hNY3naj71rEMOv3EZ/Pqr6A94/u39fiAYCqkAqrMPfVNFD3jZd2Rqw/3iL5MYb4OJmneu/Oqvw1jr19hu9N6v440mBx5rnafhgEooobmk4fOOXl2XGh5o925yVs7jOoVHzqFma5qinxZCdc5kOHDgHeabFrhX/cpFuxG7y60GjcLFKhGPLS3AYko2NVbpzuB40+etfdqUYLreVvMJEu5ea6xvbLtdmbprfqx+UFR3S0/CprXpyNvE0WfDCPjckAS/NlYIW+5wiDLfxBFKdEZ20/JH3HjrHywUTGpvLJnIcR01abnWmazc/v6DkNd5DTBx/WuErTHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1wqlRvHM0MeQYt/N4LH2GlKqiKZFm/9QHpLz8Kfxog=;
 b=Lzi3KdrNX8o2ZlsabwnYKTDDyKB6FtjOpa5SMmOqywK2LM2N2UOii/CHLtbs3h65+6cFFNlJ/yHzo3F5UnvRD5GYePWFqwe5jROr16lTzUrssHJMXWTkT3PKZ1hEy8RLiFQFhNfmZpFipPhvlKfKSZhtS4lU3CIQB85n9mM8I4Drejfam2ea1wi3x+L6IgjcwoHg5vxored9DbpR0A9qatnXmuzgcjk+KnVLX/5NBPeVCJFF6wEiq2fSMF49MnkkGHisKCRuH8H/TADZ5v4IdevxO3lfJwp3qW8LDErTeQbiIJD6DfUu3E+0zUJLhjs4MPhvFMVdoT3I5kxDiL748Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1wqlRvHM0MeQYt/N4LH2GlKqiKZFm/9QHpLz8Kfxog=;
 b=gJuEcECSjgYRnZKsLrC9ag5aTf9cQCNlq6W6Q2Zc/Rj7Pboj25qoGidgK5vvlU7xjhXx2qn9KS8auRGQtEgAVBRgVMug9lYECl/7lv4i+mzCcrPIRMBCMEMzV6cJKOEI8aIoGditl7Q+nXpjxfrAxDaVPnYU0rBQ8I0MM/JC3NE=
Received: from BN9PR03CA0592.namprd03.prod.outlook.com (2603:10b6:408:10d::27)
 by CY4PR12MB1496.namprd12.prod.outlook.com (2603:10b6:910:10::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Wed, 20 Jul
 2022 06:00:33 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::55) by BN9PR03CA0592.outlook.office365.com
 (2603:10b6:408:10d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22 via Frontend
 Transport; Wed, 20 Jul 2022 06:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 06:00:33 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 01:00:31 -0500
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
Subject: [PATCH v2 3/4] dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
Date:   Wed, 20 Jul 2022 11:30:15 +0530
Message-ID: <20220720060016.1646317-4-appana.durga.kedareswara.rao@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8fb2966f-88ff-48fd-843a-08da6a152889
X-MS-TrafficTypeDiagnostic: CY4PR12MB1496:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1SJV2owB5jqT5ViGBIw7TrKyGoo/3eTKZKAqnblCF2Nh0CDbnNvKCooresJ+d3vvN6zpZqSZEyS87xKwz3weUz2Gq1CRvYkqs3rEoSsT6bfaN7r9U0FADxt4k0pRw7oMriHlywKhSj7j7c7voJsvoI21+ZhXeOQws0b/Ttpww8O9guEHayA/Oi1qlg5oknCOJHYVgEhT+mQrlQ4Wcg0cOhmwnWFPRDwbJ9F333A16QGbBlsXLgxx3BLjyE445a/jAMBqpYRmjv1kHMNcWRowY1LIpij+MmfG98VFYWqgGYYWnkhL9/UpKb2L934D0wn2wOYfvyZizBlvgYY/r3ldosQuPgd5aowirEV0Rr5gbf4AjSGTxQ/ly0Gepd+pYtIuy5xSr0ir9g/aBf6V/K8ndAWoP+GNWH9/gKneCYGm/R0fKzV4TklRQNqrk+9dwceDVhPyF9SIPMQP0RXbq1dnG9DjWg5+eDyCsbNxKT7WF1Ra7mmnd4rpmZZMXgcr8xXsL1l2UtZfM6m7XWDwn/YUFvQLimeVP0kNpiawoi9mRAxN3VsPrSj4fTB4J6kXk5QxKJ/77G3TsPF1YEaLy9xqHBAkMDtDAl2t+ilZfl0EjroWlFiNn21ziPOW54BBZR53GdIe+959n3WqcDatQo9Ev1wdkzs1oIGZoE5lhtnuRLour/o/yQpFzmlahZHm/0CiCrw9pcOu7gnlZk3mztgY2R9BCy83TcnLm+BV0U0MnYDRvr+m38lytzlXPtE4RvPYttPiDAxZq8e/J6SFunyQO0Rx3bSNieHdRkUFHO7hwRI83KNtkRosfTyw6mZUBBRNwJBnWxe8FvbJpKrDsTJeialHOtxHJCqNpucAKl2tEuGeHZDn1XE2BD9A8qk73duh0ia8ZLAEWAqwtFccqdlVzksPZyjR884/2lzi613RDE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(40470700004)(4326008)(82310400005)(8936002)(8676002)(36860700001)(2906002)(70206006)(86362001)(81166007)(70586007)(5660300002)(40460700003)(83380400001)(107886003)(47076005)(2616005)(186003)(16526019)(54906003)(966005)(356005)(41300700001)(336012)(110136005)(6666004)(36756003)(478600001)(316002)(103116003)(40480700001)(26005)(82740400003)(426003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 06:00:33.2523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb2966f-88ff-48fd-843a-08da6a152889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1496
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

The Triple Modular Redundancy(TMR) Inject core provides functional fault
injection by changing selected MicroBlaze instructions, which provides the
possibility to verify that the TMR subsystem error detection and fault
recovery logic is working properly.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
Changes for v2:
--> Improved description for xlnx,magic property as suggested by Krzysztof.
--> Fixed style issues (indentation of example node title description
etc..)
 .../bindings/misc/xlnx,tmr-inject.yaml        | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
new file mode 100644
index 000000000000..cb14ea73fb4c
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
+  - Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
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

