Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00E84FE50E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357237AbiDLPsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiDLPsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:48:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5876320BCE;
        Tue, 12 Apr 2022 08:45:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n18so17129176plg.5;
        Tue, 12 Apr 2022 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3okIYTvZNPFDunpvxgG2iXtNjtosYg6lQPzQ1MGwbJk=;
        b=X/UPOyLBVYd9TIRyXWlv2m/qBkAxBI3gZcp892x+jLOpWGQjCrY6l21VxfC6OIj2zx
         y+LNFLSq/2ySZEPpl9NRKL7mVdXtUA6ygKL9jgpGDbOZYiwjU1Vb610Kau3kM9gkp9Vb
         pxoPd+4QWSBTcPUSacGXjBsZ1U6p1WJdjjzj1RpFHx6tlnqyz7G1VHbgGj/NqCc1OBoZ
         s7apPROniiyoUB7V+1tf/XE6jONPrZleR1Ms1Hwt7RGFgF2SL8UDaLhwpJpepNe2ZOHX
         1vbaO0ALE1SXpeS3xeAmff5kPNqCp0FmAlOvGBrg5Q4pOpLmKjxZ6qAgXnVtTr9VxIq3
         DvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3okIYTvZNPFDunpvxgG2iXtNjtosYg6lQPzQ1MGwbJk=;
        b=aDrJgLzO7LLst3jqniN5B1bbzZIHUxgFJ+bxy3wJs/mYoLONtxdmtTgv+AJBqSJX3W
         UMjlj3Yk2FkFQQDO4kPwlJm1kLhlKSmf48uLUFE01xprjlR72rEUtJkahXERjeI5o2U8
         f+TYu9KlHrgdl7RhZfep/bSqvIeR+r0JsY1lbGqmyBlhtMTrOtatVmmKuZmhcybvkyDx
         AcmdFXJmahkHRvVCOis8fbwP3YSHf3ej1VWEz4ev9dHy6QG6wqtCxm59VVTPF99ThVJG
         KilXuMXrMIqwVvlsisV+WaYDVf4bLn29iFTp6Hv4geKEe8Hf+lQFQvi6mlJkDQ4qZmVH
         B9VA==
X-Gm-Message-State: AOAM532+pqcaalM9mnFGVqU07YTK9nglm52x9P3+K6KUCNZTXgwmMGtB
        7kP5TpJVcq2tuKT788U9DE8=
X-Google-Smtp-Source: ABdhPJwfCHUCHLh1AyfvndnhFyCvr6gFxb9RB5wBg1ql/h57JQt+JyCDcfyRnQmR3mPH3+JjWND2EQ==
X-Received: by 2002:a17:902:eb81:b0:158:937e:adf with SMTP id q1-20020a170902eb8100b00158937e0adfmr1853244plg.123.1649778342872;
        Tue, 12 Apr 2022 08:45:42 -0700 (PDT)
Received: from V2.localdomain (M106073234000.v4.enabler.ne.jp. [106.73.234.0])
        by smtp.gmail.com with ESMTPSA id pg14-20020a17090b1e0e00b001c75634df70sm3285157pjb.31.2022.04.12.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 08:45:42 -0700 (PDT)
From:   SHIMAMOTO Takayoshi <takayoshi.shimamoto.360@gmail.com>
To:     takayoshi.shimamoto.360@gmail.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: BCM5301X: Add DT for Buffalo WZR-1166DHP2
Date:   Wed, 13 Apr 2022 00:44:30 +0900
Message-Id: <20220412154432.12124-1-takayoshi.shimamoto.360@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffalo WZR-1166DHP2  wireless router with

 - BCM4708A0
 - 256MiB DDR2 SDRAM
 - 128MiB NAND flash
 - 2T2R 11ac/a/b/g/n Wi-Fi
 - 4x 10/100M ethernet switch

The hardware configuration is very similar to the WZR-1750DHP,
except for memory size and number of antennas.

Signed-off-by: SHIMAMOTO Takayoshi <takayoshi.shimamoto.360@gmail.com>
---
 .../boot/dts/bcm4708-buffalo-wzr-1166dhp2.dts | 189 ++++++++++++++++++
 1 file changed, 189 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dts

diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dts
new file mode 100644
index 000000000000..22e54a0a202a
--- /dev/null
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dts
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Broadcom BCM470X / BCM5301X ARM platform code.
+ * DTS for Buffalo WZR-1166DHP2
+ *
+ * Copyright (C) 2014 Rafał Miłecki <zajec5@gmail.com>
+ * Copyright (C) 2022 SHIMAMOTO Takayoshi <takayoshi.shimamoto.360@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+#include "bcm5301x-nand-cs0-bch8.dtsi"
+
+/ {
+	compatible = "buffalo,wzr-1166dhp2", "brcm,bcm4708";
+	model = "Buffalo WZR-1166DHP2 (BCM4708)";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x08000000>,
+		      <0x88000000 0x08000000>;
+	};
+
+	spi {
+		compatible = "spi-gpio";
+		num-chipselects = <1>;
+		gpio-sck = <&chipcommon 7 0>;
+		gpio-mosi = <&chipcommon 4 0>;
+		cs-gpios = <&chipcommon 6 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hc595: gpio_spi@0 {
+			compatible = "fairchild,74hc595";
+			reg = <0>;
+			registers-number = <1>;
+			spi-max-frequency = <100000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		usb {
+			label = "bcm53xx:blue:usb";
+			gpios = <&hc595 0 GPIO_ACTIVE_HIGH>;
+			trigger-sources = <&ohci_port1>, <&ehci_port1>,
+					  <&xhci_port1>, <&ohci_port2>,
+					  <&ehci_port2>;
+			linux,default-trigger = "usbport";
+		};
+
+		power0 {
+			label = "bcm53xx:red:power";
+			gpios = <&hc595 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		power1 {
+			label = "bcm53xx:white:power";
+			gpios = <&hc595 2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		router0 {
+			label = "bcm53xx:blue:router";
+			gpios = <&hc595 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		router1 {
+			label = "bcm53xx:amber:router";
+			gpios = <&hc595 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		wan {
+			label = "bcm53xx:blue:wan";
+			gpios = <&hc595 5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		wireless0 {
+			label = "bcm53xx:blue:wireless";
+			gpios = <&hc595 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		wireless1 {
+			label = "bcm53xx:amber:wireless";
+			gpios = <&hc595 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
+		};
+
+		aoss {
+			label = "AOSS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&chipcommon 12 GPIO_ACTIVE_LOW>;
+		};
+
+		/* Commit mode set by switch? */
+		mode {
+			label = "Mode";
+			linux,code = <KEY_SETUP>;
+			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
+		};
+
+		/* Switch: AP mode */
+		sw_ap {
+			label = "AP";
+			linux,code = <BTN_0>;
+			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
+		};
+
+		eject {
+			label = "USB eject";
+			linux,code = <KEY_EJECTCD>;
+			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&usb2 {
+	vcc-gpio = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
+};
+
+&usb3 {
+	vcc-gpio = <&chipcommon 10 GPIO_ACTIVE_LOW>;
+};
+
+&spi_nor {
+	status = "okay";
+};
+
+&usb3_phy {
+	status = "okay";
+};
+
+&srab {
+	status = "okay";
+
+	ports {
+		port@0 {
+			reg = <0>;
+			label = "lan1";
+		};
+
+		port@1 {
+			reg = <1>;
+			label = "lan2";
+		};
+
+		port@2 {
+			reg = <2>;
+			label = "lan3";
+		};
+
+		port@3 {
+			reg = <3>;
+			label = "lan4";
+		};
+
+		port@4 {
+			reg = <4>;
+			label = "wan";
+		};
+
+		port@5 {
+			reg = <5>;
+			label = "cpu";
+			ethernet = <&gmac0>;
+		};
+	};
+};
-- 
2.30.2

