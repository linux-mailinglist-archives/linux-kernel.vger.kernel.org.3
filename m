Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CE553FDD7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243136AbiFGLrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243100AbiFGLrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:47:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F9110F5;
        Tue,  7 Jun 2022 04:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEmPIqcJ9CgUZ51lxiheF7hcRtQeBoCjP+31Qj/k/0QxcjSdV78qNADFqgFjwvJ38MhZSA4zEF6uvVdkVu8TKlwzCNP2Xm9R1nnUgkxwsjp9BXFGGrfPZXZg517XTgAJSldweKWicWbjF/uy1JZ7dNLEGp0/F487JVRtBLTxvnBhAWQHhpDyxkwgsQn64kkCz2LsbOC44xi2AdlHmkrKBhZkNY87IPDDVjlg9tm6XVb1z7qhaEylxS9TXNLPQ2dGVLbjPw0f+qJd9Vgzd5R6ItUC0ntF15Ekx89zJ41FBb4lSw0eFmEWGiv60olwoACBErxwU43XffC36iVkzVZRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Td+9tEcH+dtpGWGs5tJDzJMA9ZxCvzhaeEN5GiVi1Q0=;
 b=PUnB20CVYMlkHD0kLqC0Gue8ufUPMwdmaEi1xke/wP7foQQ4uVBoyz8NA7Kpq4oBXG3p8bFN3ZdesRrhQiGhLNB7cPDkwa6MAABT2aX+XEMnyqAU7MDXloBndY5sZkH0/vdX2/Gk9Fy7dcu9e+ATgeIiukM1pLEzZ1tb8w86b+HESnv1RovU6rqzDDxALpPPyXRY8agD82rLmmJ+HkDdPj8b8pfqyWUGG4etvzhJFwwKV4fCSU7LVJurvFkU14qPGjLfaokkY36ZMNoftu+Jc0qduRxtbmlkvLAo8mjcagcQFKBAfyP43zZHW/eDZeXjuXNGuZetEOaW3u1BCkoRqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Td+9tEcH+dtpGWGs5tJDzJMA9ZxCvzhaeEN5GiVi1Q0=;
 b=SZMrKSwYP2X60dKcb7XAsslg1/FIIX+J6a1KyNxfJ0HNkWu/hPVlykK8fHeM3YbOGImonxVDp8QLLZz9KJbDPVdDYdr6SzG2izEAdgklQ0x/V/QlJzhAHVZ2MU6dHdigckRpOZmxgmz+rboh1ao0dzzy8nKXJbz9blqEuOwC8XKoYMUaWav1ZP7Ar31PxGFTljho79mctpDWIdbjM3Yui6DxhjvPGhwiuvsc2yFnjUc3/0xxFWton3NXgGV9f6/6beER9Sw+48FgJ+fSUhqUb2/fbh3Vlq6EqeIRzdH3EX5ldrOwAsW406xUPHfjeDwIenXo3F2lCEc5I5Qr7FECzg==
Received: from DM5PR11CA0012.namprd11.prod.outlook.com (2603:10b6:3:115::22)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 11:47:16 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::1c) by DM5PR11CA0012.outlook.office365.com
 (2603:10b6:3:115::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 11:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 11:47:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Tue, 7 Jun 2022 11:47:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 04:47:13 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 7 Jun 2022 04:47:10 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: [Patch V3 2/3] spi: dt-bindings: split peripheral prods
Date:   Tue, 7 Jun 2022 17:16:58 +0530
Message-ID: <20220607114659.54314-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220607114659.54314-1-kyarlagadda@nvidia.com>
References: <20220607114659.54314-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 733c68e8-fb13-47c9-dd82-08da487b780c
X-MS-TrafficTypeDiagnostic: CY5PR12MB6324:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6324E1F99EA393A0C075E86DC3A59@CY5PR12MB6324.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGphVrhtCPz8/g6XzPzIwrqyQLpxZ67ddhDGH3dSJSDs9Y0mMhb3XDJkr6ew+EdnuwsGRSbwCn7ZzqF7SW15Z7KfRv3OLQx+w1UHeVgwgetwxiKCiaZogD5VpOY82AYPxaFanneBGq+Ce2AUNEC+9y4N22tpsP72D7j0g9/sgaIrqnDkLyZwFjYEQ5eb19ssbFcoOy2jBy+ytqpA1J3IAbbpDIr/QJqJa9cB2K5smVR0gUGRtjAcnSB6et6FJBhGKjLZ8uUz7pNUiwilphsvvYPMAiGsuK4SVmify4ouYtDVdFXW31S7EFAQIKx2FOx3Z9jFig2wVZh/TqdgQ5yhBfJhsHy8iOR8Pfvtqc1yVavecZuBx6bMSEKMufC+QuFUr9na0wLGOVQvqc28VR1VgVdhSHAAKsJ/a7WmdTo3QS1MypMg4MVq8rBRaACZIlCWKIKwvJLXgBugzdCGfnddL+ZYbuVzEVQNr/QmsgMjCWVTJszdYv5oa5DorWst3c5vcQI+eLHYRZleIRhvm82cVyYj2CrfSJP1pFNnVkpe9PduI1tczguW/pIvTbfEaNpbJoJsMORVv8c3xIC/0/Z7wD0vjILSab1kVhGSu9fWCQUTMlm4RFqWea5/Ftl4Dib8DoMLBcQcwAzGmYq+OwfSIjVbh6Jf3b7moEDR9zGrHuZT6OHHxUQXntxohfI9TZ/OHbM1MS+11FfmPX4c7CE3dNLPzo+gZKhxDhqD0aTCgNeLq6IVsjx9S8HQGAn5wIuEanVezNuowlxOLbfyvIudg2uE/KS77LV3vcQiuChDjwl5Ap5BDvo4RNlEm9sniWcxqbKeg/1OGiDl6A+as7daqQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(110136005)(26005)(2616005)(70206006)(70586007)(81166007)(1076003)(82310400005)(36756003)(107886003)(4326008)(8676002)(7696005)(86362001)(83380400001)(40460700003)(36860700001)(5660300002)(508600001)(426003)(356005)(966005)(8936002)(316002)(2906002)(6666004)(186003)(47076005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:47:15.7382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733c68e8-fb13-47c9-dd82-08da487b780c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move peripheral properties for Tegra QSPI controller to
nvidia,tegra210-quad-peripheral-props.yaml and add reference
to spi-peripheral-props.yaml file.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 ...nvidia,tegra210-quad-peripheral-props.yaml | 33 +++++++++++++++++++
 .../bindings/spi/nvidia,tegra210-quad.yaml    | 21 ------------
 .../bindings/spi/spi-peripheral-props.yaml    |  1 +
 3 files changed, 34 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
new file mode 100644
index 000000000000..24e0c2181d25
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad-peripheral-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Peripheral properties for Tegra Quad SPI Controller
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jonathan Hunter <jonathanh@nvidia.com>
+
+properties:
+  nvidia,tx-clk-tap-delay:
+    description:
+      Delays the clock going out to device with this tap value.
+      Tap value varies based on platform design trace lengths from Tegra
+      QSPI to corresponding slave device.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 31
+
+  nvidia,rx-clk-tap-delay:
+    description:
+      Delays the clock coming in from the device with this tap value.
+      Tap value varies based on platform design trace lengths from Tegra
+      QSPI to corresponding slave device.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 255
+
+unevaluatedProperties: true
+
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 0296edd1de22..e79f0b2560a4 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -57,27 +57,6 @@ patternProperties:
       spi-tx-bus-width:
         enum: [1, 2, 4]
 
-      nvidia,tx-clk-tap-delay:
-        description:
-          Delays the clock going out to device with this tap value.
-          Tap value varies based on platform design trace lengths from Tegra
-          QSPI to corresponding slave device.
-        $ref: /schemas/types.yaml#/definitions/uint32
-        minimum: 0
-        maximum: 31
-
-      nvidia,rx-clk-tap-delay:
-        description:
-          Delays the clock coming in from the device with this tap value.
-          Tap value varies based on platform design trace lengths from Tegra
-          QSPI to corresponding slave device.
-        $ref: /schemas/types.yaml#/definitions/uint32
-        minimum: 0
-        maximum: 255
-
-    required:
-      - reg
-
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 5e32928c4fc3..cf589d17b0f5 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -112,5 +112,6 @@ properties:
 allOf:
   - $ref: cdns,qspi-nor-peripheral-props.yaml#
   - $ref: samsung,spi-peripheral-props.yaml#
+  - $ref: nvidia,tegra210-quad-peripheral-props.yaml#
 
 additionalProperties: true
-- 
2.17.1

