Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB4F526809
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382824AbiEMRQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382779AbiEMRQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:16:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEB463A0;
        Fri, 13 May 2022 10:16:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4B9C61F463B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652462184;
        bh=6b5Fn00QFN3S8pk3LiXp3oowU6+YetKGNFXGTWU1NeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5rfzoUU1xMstwvoem9aQMqhyD6+D+l3IzMQ2gv3FhEHZWP3irW9F1hY5Z1u8Ge2b
         rhu8YwtB/1D5un8uqnNgU7CvrQRvgFRAXXc/LZnuBb3tZ5gEkRa8NRCvd502VTygfH
         T+b7LhLPTB60WIS2Kfwm62TMUPcYw9tY5p2C4B4seDTSnwiJ8Exy9NymG7b3HV/oM0
         eQ+UAANxW41CqUsPR8XZRzcw18NyQbGSP7MUpTwtUflaIMwYf/qvJX6gEhASghzPF9
         ZJyveqBm5OhnjoyeEYmq0/PwID7d9/u7Qm/dkJZFRV0Tg9cvCc1TLZmOiqTrnbRxWr
         dBldG/nYsyYWA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/7] arm64: dts: mediatek: mt6795: Add cpu-map and L2 cache
Date:   Fri, 13 May 2022 19:16:12 +0200
Message-Id: <20220513171617.504430-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513171617.504430-1-angelogioacchino.delregno@collabora.com>
References: <20220513171617.504430-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SoC is HMP and has two clusters with four Cortex-A53 cores each:
declare a cpu map and, while at it, also add the next-level-cache
properties.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 56 ++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index 167f90bd991a..1456b9035336 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -34,6 +34,7 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x000>;
+			next-level-cache = <&l2_0>;
 		};
 
 		cpu1: cpu@1 {
@@ -41,6 +42,7 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x001>;
+			next-level-cache = <&l2_0>;
 		};
 
 		cpu2: cpu@2 {
@@ -48,6 +50,7 @@ cpu2: cpu@2 {
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x002>;
+			next-level-cache = <&l2_0>;
 		};
 
 		cpu3: cpu@3 {
@@ -55,6 +58,7 @@ cpu3: cpu@3 {
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x003>;
+			next-level-cache = <&l2_0>;
 		};
 
 		cpu4: cpu@100 {
@@ -62,6 +66,7 @@ cpu4: cpu@100 {
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x100>;
+			next-level-cache = <&l2_1>;
 		};
 
 		cpu5: cpu@101 {
@@ -69,6 +74,7 @@ cpu5: cpu@101 {
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x101>;
+			next-level-cache = <&l2_1>;
 		};
 
 		cpu6: cpu@102 {
@@ -76,6 +82,7 @@ cpu6: cpu@102 {
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x102>;
+			next-level-cache = <&l2_1>;
 		};
 
 		cpu7: cpu@103 {
@@ -83,6 +90,55 @@ cpu7: cpu@103 {
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x103>;
+			next-level-cache = <&l2_1>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+
+				core1 {
+					cpu = <&cpu5>;
+				};
+
+				core2 {
+					cpu = <&cpu6>;
+				};
+
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		l2_0: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+		};
+
+		l2_1: l2-cache1 {
+			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
-- 
2.35.1

