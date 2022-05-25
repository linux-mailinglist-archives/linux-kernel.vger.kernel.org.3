Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D501F534024
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiEYPPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245067AbiEYPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:14:53 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CFBB0A56
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=PmJeUcD7gmhS0PYNVlvnsEYDc66
        oPHymA7qkWS2f7mc=; b=l6xpk6TF26KM1mnnh0+jz50FYpB78xor+ZgrgkGzOa6
        /AE5kojTiMnLlP2sgBBwW9mnPWd2Spv7hLf4TLCWD4m9nh5Bjx0BlX7RFlB8wC/r
        EPoJDhAWWgkiPoHLYjKyPthdV/nL9C63iYoaz5aIwR1E4OtFpfi5rvjYBMcreuxw
        =
Received: (qmail 1645302 invoked from network); 25 May 2022 17:13:58 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 May 2022 17:13:58 +0200
X-UD-Smtp-Session: l3s3148p1@hA++hdffyRdZD++C
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Linh Phung <linh.phung.jy@renesas.com>,
        Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: renesas: r8a779f0: Add thermal support
Date:   Wed, 25 May 2022 17:13:55 +0200
Message-Id: <20220525151355.24175-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linh Phung <linh.phung.jy@renesas.com>

Add support for 3 TSC nodes of thermal. The 4th node is for the control
domain and not for Linux.

Signed-off-by: Linh Phung <linh.phung.jy@renesas.com>
[wsa: rebased, fixed resource size, removed unused 4th node breaking probe]
Signed-off-by: Wolfram Sang <wsa@kernel.org>
---

Works fine on my Spider board and allowed me to disconnect the fan :)

 arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 56 +++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index df46fb87cffc..d89064f86d85 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -157,6 +157,18 @@ sysc: system-controller@e6180000 {
 			#power-domain-cells = <1>;
 		};
 
+		tsc: thermal@e6198000 {
+			compatible = "renesas,r8a779f0-thermal";
+			/* The 4th sensor is in control domain and not for Linux */
+			reg = <0 0xe6198000 0 0x200>,
+			      <0 0xe61a0000 0 0x200>,
+			      <0 0xe61a8000 0 0x200>;
+			clocks = <&cpg CPG_MOD 919>;
+			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+			resets = <&cpg 919>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		i2c0: i2c@e6500000 {
 			compatible = "renesas,i2c-r8a779f0",
 				     "renesas,rcar-gen4-i2c";
@@ -360,6 +372,50 @@ prr: chipid@fff00044 {
 		};
 	};
 
+	thermal-zones {
+		sensor_thermal1: sensor-thermal1 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 0>;
+
+			trips {
+				sensor1_crit: sensor1-crit {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		sensor_thermal2: sensor-thermal2 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 1>;
+
+			trips {
+				sensor2_crit: sensor2-crit {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		sensor_thermal3: sensor-thermal3 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 2>;
+
+			trips {
+				sensor3_crit: sensor3-crit {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.35.1

