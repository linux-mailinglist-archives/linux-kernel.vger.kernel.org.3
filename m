Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF2465EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345447AbhLBHzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:55:42 -0500
Received: from st43p00im-zteg10062001.me.com ([17.58.63.166]:46440 "EHLO
        st43p00im-zteg10062001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355949AbhLBHzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638431516; bh=VPvPVP2edwflLmj1mzLh01mfMS7GUrPYSb2mNvVkt/Y=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=KnpYl8dMaLsLHa+DJNgrN/U7VOqzAERFhB/kL5QU9vUZNJqMvXRYC87ibYAwQDtEX
         xEgG0+pi3AoNv8WzRkNYoSfhpl1NwWC0A5IYvVOH2Z2E+yy25KWm1Zdt07Kk+0IN5H
         DRQODwgbjoSJYWr4WzSMMOEw/YJP/7bjZgvNBq2KjWBHX9eNl/L0LGWODYVmcPO4rn
         yHpekxDOgrxZ6aMhsm7wPLVK+48bfH0IPziEuga22RTi5TI0iUmvEUg5ueFTfzuhnB
         7JbNV2pWuNVb8msEKe3OPlHU0IUS5JWljEAFiUpI6iPxA2qbBTFsqpPEwoe2oGRyEp
         ashTWp5LaEJdQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10062001.me.com (Postfix) with ESMTPSA id 41C7D6C00AB;
        Thu,  2 Dec 2021 07:51:55 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 10/12] ARM: dts: sti: move usb picophy nodes out of soc in stih418.dtsi
Date:   Thu,  2 Dec 2021 08:51:03 +0100
Message-Id: <20211202075105.195664-11-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202075105.195664-1-avolmat@me.com>
References: <20211202075105.195664-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-12-01=5F01:2021-12-01=5F01,2021-11-30=5F09,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 mlxlogscore=935
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2112020045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the usb2_picophy1 and usb2_picophy2 nodes out of the soc section.
Since they are controlled via syscfg, there is no reg property needed,
which is required when having the node within the soc section.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih418.dtsi | 38 ++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/stih418.dtsi b/arch/arm/boot/dts/stih418.dtsi
index 97eda4392fbe..b35b9b7a7ccc 100644
--- a/arch/arm/boot/dts/stih418.dtsi
+++ b/arch/arm/boot/dts/stih418.dtsi
@@ -26,31 +26,29 @@ cpu@3 {
 		};
 	};
 
+	usb2_picophy1: phy2 {
+		compatible = "st,stih407-usb2-phy";
+		#phy-cells = <0>;
+		st,syscfg = <&syscfg_core 0xf8 0xf4>;
+		resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+			 <&picophyreset STIH407_PICOPHY0_RESET>;
+		reset-names = "global", "port";
+	};
+
+	usb2_picophy2: phy3 {
+		compatible = "st,stih407-usb2-phy";
+		#phy-cells = <0>;
+		st,syscfg = <&syscfg_core 0xfc 0xf4>;
+		resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+			 <&picophyreset STIH407_PICOPHY1_RESET>;
+		reset-names = "global", "port";
+	};
+
 	soc {
 		rng11: rng@8a8a000 {
 			status = "disabled";
 		};
 
-		usb2_picophy1: phy2@0 {
-			compatible = "st,stih407-usb2-phy";
-			reg = <0 0>;
-			#phy-cells = <0>;
-			st,syscfg = <&syscfg_core 0xf8 0xf4>;
-			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
-				 <&picophyreset STIH407_PICOPHY0_RESET>;
-			reset-names = "global", "port";
-		};
-
-		usb2_picophy2: phy3@0 {
-			compatible = "st,stih407-usb2-phy";
-			reg = <0 0>;
-			#phy-cells = <0>;
-			st,syscfg = <&syscfg_core 0xfc 0xf4>;
-			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
-				 <&picophyreset STIH407_PICOPHY1_RESET>;
-			reset-names = "global", "port";
-		};
-
 		ohci0: usb@9a03c00 {
 			compatible = "st,st-ohci-300x";
 			reg = <0x9a03c00 0x100>;
-- 
2.25.1

