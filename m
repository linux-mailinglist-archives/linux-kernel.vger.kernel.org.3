Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A125577C96
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiGRHbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiGRHbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:31:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2018.outbound.protection.outlook.com [40.92.53.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E548F175AF;
        Mon, 18 Jul 2022 00:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak+DbFe+VT498t7GYkqYlhmHsEOBHS4+QQ6867raMmjtxoYXx1m0VQHVjLXvKpRw/TRrPoFZRlnIOqSpAgPskcKMH+PfrRFUP75RtjRdW3izSsG74faHN6+j7W72zUjCKidtOmLOWMwFRyIomn7su7X6qJLK43St1IfIXyqEkmYmm73dboVDbbrcorVUCKcCuXnsEfIi4z4DelNJpmB4dmTwikKnFsDUbQhIkzTBszJ4hutyGGFcm7msEe6nIR0QQD60Cesuio1cQOp+7vb0fBgFnLvOx1QiLKgSt1FfjySG8aOJ4LaOUkn/gnzsyUHsVzb0ev9PCsftCPZJQvc3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kbmv+yojO9J7V6S/tOI0QVvpyzEag+p7DEJugFZ03rg=;
 b=FevbhI3jW02ISGqTUXab0ofVwe59YHPbcRvIuriVEXVRxlOBPQoDUtYiy1wsJZ9LcLXwBeX8qFCzl6sZJoU0VMa75AyeHC5HJawQC67fLBp6XQ0pp740PiaaJ0wkoEfLY5PhKisy0KQajSzZJeO1mHBUS+UTHXskyL5BNSFF2odSDliWrpVzmhx0PECVkczxfDxgXBXsgu/ktd/L5qU/NNAI5fzQhHo+XGr4QZb04DqFdZet7xMqKXRldMXHJ0IyF5u1Ds4scwxaUsudPfr31qwt1je8gboC/f/A5B2Yv2Ali3j0VD9aktf9PplqSY2NP5YBTX+Mp6bMY/hPXdWctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbmv+yojO9J7V6S/tOI0QVvpyzEag+p7DEJugFZ03rg=;
 b=T6x/ugk8TtFCjhpYKNgyKSqg5rimFQHIiNeheUmBR8VivzWDj7jJUKOqvyd1PFLHUHVgvpAcADmxr3LSU8Zifq/JOnF/TQLvL8ihNVIjE9PnromevN3D1Y6nRH5HwPdsUv3Q7TqBqtZYE4sAL1FMLgzrn1E2OYwBv6n/qZl/zbn6W+ts//tI8WTJCUgz4rKbuVf1SI6+V3Qjbr0avdfhT2swH7PXjF0FVeGPkiSwo/k8zqBwFBfjyCBEWdctkwWSbRJDc2RbtKSyYlXkPCJ1dNkwEX9QGdQ91qZwSP9Gt4vfn/g6OQ1J4qMrir8ySjOmHRtjiVnvoGbh8mXN4YxUgA==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 SI2PR03MB5468.apcprd03.prod.outlook.com (2603:1096:4:104::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.11; Mon, 18 Jul 2022 07:31:39 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5458.015; Mon, 18 Jul 2022
 07:31:39 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 2/3] arm64: dts: qcom: sc7280: Add herobrine-villager-r1
Date:   Mon, 18 Jul 2022 15:31:03 +0800
Message-ID: <SG2PR03MB50066FD60DA7EE59B0E112F5CC8C9@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718073104.146985-1-jinghung.chen3@hotmail.com>
References: <20220718073104.146985-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [BE02+b2GbrXy+JxyQI46kz2HSSYPD+Ok]
X-ClientProxiedBy: TYCP286CA0136.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::20) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220718153048.v6.2.Id8ba3ec73f9a0373a4f5778b4f8157e5732f74e3@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a70280a8-3c1b-4046-64f7-08da688f8db7
X-MS-TrafficTypeDiagnostic: SI2PR03MB5468:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULpDmwd7qoD747pzRC8fPVgMLU4Kl8WcuaXkFSbolO9EtxU7AmL1fKJvahNwBNhJIcLIGWzvAyYIww4dYyoZhHQqKfzZa1l3X+oYG9hPVypabblhxbaGE6qgRIkh84fX4Z0Y2gb6oqf6BUux54Kks5XxfX1eyTF8XJt2ZWMhohFMg7CX+E4xEth/BbF3YcYkjH2oVdWznS1HQjNTfHDYODTsWxygHjN8+uGmlesnrBJZO6YaLFmWDN+R5hzXN0V3k96dIWGMyrG5dJZbdoVq/e/8II7sI9J/z1p3u9biCQrIQblKCkMFFF0Obii9RDOZhlCA+VBuxuUggd+ix7NOP+JJX7RN/vEl4OKTqC9lCZ0tS1j8jGnGIFVYrTxbaQepNmfYA7Fru+89fZPoxEHvsYYdgN05Dd/mHycOaf3BgnRs9rDNAp8CtZ5m1xjeNuHJ+RUrr2IWR8v48n3U49WfNAt/V+7125NimK53exwI4NhznkeEE73Xh4UxD6gZgrCFLy/IOeigwiwA/TMjSfI4fu3WzMQl476NQFXzY0x52tsPpMAtht5RVWIjRXkYBduhPHVfMl2Fqekm6HhKfyT5eGUsJJQlZnAuvCqW5Mi+pgaaWNxFgoUHo/WG+BVqwXaDVXRxu306ofhqZq/UGP8AAA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FP8DX5NvSlUHez8rLWtiHr6EqCaml+DU7+ekre9ndKUxCS9MRkzTp51BN58m?=
 =?us-ascii?Q?+FiYzsPB0gAyc5Noyb+vb2NpUnnYhCUI5i/lswWRMeRO3IMLP6QQ5aTkyPFN?=
 =?us-ascii?Q?Dg4Y77g2adNqlxZF/g8jdjA32stmsTqiD4dVlbCM4n+5hINVQrVQNiWWvVhH?=
 =?us-ascii?Q?SR+od/QUqS0/X7cQg4OcWTZL6IQbaK3itNxAZGKvXOk3Sw6nIyQsyOvgoCKn?=
 =?us-ascii?Q?TyF1pJc7eFydn3rKAdZADkUTtB1o0k2oTvnHzHUyOe5UJXTdIMovezmgcqZF?=
 =?us-ascii?Q?eFsfmEQ/QqmFPoiA6nu98oM69yxo55rKlcSHz7NqZg/OAcVlS8KxR0/vCA5M?=
 =?us-ascii?Q?iW/XYfFoPao35/xH+yx1aWnM51hI2U1YBhx+tGGxwcaJGQQU6UHTTpeUktNi?=
 =?us-ascii?Q?/ckJI6Aoehra489KI6DABa+8mMGgBrztbUNjT9jpl/k8Nfc4dooJmll4KmUu?=
 =?us-ascii?Q?vFlYslMUVqTb3KVSEYvOOYOGHyNcYB1d0kkO5x9cKcmcKYUYv6CQtSCT0vk2?=
 =?us-ascii?Q?KWejhTXZ0FehYws2gI0qU4x794fuFLhv2BS71YNBdzJkJ5t4qp681sec31m7?=
 =?us-ascii?Q?v5qHhI+yC2ZKPzR0/Ad5gwVNTrOEAGDGNvf3wXdKCDxA4AAcAe/f+U2YV98C?=
 =?us-ascii?Q?w8PfPa6tbJI9O7D838xTHqNrpDG8CXxiY1m4cD71EuRa/LgKa2Uyy+saYRGr?=
 =?us-ascii?Q?440qhEncZMPVMRGH7ShvYRYHMWl6PktoZQcOx/bTZckFmkwHMFLT3afl4WvO?=
 =?us-ascii?Q?bXLLVHtMOFaDyOCTBsxf6fa246E/WDOxOXY2FruLEbtgGjaImRs/uol/Iyav?=
 =?us-ascii?Q?t99Fbu2g+bKE+cVYm7j/nnfDifGbjsvZknFJmP8Y1/nrlgc66Qsg6I5LIvip?=
 =?us-ascii?Q?dNE99MKQaSwswLz5nsJs7H25pU8xQPh/YLWOsyc1MSU67Jf1+kdxh6u60d8p?=
 =?us-ascii?Q?u9RD217R0dNvvjgxFrVDRfhnPrukUCI6qAdS6SpDGIko3E+LJ7jwsNzd8Ho+?=
 =?us-ascii?Q?d47Nusxn+3a5e8XWQ77W0ACVNoHutCGuVUhyA/s44UFVeG7vMPSR/DIOhrJy?=
 =?us-ascii?Q?6wbKur1yBvp/VJ2oJwTl832JxdcpQ157hpbJbyF+acGvx4WSp6unIY+FIIeR?=
 =?us-ascii?Q?cJVbztW0TNjVBHghgH23VA/gwTba1DbEO+CdQXIrH5qtOoR2QxjcsHIyEBhU?=
 =?us-ascii?Q?iEwC16Din/Jn0TIAkeO/Dnmw5rCLamNmjoBO11TQv3TI4IKdwmVuKsvOb7pi?=
 =?us-ascii?Q?PLnuzE/O1YBod/uoj4R8eBmtTm/B+9bBt1qdaa7Iqefpi8DTR0TE+K6tuCyC?=
 =?us-ascii?Q?OaE=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a70280a8-3c1b-4046-64f7-08da688f8db7
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 07:31:39.6064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5468
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds sc7280-herobrine-villager-r1.dts for villager device tree files.
Herobrine-r1 is exactly the same as -r0 except that it uses a
different audio solution (it uses the same one as the CRD).

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v5)

Changes in v5:
-Revise rev0+ to rev0
-Add -r1 line to the Makefile

Changes in v4:
-Add this patch

 arch/arm64/boot/dts/qcom/Makefile                  |  1 +
 .../boot/dts/qcom/sc7280-herobrine-villager-r0.dts |  4 ++--
 .../boot/dts/qcom/sc7280-herobrine-villager-r1.dts | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 9e2a13d75f9de..7e6a4d7ef3266 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -103,6 +103,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
+dtb-$(CONFIG_ARCG_QCOM)	+= sc7280-herobrine-villager-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
index 2cacafd8faa8d..cbd8a2d1ef2a7 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
@@ -10,8 +10,8 @@
 #include "sc7280-herobrine.dtsi"
 
 / {
-	model = "Google Villager (rev0+)";
-	compatible = "google,villager", "qcom,sc7280";
+	model = "Google Villager (rev0)";
+	compatible = "google,villager-rev0", "qcom,sc7280";
 };
 
 /*
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
new file mode 100644
index 0000000000000..c03b3ae4de506
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Villager board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7280-herobrine-villager-r0.dts"
+#include "sc7280-herobrine-audio-wcd9385.dtsi"
+
+/ {
+	model = "Google Villager (rev1+)";
+	compatible = "google,villager", "qcom,sc7280";
+};
-- 
2.25.1

