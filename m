Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F69525CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378083AbiEMIJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378064AbiEMIJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:09:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFD81CA079;
        Fri, 13 May 2022 01:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMevHvVZ5Xu7tbu72nLtnom1oTqWcCRnJZbSrcKLr2eZAoQzwnqNBCDWywsu2Flnu15JkvODmHjXaGhnDQgbBYuO2f1dLq5XmRV45/pz3OBSAinVnYHH/5p5B/uhZp8UXO6es2S3l4ZBjQAkd2KRLZfAWk+n5Cr4OY5nTSVefYVuHzwcQ2vHUXrL/F4s7ee1HQjjNiRQYa2UCkiaO4blNp/x/jBSmCGKn//HVxK8PoNGIID1Zk8UwehdJlFwNGWnzoZnr2Gmf3S/Y8umcD6BqaRnsP/LniuI7uj6kg074/r+P7By0jXGe/FwXQtjbfoVbie3770Ky2FXMpKS21af4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvhiiIfqwNMHbC83BoK+8OEaS2TUyq5mZBEPUT4zkjA=;
 b=eNS2w6oleWyf/wE9TARsdQhyYCtlpmLn7XaO+kUTUYvlwjrNmEHQJngX8+mkDUUIFJhcnPgDYjzP38iOFu7xTmnbyn1Ps1X8jXNbU4A9CIgsYTJREqMtuMcl2cxCPk++Mcv+HUiafMOh+X89ZmUDq7cJAn4HrSGb8EXvIf+xw0IEw5EWJ8jMChUrJ3zeUF0Y+YK3YDDwoZHQEanj/5kbvRKVZJLk/vmWqD5iPwEQdXkXIFlTKGoycEw53OFCZbPNj/wX/KGXhIELtuIV3Gri6eKDdltLeTcl/Gf1QoChuZhycCxCmjeLrFYJcxPZLJUH9rd04KDwgEUMpNOECIoxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvhiiIfqwNMHbC83BoK+8OEaS2TUyq5mZBEPUT4zkjA=;
 b=ERFQRTQULSxgRHI+siB2KvxtOv+YnRNH1hibuSF/a5CYJAClX584Q3EPVgJEegKY1cbtgUwOo65bAfMCNTD3PdTt5mYUocCd8XGR9WH2vXIU9CJiFxa7ckNaUekNN2nx+P4VKV4+WlWnTHmbBrZxzfjrmoO4E5BZ0eT3Ff1N+mX0SolkQqWig4HHiYyIVUrgrVLqIlmfg1PVxya8otL4XiTT/9Jw6+f4sB2ASw456j7oxjISvG9rXESpembdnmVfFbmryHEVwrWr+j9yaht9w6NVakpNBOsrrYJTig5Ao7moYv4rLFs/sZ8BNSHuo7oZDAzPZSlc2hz4mc88/fZgFw==
Received: from BN9PR03CA0524.namprd03.prod.outlook.com (2603:10b6:408:131::19)
 by DM5PR1201MB0154.namprd12.prod.outlook.com (2603:10b6:4:58::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 08:08:56 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::98) by BN9PR03CA0524.outlook.office365.com
 (2603:10b6:408:131::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15 via Frontend
 Transport; Fri, 13 May 2022 08:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 08:08:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 13 May
 2022 08:08:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 13 May
 2022 01:08:54 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 13 May 2022 01:08:51 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: [Patch V2 2/3] spi: dt-bindings: split peripheral prods
Date:   Fri, 13 May 2022 13:38:27 +0530
Message-ID: <20220513080828.22079-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220513080828.22079-1-kyarlagadda@nvidia.com>
References: <20220513080828.22079-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b376cacd-ba6c-47ec-c556-08da34b7d385
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0154:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0154256D6DFDCCF097CC4CE7C3CA9@DM5PR1201MB0154.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7DwSnNjW365oH4HK8VlScmTb+I+fEhziw7jG0NFAS3liuToyCEuVT1NoNH0IOZFvTU4fRcP6hMHT/1FFpmGqn8Zj8NhuHWRQyhcoojAz1rbGZK9CNNJcpw22rJI/zPq/g5mLPPMEQGX9wbnZegv5QyEVewh+NuAozZQEjx5IrdoKLOUl2GWzu1qttakw6XHZ5SfY6x91DJSIbxhf/fecFXgQn9BbljhE4XuAbxl3hJT8BvEepbYC7k9YnRgOW9fqx49CMSJx58FPDcwYVOQmmXJlKDt3Eta7LRAGdXRct5wZj1A+HL1d/uuLCu1NNsNyoa7mtBlCo35psAJ3mpZGKucw54zsAved4iTfov7VacFr0NdV6+/Z8jTQ0ROLUjcKw9q9OtzjStNBb8gZ2jz6n20KES9s4fD+VKXVYYzjuaZodtpq/6Nzf8fenG95NLrxyp8ZIJRq0rHo4rcfyDmsfnfIyJhphDK161qdNqVoIdVuOQ0t/bIbL+nbnoRP3vbXgiWqVSTVg7LU58FSxi/SZzDeJh63uY3ajBA1mg/4AhTDT9YgtO/nOehOqI/8MjIXorrrHXFSmyc1K1XcachSnsXYGj/CIpd60UiEi95Q3jI2X2rbvFWpnljU4HECSs1Nc2/U3CCnnXiQXxrnwmYnPVBBDpSFawjzwL4DDk6talxeUMgz0DBBRPUSUbhsZoGBlkyirmcXnZR6/kaRZibnuZRMub2GgeJyA9/bpKH4XMAS32pxZu9A4zIJO8YG5wgrb4RiDjTShsZ+gDNyXD3WPO3mF4toDf1NR7byXss6xugwQ1we8s37ci1EEunSoDIyOig3tr71edqYHaetYLZTQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(5660300002)(508600001)(426003)(336012)(966005)(36860700001)(47076005)(356005)(107886003)(6666004)(316002)(2906002)(54906003)(26005)(2616005)(36756003)(81166007)(110136005)(186003)(83380400001)(86362001)(70586007)(70206006)(8676002)(82310400005)(4326008)(7696005)(1076003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:08:55.7046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b376cacd-ba6c-47ec-c556-08da34b7d385
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0154
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 ...nvidia,tegra210-quad-peripheral-props.yaml | 45 +++++++++++++++++++
 .../bindings/spi/nvidia,tegra210-quad.yaml    | 32 -------------
 .../bindings/spi/spi-peripheral-props.yaml    |  1 +
 3 files changed, 46 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
new file mode 100644
index 000000000000..f91347759c65
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
@@ -0,0 +1,45 @@
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
+  reg:
+    maxItems: 1
+
+  spi-rx-bus-width:
+    enum: [1, 2, 4]
+
+  spi-tx-bus-width:
+    enum: [1, 2, 4]
+
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
+required:
+      - reg
+
+unevaluatedProperties: false
+
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 0296edd1de22..7d60bb1af047 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -21,9 +21,6 @@ properties:
       - nvidia,tegra194-qspi
       - nvidia,tegra234-qspi
 
-  reg:
-    maxItems: 1
-
   interrupts:
     maxItems: 1
 
@@ -50,37 +47,8 @@ patternProperties:
   "@[0-9a-f]+":
     type: object
 
-    properties:
-      spi-rx-bus-width:
-        enum: [1, 2, 4]
-
-      spi-tx-bus-width:
-        enum: [1, 2, 4]
-
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
-  - reg
   - interrupts
   - clock-names
   - clocks
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

