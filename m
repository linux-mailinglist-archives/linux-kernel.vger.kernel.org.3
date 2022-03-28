Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABF34E8DED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbiC1GR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbiC1GRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:17:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE34B2612A;
        Sun, 27 Mar 2022 23:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly0qxNq0KQUx5yOl1hZb4jRnMxqiUz1ti3VFjHwYWPPkJZruLe+GuNvaLGtIHlB/4c+Gle3E3e7L14euIvUaLZbwH0NWxN3Y2beP7y52RfvzUZL9Be2kcuqQX5Tm/P4ZI/isynIzL9J05S+5wxB/do+KUJMnfNGi+bG7o4X3P4DfSEglKP6M7fAD5hvIyjBeg2ivJiSFjiAbEwa6I8Hsnlbc+tncP5heClqqiKuRixSO6muf2THOxPUDaJJKocZrIG/76mII2nWsAKJaqn+LpBTZe+xEES0tn90Cn6X5UcRtOl4yXZxz9Rsmc3d4/NdR6a3tvZffRN0QFsoN8N8/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBNYOo3hbnzsQeZv5Tz8giYwmCgw8Rgciit6wd8T64Q=;
 b=ScM9hc6EcohbZNcbVfPVjMiLgnUktvZRIlN4tnTk4MjEerwlOzb8i+lSM02MdzFd5zH4KiSGFw1C/YP6rfuGKTo5Vj5Hc6qb/qvjvi8EZvxE6TzGJSDtBK1iGfAn3YvtV/BxMoyZaOTdP++lkukr1eQx+Ay0swb4euI7dmxTgJ7XyC2UKfyiwsgpjKHk1TBM7N5OsYG+G974qCtvB1ytqgKJGb+RjRdS4OfpP44WQGyXh6Z5Au38JZfJXyx05PHMOANusJFiekks2BxDJaDzEv81iA62haiS7xtzprbwvOziLdwPviijC4HVGrMaedyw38XRR7ya7ibr4hwn6WjYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBNYOo3hbnzsQeZv5Tz8giYwmCgw8Rgciit6wd8T64Q=;
 b=UYVYgdfci5KX11IuLyJ/sYqpgAHvCuCtXCg5oRY2zYHqAFvMVBi28PvynsvDyEYs2mC14F5TEUydmcveU0wz3HIp5ryunFs8nOikIW95z3O6aLPrrbUU3BSpQRfwdM99CebwLXm1fjYttVi/vtyddr/ADekansFrlAHGFbnfRIGi0dpsWHT9AzFnz5ZwqN83CN6EV+InTM03z7WQPN5LVckv8OhzOybe8m3dqUfY9xR/USeFfZPwXMd4CDpaHAKSJ2syGvx97MKcu/ZGT3Z7sLEWNnCNCYkwaxXD32QDng/0cmFx3zuNlgKYeYqDYGpVcJlz9L24x8LsIgDxGvlnyg==
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 06:15:39 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::46) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 06:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:15:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 28 Mar
 2022 06:15:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 27 Mar
 2022 23:15:37 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Sun, 27 Mar
 2022 23:15:33 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <peter.ujfalusi@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <oder_chiou@realtek.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RFC PATCH v2 1/6] ASoC: dt-bindings: Convert rt5659 bindings to YAML schema
Date:   Mon, 28 Mar 2022 11:44:05 +0530
Message-ID: <1648448050-15237-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff7cb7e4-eb39-44b0-3eb6-08da10826170
X-MS-TrafficTypeDiagnostic: DM6PR12MB4339:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB43395805EBFB451A9192B329A71D9@DM6PR12MB4339.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tukb/HflDEajp2Cj1eH0lDmBexfeajsMH2sZXUSDfQ0YnS4F/2PMEjeCRedDv2yMgCRKnnZAIv83iMSXiF0AA56k9sypijkY+xUXbp7rZNTSv0mmknSrMCqBvE7r/6rXag/fxP3Q8FP0nijKfKRAx+1Fgfjq4QTRzejLqyhYOTb3ZVxjLQ+062e9li+GKf15+oiM5Ns/lZsDWRm3OwMs/dL3ImdJsmfxT6hDL8JqRLIKMorOr+oTxhtrz9ZBBmH4DnxEZLow1qPsY2jimcMLNzU2kbikjBiflGAU3vNI9VFrVPwGYsN5/e1O5qFBkSqhXQKzu816X00RaBinCZtO1z0D3G5oLVCnKs3p1lcb589JoLBoG4HoVTC2PAv6ltx8Ew6Sdoo2mfNZfX/jrbe6H/TeQ3dhXeMwVMKk53f0e4vQd3IXQDF9RITtDaJX6jZQgHtXIhfG5p4lvjN2mYcp94mcGpXlXd5iY4F/GQSGzQBWT784eRRSiIDkrXlAcO87VMRJ86Spth2Mee61u6TPceA5BdENjvgwLM0iaerDFTQRRObT2Pz7+MTV2SzNYl/dMbDNxABGjX4jYnn1M59gMF5nzIF5Ts7gSzBof4pyb1UXB6JfE4Xnz3alqISX+N26Ox7qQnDffw8nudVzYxJw+IRmvlUWIjYyz/YKNDCOuxm1Fh/J/u7rtljYlIBzOi/JcMUPUKf4tR0PPZ/RlHhG+JtqYung8AOm1koIK5OAEpx8rg/OukJSF6SVG9uTk0tlSh963jzfvzkMupsp7NKokwOI5D+35CNpcrcbATK4LtHCsC8mIVPk51oE9jPWqDLnnNRfA2JT4pVUraND//bBdA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(356005)(40460700003)(186003)(110136005)(54906003)(81166007)(316002)(8676002)(508600001)(966005)(47076005)(36756003)(86362001)(5660300002)(2906002)(4326008)(70206006)(70586007)(2616005)(8936002)(7416002)(426003)(82310400004)(336012)(7696005)(36860700001)(83380400001)(26005)(107886003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:15:39.1791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7cb7e4-eb39-44b0-3eb6-08da10826170
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert rt5659.txt DT binding to YAML schema. This binding is applicable
to rt5658 and rt5659 audio CODECs.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
---
 .../devicetree/bindings/sound/realtek,rt5659.yaml  | 112 +++++++++++++++++++++
 Documentation/devicetree/bindings/sound/rt5659.txt |  89 ----------------
 2 files changed, 112 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5659.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
new file mode 100644
index 0000000..3bd9b6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt5659.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RT5658 and RT5659 audio CODECs
+
+description: This device supports I2C only.
+
+maintainers:
+  - Oder Chiou <oder_chiou@realtek.com>
+
+allOf:
+  - $ref: name-prefix.yaml#
+
+properties:
+  compatible:
+    enum:
+      - realtek,rt5658
+      - realtek,rt5659
+
+  reg:
+    description: The I2C address of the device
+    maxItems: 1
+
+  interrupts:
+    description: The CODEC's interrupt output
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Master clock (MCLK) to the CODEC
+
+  clock-names:
+    items:
+      - const: mclk
+
+  realtek,in1-differential:
+    description: MIC1 input is differntial and not single-ended.
+    type: boolean
+
+  realtek,in3-differential:
+    description: MIC3 input is differntial and not single-ended.
+    type: boolean
+
+  realtek,in4-differential:
+    description: MIC3 input is differntial and not single-ended.
+    type: boolean
+
+  realtek,dmic1-data-pin:
+    description: DMIC1 data pin usage
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # dmic1 is not used
+      - 1 # using IN2N pin as dmic1 data pin
+      - 2 # using GPIO5 pin as dmic1 data pin
+      - 3 # using GPIO9 pin as dmic1 data pin
+      - 4 # using GPIO11 pin as dmic1 data pin
+
+  realtek,dmic2-data-pin:
+    description: DMIC2 data pin usage
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # dmic2 is not used
+      - 1 # using IN2P pin as dmic2 data pin
+      - 2 # using GPIO6 pin as dmic2 data pin
+      - 3 # using GPIO10 pin as dmic2 data pin
+      - 4 # using GPIO12 pin as dmic2 data pin
+
+  realtek,jd-src:
+    description: Jack detect source
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # No JD is used
+      - 1 # using JD3 as JD source
+      - 2 # JD source for Intel HDA header
+
+  realtek,ldo1-en-gpios:
+    description: The GPIO that controls the CODEC's LDO1_EN pin.
+
+  realtek,reset-gpios:
+    description: The GPIO that controls the CODEC's RESET pin.
+
+  sound-name-prefix: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include<dt-bindings/gpio/tegra194-gpio.h>
+    #include<dt-bindings/clock/tegra194-clock.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        audio-codec@1a {
+            compatible = "realtek,rt5658";
+            reg = <0x1a>;
+            interrupt-parent = <&gpio>;
+            interrupts = <TEGRA194_MAIN_GPIO(S, 5) GPIO_ACTIVE_HIGH>;
+            clocks = <&bpmp TEGRA194_CLK_AUD_MCLK>;
+            clock-names = "mclk";
+            realtek,jd-src = <2>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/rt5659.txt b/Documentation/devicetree/bindings/sound/rt5659.txt
deleted file mode 100644
index 013f534..0000000
--- a/Documentation/devicetree/bindings/sound/rt5659.txt
+++ /dev/null
@@ -1,89 +0,0 @@
-RT5659/RT5658 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-- compatible : One of "realtek,rt5659" or "realtek,rt5658".
-
-- reg : The I2C address of the device.
-
-- interrupts : The CODEC's interrupt output.
-
-Optional properties:
-
-- clocks: The phandle of the master clock to the CODEC
-- clock-names: Should be "mclk"
-
-- realtek,in1-differential
-- realtek,in3-differential
-- realtek,in4-differential
-  Boolean. Indicate MIC1/3/4 input are differential, rather than single-ended.
-
-- realtek,dmic1-data-pin
-  0: dmic1 is not used
-  1: using IN2N pin as dmic1 data pin
-  2: using GPIO5 pin as dmic1 data pin
-  3: using GPIO9 pin as dmic1 data pin
-  4: using GPIO11 pin as dmic1 data pin
-
-- realtek,dmic2-data-pin
-  0: dmic2 is not used
-  1: using IN2P pin as dmic2 data pin
-  2: using GPIO6 pin as dmic2 data pin
-  3: using GPIO10 pin as dmic2 data pin
-  4: using GPIO12 pin as dmic2 data pin
-
-- realtek,jd-src
-  0: No JD is used
-  1: using JD3 as JD source
-  2: JD source for Intel HDA header
-
-- realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_EN pin.
-- realtek,reset-gpios : The GPIO that controls the CODEC's RESET pin.
-
-- sound-name-prefix: Please refer to name-prefix.yaml
-
-- ports: A Codec may have a single or multiple I2S interfaces. These
-  interfaces on Codec side can be described under 'ports' or 'port'.
-  When the SoC or host device is connected to multiple interfaces of
-  the Codec, the connectivity can be described using 'ports' property.
-  If a single interface is used, then 'port' can be used. The usage
-  depends on the platform or board design.
-  Please refer to Documentation/devicetree/bindings/graph.txt
-
-Pins on the device (for linking into audio routes) for RT5659/RT5658:
-
-  * DMIC L1
-  * DMIC R1
-  * DMIC L2
-  * DMIC R2
-  * IN1P
-  * IN1N
-  * IN2P
-  * IN2N
-  * IN3P
-  * IN3N
-  * IN4P
-  * IN4N
-  * HPOL
-  * HPOR
-  * SPOL
-  * SPOR
-  * LOUTL
-  * LOUTR
-  * MONOOUT
-  * PDML
-  * PDMR
-  * SPDIF
-
-Example:
-
-rt5659 {
-	compatible = "realtek,rt5659";
-	reg = <0x1b>;
-	interrupt-parent = <&gpio>;
-	interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_HIGH>;
-	realtek,ldo1-en-gpios =
-		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
-};
-- 
2.7.4

