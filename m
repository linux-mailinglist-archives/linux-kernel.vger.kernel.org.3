Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359B551721B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385637AbiEBPEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbiEBPEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:04:38 -0400
Received: from mail-m17638.qiye.163.com (mail-m17638.qiye.163.com [59.111.176.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED70101FD;
        Mon,  2 May 2022 08:01:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:2001:250:6801:5501:163d:f2ff:fecb:5632])
        by mail-m17638.qiye.163.com (Hmail) with ESMTPA id 9651E1C01BB;
        Mon,  2 May 2022 23:01:06 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH] arm64: dts: allwinner: h6: Enable CPU opp tables for OrangePi One Plus
Date:   Mon,  2 May 2022 23:01:01 +0800
Message-Id: <20220502150101.45200-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUMeGRlWSkxLGExCTEtLGE
        hJVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MyI6Shw6Az01EBUdTCM0MEgM
        Di1PCw1VSlVKTU5KTktITU1MSU5LVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlL
        S0pBSU5LQU1DS0pBTk5LSkFKTUgfQR1JHR1BHR4YGUFOTUhJWVdZCAFZQUhLQ0w3Bg++
X-HM-Tid: 0a80854a16bed993kuws9651e1c01bb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPU opp tables for OrangePi One Plus.

This needs to change the CPU regulator max voltage to fit
the OPP table.

Also add the ramp-delay information to avoid any out of spec
running as the regulator is slower at reaching the voltage
requested compare to the PLL reaching the frequency.

There is no such information for AXP805 but similar PMIC (AXP813)
has a DVM (Dynamic Voltage scaling Management) ramp rate equal
to 2500uV/us.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 92745128fcfe..d7b82ef6be55 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -5,6 +5,7 @@
 /dts-v1/;
 
 #include "sun50i-h6.dtsi"
+#include "sun50i-h6-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -64,6 +65,10 @@ reg_vcc5v: vcc5v {
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &de {
 	status = "okay";
 };
@@ -208,7 +213,8 @@ reg_cldo3: cldo3 {
 			reg_dcdca: dcdca {
 				regulator-always-on;
 				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-max-microvolt = <1160000>;
+				regulator-ramp-delay = <2500>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -216,6 +222,7 @@ reg_dcdcc: dcdcc {
 				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
+				regulator-ramp-delay = <2500>;
 				regulator-name = "vdd-gpu";
 			};
 
-- 
2.25.1

