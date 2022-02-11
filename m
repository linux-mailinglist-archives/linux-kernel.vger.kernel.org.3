Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AAE4B2CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352613AbiBKSRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:17:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352598AbiBKSRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:17:00 -0500
Received: from st43p00im-ztdg10073201.me.com (st43p00im-ztdg10073201.me.com [17.58.63.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D11D43
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1644603417; bh=Rg0EIUG5YQ/nG3yQzZ80SkA2uhlV3mGvQHIXfsmLoRk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=p/MFjwttwRQM0R5xLX7LXKQwp05C2DIKB9JPfYqk6B85svRVzfrsFxA92m4jZzmEj
         P+7bFOjXPT0P+uv4BoH7T0fIGdqGT2UFCGgl3pbM/ZyzJCF98WA9t8QNnvRCYQdxp5
         XoexvO3NZ3iBg0CO+101e0oHXssAv/zEbAeQ4I/v1Ffb+rdUSqGPFRhH8UFnqDp4o0
         I0YFLerSoBp1+2zUI6LwgFQrVJEBrN3JbDdVi4Ra0cJPxBD9kZjlckmRuX6ZKEoZY0
         jxiGoRbZhBJbwRDp5DPATf8uF9GP0UadVyJl0CfwT0xxjV2cdbroysO6Nihyz2ONrg
         XGhT/25X+Z3HQ==
Received: from localhost (lfbn-lyo-1-306-208.w2-7.abo.wanadoo.fr [2.7.142.208])
        by st43p00im-ztdg10073201.me.com (Postfix) with ESMTPSA id 3B2719A0FD3;
        Fri, 11 Feb 2022 18:16:57 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v2 6/7] ARM: dts: sti: move usb picophy nodes out of soc in stih410.dtsi
Date:   Fri, 11 Feb 2022 19:16:13 +0100
Message-Id: <20220211181614.683497-7-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211181614.683497-1-avolmat@me.com>
References: <20220211181614.683497-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-17=5F04:2020-02-14=5F02,2022-01-17=5F04,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=915 adultscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2202110099
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the usb2_picophy1 and usb2_picophy2 nodes out of the soc section.
Since they are controlled via syscfg, there is no reg property needed,
which is required when having the node within the soc section.

Modification is done within stih410.dtsi and within related board
dts files (stih410-b2120.dts, stih410-b2260.dts).

Signed-off-by: Alain Volmat <avolmat@me.com>
---
v2: squash together 3 commits from v1 to avoid compilation issues

 arch/arm/boot/dts/stih410-b2120.dts | 16 +++++------
 arch/arm/boot/dts/stih410-b2260.dts | 16 +++++------
 arch/arm/boot/dts/stih410.dtsi      | 42 ++++++++++++++---------------
 3 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 9d3b118f5f0f..538ff98ca1b1 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -24,6 +24,14 @@ aliases {
 		ethernet0 = &ethernet0;
 	};
 
+	usb2_picophy1: phy2 {
+		status = "okay";
+	};
+
+	usb2_picophy2: phy3 {
+		status = "okay";
+	};
+
 	soc {
 
 		mmc0: sdhci@9060000 {
@@ -33,14 +41,6 @@ mmc0: sdhci@9060000 {
 			sd-uhs-ddr50;
 		};
 
-		usb2_picophy1: phy2@0 {
-			status = "okay";
-		};
-
-		usb2_picophy2: phy3@0 {
-			status = "okay";
-		};
-
 		ohci0: usb@9a03c00 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index c2d3b6de55d0..26d93f26f6d0 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -82,6 +82,14 @@ phy_port1: port@9b2a000 {
 		};
 	};
 
+	usb2_picophy1: phy2 {
+		status = "okay";
+	};
+
+	usb2_picophy2: phy3 {
+		status = "okay";
+	};
+
 	soc {
 		/* Low speed expansion connector */
 		uart0: serial@9830000 {
@@ -152,14 +160,6 @@ pwm1: pwm@9510000 {
 			status = "okay";
 		};
 
-		usb2_picophy1: phy2@0 {
-			status = "okay";
-		};
-
-		usb2_picophy2: phy3@0 {
-			status = "okay";
-		};
-
 		ohci0: usb@9a03c00 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index fe83d9a522bf..ce2f62cf129b 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -12,31 +12,29 @@ aliases {
 		bdisp0 = &bdisp0;
 	};
 
-	soc {
-		usb2_picophy1: phy2@0 {
-			compatible = "st,stih407-usb2-phy";
-			reg = <0 0>;
-			#phy-cells = <0>;
-			st,syscfg = <&syscfg_core 0xf8 0xf4>;
-			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
-				 <&picophyreset STIH407_PICOPHY0_RESET>;
-			reset-names = "global", "port";
+	usb2_picophy1: phy2 {
+		compatible = "st,stih407-usb2-phy";
+		#phy-cells = <0>;
+		st,syscfg = <&syscfg_core 0xf8 0xf4>;
+		resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+			 <&picophyreset STIH407_PICOPHY0_RESET>;
+		reset-names = "global", "port";
+
+		status = "disabled";
+	};
 
-			status = "disabled";
-		};
+	usb2_picophy2: phy3 {
+		compatible = "st,stih407-usb2-phy";
+		#phy-cells = <0>;
+		st,syscfg = <&syscfg_core 0xfc 0xf4>;
+		resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+			 <&picophyreset STIH407_PICOPHY1_RESET>;
+		reset-names = "global", "port";
 
-		usb2_picophy2: phy3@0 {
-			compatible = "st,stih407-usb2-phy";
-			reg = <0 0>;
-			#phy-cells = <0>;
-			st,syscfg = <&syscfg_core 0xfc 0xf4>;
-			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
-				 <&picophyreset STIH407_PICOPHY1_RESET>;
-			reset-names = "global", "port";
-
-			status = "disabled";
-		};
+		status = "disabled";
+	};
 
+	soc {
 		ohci0: usb@9a03c00 {
 			compatible = "st,st-ohci-300x";
 			reg = <0x9a03c00 0x100>;
-- 
2.25.1

