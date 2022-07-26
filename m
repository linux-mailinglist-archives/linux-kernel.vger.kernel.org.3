Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2ED58097D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 04:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbiGZCbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 22:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiGZCbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 22:31:43 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D218248DF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 19:31:41 -0700 (PDT)
Received: from amadeus-VLT-WX0.lan (unknown [113.118.189.34])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 0819D80008D;
        Tue, 26 Jul 2022 10:31:39 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH] arm64: dts: rockchip: add RTC1 to rock3a
Date:   Tue, 26 Jul 2022 10:30:46 +0800
Message-Id: <20220726023046.5876-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkJNVhhNGE0aTUlKTUhJGVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSFVKSkNVSkNCVUhPWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pww6Lgw4Sj06Ek42SAlWTxxO
        EjEKCzZVSlVKTU5DQ0tJTUJCTE1NVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
        SFVKSkNVSkNCVUhPWVdZCAFZQUlPSEI3Bg++
X-HM-Tid: 0a8238587c2cb03akuuu0819d80008d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree node for hym8563 rtc to
Radxa ROCK3 Model A board.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 3ce7eb05defc..aaf68c69e86b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -422,6 +422,23 @@ codec {
 	};
 };
 
+&i2c5 {
+	status = "okay";
+
+	hym8563: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PD3 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "rtcic_32kout";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+		wakeup-source;
+	};
+};
+
 &i2s1_8ch {
 	rockchip,trcm-sync-tx-only;
 	status = "okay";
@@ -454,6 +471,12 @@ eth_phy_rst: eth_phy_rst {
 		};
 	};
 
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	leds {
 		led_user_en: led_user_en {
 			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.25.1

