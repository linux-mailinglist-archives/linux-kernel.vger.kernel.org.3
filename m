Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC558103E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbiGZJqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbiGZJqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:46:33 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2085.outbound.protection.outlook.com [40.92.107.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5D531DDF;
        Tue, 26 Jul 2022 02:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hX41rG4Vl2nVa8FwswYG+uN+Yj1y7CkKYY1uAmhMf0Ec8BKrQXH+L3xkgmYwtXb/oH5myT8WXLw9xtJOg6oim+etrmCtsM2bOTGyI53ZUsKqx74LQvtg5pXhPbsbfVbkM62A4lne3lcgbbNEjwu+G5nRCwB/+09Nog1Nc/fy/TXkUwidUD59YTuOpmKw9vgSB9/LuNiso4l5Bp+9DyK7ty7pvEE6KQrWLrm2aKwgFTWA+2ESOzel/A02HY+CfOctn/99Gl5KbxWLtmv7bQ/mRx1ES0qNOzB/GtuO8Bad5sIytc0h/td4Ccl6CO7dGQ7Eimu67PWT987UW2iIHcpjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F836DzHzEwG8QDdXce1mBV+A6pnZ/wf7zevkDc0tJxs=;
 b=QkUjdh0YhesI2veh1w782FDxlmWW0hCdOKlmOXckzZ3PZWcRmsuRr2zNGqILSTXNb2X1xTIzd5qnl5U8w9tjww9rTRoSWO3s5bScNZSGu12qR3tMEzXoBVUWdH61wVxmA8Kk2MazRPW/9PDAUzihh4x5ocx0g0S4pjSu/a+me8m9KOo0wSlzZLPRoZIgtUzhoz4UPsNTTA8WJ/qdMQ7GVIfEPUwfZk9AwDisUUuUts9jK8FhxlHOt5A9ZA4+Gr6XiVrlblNp2QnL4lBOAc3W0EJjZEqhSSW7785ofm8jevi7Iy7qJ9RcBpxQx1aioIK/1ImVp0CD1o5UjHcejWShlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F836DzHzEwG8QDdXce1mBV+A6pnZ/wf7zevkDc0tJxs=;
 b=JvL8ZHTpucGw71SjSZP4XncGavk/y3mjR4rkGgNiA/jmhqqjyt7JVslY2esq492Qvg5siBpK/mPfyZTt5OC/bUUdiAasLu+BXVE9AqKFAWb/XzT1qbOoO18lIi1ae3Asx1prMRCTmTYF8ZKQbRAodj9Y/MuXLdrZlORnv+gG3owLHLpTJdHWQiFZazJzd+EtqjcasT5AGJ5XRac+7HEhZGTki23CeYZnOAj1QtnqKkkCg4ntmJH7y6awd3HzZFGont7Zla8oXSwXsTY6e+wVvM+fTfKkn3NRC3r0wAF2n5KQgW8U7ssVtIPz6yiiZzM3KKuzHe+SzVdygcx3qV2kjw==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 PS1PR03MB3607.apcprd03.prod.outlook.com (2603:1096:803:4a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.1; Tue, 26 Jul 2022 09:46:26 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::40c7:5bd7:216c:fa4c]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::40c7:5bd7:216c:fa4c%7]) with mapi id 15.20.5482.006; Tue, 26 Jul 2022
 09:46:26 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v8 3/3] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
Date:   Tue, 26 Jul 2022 17:45:49 +0800
Message-ID: <SG2PR03MB5006B0C3E57803E3B1E0EDBCCC949@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726094549.263899-1-jinghung.chen3@hotmail.com>
References: <20220726094549.263899-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [pxfDm0nxpGQJEP04XuqDAfqQpkBDKoUq]
X-ClientProxiedBy: TYAPR01CA0010.jpnprd01.prod.outlook.com (2603:1096:404::22)
 To SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220726174436.v8.3.I14c487c5c9f6125f9b517636d0cd807132b9baa7@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79e399d8-137f-4117-d39c-08da6eebb4e7
X-MS-TrafficTypeDiagnostic: PS1PR03MB3607:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HwedPSr2PaWJ0smSKZOBhEbZmLERfrWUH9myVhK7R96oosMwKJu4AY4Cn8aNulwpN3osgG4BRbHM8LcnI0Gtv02dZvsasb1k9Owa+RiqHSfnDudpCxICsJKPfRpYtiJQ+9OGbNzg9SKJk+KIGVMjePsax7VQvjx8zErfOav2y8o0zbP5S1S/8V1caKzD0ey6tgeC0fCDqWaT1WZq5JJsl6akxPnNi2+O7Rgr9lCOMYufatrz1jtWuAGM9pfAD00EpQF7f3kUOsq1RaeNh32i+WYv+X2t0SzmXTwmpSzawXBuXWu8nT3iPI323u1e8rxWVl3PCAyQjnaLat3iKBIKIHkmwd/P25meX0DNb778HMm3Z+cWVs92qs9uTN71QgKQkHrbQE7nnxUOAM/dpKz1ExBKHNh8UepxCvu9OQiNn8NDuOua0Wp5y6eRwLkU4rRI9I5wOGvPc0HBcKNbtWvqL3GXfPkR2TkawPOIVO9mxN2DF0EvEFzhhAzaEpofKWH28PM9dBYfQph2IfNjL8mHQEaeUmFjQsILoAStIvp65P3EyBwOmJBYBJ8zlSK5HPm8lYi1d4IA+iNaeljoc5KC0JflcenAcOP+bt4shR31QAfmJHC+JTX8WIXhTYX/m+wz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?46W4nklVPywp4ITsgFIcTepgJ3KmCcCkE8H39u1uqX3qjh/3pFrn2xAArLTR?=
 =?us-ascii?Q?nExRJW6AW69dnRmbO8xuJL68GQUiy/2U+obRommKOO8pOIc0iOMEfakhWiJj?=
 =?us-ascii?Q?cS/5shPkviIGW5DANtuIH409XfJru9EiLpnA0cHp8Yx84m7o353A1v4MkDFW?=
 =?us-ascii?Q?ZhrPn4dPkuPu1tn707g14FAzwj9/40k2+bl0glTfySmHne5eR6c62jhlLPin?=
 =?us-ascii?Q?QJA5nw17GkRCXwQo8GORqUsCdvXHT5E7Ii3mdliAsJm96OHRFgr4EuTdmij+?=
 =?us-ascii?Q?Habyt5phNQqTyZsTzzJ6ghYUGDNNmHfepZl85yFsDVuoLt9ugMRBbEXgGJyp?=
 =?us-ascii?Q?0YYoYUl85PrU1XIYSW3pCVFE1Xtm61pMMJI/3rk/jwpZRGjeRO2YslCSahmD?=
 =?us-ascii?Q?anEowqeec4Ez6a8jv6u+Bvv9wy5dbre05Yq3ISi8ZCVTmPC+XYyTzAJmPZLU?=
 =?us-ascii?Q?noMkEHnOalZ1fOh/MPIYbkCF0wt7z5vXP7VNLTEvt2alwyTHlidaK/cVWSFr?=
 =?us-ascii?Q?WFAsDt1OC1aZtuhNF7CbDMuKicthY2dSgJkG6V2ap7ZKqGqkcnRtrJBb2Tem?=
 =?us-ascii?Q?kL0DYeaqGRNzdB/x/XFulKcFnmPfOWMh2rfwva5oE9Fo0e4gMpoGAa1MJvta?=
 =?us-ascii?Q?/2IV6z+yEpXCXdGCI56MNY9HVqC0Tdr8iD5zH+MabRY4JVslDTaPec4sD3eA?=
 =?us-ascii?Q?nheVNPxaoWBesrEKKs1q5OXJgZZ8kUN/Bu6pYVldhR9XhbZYK8ol94KXdlS6?=
 =?us-ascii?Q?96cMTLW4BN+2bfZk1YjhQFEnhRw5PmPA54audlfXkGyZrhRgDfGXIuladmbE?=
 =?us-ascii?Q?7YYIiN9pM90CcMXrswb7DdWE4SvTMmZHmMdpGqTQKLVHD6/25m2PeYQwBgDK?=
 =?us-ascii?Q?dmshKYVHRQWzqVSJHgeICwzDLNo/+mo2PW+WkaiR8f2DMfG1j69soY6r6SHo?=
 =?us-ascii?Q?PbLDrjZCURTjjgDnxZJDWcvRyuI9YuxX8h0ACrXk/Guj/TvLGQhGIdNpaI4L?=
 =?us-ascii?Q?l+DtKrq4aSSdDJAAfSocmjYNx03gCkJhsVhbJoOR7gWiC+2f0UhEqcOxHrbv?=
 =?us-ascii?Q?jDgYAMVikydT0Ntxvd8i8aTqkIHJmx4/6yE2wdBmOGmU3wRbkFbincaEcKig?=
 =?us-ascii?Q?OOIZFVNpG2rZWwTcYgQexGAmrrH93881Hqy+sjVcR920EjyCcLmsSLlIJMbn?=
 =?us-ascii?Q?vTNLZuwUCpcpvP+cFk0cl3UPMSyjWuouQAoZQkfvGnPNoBx1OTv/DFXolNd9?=
 =?us-ascii?Q?uqzmn+aYxUGqZomEas6IOiKISwkX3rlNfr/QNnLAkPyYo3Yn7uWBreqie2eM?=
 =?us-ascii?Q?y4w=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e399d8-137f-4117-d39c-08da6eebb4e7
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 09:46:26.0620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR03MB3607
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
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

