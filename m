Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096BD544ACB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiFILnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243992AbiFILms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:42:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0FA1F12A4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:41:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y19so46904407ejq.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a7AVzyUmsqVPd91IAsbJZXPj8ozhTONPXm6ECNLQgio=;
        b=bzsQQpQMea7pB37AbYmp+iBb7tzYIqsnIH+vEjHsewmVTalQt/P9huDagHIU1AoTzX
         IuAnjSxsWyyjGE/U4REcA9LfcCp5Yv9++0CLm3752tv8d90EK1HXsBRLn58XM9/i4Lht
         b2nw/fa9JlAoV2BL80uH0iM6BOxSJSKR6bdw5DE2PDIGUiWJya6jHOoDONihw/AK4onp
         ECCmAa5j2ewt/2OdlndAjdq0mjXnw+FHVUWq+PYy1OaF/lgsWz858DmZreIkbqTmwQJE
         AM2CEKeqoIoiJg3UleZwjMSiD81bQizM47IhZjeCLLg+D6BXZ62wwTyl4UyIOxHhw1+B
         E0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7AVzyUmsqVPd91IAsbJZXPj8ozhTONPXm6ECNLQgio=;
        b=RgAoTSjsvKGIcLTHrf/BIfljAYk8fYexNHmOJOwDrPr04pndr0accnqymAsK+JJEYY
         j0lxEA0OFSGFLOAvviQgUlSTJKOr8Bh83Cf5Y8ccjh+Dy43mb5B4nrxA8gEzP2a7f4XM
         ig9eIc6IEezPev99WtQ2M1seOOHPY1412n3SkFHcloxmrKJlsIxNUiBL56HLcJ1oJdLa
         Uvpuz50ZpyE4wSfwJ5a1ekbhEonjHyJJyQHpBd/v5AoOSCWeKlnD5p7+5r6QrxIzOVvA
         ssckQy7p5djZyDqnzakqhLgqJ6pPZ01ZuFDfQ4j8nlTcujiUSR9IZiVTigL6/Lb5qmvw
         DQPA==
X-Gm-Message-State: AOAM530a34++5nF3JFBt26xFtVJynkGnPSg3HQMUCZg9tyoBzm0Yhcjh
        VMWuN6k+/Q9Uub9MSepoXtkVaA==
X-Google-Smtp-Source: ABdhPJyWwogLsE1DiHbVVqhQ4XJnLO8mzMs5f7M6JmVUARXRdLSDMkAYFuzgelKC5xtHU6wFcSHc0Q==
X-Received: by 2002:a17:907:968e:b0:6f4:d80f:f0c3 with SMTP id hd14-20020a170907968e00b006f4d80ff0c3mr33787314ejc.145.1654774862082;
        Thu, 09 Jun 2022 04:41:02 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bk2-20020a170906b0c200b006fef557bb7asm10498662ejb.80.2022.06.09.04.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:41:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 46/48] ARM: dts: at91: drop unneeded status from gpio-keys
Date:   Thu,  9 Jun 2022 13:40:45 +0200
Message-Id: <20220609114047.380793-7-krzysztof.kozlowski@linaro.org>
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

Nodes do not need explicit status=okay.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts          | 1 -
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts | 1 -
 arch/arm/boot/dts/at91-sama5d2_icp.dts        | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index 7bf99bdbafcf..ade07b9eb101 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -80,7 +80,6 @@ gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
-		status = "okay";
 
 		switch-1 {
 			label = "SW1";
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
index d5652c974748..bd5422495306 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
@@ -31,7 +31,6 @@ gpio-keys {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
-		status = "okay";
 
 		switch-4 {
 			label = "USER BUTTON";
diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
index d7b59e16a081..0023b9d74651 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -47,7 +47,6 @@ gpio-keys {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
-		status = "okay";
 
 		switch-4 {
 			label = "USER_PB1";
-- 
2.34.1

