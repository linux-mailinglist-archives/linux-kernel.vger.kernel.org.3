Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188F64B0E26
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbiBJNKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:10:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiBJNKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:10:50 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CD61A7;
        Thu, 10 Feb 2022 05:10:50 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id d188so7152796iof.7;
        Thu, 10 Feb 2022 05:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CI6j1xULGHZK/LVW1ZPwGP4+AV2y1oZFGa5IIiZmDJo=;
        b=IiXa3VQCBaF1SQR3XFy7qVDbJBImBsmQr2ySMCLd5hGTAr79yz7XXN6wj+uTkU8TO3
         dYtgDZJhGzwMKCUO9sLKJokv69VOZ3Az1TVq3ATxSYX576eiywU0ZG5xHPbkjU1zXCpg
         fp12novry+/WVScxQr4b/ouLV94M6wnamV5uhCAVZUn/UfDBj/Hgwabqla3z9n0OQkDB
         aXoS8OXUTsEVVkK7N6qEfVxqH+8o/R4AV024vON45LxXEUpFvcrmPl4ix2S4emg2nbfC
         afCL5gHo2kl6D85muQrijK4J0RmBEA/pV5XmGQkgAn8iyC1ivf3F5hXQ3dD0mTcaDejl
         rm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CI6j1xULGHZK/LVW1ZPwGP4+AV2y1oZFGa5IIiZmDJo=;
        b=SZnwEVkWgMBwhFD5om4aN8QfFtEQQRpdWTPh+OL8kiNM6l42APJSIDmp9XMLxZBqXc
         K6QMfIJ0oAymK1V20AYzI5a8wfv8VWu7gTx75Xzk2dAYidWs+2l7aAhp7VuFMMFVuj23
         P907HLFia5RGxkFhw0+QSmmb39bR5US4RCfe8TMw1VZnzCvEHib6fNP4w8VrzEVsv95V
         EEM25ox2GjYg3U2lo/sa3WEEVe2xYEEibeLrXQunr9Sgq5Ni0YA8WVmwt2FxjUbLs4kV
         l6bxEK8wAW+77QCkx/ZKCrgY8CckOUGZbIabQaCDUykIsBKtwuCVZN1wiOJw8b3nBV/O
         6vNQ==
X-Gm-Message-State: AOAM5338/q5YEmOoPWLoo+VUeH/cpv8GnmDtmEM6YjI0NLxjR4T+HRPm
        EYR0UO3I2zbdk1X9a6EXHyeGhAuw/C1nGQ==
X-Google-Smtp-Source: ABdhPJxdr4zXq6vGyMReqolYLQfOtmPtsRHFFhb9UQcKCp1p2ZiL9mBFZ5+kjCdb03tgN/4ftCRQOw==
X-Received: by 2002:a5e:8406:: with SMTP id h6mr3750298ioj.144.1644498649526;
        Thu, 10 Feb 2022 05:10:49 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:ca61:525d:775a:21bf])
        by smtp.gmail.com with ESMTPSA id o22sm11173756iow.37.2022.02.10.05.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 05:10:48 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: dts: logicpd-torpedo: Add isp1763 support to baseboard
Date:   Thu, 10 Feb 2022 07:10:28 -0600
Message-Id: <20220210131028.1404851-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
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

The baseboard has an ISP1763 USB controller acting as a host.
Since the pinmuxing for the corresponding IRQ is different
between OMAP35 and DM37, the pinmux has been placed in the
kit-level files, while the common code is placed into the
baseboard file.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts
index 57bae2aa910e..cb08aa62d967 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts
@@ -11,3 +11,11 @@ / {
 	model = "LogicPD Zoom OMAP35xx Torpedo Development Kit";
 	compatible = "logicpd,dm3730-torpedo-devkit", "ti,omap3430", "ti,omap3";
 };
+
+&omap3_pmx_core {
+	isp1763_pins: pinmux_isp1763_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2154,  PIN_INPUT_PULLUP | MUX_MODE4)	/* sdmmc1_dat6.gpio_128 */
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
index 5532db04046c..07ea822fe405 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
@@ -85,3 +85,12 @@ OMAP3630_CORE2_IOPAD(0x25da, PIN_INPUT_PULLUP | MUX_MODE2)   /* etk_ctl.sdmmc3_c
 		>;
 	};
 };
+
+/* The gpio muxing between omap3530 and dm3730 is different for GPIO_128 */
+&omap3_pmx_wkup {
+	isp1763_pins: pinmux_isp1763_pins {
+		pinctrl-single,pins = <
+			OMAP3_WKUP_IOPAD(0x2a58, PIN_INPUT_PULLUP | MUX_MODE4)	/* reserved.gpio_128 */
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
index 533a47bc4a53..b4664ab00256 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
@@ -93,7 +93,8 @@ &charger {
 
 &gpmc {
 	ranges = <0 0 0x30000000 0x1000000	/* CS0: 16MB for NAND */
-		  1 0 0x2c000000 0x1000000>;	/* CS1: 16MB for LAN9221 */
+		  1 0 0x2c000000 0x1000000	/* CS1: 16MB for LAN9221 */
+		  6 0 0x28000000 0x1000000>;	/* CS6: 16MB for ISP1763 */
 
 	ethernet@gpmc {
 		pinctrl-names = "default";
@@ -102,6 +103,44 @@ ethernet@gpmc {
 		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;		/* gpio129 */
 		reg = <1 0 0xff>;
 	};
+
+	usb@6,0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&isp1763_pins>;
+		compatible = "nxp,usb-isp1763";
+		reg = <0x6 0x0 0xff>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "host";
+		bus-width = <16>;
+		dr_mode = "host";
+		gpmc,mux-add-data = <0>;
+		gpmc,device-width = <2>;
+		gpmc,wait-pin = <0>;
+		gpmc,burst-length = <4>;
+		gpmc,cycle2cycle-samecsen = <1>;
+		gpmc,cycle2cycle-diffcsen = <1>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <45>;
+		gpmc,cs-wr-off-ns = <45>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <0>;
+		gpmc,adv-wr-off-ns = <0>;
+		gpmc,oe-on-ns = <0>;
+		gpmc,oe-off-ns = <45>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <25>;
+		gpmc,rd-cycle-ns = <60>;
+		gpmc,wr-cycle-ns = <45>;
+		gpmc,access-ns = <35>;
+		gpmc,page-burst-access-ns = <0>;
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <60>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wr-data-mux-bus-ns = <5>;
+		gpmc,wr-access-ns = <20>;
+	};
 };
 
 &hdqw1w {
-- 
2.32.0

