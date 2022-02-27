Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF5C4C5C94
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 16:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiB0PbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 10:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiB0PbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:31:02 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A63FDAB;
        Sun, 27 Feb 2022 07:30:25 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id j5so10514877qvs.13;
        Sun, 27 Feb 2022 07:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BiTCbZuuiqDpXPtBKnm7lrk6/Udlslh2uUBYoU46tJs=;
        b=jB3Bs3EV7b0tr5aaW5H0aQJpL0R6c0th6nflIfkIMfh7+LtdtG6Xw1wKMNP2PB6mXz
         W2OWFdKU3BUxOPUOvWmMJXtyIYKOSyuyHXdsbVI1wJo9QwajPFmLS/N1nLv0C2fcLYM2
         XhkiM2NHARQvwkultLQ9CtaaYUmg9fwU+UoTJCZgP1mOJAZ+AFlreNX8QrteZXz4XHU2
         Qyo1/ninC7R1yfazUCgmd/+/VweK14yyTyjtwFQYPcDHXkAsiFKCgDl893uPC4cOsBnW
         1DYiHipAFQ9l/Xni1uHkUXRk49bDIWdGUXilsi5MVbTrq4EIyZ77CPTtKul4FC3yIqIq
         wk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BiTCbZuuiqDpXPtBKnm7lrk6/Udlslh2uUBYoU46tJs=;
        b=L2xLPXrEo6CMHEItIOyrW8TCiRuoHYPh0SYu5xH8Ss9qDucY7L6O058Wl6vOYQ0lpv
         PoVvNjtYJxYHmf0eA9CaCh6omwB6KjGBFrGgTX1ImhAjZLHI29GyArGtjrnzjRmyRIsg
         YtLGJgFe6FfDIpDCAyf2TvBdc5krvosf0ZvePn3fFjNrQiUJgdsjg+y5DLqBjDygrY3A
         spLxekHmIp6aTYXIURKL2hkToGm3zjhpiZzBeSCFHJJ5aV7utcX8nrEkhDe72zQulx5D
         sdLlKefFrSADkOOlsTj2HAuxDSMR6EwR9nXJSQY/HhqOaHVQM37A6IYXOuqjiIsUVGga
         nQkg==
X-Gm-Message-State: AOAM533P4LYH0jgAO8M3IF/xq3IQFe4sz+/uT7GoL9eTa3XLeFjP7GsN
        Wlv5wmzkJxySb228fuMQClo=
X-Google-Smtp-Source: ABdhPJwhzzsUbaNu2GNX6hG+7RoLI3yIs08T4UJS9HpfV7hEI+6/L92WLdLG9Tvw6hv3JRe9TJVqnQ==
X-Received: by 2002:ad4:596e:0:b0:42c:33e4:e496 with SMTP id eq14-20020ad4596e000000b0042c33e4e496mr11539543qvb.35.1645975824958;
        Sun, 27 Feb 2022 07:30:24 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a080a00b0062ce6f3f5d7sm3845767qks.16.2022.02.27.07.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 07:30:24 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        jbx6244@gmail.com, Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] arm64: dts: rockchip: enable dwc3 on quartz64-a
Date:   Sun, 27 Feb 2022 10:30:15 -0500
Message-Id: <20220227153016.950473-7-pgwipeout@gmail.com>
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

