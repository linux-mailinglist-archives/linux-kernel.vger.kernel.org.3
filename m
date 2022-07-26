Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828F658103C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbiGZJqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbiGZJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:46:31 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2039.outbound.protection.outlook.com [40.92.52.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2BF3135F;
        Tue, 26 Jul 2022 02:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3FqFGupO5CmMWB0elICG1zHMqEUwED8cpVPDCxrtDYbUiJde42aaxOaJ9ZqveylJDYL0MLqUQxUtWnJnWfs2XedeYHKJLGjhTPAfpGj5dnh+EBowpSDPpiuQX1FnUt3C/74wI6BCFOqPNI+DqpKKhgEGtxCSjSt2/fcSMX8ChI+YLK7ebdmaBFKY9P2s/uhHBSDnfTSDMbTS5ABPmGQaPsZfJP+176UwcQfoTox/tXHnUcoy5b4yLIZ2TGjuJjmLQ0fE4I5ffeKW5bn46UNaQFC5HFc4msUkNOw6pzsstudi5h9uX3r7FqeFzQxmhjietaW6IEO39sWZn9OnKXsyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7I4D3a3U1+yINKzB4WpZqGM4Ch7A0f4OowHHbu4pKM=;
 b=Y6vTY8DtRxQ7U+ElGNCPcjGvJZ+QVPWKNdz5XT2Ajs1t25maiqJ1rlcBrW+wGad1sfXRZvC3cVbnQDWK9+u8AHucvy3nz8g7AV7Eznv2wE5Wx/kj2MKGRzo5kX+eGvFrhsCTyCDj3uOQ4LQPLec29n8oAZjEKMithmhoSVIsX2dMLqL+aBe8w9c1lqG03AChSLlqDvgCvedU+p7np5xy0dlkej/TaVgG5OfCMziPZ1Smr+olwCqtO0ixbL+OqHIYSDvCYqAwNeOgwf4J86DiltuHds1q6HjPjpO2inltfmzjvmhL0Q53fmckT+JLGXcNheiglMMRUqigsTtcRY369A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7I4D3a3U1+yINKzB4WpZqGM4Ch7A0f4OowHHbu4pKM=;
 b=iE/uClIwEF2hsVQEG3NwcEVJuUbcIEKc/Dja9DszA3DjOVBNpC4J/hJqMmTzr3A6/VUEQvyWr5/32+EUwhZnoPChvRo/SRxq+3wHftmS56wcJZtT8IPG0Tz/3jZpl9/JXPwot9NUTe8Kx28KrC4OOeYIQTzSqhnOKNtuzLBKK7IvKssNwgQo9FEpAin36NRXrfWacV+phG4OdnGhT4vq2sUjofoAf3IRsbRtMbgN1SNnKKUKquAqyFRcGOVm6ZjdrSa/6ICwRyIuhvM/F+IHydDdU0yG3y7nLbjs8HbAnqKxQSwu+cb0BNwaC9sL00yidlTXHD91ERsuAs7vLLXhtA==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 TYZPR03MB6669.apcprd03.prod.outlook.com (2603:1096:400:1f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Tue, 26 Jul
 2022 09:46:21 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::40c7:5bd7:216c:fa4c]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::40c7:5bd7:216c:fa4c%7]) with mapi id 15.20.5482.006; Tue, 26 Jul 2022
 09:46:21 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v8 2/3] arm64: dts: qcom: sc7280: Add herobrine-villager-r1
Date:   Tue, 26 Jul 2022 17:45:48 +0800
Message-ID: <SG2PR03MB500667CFE3F5F59585F8BA77CC949@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726094549.263899-1-jinghung.chen3@hotmail.com>
References: <20220726094549.263899-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [R9hYvxFNpPSS2Ek43FIuiZLh/jWIo7MR]
X-ClientProxiedBy: TYAPR01CA0010.jpnprd01.prod.outlook.com (2603:1096:404::22)
 To SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220726174436.v8.2.I3597cf44fd981ccfe889e4cbe099b332051468ae@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f3383ba-01c1-4de5-dba7-08da6eebb217
X-MS-TrafficTypeDiagnostic: TYZPR03MB6669:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VOiD5LOA1rlNDeQ90q6YkePWxilyIgcAniPiL11U+qWMs5T3Nrxp2d7/2Kpv3epFnGsxGq/JDIChOcUYQIA+i7Ndjp8AZW0hqLuyk8FW4zceltIsRW2bn7IyYR4fC7GWutWiT1lp3nKUTmBKT4H3eWjP62lNbplrok96xhW3StsZC370jlzMQBj7XS8gZ/64Vi1ykx43xG1o+0y1nffPMshwT3pIz1Uo7bxM6cbE6MBCn4oKV10yDF/6ERoxGQzulh3kFoBIKMA5r0Af2UjkGKEQyFsnesK+WLjLfx0qiPnJMT7B0yW1kH7z0VodhsHl2thqjdMyPFRlitfPuWgahUIsg/oFtR0AAU6Pf/cVnjUBSVrsgJ45QzsanQ2MVeT6NiXQTAfKMAFP7XZoE5AROiCjAbIyJKnfzFMo+bUyJUPfXMuLZpY6FEaKfHBssW4DWWd2fbsbtuEkMahVJ7SNnyTp6SLGL/IJofmmLNiLcEvCemIvUo4rA9SU9H/D0xYr/d1iPS7Ezn3jvBswzVsqPiCn80bSEHemVDPUszOhFS5rOSrzgw52kTEkqkdBVa4B555k5UyIeyNZb8e1ESxLdKnX58WmHEf8Ddywlc8fUiOQZfL6g585ZH0SMC/AJy6475Ry+AMMY8l+u4RUW+ujmQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EmXlgzXB3BoT2XXQSoCwp+ARRKMya8M0q4k+3vz+FccT5AjC9w6idTgZUPfs?=
 =?us-ascii?Q?R3OtDLKgWbsOHsNrjRXzaoXiEEOGxEGNrW2SR0xfoDi1V2N3G+kVgQPraigX?=
 =?us-ascii?Q?Q+9UW9FqpNjHPybiuO1tKTO8FQPUCJx2sn4SCP8ckVeO51tZ5uVR+PbkZERJ?=
 =?us-ascii?Q?p0d+MALytPxWmC1P5JQOld/aC4UD4Cru/mTaHLDTyg7bwxLJrBwHVPucfW3Y?=
 =?us-ascii?Q?FLxrVd+1WD3c3RfZcodGxBiR7mwjnDl1B0zYDKcV259AGmoDo+Ha2e82ETvb?=
 =?us-ascii?Q?RhI87bAdgX5+7F3VK9LrjucLK4s0UN2qtiEOmN+smjpqL2Lz4MAvmcBAlVMw?=
 =?us-ascii?Q?EIm37ZFTP/1r+ZEmuF+/YyReHx9SfzbdJgEu1WKaeUczVv0R7SCiQqT3p4L3?=
 =?us-ascii?Q?kNxzADqOBw0X8IX6MWflLPYC4rqgc6Xf7gkdrsghBdUWhD9ePxkH5hbc9Z2W?=
 =?us-ascii?Q?/1WdhWhNOldEADTa8i7ChT8YH0sy5sRKf6O+gV5ZHIMioMfpGuFg3DhnhruS?=
 =?us-ascii?Q?kJXT9ctNS8V7F0YrvvyWcquHBpHf6jFFnSXg5F6MxhaAEoLB5F7LYQvV5hx4?=
 =?us-ascii?Q?aPF81aQpj4skQsRn2JLdMu/yC8zGqwhEzRd2yFvorRNsWrLfIOq7pPHVWXBg?=
 =?us-ascii?Q?RaF6FTg5/6OvSvR9VoBuQIFimEHzJYHhBQB9RHmMyMyVG/1078uyeT4ltH6h?=
 =?us-ascii?Q?AbPnII4PVnMYuqmW58O/pNirJlGiH9r5yBs2WQa+CfIIdmAE54CE9429z/By?=
 =?us-ascii?Q?jO451Zs9Bvspm71K0RN8g0ybLkaYbz6pScWDNwCxCETtDfk2kWigQC4oNAxg?=
 =?us-ascii?Q?rgHd/vLHvJ+Inv1TI0HKY3lp8XLbjwo3WNjfDE/W9Kp9gWngELVDollsWmYn?=
 =?us-ascii?Q?GiGmCIlelLHV/jzEYu9B2SfNVJYA5qoHXZIRG5pv+ZL1Y/CF8pHQ2wuA5rg1?=
 =?us-ascii?Q?aWEcUwZorCTdQXgu6m0eaW2HZwOAYrL+7D+Pr1e2RkNuBNXeX5kinDLPIDXl?=
 =?us-ascii?Q?U21bvoYckYs7xgkI/HgfE5yAvA9+v9PXIUJfm7USLfXk9ZzVa/El4IOre0RY?=
 =?us-ascii?Q?PrQXMsj/9N+IzEqvqWX7elpTj27FdQdfSHomMTw+EzMeHLPUkT8iffld4Ysj?=
 =?us-ascii?Q?Ox2kYc7wuF2cQ9JNpkgw2GaPYkltnD547I5yo9G5KoTbDZwJZENyRoM51x9e?=
 =?us-ascii?Q?dS3TQyTx7NExPyvx5LIUcbC6l+CfVBoSLK6Had8eqSriwr+tXXOdLPjMU+go?=
 =?us-ascii?Q?wSAZdMKv87oFb/59RYTPJZ5zjCO3rZ2Hw/g2wss0/aYtJ2hl96kE4YioPthZ?=
 =?us-ascii?Q?lHE=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3383ba-01c1-4de5-dba7-08da6eebb217
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 09:46:21.2967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6669
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

(no changes since v7)

Changes in v7:
-Revise typo 'ARCG' to 'ARCH' in Makefile

Changes in v6:
-no changes

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
index 9e2a13d75f9de..2c1605e00d349 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -103,6 +103,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1.dtb
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

