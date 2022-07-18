Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C270F5779C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 05:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiGRDcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 23:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGRDce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 23:32:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E87DF02;
        Sun, 17 Jul 2022 20:32:33 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z22so579078edd.6;
        Sun, 17 Jul 2022 20:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7vU2EaXziKtqA6IF4Ixdqyip9HawpsDk92gp0K8d4qg=;
        b=EzgVqeyAcGyjTaL9iKSBmbh1jgOQftICXQMK/plVSPG1Jc+/W59+11U+Ji006d9gBA
         cK7wUaxD16Tzp6yVXclMnkgqCIjjp9o4kAcOe7Iq8FsQN58NFpgdKxPVdiuryEPtEycx
         Dm6UsXetNVyGZ8/MRK3Va9/anbTbu5bL3OVqQ8UdkrlvfyATBAEIvnmmZldBDMgfFgdP
         NA0OrTSjM0DpidP5a/r1PtAAp917lu8GdkMlVCOkYURvt0yx5hDkK6gBfMCjEqNIz8/m
         rKoVMEXU7tAFqfsyUj1kSBaMyDVmMm5nVI6Awc0vcpPz40j9YWIdjVQruLVLLBjrkW71
         /iUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7vU2EaXziKtqA6IF4Ixdqyip9HawpsDk92gp0K8d4qg=;
        b=LYHhkk9b2UNRLH1cdE5w9PARAfXFmQNlc7ouNsfv+chXVnObQ9B/LOJgxYPgouhHqA
         TGo+f+aXkYuMQjN3qZEnFzdPEklAkHRnyuR5zje6dj/1hJ/OWlqHGrweeCZ+vxySEz+X
         VP7tebJ9BGkMsFUM0T8T/NvhigwR0KsDRq2/r3gCBhjeo1lD2d/N7J2jloPpm/LMuc0S
         ySlIgsNew8oJNzOYhxle5anL2C4TMwzuryghXkEx+bSUZXwpuikCRa0y/OBj81gqemHW
         IQIPfxPo5cPzQPfUKRM1l+AkWmbWZfxzQXvHhuTgiVxK9SrVFSLmFQc2CU56DNn5vzYZ
         +7bg==
X-Gm-Message-State: AJIora/w3fH3s4R0ZZRrTr9cdx+hZzD8S1LL2tTSmCvy1PZ7rJ4NcKhY
        bI0W+SItR5gwtY7FBY+7qgk=
X-Google-Smtp-Source: AGRyM1tl/Y2QD1vN32cF7rhxUR2CaQ2xN/3eHkgE3g0LGVY2m+PPX562g3dY1rNLc5CvkNi0RVavIg==
X-Received: by 2002:aa7:dd4b:0:b0:43a:d508:7cb9 with SMTP id o11-20020aa7dd4b000000b0043ad5087cb9mr35087886edw.218.1658115151793;
        Sun, 17 Jul 2022 20:32:31 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id z20-20020a170906715400b0070f7d1c5a18sm4972287ejj.55.2022.07.17.20.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 20:32:31 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Add PCIe 2 nodes to quartz64-b
Date:   Mon, 18 Jul 2022 05:31:45 +0200
Message-Id: <20220718033145.792657-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the regulator node to the quartz64-b device tree,
and enables the PCIe 2 controller and combphy for it.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
index 528bb4e8ac77..8e9cf3ac1c39 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
@@ -54,6 +54,18 @@ sdio_pwrseq: sdio-pwrseq {
 		power-off-delay-us = <5000000>;
 	};
 
+	vcc3v3_pcie_p: vcc3v3-pcie-p-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_enable_h>;
+		regulator-name = "vcc3v3_pcie_p";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
 	vcc5v0_in: vcc5v0-in-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_in";
@@ -113,6 +125,10 @@ &combphy1 {
 	status = "okay";
 };
 
+&combphy2 {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_cpu>;
 };
@@ -427,6 +443,14 @@ rgmii_phy1: ethernet-phy@1 {
 	};
 };
 
+&pcie2x1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_reset_h>;
+	reset-gpios = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie_p>;
+	status = "okay";
+};
+
 &pinctrl {
 	bt {
 		bt_enable_h: bt-enable-h {
@@ -448,6 +472,16 @@ user_led_enable_h: user-led-enable-h {
 		};
 	};
 
+	pcie {
+		pcie_enable_h: pcie-enable-h {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie_reset_h: pcie-reset-h {
+			rockchip,pins = <1 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pmic {
 		pmic_int: pmic_int {
 			rockchip,pins =
-- 
2.37.1

