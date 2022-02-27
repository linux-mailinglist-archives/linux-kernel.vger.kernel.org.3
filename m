Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304A84C5C96
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 16:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiB0PbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 10:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiB0PbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:31:05 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C203E40A00;
        Sun, 27 Feb 2022 07:30:26 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b13so8551545qkj.12;
        Sun, 27 Feb 2022 07:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OHIHH7LBjO7n3w0TkyTvZ+CHhZPHMYRUZ96K/VbT0E0=;
        b=dqo1I6grQ/gBiqH+YPs7rXzhBD+bYuTqGeeOaI1GieS/LuXuyYCOf4SDuoUihIgUKI
         wmB98GeiOf2BtGiD47F0s2369fXjh0kq6UMFZp8ZioU4oEmdcbksndvsD8my0ClMng4H
         KrtuQYss4Pw3Ltj2HJsJWXw6ykBZp1gHzox4ECvCsN13uy4xpInoE94UI9kGZyWBcA9Y
         ogmnGkDDmzEInz6Um7XAIbKyAEnB3gfq+AAC4skkXDrTBS2bSNgEg2HXzP5AOPiJu1zF
         dR1ElE9m03h4tuNnBDpHnqSfOR5pZ27Js4ThB+oodojxkhohDSCGnIGcqnokDnjVqPcR
         I9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHIHH7LBjO7n3w0TkyTvZ+CHhZPHMYRUZ96K/VbT0E0=;
        b=cSxjVGjx1XWeQbNZSNooOgiSDY26/nwT+wgVOtZKtjNHke+oTuoU8/j+OtecOleW0e
         PX/1tuEQHsKxtE/aFRpvv1DGP5DZk5TIGUps/neQGhB2GOj9b3xGCnYG8mHH1gTmCxs3
         rg+HaGLvaEvdCabiVKtPhmFj8rwriWV0wFg+ghnUqhCXUBV9/z0gZeCsvVnR0KTc3X6Q
         ai+R3gjYALC8MemJ4xlgbPxxu/Ht7XgRobHufotFrFg2DhVNhxrnKrbpdJBjS8aeRfsn
         PquNUjrF38/xEIs6st+texjeE21FZIwiXNtTUHaQwGo2lHuPfvNxuG5jQ2R1Bcm0GoyN
         kDxQ==
X-Gm-Message-State: AOAM531z8hltWvlECGQLsDT9M5iFPGZHH57xGY+fkB124k8/QpOD+drk
        omJe7n4TnjBUy2sNb2Iu3wKDTPQ/xgh0jg==
X-Google-Smtp-Source: ABdhPJxTAoe1idnBUg1yVcCCX5Wrzu4GMifkspHde49AFZZ3QzRabhGZqebkFr/DuC/6AhlQinm6+Q==
X-Received: by 2002:a05:620a:13d1:b0:5f1:788d:cac9 with SMTP id g17-20020a05620a13d100b005f1788dcac9mr9478022qkl.608.1645975825899;
        Sun, 27 Feb 2022 07:30:25 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a080a00b0062ce6f3f5d7sm3845767qks.16.2022.02.27.07.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 07:30:25 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        jbx6244@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10
Date:   Sun, 27 Feb 2022 10:30:16 -0500
Message-Id: <20220227153016.950473-8-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220227153016.950473-1-pgwipeout@gmail.com>
References: <20220227153016.950473-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Riesch <michael.riesch@wolfvision.net>

The Rockchip RK3568 EVB1 features one USB 3.0 device-only
(USB 2.0 OTG) port and one USB 3.0 host-only port.
Activate the USB 3.0 controller nodes and phy nodes in the
device tree.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index a794a0ea5c70..622be8be9813 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -103,6 +103,18 @@ vcc5v0_usb_host: vcc5v0-usb-host {
 		vin-supply = <&vcc5v0_usb>;
 	};
 
+	vcc5v0_usb_otg: vcc5v0-usb-otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb_otg_en>;
+		regulator-name = "vcc5v0_usb_otg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
 	vcc3v3_lcd0_n: vcc3v3-lcd0-n {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_lcd0_n";
@@ -136,6 +148,14 @@ regulator-state-mem {
 	};
 };
 
+&combphy0 {
+	status = "okay";
+};
+
+&combphy1 {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_cpu>;
 };
@@ -507,6 +527,9 @@ usb {
 		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+		vcc5v0_usb_otg_en: vcc5v0_usb_otg_en {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 };
 
@@ -568,6 +591,11 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+&usb_host0_xhci {
+	extcon = <&usb2phy0>;
+	status = "okay";
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
@@ -576,6 +604,24 @@ &usb_host1_ohci {
 	status = "okay";
 };
 
+&usb_host1_xhci {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	vbus-supply = <&vcc5v0_usb_otg>;
+	status = "okay";
+};
+
 &usb2phy1 {
 	status = "okay";
 };
-- 
2.25.1

