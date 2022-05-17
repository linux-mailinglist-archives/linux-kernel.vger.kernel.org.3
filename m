Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130A85296D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiEQBiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbiEQBiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:38:03 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28C7042EEF;
        Mon, 16 May 2022 18:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=k0ctV
        enGMMCdu3p7b3myrdeaZuuz8j0YlMGMike2E58=; b=FkmEWkafRVvthQnx/j2sK
        /7z7EOTH1BAtpoONhF8/ExSjcVQY/mdPTfcxWiXdwTGaVPA2TXD2rCJxbb7vIFV2
        b9V6oW9WIU/pXuMubfKzsnRlkYmZKLerWC1VkRmBrpRL5b5/aIa73E7kqPIo4asF
        5gbfMc+M596rkBjId5e0hU=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.20])
        by smtp9 (Coremail) with SMTP id DcCowAB3USwR_IJiF3ohDQ--.61255S5;
        Tue, 17 May 2022 09:36:20 +0800 (CST)
From:   qianfanguijin@163.com
To:     linux-sunxi@lists.linux.dev
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v5 3/3] ARM: dts: sun8i-r40: Add thermal trip points/cooling maps
Date:   Tue, 17 May 2022 09:36:07 +0800
Message-Id: <20220517013607.2252-4-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517013607.2252-1-qianfanguijin@163.com>
References: <20220517013607.2252-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAB3USwR_IJiF3ohDQ--.61255S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4UArW7Wr4fJFW5Jw1kZrb_yoW8CF4xpF
        1xCw4FqF1jgr1Sq3Wa9r4DXas8Ca4vkF48Krs7WFykAr98XFZrtry2yw1ftFyDGF1rAw40
        9w4Yvr1xG3Z8A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9Aw3UUUUU=
X-Originating-IP: [218.201.129.20]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiGhUE7VaEBpyRLgAAsR
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

For the trip points, I used values from the BSP code.

The critical trip point value is 30°C above the maximum recommended
ambient temperature (85°C) for the SoC from the datasheet, so there's
some headroom even at such a high ambient temperature.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index ae2a5ebd9924..b43f3f72a915 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -86,6 +86,7 @@ cpu0: cpu@0 {
 			reg = <0>;
 			clocks = <&ccu CLK_CPU>;
 			clock-names = "cpu";
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -94,6 +95,7 @@ cpu1: cpu@1 {
 			reg = <1>;
 			clocks = <&ccu CLK_CPU>;
 			clock-names = "cpu";
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -102,6 +104,7 @@ cpu2: cpu@2 {
 			reg = <2>;
 			clocks = <&ccu CLK_CPU>;
 			clock-names = "cpu";
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -110,6 +113,7 @@ cpu3: cpu@3 {
 			reg = <3>;
 			clocks = <&ccu CLK_CPU>;
 			clock-names = "cpu";
+			#cooling-cells = <2>;
 		};
 	};
 
@@ -125,6 +129,30 @@ cpu_thermal: cpu0-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 0>;
+
+			trips {
+				cpu_hot_trip: cpu-hot {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_very_hot_trip: cpu-very-hot {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				cpu-hot-limit {
+					trip = <&cpu_hot_trip>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpu_thermal: gpu-thermal {
-- 
2.25.1

