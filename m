Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3F957DBF5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiGVIMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbiGVIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:12:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2037.outbound.protection.outlook.com [40.92.53.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C25C9D518;
        Fri, 22 Jul 2022 01:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO5qia7XT1jljGhMTMKBcFSSfh17WFwY1yxSOqm31jNHfe0pRqc7iMBJ4Dcy2iFQ9hOhJhFY68va6UOavkHE6N+kbRWA09Hm03iIjZxJbQGWq45915iPxs3WSSHKJGscIZVzfQTa05VKcqHXnc9kr4xX6Q0YJHf7MFJrru5sPyvYgpWMN8VEIQ5FiE/kngYmlntiokD1EQQsMqb1ltmkf5lowMyu1G/fn28jagV+ZgVIEOvizATZMShnCwS4wTeK4MGXi9H7U8u2WkpECqpETjL15G8kOG0lmTiGEHniWGTan/e1T/5YQ/lluxWRCo6xAjqT92X/Dk+lt5hQjhsn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ujww9TlTMfcVKDjg3QrSmYrEzsZ+YcGJ/aSamEoRJk=;
 b=QkIqcrxdaSDxZuqZKNrSL5F8yaFZrntSuqDVuf0cAJbqC75j/qTDRTBaLAVvmzccd0QRgdYvTNzgQudzpgaa45pwjOQsp2GlZxWb0fBGahrhHeCVEIf5YIbtm/L6MIGP+phW9sasF4s4GAMRbUq+UBOUNKTfVxh4H0wmbR10/wZimjGM2K7lBYjUYEwdbr/fAwxbSANCi4T0bLcSBVBBr83Ted0ArfaAJ0iSr6TJ5EWbpMxoMoa+ELy3vDTYDq0GkSbo3kM2je+i0vX3DBmixuTag/r2QY3xaph2J6jqkPG36eN7FJ+TfaRjn9Q2lX49SgB3xeXZeSlwftKA4LFocQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ujww9TlTMfcVKDjg3QrSmYrEzsZ+YcGJ/aSamEoRJk=;
 b=V+8OQ5ko6RRGhwiebhKGz5B5Kmo9ED2DH1qeKJs3aYQihqFi7SITA3DanujIpNormjsEyFdg1a5X18yx6IH/p0KZRD4d+gDpD/lEJnvEZEujDT7ytN+YHHKcuPtbC2WU1GMxDGS+g3VwekauDNZyAokiqRZfk1CMp5ifuekjvHDtWeaSXMRZH0IGqe59hMt2qyThYqwwNSgM/8Dxt7HMqkfcnkA0C1Mo2V1HJySxx4qLnmCJT2GJHU9rgRFFsyFjaLOopb4OxxN9TqYSY7vGZFvFVmGgIo+vtBHkLHc/dzolVqM30n3TjhZABtWlCQ85Np1GeCyLrDhPKtFdjavP9A==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 PS1PR03MB4889.apcprd03.prod.outlook.com (2603:1096:300:78::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.1; Fri, 22 Jul 2022 08:11:55 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5482.001; Fri, 22 Jul 2022
 08:11:55 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 2/3] arm64: dts: qcom: sc7280: Add herobrine-villager-r1
Date:   Fri, 22 Jul 2022 16:11:26 +0800
Message-ID: <SG2PR03MB5006FEF9D137C015E1835CFDCC909@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722081127.228971-1-jinghung.chen3@hotmail.com>
References: <20220722081127.228971-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [0rpbZHBR6H49zIJ6z8Uq6eZAqP/YMenc]
X-ClientProxiedBy: TYWPR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::13) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220722161112.v7.2.Id8ba3ec73f9a0373a4f5778b4f8157e5732f74e3@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d66bc18e-49b5-4fd5-7857-08da6bb9d720
X-MS-TrafficTypeDiagnostic: PS1PR03MB4889:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5NDa+CemQ+irKqmLXPBag4j09JgzrDmMBu9bRGv2mon418wNi2PMonq4/P4QYYXl4/rZFTiz6SFnQlDJ/Gt6oDtq75eMjz/aF7K/zP5zYHz2N4Smr/Zdi1OQijRBSEk8sgGuXnEhol7CLL0/5hDwfHG1izCjJS4POl+keTXJK5ewnseg26aZWiWKi1T1w0l/d8zzjfBHJLyjIqKXaHZDa0GvcGX0IBaLv6hReVUzR6yxLJT7RNxabOQySwf62yYcTY1UGlQe/57WsgBZTwGEt+Txl35D+9yq8n9RA+nqSrtAmXk+KvUpiGqrUWplZJkn1n6VDp3vmIK3tkrAP++ZMY1Nwbc0YmOzMSgPXnwi8CT5g+zjyhx4fP4KrUdOZcgo4+xQoikhzGAwv5m5U6Z3GXcX3IYUaQP8feDsIvkSIskPObKh2i3XHcOarcw2y6w2sSUs2z4dvpRL9QLJbIhsujrsTrUisKoJwb3MBJwz6dKaD6IWuc7OOaufeVW9jj4ezPY625L3m/ECIorlJ3OPY8C42JWWDxoVVcN7Tft+KmnbNJM4zYQ3QPxcYHe/IljhQVCpfjMPTh0eLzYtwuqlKKnjs+Kwluu+BGaeGtm7NPfvFjJ5fF1tKP3BwfkTAUgC5iqQvqJZm92bfQbN1KnlTQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xXvCEzvcRsAaUuJPvl5iSRV9RHV5yjkI1Jt0guN6YUonbGORBFuQhF0zchIV?=
 =?us-ascii?Q?JHtIuK+jL8c6DM5OJg0ic11XkAOZubJ+zoqlT0l6JP6c4brYQ02StEPwJb9n?=
 =?us-ascii?Q?eH9bS53o2p5sZulxAaxW3zLDO5LKe9A7vv8ByI14reZE+3JlNtaHMiLh8Zgi?=
 =?us-ascii?Q?KMoHKJhTICZVx0eyN2QT3wsrwNmSmoubVSsazIQp6cvyxzM4bgcG4oIenXwu?=
 =?us-ascii?Q?23Hyb7mFGsDWI4n5Qc4sBxBY0kZ/FsfikxyVaYDelvp//2zWkV3EeVncABcF?=
 =?us-ascii?Q?uoqIwA11jhwRcbwCbHWsC7v2OKn3V1RsTOrZhBvPLO0A3wz5ZSRY9WERvXY8?=
 =?us-ascii?Q?DiwlZg9nYFrDQKmF3+i0EuTdnqMnO7nNPYLMuMeaju/3tZLoTTmeaEhu4lFn?=
 =?us-ascii?Q?oMbmy2CEuYjZeDWcfZmjyfWVPNwPrBGtzmMm9pbGFr6xRe/jLphqm0XIr8Yq?=
 =?us-ascii?Q?b2m5fQDl2po2Rr+IZoo/WUlHK1LBBMKOkFWI6i8s+scI3YN7y5Za8POuwRIA?=
 =?us-ascii?Q?+sc8L+KzLr+VIMRWIlqvdIIYylSL99wLUKWnirxG9UdRA9W6pLasMhgLQphK?=
 =?us-ascii?Q?5x7Io639YSUS685wZTl5/bH/3DA2vOAa6FmMx2sA+rrdzu7CzLcFp0r8BUwA?=
 =?us-ascii?Q?CPeqoCUhWs0RvXj4LG5KRWX8UdWCdFBfpRREixL/2ouuhk0jttaXngCaSB4g?=
 =?us-ascii?Q?Fr4T1NzGCe+s+8FRmwE37TLe+2JBZK/5PpInUICl7VL+I2J3Oa50CZlg+AHE?=
 =?us-ascii?Q?l44zlsqizd12efgxQq02TBDFUw5jO/C+NZggx59BqjzGhxtNrT2wVBMGmdQk?=
 =?us-ascii?Q?NTLUF22q8GB5FDlAvxFiUGVTEL1t/0tvVFMWqJAgrnGSifWKrt2SWTKgLi55?=
 =?us-ascii?Q?quVeS56Tjc1AAbn0oORXiIVu8vl65QnKWW3G/PrToj7eAQrWdE2DksztDOyi?=
 =?us-ascii?Q?ZX+6oPPo4JcfOTCk4BaR20l8P4j5iOEq1/L8m9M6TDRDfsGwUXxDUjI7gVtq?=
 =?us-ascii?Q?n0k7M5Njz6L5MM5DiFT+oe9nRZPZmvcCicQugS5s27LLcTWmWgzjZ6ktcI9d?=
 =?us-ascii?Q?Zu7XwqlwJ580WRjV00eDpYWbfVGQb+qWOLArJH/DF575Pa46KwKLN2/0zAWz?=
 =?us-ascii?Q?/nkRcepZiuK/LsON0xSKPtgFqXdXgHQetuxkfLNgWQ6e72hQd387s/EgZBmH?=
 =?us-ascii?Q?6e/ihIZjUOYJjD6N3H4YnXQONfP+sgdJvMRnOKIIwJu3ykuWfZfnsqUU1t3N?=
 =?us-ascii?Q?I6fcHVUHtXngZf9ioR/w/DUVW0dedGmsXIDiM7OW5Qwu5xXkCEu9MYd7OkDv?=
 =?us-ascii?Q?YaA=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d66bc18e-49b5-4fd5-7857-08da6bb9d720
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 08:11:55.0885
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

This adds sc7280-herobrine-villager-r1.dts for villager device tree files.
Herobrine-r1 is exactly the same as -r0 except that it uses a
different audio solution (it uses the same one as the CRD).

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

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

