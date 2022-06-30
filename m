Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B18D561271
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiF3G1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiF3G1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:27:17 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2092.outbound.protection.outlook.com [40.92.52.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E3D1D326;
        Wed, 29 Jun 2022 23:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMvPTuUqW36vagX6hbpusjq0qyV2BK55rw1mGwOxUqP/q2NMJjepipyNvalwS1jbUsZsc/U0GRFLavO2j+AfVc5htFkonESmL4sLzRtMvRbpfDawwI7CdNSzZI6xYmfqWYtm0eYsXulKowppcDezDx/VUtSGWBYA++xYa4jDXUO0U/6ikPSrSmLsp/89xVh3gISyRuie2gymRY1ZvM+GEx/gEh3H0/ubrASrtl88M/ssHu9clH6PfIfeQBg0Vn2jdx4VGz0H5lHfGz2xh0ko1En01EtdprHmJ8pcA8N8JjNmCfot0fK6SrDZzBKDnXEDzenNVM/s0OIptlclrhihzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSeDyNtG+4aAdWclFARFt0icYdHuIJqoWwouK3s8DSU=;
 b=VMVutzlfS7Ac9ChLXAwk6D1H0MMNP9QSmFNoZNEenp0ODWkr9vwY9hlB2AXqJ7NyGOALbgpSTK3PsRoctd1ljNdWvpmMG482e7nKCP8Km2CHzFsBo7INK6IUf9VTt0I5D5cimof+43zuTHBX/tcKW2lrBfPGIxYkqgJI6w14kLfzlN6O/RoAmsm/0cDnZd4UP33EF4q+UwzyajDJ7RzXudWZ0BhwBaj5wTFvkahUg2ODBCFnGCEpXchUDnbsXNGSuM7b6Pnvy0TgSTDZSgdk0oAs7EHJJ5fZY1PP0NzMSnnoOLC6/XEoepYQhmyhKC6cfJa6baO2/CZJ2MiuM1KzXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSeDyNtG+4aAdWclFARFt0icYdHuIJqoWwouK3s8DSU=;
 b=myTg3fp0H5t5vsIfXa1wzwF6bSZbrscoArTWZAaeKGe9ZsWYKXUHpPkQslT1pIrhP5J7D4AXyZzQlOj8PuX7+OiPGMVh4qrt17/3rV3C5N5iDhEpnJUG3viT3NYAHZZSeqpvmGspvgr9YtcP1wxxqJfD45GwL+By8Z7vOKxTqBJz6zsx3JE6VL5rCYAdTz4knkWKF0X+NszcSl+O8C5V5dXzsHQ3fTvfRZ4UxAaRLyv0kVBgq/C/Z21J/UAWDFlzC8rADvPGXGmblgRvKcpgBU2znWOAc2RlmEB5Xl0FyJOCjAvMy+0oHzvWdw90MfntHqSk7Grs11X3wCvFcgw55g==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 KL1PR03MB5538.apcprd03.prod.outlook.com (2603:1096:820:5e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.11; Thu, 30 Jun 2022 06:27:11 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5395.011; Thu, 30 Jun 2022
 06:27:11 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     swboyd@chromium.org, dianders@chromium.org,
        Jimmy Chen <jinghung.chen43@yahoo.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] FROMLIST: arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
Date:   Thu, 30 Jun 2022 14:26:54 +0800
Message-ID: <SG2PR03MB5006F091C2016ADE8A9A208ECCBA9@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [xUIUf/HMN62igs8ujRZlgvQz3915EiukjBc29IDz/LW2HRga5zlERHsr0TV3hNxU]
X-ClientProxiedBy: TYXPR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:403:a::36) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220630142652.1.Id6e9a249abdfc8a2a2c41364ba249fcaf51d7dd8@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5be7f2e7-89a4-459a-7705-08da5a619092
X-MS-TrafficTypeDiagnostic: KL1PR03MB5538:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9XMbLmYCBTnIYfxmU0qCHt9uy3l3tnIJNYfo8iWBC8yR21u3VpimiEToaDbKNdtZ+4PGqKr9GFbk3HiwRsH4qA2DJCq3WCDqTuTFWMdRa603JFdws+Df+hI1Ai9omgTnakZAv4Y+6gSCEFtISJOTlcstknqBOt/WWd/CSTNuoMYy6aDy2VbAd+CZEuNmt+DeIDHDuagNCZkeF7PkdhSPAB3oisyD0sxDQw4cql5UEPiNrIsfbLSKhCFzqAdmqC8HgjvxHhjOMXHzIH1S6VLRI7GTPlNzw3RfCfsDdVFaBCm3+bbHb2cloYZzI96AnYrLGJBzoZw22Yu3lIWXrvXMqVxI2p/K4BAz2kFSgEiyncIJx9q3jerzb976ud7N+Lo0V23F2/5fnS5se55gCf5u1mbqfO/n3fqoHIQ3YUgt5fMIJNT74WLL51XQalS9PYHPipNlQaYb+7SE73hmLKeZck284EBqD1rwVxYVaXnYAsMvnUYO+VQ3xuiE3+VBBhcAjWBMJVJtrQfGvJOz3s5wR9Bg3MrOWeLmrroVhV3qs2PghGZyUtIQgAJRWZRLBxGe+I1Bfbs31StY10n+FHRt+JtPueomLsbwWkimcIh3fWqM649yNSffOCdKFF6LKksHObjLEhCor/uEHog+1vxQqA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kQBIOElOMBuQhjv2l31BJ31cxNKi/fme9COnWoMXG9u4z5XeY8ba5uzOqO/H?=
 =?us-ascii?Q?5QPMegJjgRG+LQa9QJ2mm2VE+yYNihCVFfjivb5WHobEXLFAOnVwglumVRuX?=
 =?us-ascii?Q?jtNTIAMuRpVd4k8LaGBnvdXfGMEI/Jv7qV+1ifOAPZ23kYtSbC1VthdDXvrH?=
 =?us-ascii?Q?+80O+w01nsSwy4UTOuweMb9mpNs0poTtOiyXwJzEnUL7VNRU2lgSxkZiKL5l?=
 =?us-ascii?Q?dJoXhATUUAiGk0TRKLWNbqRBKwLMxUNIl0pCq8Tv05WvR3434x0zHyQ0gIgV?=
 =?us-ascii?Q?w8KXBU6INr29dsPTuePnCs1OL/SQhuNMJMmC4R0CSCI7KM0Zne38QwEqMZYO?=
 =?us-ascii?Q?M1J3TSeEgflH4O/pHTxZLsNe8ToVyk7VeECoX/r8+1FhPXXuvHPdX+QB44Jp?=
 =?us-ascii?Q?LhYKv5Y9hnNMizfNhdoOQ1u9bgfBuOwvO9Hu0Lzc2qxEonMLbiqHMNEmcvLK?=
 =?us-ascii?Q?vTOpZyBSc7/Bla6YT+pqkyiac0QpNCizATFC2iYW3QBDekIgR6adXhQaa0qE?=
 =?us-ascii?Q?FK1D7gOCtuRIf4EsBMwKwoKVymgio74qWRtb8YqwgVJ24XxcQnISP9lxQftr?=
 =?us-ascii?Q?KbY/jmR8ewIIlZxgn2B63oWfnr++AdlqxQId5ubNU7vIZ1XOxl65SZ0JJPaq?=
 =?us-ascii?Q?bHV53PvEYrcczzgba6q09nJlTG6+KUgIFGLuAkUzhOZjqAsnak5g3HZD2+ZY?=
 =?us-ascii?Q?KgxJnDlUtvNUdu4UzGWQxvjEy+nGOUJgswlURDHc8SIXICX44pVjlKQNe4Bx?=
 =?us-ascii?Q?GY/gFfoujddbfcM3MDukgTAzs0gZLjMHmgisgB1ILTaEx3jByvFsHvGDptYf?=
 =?us-ascii?Q?UtZx3XWLwBc57yjUn9SHQdCqzLaQgvW/+sFvCYZCpDMlYkSRf0s97tA2qH4Z?=
 =?us-ascii?Q?h/BxsSBq29sSHaUjExIdKIuYFnxNa2HgHyvUPzjCmVba7gT4FVRqgLjU7cK9?=
 =?us-ascii?Q?q4yR4zrBK3XwpbLAP8kHQ04I5XbHq446YONib9t7U83upSM8xfZkNSvWCk3h?=
 =?us-ascii?Q?2UdgjgbtqsWsahsjygLAsibOEZwaB5ZuBT8L0oRXNHXV43E6MK52jXAMhsEX?=
 =?us-ascii?Q?AE84QApE1wxlbcdfBc5Ft3jYznPVTBD2sx5N3frOrcZNu/xCL53jIv96F2PU?=
 =?us-ascii?Q?eUmhEvwFNCybZLwoEAVgZbjH+vHTD22H6VHeaUtCdBlPkON3Po7Sf4zFX0cK?=
 =?us-ascii?Q?F+7zL/2OtvJW7ghBvTeuEY8r0mJ+40eiF+AkM1xpnle2TdDS3/NTI5fKF/qL?=
 =?us-ascii?Q?JtEEOMQcXWG5taa8KV5/SSvBNqv1G0/VJuCIPvMHP5eUUEHDd7r5MFSuiORE?=
 =?us-ascii?Q?CIL6NJY6DMsqTr3aHpi80ksumEfBbn00dfN6nagVWVC1Izm5aUDKZjLZetv0?=
 =?us-ascii?Q?v8fKmX8=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be7f2e7-89a4-459a-7705-08da5a619092
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 06:27:11.4879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5538
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jimmy Chen <jinghung.chen43@yahoo.com>

This adds LTE skus for villager device tree files.

Signed-off-by: Jimmy Chen <jinghung.chen43@yahoo.com>
Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
---

 arch/arm64/boot/dts/qcom/Makefile                 |  3 +++
 .../arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |  7 -------
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts |  1 +
 .../qcom/sc7280-herobrine-herobrine-r1-lte.dts    | 14 ++++++++++++++
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi   | 15 +++++++++++++++
 .../dts/qcom/sc7280-herobrine-villager-r0-lte.dts | 14 ++++++++++++++
 .../dts/qcom/sc7280-herobrine-villager-r1-lte.dts | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi          |  1 +
 8 files changed, 62 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2f8aec2cc6db6..ab1066883c468 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -85,7 +85,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
+dtb-$(CONFIG_ARCH_QCOM) += sc7280-herobrine-herobrine-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
+dtb-$(CONFIG_ARCH_QCOM) += sc7280-herobrine-villager-r0-lte.dtb
+dtb-$(CONFIG_ARCH_QCOM) += sc7280-herobrine-villager-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index 9f4a9c263c351..b1f83ddb4e23a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -83,13 +83,6 @@ spi_flash: flash@0 {
 	};
 };
 
-/* Modem setup is different on Chrome setups than typical Qualcomm setup */
-&remoteproc_mpss {
-	status = "okay";
-	compatible = "qcom,sc7280-mss-pil";
-	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
-	memory-region = <&mba_mem>, <&mpss_mem>;
-};
 
 /* Increase the size from 2.5MB to 8MB */
 &rmtfs_mem {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index a4ac33c4fd59a..7aaba5e51af01 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7280-herobrine.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1-lte.dts
new file mode 100644
index 0000000000000..e37773fd63b3b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1-lte.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Herobrine board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7280-herobrine-villager-r0.dts"
+#include "sc7280-herobrine-lte-sku.dtsi"
+
+/{
+	model = "Google Herobrine (rev1+) with LTE";
+	compatible = "google,herobrine-sku0", "qcom,sc7280";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
new file mode 100644
index 0000000000000..c628910b310d3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+  /*
+   * Google Herobrine dts fragment for LTE SKUs
+   *
+   * Copyright 2022 Google LLC.
+   */
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
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 5eb668991e249..6928a0908fcd6 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -13,6 +13,7 @@
 #include "pmk8350.dtsi"
 
 #include "sc7280-chrome-common.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	aliases {
-- 
2.25.1

