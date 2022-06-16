Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7C554D674
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350165AbiFPAyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350033AbiFPAyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:54:12 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B905715D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d129so12901642pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0YNwH3n6PjIeqiCRdH4f7yYwMmdAgLu9xDerffdwL8=;
        b=K0AVGQEm8suGzIiJnahUJLp+ZdFjU8WamJJH8Akpa5KPZmZE7aInFg6OiJFKbQhNhL
         RT0hmjB/JS9NmzdDhTJFeKR9Jw/RltbH8IpENXeqgTNl+Cfe/5bRJCx7MkxrMe6XDkVO
         6k7kB27DzRYO95/RSs7kC7XRnylf7zbv4BVoiYqWKPmuLokZadiO3yE9gl98SIOLWtdA
         zvrfqKAbTrGjiTbkeSjlSHeSvO3V4AGZMDsBbFV/IRgnrAykmekNAw4vk9pFk/hJ+/OZ
         an2k9jMiCClQPYIiw32debQq+kHrvINtM0ZNpwsCwiC+zmKr61i6Fb/ovnIgVj7ej1RC
         Mweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0YNwH3n6PjIeqiCRdH4f7yYwMmdAgLu9xDerffdwL8=;
        b=QRsbFsPNuldRkJdNchiJhKo5ZGhkNgQcIkMg0KR2kUASXWc4R9/MNvmGRGlaLQpPNE
         tAFRkyIjOfj82da8aKSuWmoViBXMt1zWVHz2RrwnNs9xBoDpJgHYP8FS5GptNVBWtv04
         wMFAmfONNfvTchgnCC2br0FXGGuS05ncBe/qmjHiFjtNURTstcCBfIhsBpTDY21nTaK4
         63WXKqvJlYZ80EdaWTM7PtXcI8qE6E/XbyUw8eUA76dmJk7ow0QuxmtPsBXHKwygfxWY
         I0eBt4PLnJqySmEskQauRd6wVahUsOC7cTHvwGirMPcdcUhNH/5hfS86oD8P/OxFzBTO
         xcNQ==
X-Gm-Message-State: AJIora9UdkAjrG+ibcgWHrUxLj8spnbAAC72JQnFBSn8V7l5lKAWbRsE
        z1MOuL9NM3L67HH1q/PfeRWvPw==
X-Google-Smtp-Source: AGRyM1tLNfmaBfmE0NEI0mTbmy0dpgYmXYHujjOMZg4bQk2kLfZaAhhrgg7Emu68enXZ5qFD+YkCbA==
X-Received: by 2002:a63:86c3:0:b0:3fd:9c06:ee37 with SMTP id x186-20020a6386c3000000b003fd9c06ee37mr2118122pgd.357.1655340849623;
        Wed, 15 Jun 2022 17:54:09 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 11/40] arm64: dts: marvell: align gpio-key node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:04 -0700
Message-Id: <20220616005333.18491-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts     | 2 +-
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index caf9c8529fca..6721b9b4cf5c 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -45,7 +45,7 @@ red {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		reset {
+		key-reset {
 			label = "reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpiosb 20 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index 871f84b4a6ed..15f6ca4df121 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -94,7 +94,7 @@ keys {
 		pinctrl-0 = <&cp0_gpio_reset_pins &cp1_wps_button_pins>;
 		pinctrl-names = "default";
 
-		button_0 {
+		button-0 {
 			/* The rear button */
 			label = "Rear Button";
 			gpios = <&cp0_gpio2 7 GPIO_ACTIVE_LOW>;
@@ -102,7 +102,7 @@ button_0 {
 			linux,code = <BTN_0>;
 		};
 
-		button_1 {
+		button-1 {
 			/* The wps button */
 			label = "WPS Button";
 			gpios = <&cp1_gpio1 30 GPIO_ACTIVE_LOW>;
-- 
2.34.1

