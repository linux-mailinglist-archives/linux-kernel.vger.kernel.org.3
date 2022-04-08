Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D694F9928
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbiDHPPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbiDHPOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:14:50 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FBE1017DF;
        Fri,  8 Apr 2022 08:12:46 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z15so1667132qtj.13;
        Fri, 08 Apr 2022 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BiTCbZuuiqDpXPtBKnm7lrk6/Udlslh2uUBYoU46tJs=;
        b=mbS4q19oIqjAQ62E/SZBSAS+VQIoZvxk+Lvp/grvWdLSp1HSOjFEPHff+FMIPeer47
         ZTtnIRo7fEiU88/vZmzjyRJGJAnUet7X+rkS/8K3MzFektq6sA8aK2HLGW3AOHFZZVOm
         1tbnwiFwgBiEyC0e0JUnY1SF+1lHuSD2IioJQccwK5XE24rU0dTV3NawdCQD3o0Vkl3Y
         Pv1F9cPRFLNNWorCW6K8QglPWTwwGNXyGuKMT8Gdd+0aW0EROo5D5gyZzSvueyD9IEUA
         pv2KqNKRfPWeQaxsgaIkCbpSKmXxwRHN1G+aFCGb/IMkNTtPOBcwwtneyAOwMSUdjB/Y
         JhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BiTCbZuuiqDpXPtBKnm7lrk6/Udlslh2uUBYoU46tJs=;
        b=eZHx4RdKulj1I3zSjYdV1iY5FqB46J5+ZhYcYB94oY3/xOS0kqa5E0xOJMcmLQpztK
         4V4qKNTYpYe8s+OL99ndW3RGxKUqhewsaV1c3qZASyO2WVSM/Lhbvxo7aMgrcS3BfTB+
         m0qNGe1c+XMx8+BZStMMscUPc9bqPin6Mkzshid/7Z3sHF8LRZmTxn7S+GlILIsqEPgk
         LNWxqsXH9YwzuTvEFg91udEE9yoz3cGDc8O6LsjMOW2/QY7opfn2WeBa0PyWyBgeICwK
         t0ujriFM7PDeOav8YD2+mUlzwCTrVrZrn0KZfMMg1Lu4z5hSig4O6k54cPMSOVw4zZMF
         uQdQ==
X-Gm-Message-State: AOAM532XsNMzHB5qDUe0XzswXcpV7Kx2QwylUA7xH4SHzLYH21o60XVJ
        CgguQEBLw2DhDVx9qHlzQmc=
X-Google-Smtp-Source: ABdhPJxfCAacR/8MMW94Q5F36iZ+s7P9L3sPX/KHUxhf9Szg+AfYfAADj3i67pPKqBOD9hxbtum3Kw==
X-Received: by 2002:a05:622a:1894:b0:2e1:cbdb:8b74 with SMTP id v20-20020a05622a189400b002e1cbdb8b74mr15793603qtc.643.1649430765418;
        Fri, 08 Apr 2022 08:12:45 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id 191-20020a3707c8000000b0069a13545fcfsm2266052qkh.123.2022.04.08.08.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 08:12:45 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] arm64: dts: rockchip: enable dwc3 on quartz64-a
Date:   Fri,  8 Apr 2022 11:12:36 -0400
Message-Id: <20220408151237.3165046-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408151237.3165046-1-pgwipeout@gmail.com>
References: <20220408151237.3165046-1-pgwipeout@gmail.com>
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
index dd7f4b9b686b..141a433429b5 100644
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
@@ -672,6 +686,29 @@ &usb_host1_ohci {
 	status = "okay";
 };
 
+&usb_host0_xhci {
+	status = "okay";
+};
+
+/* usb3 controller is muxed with sata1 */
+&usb_host1_xhci {
+	status = "okay";
+};
+
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
-- 
2.25.1

