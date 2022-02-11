Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5704B2CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352606AbiBKSRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:17:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352615AbiBKSRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:17:06 -0500
Received: from st43p00im-ztfb10071701.me.com (st43p00im-ztfb10071701.me.com [17.58.63.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A361D52
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1644603420; bh=VPvPVP2edwflLmj1mzLh01mfMS7GUrPYSb2mNvVkt/Y=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=182pcnyKzQkKH8ROIeaHYbAVzzfjjeFw2Sj8dLR0exzSUsDTXAojvjS+qeMKIvu2Y
         tYCoc4arduXfQO89FT+915Kohw+4UBYkwbYDqoMw4FgmRwJGEjKSO37aYumEOcRPgF
         qvWPDK3HOZ2g264BwAdlHalfcfiIEJkwAUL3u0ZJPRw3tvWPIr1YJe3CWVQEfr4Jom
         wh2vuKAA6HrDg3K0FchSrCxnD33EOAZL9TD27+LI0JWyPG8BoVQPY5lO9jCOgUKc8P
         cHLZpoXoKkhHPOXQqM3IPTsqtETJ31d1YMiv0izcS/wpr3fCaNcGpSHUgjQgixEpPf
         y5Urxdwn6mlZA==
Received: from localhost (lfbn-lyo-1-306-208.w2-7.abo.wanadoo.fr [2.7.142.208])
        by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id 1991BA0058;
        Fri, 11 Feb 2022 18:16:59 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v2 7/7] ARM: dts: sti: move usb picophy nodes out of soc in stih418.dtsi
Date:   Fri, 11 Feb 2022 19:16:14 +0100
Message-Id: <20220211181614.683497-8-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211181614.683497-1-avolmat@me.com>
References: <20220211181614.683497-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=766
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2202110099
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

