Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD1D58AF10
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241282AbiHERoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241653AbiHERoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:44:15 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DFF65540;
        Fri,  5 Aug 2022 10:44:14 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 275Hi6N0074135;
        Fri, 5 Aug 2022 12:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659721446;
        bh=U19eGmWNXBX2NLN/+q7XOnbA7r6eO+4RFPTBxU8oHdA=;
        h=From:To:CC:Subject:Date;
        b=iIX8Q3QFh+Hsp/i4i5IiefHRFTdhGNevv3g4ECaytQCNEfQlvAXjhOCfa5h1rS79k
         guYzCuj4+p2Cu848wUS7GwJmrCj3cByigssUFkgmZboaJoxJn0LdhRE+iKicFLkiJX
         8TCmuZMg03JYiCgBftj9gxKYC0hgD7r9iqO+3jhU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 275Hi6la026545
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Aug 2022 12:44:06 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 5
 Aug 2022 12:44:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 5 Aug 2022 12:44:06 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 275HhwIU021358;
        Fri, 5 Aug 2022 12:44:00 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j7200: fix main pinmux range
Date:   Fri, 5 Aug 2022 10:43:39 -0700
Message-ID: <20220805174339.823634-1-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Range size of 0x2b4 was incorrect since there isn't 173 configurable
pins for muxing. Additionally there is a non-addessable region in the
mapping which requires spliting into two ranges.

main_pmx0 -> 71 pins
main_pmx1 -> 2 pins

Fixes: d361ed88455f ("arm64: dts: ti: Add support for J7200 SoC")
Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 16684a2f054d..a713de57056f 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -295,7 +295,16 @@ cpts@310d0000 {
 	main_pmx0: pinctrl@11c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-		reg = <0x00 0x11c000 0x00 0x2b4>;
+		reg = <0x00 0x11c000 0x00 0x10c>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	main_pmx1: pinctrl@11c164 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x11c164 0x00 0x8>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
-- 
2.36.1

