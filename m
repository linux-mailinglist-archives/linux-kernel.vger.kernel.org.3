Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9453566120
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiGECWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiGECWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:22:37 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2083.outbound.protection.outlook.com [40.92.107.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5735A65F1;
        Mon,  4 Jul 2022 19:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaGKbc13Jbd0XSE/MPLx3Mnjo/7+P4dfrTOKwPefVxZDPm1zTpMpU79LSa/EUzfnqB6pgVcxVDecGl76E/3hc7SL/zdOns50nYqG5qMk37UYT8a9cPgJx8KCoXHt2pFtn4ZQasn6z6HaEbblqByC6vPxmFYguxjV8DGZCrvyUAKr1JXGUbUm+MWP2mUDfVhg1vkN6LnQp3omR88csbvebO3tWvoOfFYoR0j3eI6C+HedsDnopvix8tNCsnxqFKjXvda7suT+/sWZdhjjcyKlPVGit5t5vYMECXXliBq3aKE169JwfU2SZ6al4P9Ph3+4b6qeIp4VVEZ9UTVi96Qe+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bZvsyru487tBJnaBrKMsNYfaT78UUAlv7JCNqrExR0=;
 b=ei7tLwbjG98fh2aOUg6oeRx2kn6D+3F8F9uetFLXDfl5/lAiXk+buQtzsFh5wMnUWBhNU4B+MV4cMbzBz6WJKDhIxVG26Ck0QTNUhwGg/LXC5Ge0TQcgoew/70mBdO8qjYNdrKm9Q9K2Je9dbDjFP6n2dEFHvj+2PGjPhTZjxUYlfpwFX/SG+Gy+xUn3o1tVk+MOQ9nd6EoYSDEFfqUCflbFc0B6iHKxp8ksNf5lit2uLf00jLO9sOHtE7NTo/g84MqUQoYQ0fZJRbf2lCNrZF5jjrD9CkjLY+h1eN5dpNVAzU7c16C1YNgU36QPcYJ9P6hH08HMn9zpr7IUO+9yCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bZvsyru487tBJnaBrKMsNYfaT78UUAlv7JCNqrExR0=;
 b=YVUwFcRU1e5drWn+lmQNmyvA7kC36+0FBnOfz4LNWHyKcxpRrckcFu3irx6dwhd7kt6Lqeq5bV7VVK2xC7I6xi1Be3HsLOnVu9VBcxNQzER7egk8jViEmJAMXQkpQ3FdzUCnOPGz52qRKgQYEbI/LgsyyG4s6idP/dlxMMK8bkd2kFV7or70ofvUmSODz8ZrzmPYfTpdTiqm3hJweqkY9R5Dl8PdSszIbGuk6nXGOnxy65rN7lOGeHOl8E9FjNXr2qzlecxpVPTyeYtxX8CWM1cKlRizcIbCLN/KhPRmo46O2emzN91FrMYvEgidAoyQj3vN1oAfW2oi9VjH/pSzCA==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 KL1PR03MB5063.apcprd03.prod.outlook.com (2603:1096:820:7::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.13; Tue, 5 Jul 2022 02:22:31 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5417.012; Tue, 5 Jul 2022
 02:22:31 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] [PATCH v2 2/2] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
Date:   Tue,  5 Jul 2022 10:22:14 +0800
Message-ID: <SG2PR03MB500697A11DA5D0B45DE41B0ECC819@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [I4DxFypmfU1tb9Db35AZKj9sxRGKL5v2]
X-ClientProxiedBy: TYBP286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::36) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220705102201.2.I31e05d3184dbcf0578b32593fe5d150b80a46624@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32951e30-fd67-4b21-ca9c-08da5e2d36f6
X-MS-TrafficTypeDiagnostic: KL1PR03MB5063:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mD+a+0o02VAenL/dmyDfw1YtoZAuzT9SxsZI4HdCPDRlzEhJAy027lcx1oeB8AEgFAXQh9zahOAl70UDMq388l9VnmEjF7aYwkbIrY+qR+lfedHtKCziOvdILVd+W+yl6WrH3Burq2AbGBSBefdLL6yloKCYKVArNALDiOSfGRk/WQ43x9vpZn7V3CIl8mq7dxEHJZi6hC1OlzGdJtihdavnb+2uy/+VKGvRIOO85cmN8z8kPA2V47Wawjxz36XVX3kN55ceY9yJ7lyx636CNmd62amrPTniW/jR/kWXhuCurLM0HScBb0LMQDT/kHs2m59zRItGfpA5HbjICIMHmNEB0nsBBJNb0YWmfQNQquBwwzBPeT5FKfWWcm2RWC2tZK1T//rSqRbM7QFq6O9tU+s8WwoJuR4x0qVcthy8qXV7SDJoMJIQxBp1YzdE7yTVqGUyyknTw2zIwRAJLKCAqj4deuHRYGw4arJMLQKfHcuhCF0AB2n4xEyuECKEViBpwI6Ij8kVDVK1L17AerQA++gFFIH96puPDcn/r8E7cE1GmooeJlHtS2gFhTgsuOPW3J+YZx6b5c2pNfiAae6h+I6MGPk2GDQj+gsUYCbUMy5Zb1KwuY04Sj1hb9lFLGtI9cs9cKNeArjVKfoUY/CyVw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?16o/sZcUZP79ZcsC0XjG7IKgAls6T68L8x+H6a+DpGSQDnF0gcq5xXtResME?=
 =?us-ascii?Q?BEmUnk3BfknCV01Sefd5j6hXKEQPhtSkSoRHiH/HLBEvnayJZmI9Ke1tKFkZ?=
 =?us-ascii?Q?al0MNhMhZeJU01PRc+u4GrTFxkBdtFJPmIEdvw9ars9yGHkzqPTlnzPEd9bd?=
 =?us-ascii?Q?jDgsqdpuahbUegT7kcWtNoMRvFODA6jzc91JVp3/zi2cmvnHC65Bwkhq7yc7?=
 =?us-ascii?Q?3pD21/cYKKEllydOi0Z0tusIQKs3vcK5fVqzWkDNv8P7V4zCThPP8KyGcydN?=
 =?us-ascii?Q?MppBkGiYXwhV7NUcjZBZ6JW0VM8VWwUDK7tFP/yyoVfvEWgQnOuXgxtEvHbD?=
 =?us-ascii?Q?XbdpxcHtFhj+mXR/eYWB+nmO7Rh4jZSfChyiFzlZ75Lk6Gf3596IzJl27cmc?=
 =?us-ascii?Q?INrCLCduY+XApD4r8vNqst2eGN7Q0lX+WW5j89zMazNDzGwWa1L9ZKvHtbhy?=
 =?us-ascii?Q?/jBhF/lS7EvNjwdRGvKs3rtY6N1FWYKzhaji+OoEz0twTvJj1Yj6kw4jj1r4?=
 =?us-ascii?Q?YPoxmeC/zMvmjYkln6MylOBs8lmmO7EdncPxRf45yFYjbEo6P8wvL/sbGrkt?=
 =?us-ascii?Q?uDocZgP/ulBVzkOGyJuSOEn13L4+bXsrLpVzc1ITtTk+u7UgGbYnpNefpDKk?=
 =?us-ascii?Q?okBcU+29R082BAVoWX1KLtGbSl3BcuWY3kmvtgY8r6v2iXZu8+t2916VSC1b?=
 =?us-ascii?Q?ksgYnWfFoKELfYl6d50nle1S2VSv1h/mtkEXQ1++FhO82kydQ2cx7Nluwoi5?=
 =?us-ascii?Q?8Gqfc6e4oEHNDqL5ZrSn+Gh8p+H2wRxs5ljrMvm6tOVaot6QE5Fxw0qIPo4I?=
 =?us-ascii?Q?AF7Jw9A5xFH0FA7JaakDaGZvuG98HUMuii3dV5YcGpK2D/38lZdIbfTIYPHd?=
 =?us-ascii?Q?XC7XwvIPF8Gy5KFceDsg3ocnjgFan37F75oChLxoAkIi/g/YTUODa+33Zw11?=
 =?us-ascii?Q?eNGOMZcKrM3/h/xbr2Mrleh/r9Fy0NBwOAsRkv9dkfn0+5CovjIkZYgn0xoO?=
 =?us-ascii?Q?C0r+3pjRVstkx/6Pj7o4QRv68TSlaOfaEZivc8fUjjfK78mGuLWX6pqe0HUP?=
 =?us-ascii?Q?kkLYwQm6NKlM2wLRcjr+GTC2Ov1VxMW/pp3eBySwosgfbfSBbFC3ScWOTsiY?=
 =?us-ascii?Q?O8Ll6IRCc5ltc1uwAgZuiek1Ugz0Ld1O1uQkEyYQDqTqT3cBaHeknzvYWpSf?=
 =?us-ascii?Q?Ex1UKD1ihyXgs5slEVLluErLhc/ymDNbE+qRjsFZ17MlzqzWCKWJqITvG1c0?=
 =?us-ascii?Q?5iWF6ZdGijy6fO0U8kckqtM1vNYqFlWLNbdFCXUCRQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 32951e30-fd67-4b21-ca9c-08da5e2d36f6
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 02:22:31.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5063
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds LTE skus for villager device tree files.

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
---

 arch/arm64/boot/dts/qcom/Makefile                 |  2 ++
 .../arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 11 -----------
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts |  1 +
 .../dts/qcom/sc7280-herobrine-herobrine-r1.dts    |  1 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi   | 15 +++++++++++++++
 .../dts/qcom/sc7280-herobrine-villager-r0-lte.dts | 14 ++++++++++++++
 .../dts/qcom/sc7280-herobrine-villager-r1-lte.dts | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts           |  1 +
 8 files changed, 48 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index bb9f4eb3e65a0..6d81ff12f5af2 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -103,6 +103,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0-lte.dtb
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
index 0000000000000..a4809dd2f4e8a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Herobrine dts fragment for LTE SKUs
+ *
+ * Copyright 2022 Google LLC.
+ */
+/* Modem setup is different on Chrome setups than typical Qualcomm setup */
+&remoteproc_mpss {
+	status = "okay";
+	compatible = "qcom,sc7280-mss-pil";
+	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
+	memory-region = <&mba_mem>, <&mpss_mem>;
+	firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
+			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
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

