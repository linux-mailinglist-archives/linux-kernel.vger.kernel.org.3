Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA20A4F8180
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiDGOYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343876AbiDGOYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:24:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DF3187BB9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:22:32 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id f18so6607439edc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nNOy5THDWbheBkCwuNFKp5hbaSXwJtJCl29fvVzZIxc=;
        b=g6vVoxh2JZOKzW5085vICQpcMRu6c1mU73SCHqk9+9Ihw55ggMFIkkIxB1W6yzXdYH
         uxKKhq3YdX0P0rlX2KwA9UMQHM+cxuOcWJkS88yECE5Xmb9yfMHqU+p+XVtAp5W5SEd5
         07ta8Q6+NevAPHQl8VYJ64gxsYIJMyf+QNcS0UTZW4gZkNj05vapei596ImMyKCJxKmQ
         higwFvrrKh6SSvgW14eTzkmhXGfZx/OStZMyWk5J8yRkAgTk8FPVi0bkbFwmwUK0mgqf
         eWYnybcqbPPnco8lASptmeRk+UjpHmFEI/qPi+wsH7AmG1yskUIAc43ufMVTU9kYdoFk
         FYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNOy5THDWbheBkCwuNFKp5hbaSXwJtJCl29fvVzZIxc=;
        b=c3RKMOefE9B8mW5u8/BKucItjqrpGyS10o48Of63rWOXkaO4zcH56TeOwXhe9X6wZL
         ju53pM5Gm8wKFuP27OMLAZr0rVEVsxuq5dj57rrhxyodX0VsdMY7P0+htQqOVIF7pxRb
         XZ01fLQK/nmm58pw0is2iilxjjTlrNqzFStT34B4a3qOLNj7w0bYq8TkVv18p54qYD2T
         yL2HRLhiv6VTeI3/n7fSHA9HjnoYrApoKf+kN5Wjaj03U57V/QFDP7SzFXZ/hwOkFUd1
         XXw7p3cm5QsNoRqIgfKAB3qrDphG6Krh4gUz7+xVzJPQpUrqB2nibTCaxvyxfuLmpVtQ
         vu/w==
X-Gm-Message-State: AOAM532mrDZB3KgEGjo44JRmYPaflEz+6Wfhz+rfMDksHIqxNA7obCgC
        7jQ2CrP9/SYR6AamSiCxA7+K+w==
X-Google-Smtp-Source: ABdhPJyn/dx+S9rLQlirNuj/lAIVKwPvohwq1QEPSFZKwFdmUwg1ZjYhRHaPr8tYZQUKGXHZfZBvaA==
X-Received: by 2002:a05:6402:90c:b0:415:d340:4ae2 with SMTP id g12-20020a056402090c00b00415d3404ae2mr14449897edz.331.1649341335146;
        Thu, 07 Apr 2022 07:22:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm7569808eje.183.2022.04.07.07.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:22:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: meson: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:21:59 +0200
Message-Id: <20220407142159.293836-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407142159.293836-1-krzysztof.kozlowski@linaro.org>
References: <20220407142159.293836-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi          | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts    | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts           | 2 +-
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi              | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts            | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
index 2d7032f41e4b..bcdf55f48a83 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
@@ -416,7 +416,7 @@ &spifc {
 	pinctrl-names = "default";
 	status = "okay";
 
-	gd25lq128: spi-flash@0 {
+	gd25lq128: flash@0 {
 		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
index 2d769203f671..213a0705ebdc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
@@ -298,7 +298,7 @@ &spifc {
 	pinctrl-0 = <&nor_pins>;
 	pinctrl-names = "default";
 
-	w25q32: spi-flash@0 {
+	w25q32: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
index 93d8f8aff70d..874f91c348ec 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
@@ -284,7 +284,7 @@ &spifc {
 	pinctrl-0 = <&nor_pins>;
 	pinctrl-names = "default";
 
-	nor_4u1: spi-flash@0 {
+	nor_4u1: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 86bdc0baf032..f43c45daf7eb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -374,7 +374,7 @@ &spifc {
 	pinctrl-0 = <&nor_pins>;
 	pinctrl-names = "default";
 
-	w25q32: spi-flash@0 {
+	w25q32: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "winbond,w25q16", "jedec,spi-nor";
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 3cf4ecb6d52e..c9705941e4ab 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -458,7 +458,7 @@ &spifc {
 	pinctrl-0 = <&nor_pins>;
 	pinctrl-names = "default";
 
-	w25q128: spi-flash@0 {
+	w25q128: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "winbond,w25q128fw", "jedec,spi-nor";
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
index f3f953225bf5..e3486f60645a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
@@ -121,7 +121,7 @@ &spifc {
 	pinctrl-0 = <&nor_pins>;
 	pinctrl-names = "default";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
-- 
2.32.0

