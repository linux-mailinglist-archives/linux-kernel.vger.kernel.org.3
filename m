Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E66F54A9C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352578AbiFNGtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352435AbiFNGtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:49:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23435393E0;
        Mon, 13 Jun 2022 23:49:04 -0700 (PDT)
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D33A866016AA;
        Tue, 14 Jun 2022 07:49:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655189342;
        bh=HEY57/+pQCdqZeUqLYJAbru4ZTJec0xYbZTMVXt16Ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cByx7Kv+Nf87SMgS2jkmXOjVVEQa88yPCjeTDa2PD53e4clOraP6sQykPydDm7lMH
         nAaXYjBHe7Tr+L55Fhe2KammIahnevC35qY+CE8lyY3qBREhQHqvs4/S1u7i0aQIHv
         6DNBzZI9JLZptUlOWy/3yqWR+RDbmqfV44ABqW8qG7yBI1qo5ctFx6l8rHPZxnXqjm
         +Bb7Ee8WCEn6Hd3L47Oo8iAn0HRl5IwZJjw9sgMEvnOFNXA760MxojE7vK7a9Ryjt9
         D2quFLXZeB4OqVsXJfLpRU2YisGtN9fJBzj4JpMPwVcipuBnizCNQ68BomwrAY0Mv0
         tHj53OTP4AgKg==
Received: by beast.luon.net (Postfix, from userid 1000)
        id 1E97D4179E46; Tue, 14 Jun 2022 08:49:00 +0200 (CEST)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com, Akash Gajjar <akash@openedev.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: rockchip: rock-pi-s add more peripherals
Date:   Tue, 14 Jun 2022 08:48:57 +0200
Message-Id: <20220614064858.1445817-4-sjoerd@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614064858.1445817-1-sjoerd@collabora.com>
References: <20220614064858.1445817-1-sjoerd@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the following peripherals:
* Onboard ethernet support
* Bluetooth
* USB 2 port
* OTG port via type-c connector
* Hardware watchog

Also add aliases for the mmc devices and the ethernet interface

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

(no changes since v1)

 .../boot/dts/rockchip/rk3308-rock-pi-s.dts    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
index 9095efe25ccd..46ba48b843c5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
@@ -11,6 +11,12 @@ / {
 	model = "Radxa ROCK Pi S";
 	compatible = "radxa,rockpis", "rockchip,rk3308";
 
+	aliases {
+		ethernet0 = &gmac;
+		mmc0 = &emmc;
+		mmc1 = &sdmmc;
+	};
+
 	chosen {
 		stdout-path = "serial0:1500000n8";
 	};
@@ -132,6 +138,15 @@ &emmc {
 	status = "okay";
 };
 
+&gmac {
+	clock_in_out = "output";
+	phy-supply = <&vcc_io>;
+	snps,reset-gpio = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 50000 50000>;
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 };
@@ -195,10 +210,47 @@ &sdmmc {
 	status = "okay";
 };
 
+&u2phy {
+	status = "okay";
+
+	u2phy_host: host-port {
+		phy-supply = <&vcc5v0_otg>;
+		status = "okay";
+	};
+
+	u2phy_otg: otg-port {
+		phy-supply = <&vcc5v0_otg>;
+		status = "okay";
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
 
 &uart4 {
 	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bt";
+		device-wake-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>;
+		host-wake-gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&usb_host_ehci {
+	status = "okay";
+};
+
+&usb_host_ohci {
+	status = "okay";
+};
+
+&usb20_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
 };
-- 
2.36.1

