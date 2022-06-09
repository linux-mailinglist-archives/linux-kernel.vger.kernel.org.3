Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F34544A72
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiFILjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241959AbiFILj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:39:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64847193224
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:39:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bg6so27092191ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S/Iyhr3Mwr1/UaDl6/ye/BNS3vuL4j/ikUzThz7lvvc=;
        b=BkcyjVbmqgJLXxxpG0tjNrsiP4G/fJ60EsNHOJWUtbgrY1qCdzdhaPm5SUSWXnl0vo
         R+xtqx2Dhyn+2+hz28TQMps9+bMFj1aGyois5HorVpF3/Q4aFO6zXsBlkc81gRPbXp65
         /WWrutLtVhXjj+JnFJavnpk6ngRUZ/r280lPDGdD2MYKA3EYqSZJ5/hwgUkbXCC7K756
         75qRP6JbG8wsNITUK22s0KuGGfXw79ZxdabwEQTm9ZAGkWyUtZRxBUIYsUfoiUGGdvC5
         3E6gvrsmWFsvkamd+HfER608MxakEpme47E1ANpMtso28NM7mK6t8vOdlVAIVSM65vvN
         lPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S/Iyhr3Mwr1/UaDl6/ye/BNS3vuL4j/ikUzThz7lvvc=;
        b=DqUBc8bE7C5IV+ui/ynsd1anulviheZhjhv1TzdIjj7wLigUeHlfscL/aiOzG3mS5K
         2QNVALP1iKz5d77bUC4lxIRm4PRPDscJYC3n3jFb2/YYNJt69WCONueeD96B7hklhzR/
         97AYuqS26pfq/gSVkTEiQyt4IKiPwNaEFh0d63cYHI/Kl2YK/PRsHYWR8lDRYgeTt210
         iZkz26UUJrja503aW1pnNDOgFeh51zg7DwDkSacqHK46dpbe+eS5eREyXz1RPyu9n83W
         US0mSnFoqvFfr4qabJ161uibYxD3CoEZ56FYGwKMT/YodlvHB/ggboGvl9gxuD7tOUpL
         eI7w==
X-Gm-Message-State: AOAM533USZDT3m+fZwoegwbrgojvJe/JHYc1zAlOxh4Q5NzV1WznwPIs
        jYJFRPS3lsXpjy+CNkqday47pg==
X-Google-Smtp-Source: ABdhPJwQMIc3Uo+Ew0KdGsrt/Gc0dKGNxXahzqr0DO79q4xdDDGhu38fN93TWtCnSdX63yIKmiTRXg==
X-Received: by 2002:a17:907:6282:b0:6e0:c64a:60a7 with SMTP id nd2-20020a170907628200b006e0c64a60a7mr35588659ejc.349.1654774762958;
        Thu, 09 Jun 2022 04:39:22 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7d54e000000b0042e21f8c412sm11898495edr.42.2022.06.09.04.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:39:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 05/48] arm64: dts: allwinner: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:39:07 +0200
Message-Id: <20220609113911.380368-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts      | 4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts  | 4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts   | 4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 63571df24da4..620cb3ef5f6c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -35,10 +35,10 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		lid_switch {
+		lid-switch {
 			label = "Lid Switch";
 			gpios = <&r_pio 0 12 GPIO_ACTIVE_LOW>; /* PL12 */
 			linux,input-type = <EV_SW>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
index 55b369534a08..a3e040da38a0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
@@ -52,10 +52,10 @@ led-2 {
 		};
 	};
 
-	r-gpio-keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		reset {
+		key-reset {
 			label = "reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 1010c1b22d2e..b5c1ff19b4c4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -54,10 +54,10 @@ led-1 {
 		};
 	};
 
-	r-gpio-keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		sw4 {
+		key-sw4 {
 			label = "sw4";
 			linux,code = <BTN_0>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index 74e0444af19b..d7f8bad6bb98 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -48,10 +48,10 @@ led-1 {
 		};
 	};
 
-	r-gpio-keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		sw4 {
+		key-sw4 {
 			label = "sw4";
 			linux,code = <BTN_0>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
-- 
2.34.1

