Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CE354D689
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349828AbiFPAyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348823AbiFPAyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:54:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495D157152
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so103232pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5cSlP87HZIroMFQjz/vmfO1yXb2dVVbYI7ALNnjKsu4=;
        b=j2v/OHNCeMaCuM3Z6TS0vO+Y15ypfjzf3Yic+AQ9NC8CXymLIse1JfBNJ3wm6MxOPc
         9tJW9CzFoJa11L+y1tF1NJ+WHcxB8XWnXyf/T1afCco2sLMPg5E3um5oThiSgVbqh53b
         +yPJOLKCoeVcy/ZHcd3km23RWoN3tlJZtYCvdZm3L4V9aBus7qzS6DYVt7EpEVZ+2iog
         q3lsz4Ee7gYzw8vHi7HXC5cJgaB9CG2VRzWoS0MbR37n4mJrrIbGE3tiOGhNF1/obvAc
         RyOrRnwal/bicTHRydW25PDLHx42VBzKqKuXmHx7qEy1RefsAYZyt7qK+m86klBB1k9I
         hMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5cSlP87HZIroMFQjz/vmfO1yXb2dVVbYI7ALNnjKsu4=;
        b=Uhja85Mf2nI2V6oK+O+YciUIx3KERRL7hmd3xuUE6i8KwrtY2rZLRlmZNrVCMg3Vgy
         aa6sh+O11esuHF5AovQavqFRxiWQmEZuM8Ca3E/PbCnGz3R2aNa2h0zHMgTJQg7hp6dc
         hahsU1sKIMAzSGACdCAyMHejxgJ56AUKHmwGvAyxI/t0t4ax2EgrPD1TZ7A2X5H+nInb
         5vsSKVUefJvMTIYuMn8vaNORD96FYeURNkZCd1QCUCCdt94FIMDOVtaHJaVFxQ1Dgs2Z
         CBizMmT1oNgdqY4jCavxyMc+XuhNKM4zNOA3N3pw1yhYauN4kW9XzbX+cOv+/5dMKSht
         vpGw==
X-Gm-Message-State: AJIora8m3jtDkJC+lzfUmwfha+kJOBgCeczuj2jpI75v1gdyJlaxuS+b
        UCfNWpntNQzh7kZirN6U6+D6tA==
X-Google-Smtp-Source: AGRyM1uFb5RnzDIdY3RB2VGlMJ0Tc18lyHj2Yzjra33pWjOdILaCiCY4mALTtc08arePdmn3U/rfQg==
X-Received: by 2002:a17:902:e80b:b0:168:b645:849e with SMTP id u11-20020a170902e80b00b00168b645849emr2018732plg.26.1655340842807;
        Wed, 15 Jun 2022 17:54:02 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 06/40] arm64: dts: broadcom: align gpio-key node names with dtschema
Date:   Wed, 15 Jun 2022 17:52:59 -0700
Message-Id: <20220616005333.18491-6-krzysztof.kozlowski@linaro.org>
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

