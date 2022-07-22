Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C7257DBEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiGVIMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiGVIMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:12:15 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2037.outbound.protection.outlook.com [40.92.53.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579F59DCBB;
        Fri, 22 Jul 2022 01:12:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFKyC5VNW51cVE2tATwPLEYqzALSgOGWVlhhBqTjhj0VenRHse2qfFJ1P7J8YVkp1CxhxW/yxvJmfp7yFFNgkWtuNE+acH85xvHLRSFdLIKvIVvl/zERmNNXTn3hv0IhQrNtDLiO4cvShBqVw2RFsMOO3ixVZELNQ+L0KrkcsX0o8FyP72fjkaTFYBDQOC4Jti2XMnoRAlI/+Lm2cQ9SNarG0Du04NBVkutmmlXvZWpxR61WZ0h8C02bQ7E2jpV1BW9v2AOXlDlyJXFGPsSvFZDOrx8HdnZQjBbTDtFpFlHZ4hvSq8iRhepV09qBdfq6SHQ6PgUdNQASzCCH5Alw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0GiDRWVs61CcElpLhdf6cGGMFhXiHw2qBrtSWdAWb4=;
 b=iXZrBrIZ7KLj+ttvLvb0v1xNUe2lqqxe7hoWQL4manDUw7AyZx5Fkl15Cx4WocjjmJ5Kl+Os1ZcWtRIP0QLo5CML+yCupcJoDEdpq0HAmM3+b/iuADXiJkYSNlw1bhowJr1dWvYIL7FgWSBjbEmDH+HrmiFFAN1nNs8WnEJ18faJAJhvplwhd2dHqKOIW5YC8kwbJlJSMzsjSGcoSNeb6JvaFjrOE9OxXbOg02rNj4lWwN8v72qHBXKSgelETkYk1Zmhc4quoXZah0o8UHxZaSdTyJkcKYC1KUrRz3sqchWzVbVpWGN5DCbSWLWVoKZAKQt7hjuEBCdiARz4zbYGFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0GiDRWVs61CcElpLhdf6cGGMFhXiHw2qBrtSWdAWb4=;
 b=ZU8QOPiZ8fUphUgkOXYLCohyzWWfKZfWUKTGLcIYuYMIaDW481vw9mUZg478ST9jwZvgarz5QONAh56kA9p5fSlFXw1LpUiG/rWzHSUHgLP5IPuNRcLOZk3kOdjXs7vTSx70OuffFooSH7S/UmF/e0GbC9L/Zigs9B/FXrvCl9LbHsJglOEqVXEuc8Oktq3GjnWDgL/WryDREi8StlCAOR93GmDnWNkUgC4j+v2uRNZ2+MGuEeS/H/uQq8Bmy3GJWEPYCKGV3ZWCm/M+OvSiJr+vPIGInrwpIi/zwrn5fhBEUNgs6raCahIo4P3M7MKqjhDPz2T+ajoV9KPcr/+3oA==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 PS1PR03MB4889.apcprd03.prod.outlook.com (2603:1096:300:78::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.1; Fri, 22 Jul 2022 08:11:59 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5482.001; Fri, 22 Jul 2022
 08:11:59 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 3/3] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
Date:   Fri, 22 Jul 2022 16:11:27 +0800
Message-ID: <SG2PR03MB50062792832700DC51EF6143CC909@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722081127.228971-1-jinghung.chen3@hotmail.com>
References: <20220722081127.228971-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [/LK+8h22v4PZcAO0jaSSGTFZRh0K/pHk]
X-ClientProxiedBy: TYWPR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::13) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220722161112.v7.3.Ib4ce5b819c276903afb57438944b520ac1434e63@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8e04735-93f3-40d6-5dda-08da6bb9d9dd
X-MS-TrafficTypeDiagnostic: PS1PR03MB4889:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nU0m0FHUE3wWY0P5NfAwYPaS+IbgTDTwbHGEQOfY/YlBKsv+TVCHGl7p1tT5wYBSsxgUsYAGMYdvz3xShDs3YZQiC8D4HV6Fh64nBOoeTcpfYv7Sj2mjkImEnysDWpqlvXQtGsODE+KVzaiwBofRtRH0g1ohRN7kc4D3r937zg8Jfs/S7LKf4q0fFPxfzHPGolX+Ijd5c8Gp1nf8mFdGxSERCJ+AvLgO7OEntOAOFpbHZNCLlhLAUaRumhkiy1Q7QsUJUqsdwGIo59QIIdaWrjdFmS2S5czVUA/uHpgE8QD0FHjCAJFbN9rLTTM2R0PqNY2weQ1Hx8seWTIAvuYGADg2UaR+Ze1dBLwPJHVpCjHar0zWnEzARO7dxcEhpESR+mHJ7kBIa/IiN8MQGlQlU5veaIxkwInsOlhltzfBBA0eeVaDFi7fQaFPjFdlVPTNmiibpn51ZLNGrGZaLchdU7aAdwjD1N+iGgrWQyKyA5lg1f8E+LH/BIZ6bqHQoPPgWiu6LWwahdtBMfWqSD+eIX+TSdFevYuKJzOBIs0qWknZpFcbHTYK/YIfs/xZIE1YrLOwqYscIpE0IKGzq4Arb3Owq8Mi+sMFYYVhLcAsnUwCsNbT1cy2/pX+kQbaQr6ytnRY9qJd7wF4/2MlF7KoUQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IBt5gpviq6KIDMhS0W8M6ZsZN2YlEt21b3Hd9bh1JQ4G1J+cbX95Ey3ff22Q?=
 =?us-ascii?Q?ZjPfmxHYA+SGNlXKxqFqFPlLMhhHt3yMcvihYsZeKefWpeWuA9K+Gf04n1aw?=
 =?us-ascii?Q?kITbkwq99N8/SbEBd8mdlDv+JLtruCl9DNeiWrCXtNkMgQbbMxFzbPbwynNz?=
 =?us-ascii?Q?R02bMK/RM4HuiIJH3Bd34T58CEELM9+zhjR07JgLonahmatVdxVopry2CXGY?=
 =?us-ascii?Q?RA5z2SB1EyuGdoPqOGoxLh+g4Z8lXGZLB+0/TT5zCux+SLZlGT4wOcMmS5aC?=
 =?us-ascii?Q?R3IDUmCSAIrj+129QI97AVDan1RiQYZTL9ig1nJO4wmlT1rNEiUtScB1rl/0?=
 =?us-ascii?Q?Zwr0TXHDM3XzOfnlu6bQ9htJjAFe5QCrWChyLyVAW3odqWxD6ZEwHXwyMQar?=
 =?us-ascii?Q?PWfM340Q8euqIuTWWIMsmn/U55bcWwbu5TqO1ZzpkYnbmG1AGGW416IcUUCD?=
 =?us-ascii?Q?8BawtFh3oejL4Ht8vPFeXRbT7RRaD/EEwMnUxFIAHNQSybfbNkRIEAzg870g?=
 =?us-ascii?Q?1E0JzFGJTajGTC43UnN+8E5wRAT6yq7dOOe8FAuhJWqYHOnXBg9mngzchDOZ?=
 =?us-ascii?Q?acKjcuFRwv1GWy20WNubjKrAmakET0G8fuYir835p+en6IcEWSM+aTmyKQp6?=
 =?us-ascii?Q?Fr4dHRqpt7f8c4Xt6N0r71DSoLf7udTPnONU0SSBY4l7M2yMgQElSoIcrv4O?=
 =?us-ascii?Q?+zg51H0iBzYZpud2RS8jXMkMv/aqNevqgbHf1h/sZmH+nVYYn1hqdF6BREE5?=
 =?us-ascii?Q?7GWsNqVD3AzRWjAjQJwXIpRIFDrwIkH54jUDFLu4hevMntDzwZ9G/t+1TV/2?=
 =?us-ascii?Q?Fb0dTx6N0yHpgf87Mg8FPIt24FIG9Yuhd7bjSsBP6WlhgyldHtLO67xOME2y?=
 =?us-ascii?Q?ZaPjY8Ew7JjHppGJRWZ0qt4uctL7AFwhx3cuOE05AbntVluIF4iFRzLw7Nva?=
 =?us-ascii?Q?TPrqULrLmSa1iZLO6NNR+jodzV4naW7PiifDNEJyofrYljVJ1vmXG3CUy9nR?=
 =?us-ascii?Q?V1LbbDorHmvCBWokX1N7jxSCJdXQY4krWUVMI60I/hKVxamY17KuMvsAWX0k?=
 =?us-ascii?Q?ZeFl3jp50gu6oLpkf8gyhuI/jTpfDH9dNELFCw4ACeARUcGxKlHPV+V19dTe?=
 =?us-ascii?Q?X4OliwNIO7a13l3XBvNtV2/1LaYjjkMK0FzrM25uiGGTOLMvkp3SyvjpLM+x?=
 =?us-ascii?Q?1TMXejsU53XGQ8izHEue4xQ+Ia8czgeYZ5oxkGEUxUOFWrGjiZeCUbHYLU4t?=
 =?us-ascii?Q?wAXAc0Sb/K0cVJpyOOSqHi5pTsRrr7MiptpSCI0skFtlbR5uxW1/ezcBV9lt?=
 =?us-ascii?Q?8xY=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e04735-93f3-40d6-5dda-08da6bb9d9dd
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 08:11:59.7443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR03MB4889
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds LTE skus for villager device tree files.

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
---

(no changes since v6)

Changes in v6:
- Remove v5 accidentally added sc7280-herobrine-herobrine-r1-lte.dts

Changes in v5:
- Reorder '.dtb' in Makefile
- Put the "interconnects" line back

Changes in v4:
- Reorder 'status' last

 arch/arm64/boot/dts/qcom/Makefile               |  2 ++
 .../boot/dts/qcom/sc7280-chrome-common.dtsi     | 11 -----------
 .../boot/dts/qcom/sc7280-herobrine-crd.dts      |  1 +
 .../dts/qcom/sc7280-herobrine-herobrine-r1.dts  |  1 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 17 +++++++++++++++++
 .../qcom/sc7280-herobrine-villager-r0-lte.dts   | 14 ++++++++++++++
 .../qcom/sc7280-herobrine-villager-r1-lte.dts   | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts         |  1 +
 8 files changed, 50 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2c1605e00d349..24eacbf330880 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -103,7 +103,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index cfe2741456a1a..25f31c81b2b74 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -83,17 +83,6 @@ spi_flash: flash@0 {
 	};
 };
 
-/* Modem setup is different on Chrome setups than typical Qualcomm setup */
-&remoteproc_mpss {
-	status = "okay";
-	compatible = "qcom,sc7280-mss-pil";
-	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
-	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
-	memory-region = <&mba_mem>, <&mpss_mem>;
-	firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
-			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
-};
-
 &remoteproc_wpss {
 	status = "okay";
 	firmware-name = "ath11k/WCN6750/hw1.0/wpss.mdt";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index e9ca6c5d24a16..921eccfec39ae 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -9,6 +9,7 @@
 
 #include "sc7280-herobrine.dtsi"
 #include "sc7280-herobrine-audio-wcd9385.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
index c1647a85a371a..c1a6719687252 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7280-herobrine.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	model = "Google Herobrine (rev1+)";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
new file mode 100644
index 0000000000000..a92eeccd2b2a9
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Herobrine dts fragment for LTE SKUs
+ *
+ * Copyright 2022 Google LLC.
+ */
+/* Modem setup is different on Chrome setups than typical Qualcomm setup */
+
+&remoteproc_mpss {
+	compatible = "qcom,sc7280-mss-pil";
+	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
+	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
+	memory-region = <&mba_mem>, <&mpss_mem>;
+	firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
+			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
new file mode 100644
index 0000000000000..672cb78e3088f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Villager board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7280-herobrine-villager-r0.dts"
+#include "sc7280-herobrine-lte-sku.dtsi"
+
+/ {
+	model = "Google Villager (rev0) with LTE";
+	compatible = "google,villager-rev0-sku0", "qcom,sc7280";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
new file mode 100644
index 0000000000000..2f05a19cc388e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Villager board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7280-herobrine-villager-r1.dts"
+#include "sc7280-herobrine-lte-sku.dtsi"
+
+/ {
+	model = "Google Villager (rev1+) with LTE";
+	compatible = "google,villager-sku0", "qcom,sc7280";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index 6d3ff80582ae9..fba7e938ce35a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include "sc7280-idp.dtsi"
 #include "pmr735a.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
-- 
2.25.1

