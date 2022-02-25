Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA614C4808
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241964AbiBYOzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241932AbiBYOzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:55:16 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12842325C2;
        Fri, 25 Feb 2022 06:54:44 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id bm39so4698109qkb.0;
        Fri, 25 Feb 2022 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oKfaXxTGc+2P/fRlR69FqeRWVrJ1FRef9N70RXYizpI=;
        b=XqeM9c7FMetkvxUelD3CMWMxe4MLdYQj9t0n+RbCNWCrJ4NwISdljwIYT7ZGl2xoqI
         BJQnqoWbqwXN5sydCKrv/Tqn3QqPXTCc8AN4V4x+SZL/K/ixQelbtV+gvIIJBuD/pdoj
         5OjM6bGvKMXY+2xP2z2LJzp5eIRPn50J1xnsph72iUJj20OFzYnyOjSpqT7yFUlPAS1b
         lapYJs/lKw9dDcjE3alasio6+ypU09IIWFmTtgEr1PCBAzbh0mC+xHHVrKFX5aYd3UDt
         0EpaDFEKCorL/5tsSlnACCBi6R8Vnr+mEX35gEueEbziz1/LAuPgmIglJcSSfBnjAAu2
         +j4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oKfaXxTGc+2P/fRlR69FqeRWVrJ1FRef9N70RXYizpI=;
        b=klTNPN8EAhfntCNDw0qSS+Q5v3AmC73Qth0AQVlStx3k8j1MzB9O1H8KmIbbSYrUeD
         ldj2suJml75DLb266+gEYtc2qRSki8mI8aY4YT+CZ2AXCt10LoluVGG7zxrYjiH3UuRt
         QAE7su+5ZeYVmA4wkcFVI8YwDxzi9lu5kUJ4ffQJJXz0CBCUxTwikldGzRgC9ER+cPif
         G2PtvgQpHWy+FaB2nrL6p++SFiz5ERc8TK+KDWaoZjTHg+ZIc1sJSQln9cFj2fVZ1NC8
         SL1b2gAnjJ0pxSSi5Uv7XtawV41Bpb8leKfAra1zK9T3dYIgcY5Hly8h6kh1pZ4nFdJU
         kF/A==
X-Gm-Message-State: AOAM533HgB+FAAluubGBR0fT9cG3Jbg10ptBbERipVaU1HYIh/O4sxYg
        sNa1uckjk+ghoXR4sQFGgXV+k+f8x0AhMQ==
X-Google-Smtp-Source: ABdhPJwmBmlnumTJ/EgWC7d02acfCNzECApowxrebC5yZ8TCcfNS5vdlZ4L38h2kP7AlhNkxewqM6w==
X-Received: by 2002:a05:620a:1992:b0:649:56f3:6451 with SMTP id bm18-20020a05620a199200b0064956f36451mr5073437qkb.84.1645800883804;
        Fri, 25 Feb 2022 06:54:43 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id d202-20020a3768d3000000b005f18706845dsm1318292qkc.73.2022.02.25.06.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 06:54:43 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 8/8] arm64: dts: rockchip: enable dwc3 on quartz64-a
Date:   Fri, 25 Feb 2022 09:54:31 -0500
Message-Id: <20220225145432.422130-9-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225145432.422130-1-pgwipeout@gmail.com>
References: <20220225145432.422130-1-pgwipeout@gmail.com>
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

The quartz64 model a has support for both the dwc3 otg port and the dwc3
host port. Add the otg power supply and dwc3 nodes to the device tree to
enable support for these.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index dd7f4b9b686b..a911fa1ef955 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -151,6 +151,16 @@ vcc5v0_usb20_host: vcc5v0_usb20_host {
 		vin-supply = <&vcc5v0_usb>;
 	};
 
+	vcc5v0_usb20_otg: vcc5v0_usb20_otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
+		regulator-name = "vcc5v0_usb20_otg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dcdc_boost>;
+	};
+
 	vcc3v3_sd: vcc3v3_sd {
 		compatible = "regulator-fixed";
 		enable-active-low;
@@ -187,6 +197,10 @@ vcc_wl: vcc_wl {
 	};
 };
 
+&combphy1 {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_cpu>;
 };
@@ -672,6 +686,20 @@ &usb_host1_ohci {
 	status = "okay";
 };
 
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_usb20_host>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	phy-supply = <&vcc5v0_usb20_otg>;
+	status = "okay";
+};
+
 &usb2phy1 {
 	status = "okay";
 };
@@ -685,3 +713,12 @@ &usb2phy1_otg {
 	phy-supply = <&vcc5v0_usb20_host>;
 	status = "okay";
 };
+
+&usbdrd30 {
+	status = "okay";
+};
+
+/* usb3 controller is muxed with sata1 */
+&usbhost30 {
+	status = "okay";
+};
-- 
2.25.1

