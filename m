Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D1B54D69C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356483AbiFPA5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357246AbiFPA4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:56:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D44590A7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:55:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so371394pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Vomts4VmbqvFQPOL2ceI/hWwepbwm4BG8ZS+YMOGeM=;
        b=RMYupGnPOpuGbxL+j/mOKPQxchJTm9gdAW8O3N7c5LD15PUMEfbScpik3d+ikdvZog
         +T5xSYVsqKagsiKKzU5RiNpinzAbt/IPlHyAFRvibosYAWrR79/XjlsOJyPUGxkNWn66
         39bgeZhuJ0Bt5zp8wfLEmnaRqpewfWpyc+MDggdLnM+8Qy73wABoJqsQ3dqU+oQwtjvb
         +dL18n5Rnlxizrm1Q/JU+bKbdlA1FFDITp9Xh8bJtD/kbjCPAQUMU3irekgyBU0zMXs2
         6nPpKrj6hO5CH613QCfgjUhPJsBSS35GucCsxiTzkO8ds35rPvwjVgl4DBbzDOnsHAGv
         xoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Vomts4VmbqvFQPOL2ceI/hWwepbwm4BG8ZS+YMOGeM=;
        b=dUnOwKMUl49T1EqOnz3ssMFHo8RT1Si+FpoIh0KzsbwQ05mIeRcVpWR2LFWVPqYv7d
         HjQgL5fRt5TMDhFNrME9s6KjXpgEw+qoHBZvZDZzrZNDCDBwyZs8SmDbTLk3q4MHJqRo
         254rM2uNju7RG0BQxWhUS/bavCzlz0Qg4IKrvRCDlAQoyFcjtj+Ui3jLAIueruzJMlbH
         QPPQPwLBLat47dLfqJ3BazS8b9oioU4BWoLLKhQQHh5U49w05rdjFxqWMYJWyhEToaKO
         DZW/fpjycXFkif19GAuk21B6jTxxOArZHDSuYXQKDs0eWxkxXBJv806MXEZS5sr/QhQ2
         mz7g==
X-Gm-Message-State: AJIora9q4KgQTpX6h247rlI63XJqiWJlPJ2cY9PSZzccdsnuiy5Tts52
        KISZEHwUCz0axGV2V1FdjCDTcQ==
X-Google-Smtp-Source: AGRyM1t+KymAIQRuqWy/mRILx38eaGMZzrgQK/Zp/YywmnGMoYPs/P8xrZj2uSJ7yaj7neJ4SWiSNg==
X-Received: by 2002:a17:902:b68c:b0:167:95e2:f822 with SMTP id c12-20020a170902b68c00b0016795e2f822mr2108356pls.128.1655340893636;
        Wed, 15 Jun 2022 17:54:53 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 40/40] ARM: dts: at91: drop unneeded status from gpio-keys
Date:   Wed, 15 Jun 2022 17:53:33 -0700
Message-Id: <20220616005333.18491-40-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nodes do not need explicit status=okay.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts          | 1 -
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts | 1 -
 arch/arm/boot/dts/at91-sama5d2_icp.dts        | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index 838353a42097..1432732e163b 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -80,7 +80,6 @@ gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
-		status = "okay";
 
 		button-1 {
 			label = "SW1";
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
index b55e8fb113b1..e1158755008b 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
@@ -31,7 +31,6 @@ gpio-keys {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
-		status = "okay";
 
 		button-1 {
 			label = "USER BUTTON";
diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
index 38f0e1ae6ae6..0ba73df5cda7 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -47,7 +47,6 @@ gpio-keys {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
-		status = "okay";
 
 		button-1 {
 			label = "USER_PB1";
-- 
2.34.1

