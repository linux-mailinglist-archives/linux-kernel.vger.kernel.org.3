Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0938E544A95
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243083AbiFILlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243027AbiFILjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:39:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325A21DB1CB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:39:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kq6so33861018ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5cSlP87HZIroMFQjz/vmfO1yXb2dVVbYI7ALNnjKsu4=;
        b=enklcfx+xRNsl71eeOzYaL6+EZ4YcYjvBL9JTEliFZViBCfEgXZk05NA+a3vnLCm/T
         x90kLtSv9ZwZszLDXq+O5y6nFvhB5OsAyaOZNZ29HyWSWodl6V9hEOI1PF5//chAON8C
         bNaB3S+cHf+gKBAH4jZ/PCpJuEWSqEyxJI6MnJPgpHlgI2XoouOpbdg5Ln0Vwwg3Ug7T
         qWDtoE6to+8XjOpO3/yITnuWd6awIgNFPFWbZyIwlt3VQcD3lz85kfAs28Ykdd2uqTjM
         x/ZbWZHXBjE5ksyQELNP9KDO2JWqJkWK0uOZoFzyqmpN80Bw5VLjlPg1VPNyfeqWkFyH
         HrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5cSlP87HZIroMFQjz/vmfO1yXb2dVVbYI7ALNnjKsu4=;
        b=rM93qe+Q0VpYeVGbpMOWgnl8msO1cPKHYmQ+Vtzlpv20nv/hFozaxTmPbCq4uvsfmf
         xO+BNsxLjm63RRwDan4NiSiLMVVAT87vXS74b7ApNKPdxT+EyS7Tloj/7DlEBPVDm4ND
         Kuvcx8+H2FSeMuOqZmh1M2PQh+v/jhhgQb+eX/JNR/zgsemUy106wvm6i+DogwMZXqhC
         WaVfZINs/UEmN/0B1TrYxME+8gbrkkjqxeMzHwolQMq6n0VSJGPjLo6NWK07HdmjgJ8H
         R9WgibCVKkBucPLGizqbXJ9BK+MqC9FciubNGDcCF5rEsHN2/Qnjdd19F1pK5khVb6eP
         ZwBw==
X-Gm-Message-State: AOAM533a+v2su6P09tDRddSnpZbI/yfmHDa3rvfTe2RLfVNxSou/JLQA
        gcH71Kf1N3WjwWoOBlHgMoby/Q==
X-Google-Smtp-Source: ABdhPJzbtDmMYGs5XyaYrA/HvXC2c45Gr8YCbQa6XbqGLvXtb8Jyb8dukWQr6y1esYHzmAPKuvPYGg==
X-Received: by 2002:a17:906:51cd:b0:711:f4ee:6582 with SMTP id v13-20020a17090651cd00b00711f4ee6582mr7625174ejk.591.1654774781573;
        Thu, 09 Jun 2022 04:39:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906528a00b0070a80f03a44sm9460415ejm.119.2022.06.09.04.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:39:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 10/48] arm64: dts: broadcom: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:39:29 +0200
Message-Id: <20220609113938.380466-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts   | 8 ++++----
 .../boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts  | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
index b63eefab48bd..064f7f549665 100644
--- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
@@ -83,25 +83,25 @@ gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <100>;
 
-		brightness {
+		key-brightness {
 			label = "LEDs";
 			linux,code = <KEY_BRIGHTNESS_ZERO>;
 			gpios = <&gpio0 18 GPIO_ACTIVE_LOW>;
 		};
 
-		wps {
+		key-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
 		};
 
-		wifi {
+		key-wifi {
 			label = "WiFi";
 			linux,code = <KEY_RFKILL>;
 			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		key-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
index 169fbb7cfd34..04f8524b5335 100644
--- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
@@ -18,25 +18,25 @@ gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <100>;
 
-		wifi {
+		key-wifi {
 			label = "WiFi";
 			linux,code = <KEY_RFKILL>;
 			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
 		};
 
-		wps {
+		key-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		key-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 30 GPIO_ACTIVE_LOW>;
 		};
 
-		brightness {
+		key-brightness {
 			label = "LEDs";
 			linux,code = <KEY_BRIGHTNESS_ZERO>;
 			gpios = <&gpio0 31 GPIO_ACTIVE_LOW>;
-- 
2.34.1

