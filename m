Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D56C465EF3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355953AbhLBHze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:55:34 -0500
Received: from st43p00im-zteg10071901.me.com ([17.58.63.169]:40574 "EHLO
        st43p00im-zteg10071901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355905AbhLBHzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638431512; bh=ZRgZYLtFYodHlBpE1OBDO5DIOZSgaVeA5xFn9tbB2Ns=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Wmr7M8k/VNRDAl+gCPp8JsH1pnksf9vhZIxPt0IghUlSkicIKFavR7nUzY8gCCcfZ
         aBiB/tLEldfRpeMpM5cKOXYmGx3DTDLu1+0JOB9YLr6/+hE0r6pKWzQz4WIDBaSSs+
         meYHH/MFEuX4H/G1a9NyxHsv3TAhh5HY7ABuR4RpQclFnmjzfaSqDvEEVwtAvOaRQa
         kNwuHjb+eizxnJlN4wzBwkxSQRjMlvmv/U5Q8f9m4THHFr3z+K5lgN1+dI4Hd/CgoA
         5l+tk4CwJcZTagV3Ss1zMgf+ce646ImE/bsKwByPXiBccJYh1h6TE8ulDJZ/0FQS1q
         xBQPURWGkH9gA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10071901.me.com (Postfix) with ESMTPSA id F33A1D80A6B;
        Thu,  2 Dec 2021 07:51:51 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 09/12] ARM: dts: sti: move usb picophy nodes out of soc in stih410.dtsi
Date:   Thu,  2 Dec 2021 08:51:02 +0100
Message-Id: <20211202075105.195664-10-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202075105.195664-1-avolmat@me.com>
References: <20211202075105.195664-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the usb2_picophy1 and usb2_picophy2 nodes out of the soc section.
Since they are controlled via syscfg, there is no reg property needed,
which is required when having the node within the soc section.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih410.dtsi | 42 ++++++++++++++++------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

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

