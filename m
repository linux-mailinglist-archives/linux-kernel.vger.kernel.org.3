Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988D24C57A6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiBZSnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiBZSmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:42:43 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12B61E64FD;
        Sat, 26 Feb 2022 10:42:05 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id s15so5512870qtk.10;
        Sat, 26 Feb 2022 10:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OHIHH7LBjO7n3w0TkyTvZ+CHhZPHMYRUZ96K/VbT0E0=;
        b=aIKmXmXT0X3QGneIFAV3GhqKa4LgEhGVof8di7S4VZTO3vixTBvQ18ZxWjDRJJJn7d
         L3kouKub8Vu8dxjHqk+L4g4vIN30KNoaIxOu5RZH75NLsvfkpzNtrLzXmvXNNwnYKpGh
         nZcn8AP5Gn9bSm3UlB6HfQCWMKxmz7YrxTH6pJVewCZs4rmS5SoW/vOgbgF63siaUj1q
         NJp5hQIe9XrYcGX32A8i+uuVqc5qVyrsc0Kk4ERlPHNJb82AcdcQ0DkFxMQMUoUZycLy
         ca1MGC8AtLvQlJzYz17WoUWa/oQ/7BjiZtGxmgiH1jDDbdMKTTjSKDXpRnzRZ2Xeh2V2
         HQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHIHH7LBjO7n3w0TkyTvZ+CHhZPHMYRUZ96K/VbT0E0=;
        b=FnDrvVutfQf6cGUZSDAM7kZ0Xuf9utTfL+ykAkEpB2jtStGBrJ9JymyiCF8+ws/58n
         zsWUgVRgSGj8W0gBeb2K1vMvM/osr1cy8WJgnKZwTW0s1AWYhnXRsh1f6hx34F86Iyye
         svvHfrKT2+WdSsTJA49oh5PElGDBSJ59LbV1l4QdLDQXWretCCOh/1rdXOQlwICjdX6e
         EHkAimNZqpqyYBsYPbLqeTBbSKegGMBc0M3stDqHZdQu/i7SPz82+CWOYOdfZp9BmICS
         yOWZMyZP+CTzjQOIpzBQg67v4+P2ugaZ6Hupd7LkHCY419mHB/z0wqDlaBKF9IOQotZT
         nX0g==
X-Gm-Message-State: AOAM532sP5qBq5i6S9TVzj4wk+q9LEXyphzBcPEvCIDRFcZCzmValu5u
        nfHTMKbuKIbttvYmZx0ur3w=
X-Google-Smtp-Source: ABdhPJxlMcbNkkrusXkql9nwS+Wn/Z9sD2cs8nqKgPu+C8cCCHwwYoC2LCrMmNBJLLog7nn4qwdHmg==
X-Received: by 2002:a05:622a:1187:b0:2de:6ffc:19f8 with SMTP id m7-20020a05622a118700b002de6ffc19f8mr11440373qtk.453.1645900925094;
        Sat, 26 Feb 2022 10:42:05 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id p68-20020a378d47000000b006491d2d1450sm2891983qkd.10.2022.02.26.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:42:04 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10
Date:   Sat, 26 Feb 2022 13:41:47 -0500
Message-Id: <20220226184147.769964-12-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226184147.769964-1-pgwipeout@gmail.com>
References: <20220226184147.769964-1-pgwipeout@gmail.com>
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

