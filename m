Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A7C581417
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbiGZNY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiGZNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:24:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFE92BB31;
        Tue, 26 Jul 2022 06:24:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w185so13232729pfb.4;
        Tue, 26 Jul 2022 06:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IrFDtxgAaduvoUdhvGWeyiNBzh8yHroFXXWTqHTAHIQ=;
        b=fNIxcMiJKW+W5fH5ldVegy7d3gemWlU0e5euW0jxwhZpRDhDbrwMtnYsARATMRh4ZP
         0I3DwElZaa6Mcw0pbdHsPOazD9Z3esbP2r4ZHp1F263D/aMH9NGnvzSd2XSMol9C6tlB
         4/C56q/9iw89ZFY0oNmH6pEO8JkqnbR0SvieKDX0+jETd7AjLxIEJYFo9qW/LyEiOipS
         r4U8kF6rPzw3YATEGcP9Xlcv08NSljuCw8rD098t8TS+yEGn/xSbLAQ3PWnKnz6YYYgv
         Atnx+hZuyWFsa8IM+ezq+zOx5pJhKicyk+jcworCXMvMVMijSsUnFeZrcQbxL5U8ug02
         UDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IrFDtxgAaduvoUdhvGWeyiNBzh8yHroFXXWTqHTAHIQ=;
        b=L5wdKzXY6/kI0Tdq+pYXvkMk+00nsyANEYLRAhJLXcq58eNl2JzZk+SAmifmj3wPyY
         Li4fDuZO87+AAt25WzxplD/8hRwh3EekiBpNg/RJyQRz0OW7WPRdnkQqHaMf3YkkkxsW
         fHuDPYYIcqaXH7QlrAm2s+zblRHClEHimsnOSSUkG1sQk92NT/0cHmZcgWNrRXo3xDIW
         ykEw50aDtD5mVUDTd1HikGZlT/g5gqk6hVFLkkK2E+6hXYmwez0oQXIHNwdxoH8BLdgl
         wOlauoOUYBbvy/ahZc2yy61DIsu+M9UXz1zg9lkREVZk9+6/X5wVCq0fyDs0DEyy7epo
         HFcA==
X-Gm-Message-State: AJIora/RIJzYfVubNmNLLotJr4M7/Au7UdhDmJ1j853susY2gZ2C+GCC
        pJh0S+rlkz2F3QWVUl5XC9w=
X-Google-Smtp-Source: AGRyM1vzji5IeXYT5V0ZThuSRg6t9bm/F+/+vinugM6yULQlMMLdDqGmt27BgQSivVn1fD3tAi//Rw==
X-Received: by 2002:a63:43c2:0:b0:41a:9dea:5dac with SMTP id q185-20020a6343c2000000b0041a9dea5dacmr14559542pga.585.1658841894228;
        Tue, 26 Jul 2022 06:24:54 -0700 (PDT)
Received: from logan-ThinkPad-T14-Gen-1 ([117.213.133.171])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a0b9700b001ece32cbec9sm13256339pjr.24.2022.07.26.06.24.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jul 2022 06:24:53 -0700 (PDT)
From:   Logananth Sundararaj <logananth13.hcl@gmail.com>
X-Google-Original-From: Logananth Sundararaj <logananth_s@hcl.com>
Date:   Tue, 26 Jul 2022 18:54:45 +0530
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org
Cc:     garnermic@gmail.com, thangavel.k@hcl.com, naveen.mosess@hcl.com,
        patrick@stwcx.xyz, velumanit@hcl.com
Subject: [PATCH v5] ARM: dts: aspeed: Adding Facebook Yosemite V3.5 BMC
Message-ID: <20220726132445.GA22389@logan-ThinkPad-T14-Gen-1>
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
index 000000000000..5eeff52f6c08
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
+
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
+		label = "spi0.0";
+		spi-max-frequency = <50000000>;
+		#include "openbmc-flash-layout-128.dtsi"
+	};
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi0.1";
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&i2c0 {
+	// Host1 IPMB bus
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
+	// Host2 IPMB bus
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
+	// Host3 IPMB bus
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
+	// Host1 IPMB bus
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
+	// NIC SENSOR TEMP
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
+	// FRU EEPROM
+	status = "okay";
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+	// INLET TEMP
+	tmp75@4e {
+		compatible = "ti,tmp75";
+		reg = <0x4e>;
+	};
+	// OUTLET TEMP
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
+
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

