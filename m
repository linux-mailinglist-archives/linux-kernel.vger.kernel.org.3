Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A30657B4DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240177AbiGTKyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbiGTKxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:53:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACA06D9FD;
        Wed, 20 Jul 2022 03:53:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gn24so3057082pjb.3;
        Wed, 20 Jul 2022 03:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Mhscre5ApuF2HLF9SvgHNFOW7TSIpt1lI87XGb9QgEk=;
        b=Vx3ArBaj06YNGRzw3bIkp29i3TbvBW7AhKEroeY0bdYRJCS5ylMDCFwYOF6t0w4/+5
         J4aNvyjFyvoHsd3J4jg3wWRU6cpdAzSKPMYmlbpZ5qNnrrKwpfPs5ls3GHT56+B76qlX
         rsUFutlvRiYpP1gStiI9isgWRPkf3Asowi/rHFO8hWCZX0OkyotILnidhK16RdCRvMvv
         KPr1eDl4quaXmk7fFAL5dx/6o+vblbAVM6QPVQ4jk0qUhfT6uGl7RnPOpDmNIKzbALBw
         9ZC9F9sqSsqtgHD7xS86eXssorW8nnNUGBNYMamNxQNBjGtt7R805dr4qLjkGOGOQD2N
         D+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Mhscre5ApuF2HLF9SvgHNFOW7TSIpt1lI87XGb9QgEk=;
        b=eIkL52hswvF0BH550xed7KOryF+tE7HrVDf7LD8svoWD/VNssO5GyKRnhg3L9pM8vg
         QnV5V+FKRYHGr/bCPJrLzJzIkcQLiIwxKW7JlJp6q65MaXBhjCpbT7Kdj9NfeXxwf2DN
         OaZEFKDWC/+4BnCV2h9Mlf/+rCOrZm+cWaX+lTO9ax/F12mdPE1WBIXeyii4AAsktHCk
         F45xoF1iwDs6ptIYXV7UrnvpX/AZj+HbTJ7KjAdP0zcYMacigLA8PJCkDyvu+YJx52pN
         09D4KG+zOM5ybOYCRdPK2vpJNEQe693JDtPoaDLZCpVlrxM0aGSHNIDgiblqrieKfsrb
         yK7g==
X-Gm-Message-State: AJIora8bpZOoQlfxnHcAagt+4zjAlgqKRNjMFwZBrgEcOzQ/sO6XKU5m
        0QxgemWA62ZpMns62FuEoAE=
X-Google-Smtp-Source: AGRyM1umoS76A2PCTrBwJuvfac+pH1JwJoVe1Fzduqb2TLUkr2jdunjgEYihu2f1l0JRsXX0ThtPLQ==
X-Received: by 2002:a17:90a:6e46:b0:1f2:f04:a173 with SMTP id s6-20020a17090a6e4600b001f20f04a173mr4639203pjm.23.1658314419816;
        Wed, 20 Jul 2022 03:53:39 -0700 (PDT)
Received: from logan-ThinkPad-T14-Gen-1 ([59.93.6.68])
        by smtp.gmail.com with ESMTPSA id t186-20020a625fc3000000b00528c3ad8e09sm13328684pfb.66.2022.07.20.03.53.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jul 2022 03:53:39 -0700 (PDT)
From:   Logananth Sundararaj <logananth13.hcl@gmail.com>
X-Google-Original-From: Logananth Sundararaj <logananth_s@hcl.com>
Date:   Wed, 20 Jul 2022 16:23:31 +0530
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org
Cc:     garnermic@gmail.com, thangavel.k@hcl.com, naveen.mosess@hcl.com,
        patrick@stwcx.xyz, velumanit@hcl.com
Subject: [PATCH v4] ARM: dts: aspeed: Adding Facebook Yosemite V3.5 BMC
Message-ID: <20220720105331.GA23472@logan-ThinkPad-T14-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Yosemite V3.5 is a facebook multi-node server
platform that host four OCP server. The BMC
in the Yosemite V3.5 platform based on AST2600 SoC.

This patch adds linux device tree entry related to
Yosemite V3.5 specific devices connected to BMC SoC.

Signed-off-by: Logananth Sundararaj <logananth_s@hcl.com>

---
--- v4 - Bootagrs and memory removed.
--- v3 - Addressed v2 patch comments.
--- v2 - Enabled i2c drivers.
--- v1 - Initial draft.
---
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-facebook-fby35.dts    | 260 ++++++++++++++++++
 2 files changed, 261 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e0934180724..58add093e5fb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1465,6 +1465,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-cloudripper.dtb \
 	aspeed-bmc-facebook-cmm.dtb \
 	aspeed-bmc-facebook-elbert.dtb \
+	aspeed-bmc-facebook-fby35.dtb \
 	aspeed-bmc-facebook-fuji.dtb \
 	aspeed-bmc-facebook-galaxy100.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts
new file mode 100644
index 000000000000..05efba7117a8
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2020 Facebook Inc.
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "Facebook fby35";
+	compatible = "facebook,fby35", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			<&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
+			<&adc1 4>, <&adc1 5>, <&adc1 6>;
+	};
+	spi_gpio: spi-gpio {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
+
+};
+
+&mac3 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+	no-hw-checksum;
+	use-ncsi;
+	mlx,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
+	ncsi-package = <1>;
+	ncsi-channel = <1>;
+	ncsi-rexmit = <1>;
+	ncsi-timeout = <2>;
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+	compatible = "snps,dw-apb-uart";
+};
+
+&wdt1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+	aspeed,reset-type = "soc";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+	aspeed,ext-pulse-duration = <256>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi0.1";
+		spi-max-frequency = <50000000>;
+		#include "openbmc-flash-layout-128.dtsi"
+	};
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi0.0";
+		spi-max-frequency = <50000000>;
+		#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&i2c0 {
+	//Host1 IPMB bus
+	status = "okay";
+	multi-master;
+	ipmb0@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c1 {
+	//Host2 IPMB bus
+	status = "okay";
+	multi-master;
+	ipmb1@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c2 {
+	//Host3 IPMB bus
+	status = "okay";
+	multi-master;
+	ipmb2@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c3 {
+	//Host1 IPMB bus
+	status = "okay";
+	multi-master;
+	ipmb3@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	//NIC SENSOR TEMP
+	status = "okay";
+	tmp421@1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
+};
+
+&i2c9 {
+	// Debug-Card IPMB bus
+	status = "okay";
+	multi-master;
+	ipmb9@30 {
+		compatible = "ipmb-dev";
+		reg = <(0x30 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+	//FRU EEPROM
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+	//INLET TEMP
+	tmp75@4e {
+		compatible = "ti,tmp75";
+		reg = <0x4e>;
+	};
+	//OUTLET TEMP
+	tmp75@4f {
+		compatible = "ti,tmp75";
+		reg = <0x4f>;
+	};
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&adc0 {
+	ref_voltage = <2500>;
+	status = "okay";
+
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	ref_voltage = <2500>;
+	status = "okay";
+
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+		&pinctrl_adc10_default &pinctrl_adc11_default
+		&pinctrl_adc12_default &pinctrl_adc13_default>;
+};
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
-- 
2.17.1

