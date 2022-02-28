Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7D54C6EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiB1N6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbiB1N5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:57:54 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D72D7D013;
        Mon, 28 Feb 2022 05:57:16 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id g23so12550963qvb.4;
        Mon, 28 Feb 2022 05:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OHIHH7LBjO7n3w0TkyTvZ+CHhZPHMYRUZ96K/VbT0E0=;
        b=F6IhWmzb4cnHIFA1qIQwAvnKEQ1K2GIrl4xx2jcR9lR2UnMRm9NjHHo5JqKxIiRNtA
         Yo4UHxBL6ux+9oyJIsYGmeUoapDPI1Pk9TYmf3Db+2aIKZzv31/IhxZNzfZ5nng9APzo
         8ogBn4ijwd/hH6ypNhyN4iT5ZBqf3PsBGn+Lp2e5+KzM0SCTChaUXgjsZ4GL1V0pW1A0
         DeA9H60uYVywZ5vMHH9WSJ4XNrBBWCP5qYd1NfNn9VshJW0ZoEDVUfU6flaJjOME0qQw
         aPEWusYBUcw4KUbAcoxvsiH05fV/21oHvusB4BIIcwjRLS0mUJY2aYDgB9p0QDrLTxDk
         HWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHIHH7LBjO7n3w0TkyTvZ+CHhZPHMYRUZ96K/VbT0E0=;
        b=d0I4RR3Gx0JRzmoZAjVslAvcbf4YU6XpR5VTfyIZqdeJm4pV+mDcc7iXS3mDDyZy1X
         IIWjNo/ZlhIeosM33Ygbf0IBBpKQTR46i/4f1hjAMcOpcQXqMlgPDJUTQbalYpjyXMWx
         iuJpQHM/LUzyBd0GAnA8KS3IvBuicgGYHiH+2ST3H7BVImpB71QcyNy893YlVzzz7IzJ
         +FAPMrXDW7LxgL46BPiCVRWF5deNgthZLhoInW+RHVW7xl1Ry2XQgECF/o9WIdlHBZlm
         4BMp4LGmIwy+koN7iD1VbqiBElD3erDqrPW5jgyurgHGauiOntH6/BuGcI4rkXTw+VUw
         VEig==
X-Gm-Message-State: AOAM530KWCW/ShtRMyl0O/HNP87bLStwDTdImo0WBU2XfANNg0He9BzN
        E6EtLJigltHXZZAT5OazEU8=
X-Google-Smtp-Source: ABdhPJzXNKADtw0ku6kOnCLRqxDyPgG/YOnDyvyNoSYZ7y5E38ghaI+xQtmpImP6Kw6m2PtIBFhRTw==
X-Received: by 2002:ac8:5fd1:0:b0:2d4:d8ee:84d3 with SMTP id k17-20020ac85fd1000000b002d4d8ee84d3mr16473255qta.147.1646056635478;
        Mon, 28 Feb 2022 05:57:15 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a088800b00648bfd00a41sm4932244qka.80.2022.02.28.05.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:57:15 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        jbx6244@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/8] arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10
Date:   Mon, 28 Feb 2022 08:56:59 -0500
Message-Id: <20220228135700.1089526-9-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228135700.1089526-1-pgwipeout@gmail.com>
References: <20220228135700.1089526-1-pgwipeout@gmail.com>
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

