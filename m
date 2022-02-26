Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB354C579F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiBZSnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiBZSmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:42:43 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EF227EDF6;
        Sat, 26 Feb 2022 10:42:05 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id bt3so5511645qtb.0;
        Sat, 26 Feb 2022 10:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BiTCbZuuiqDpXPtBKnm7lrk6/Udlslh2uUBYoU46tJs=;
        b=WSasS5o84NKASXBrTz0GFTfqczipyA8RJUMD45mwAouCwMjDQkCS6t2pjJXhrxmBSn
         PLWHcJxPouyMNX4nMIk/TruxYzycYsolbsI41ian13T7ZeVAhGsvzGkBjaqi93DMWQH6
         d0f9ob6wx6JFKGZF43OqG1jGcugSsQv70jm6MWJ2l3+OFUcr8oIMGE44LPvRDx2FqgaS
         KSkxnrGGKt+ZGAU2I0jKe3mtRVsbmb0DzA4zZAnxUKbqMXNYYZT/yOtsuCTQaXvqcHVx
         qoPHy4kLtLdfL80nNm3LwsRil7ys1clVLJOn/dSAa+MJ34BaBSqFncf/Y4E648M4QZyf
         xnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BiTCbZuuiqDpXPtBKnm7lrk6/Udlslh2uUBYoU46tJs=;
        b=jcZHSCkE9CxMEsCyErwcy9FIaLupAd4BDSLu+EffsfG9+OySuXWFhopx9m/mb5NoN1
         BHlEjbc0tucr/fwbjKp1lv6ek+ftnmXuAxIYp0P6fm0sSSofOWu6NA6uJxSEuY4p4Ano
         ZBk+j/mo8miHWogaTYcdjfC0oKW/gsNvJfA5V5w1VtqKbexJpiWyCPA3w+a2ApdhE7b7
         6/9HpVPn3ye+bxToVxfEEoBe+CMwadE2UiR7l+XrRctJOkPKLNtyW0HaWEJjR9MS5DIg
         c3z0Fpuk5TCUAiCSdlzfKPnvZiCXDi49+8JNb29f+p3KbgiahAncsh8o5VUce6MEAHYh
         m7eg==
X-Gm-Message-State: AOAM533jZutXoJnb7/xhTNy+LpLnWpg6CrV1Ku/w3r9O0j0HPrjFwHyE
        ozYqI5oVoG/bCr3A/NzkPSQ=
X-Google-Smtp-Source: ABdhPJzVSDaykusaRDWHVDOOn6aVrgM0ZbT4aX2SWabl7igqk3VkLmqcFRsjfPFR6LEHbTRRh6el7Q==
X-Received: by 2002:ac8:58c1:0:b0:2de:4700:122c with SMTP id u1-20020ac858c1000000b002de4700122cmr11185108qta.100.1645900924148;
        Sat, 26 Feb 2022 10:42:04 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id p68-20020a378d47000000b006491d2d1450sm2891983qkd.10.2022.02.26.10.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:42:04 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] arm64: dts: rockchip: enable dwc3 on quartz64-a
Date:   Sat, 26 Feb 2022 13:41:46 -0500
Message-Id: <20220226184147.769964-11-pgwipeout@gmail.com>
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

