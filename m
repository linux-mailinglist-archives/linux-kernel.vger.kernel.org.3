Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AFB53FB64
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbiFGKe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiFGKeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:34:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD3869296
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:34:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c2so22372145edf.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVrEyDI1PPHvzCAbZaShKqmCzODPm4yYUnVIkzwCwX8=;
        b=OMMPzvhRG6d4OSSbryIv7SZSHeRq3Dpk+HEiJusk04NUzZYZQoyQXiuoHFhjHnHc7Z
         5+kTRjFN1ZPI2NI7b1J6f4h/c2SdoCT156Yf1eb4fyAXpXULiAcCRqkTpkAw1i7deDiQ
         07GvWkahXm0gkfIeI9jUjbJahg/GlYRNFhN1Lhrv60jsdsfe4tzJMNzpXOs5WZshsSgC
         5/NBvTEoMmCQahWKto2xEwrKWnGhealIC868+nJ19qBwQKXW3OyWeTVZhaO7DsptYPoo
         mgBORvAiLwRKQcAcQQVMcf4mZndp0MApNEifaoPZUXL8c08GiPtfGuKNefEdA8n4N5lf
         PbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVrEyDI1PPHvzCAbZaShKqmCzODPm4yYUnVIkzwCwX8=;
        b=Hcp5zNL5UHhOtnEFmJ0mHDx8LWP0I0rSTWWBgT7Qf1fn4B6Nl8y3gHK7CCOTMDjw5j
         H5RH0teolwo4SBMGZI8WH+W8nGdoN89BiAMWwEAVtjzqdd9ppVSHppO9g1T8nyZMnDD+
         3D/BXuYAcYMu/XIGoe/yduA5rx9qfYQ294HLwUcwkMYa3t5sG6Z28P3px7MXDyRYHtR+
         aCsN4LUqsEv/LpCdywH723pJ6+SSEAVnZcm7aR4ZxNrQqW1EOpjFD/aDrhvuj4MdhbvR
         4PPtk1C+40LVLP1uHrCumQ+yuOOrjIXGcT8TzGd63ZHynCRiFiW3eCkvmPiiIBu0Fc2r
         K76Q==
X-Gm-Message-State: AOAM530adPuWsjg618doX9mxj9CDkIN+cmJaknk2j1Z3eGL99vGXPnR8
        oQRvkpmjqKdZc8aJzfiL8mUKLw==
X-Google-Smtp-Source: ABdhPJyOTR5n6tilKn83GYM5Nsi6ppDbx5M6PKI7VSulNDoRCtph1T1Dw+nPWE2vli9It0aQ0A11Iw==
X-Received: by 2002:a05:6402:50d2:b0:431:53c8:2356 with SMTP id h18-20020a05640250d200b0043153c82356mr13053043edb.300.1654598039850;
        Tue, 07 Jun 2022 03:33:59 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709065ac400b00704fa2748ffsm7505359ejs.99.2022.06.07.03.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 03:33:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/10] arm64: dts: qcom: sdm845-db845c: add function and color to LED nodes
Date:   Tue,  7 Jun 2022 12:29:31 +0200
Message-Id: <20220607102931.102805-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
References: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
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

Add common LED properties - the function and color - to LED nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 194ebeb3259c..398055fc1fdc 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
@@ -62,6 +63,8 @@ leds {
 
 		user4 {
 			label = "green:user4";
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&pm8998_gpio 13 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "panic-indicator";
 			default-state = "off";
@@ -69,6 +72,8 @@ user4 {
 
 		wlan {
 			label = "yellow:wlan";
+			function = LED_FUNCTION_WLAN;
+			color = <LED_COLOR_ID_YELLOW>;
 			gpios = <&pm8998_gpio 9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "phy0tx";
 			default-state = "off";
@@ -76,6 +81,8 @@ wlan {
 
 		bt {
 			label = "blue:bt";
+			function = LED_FUNCTION_BLUETOOTH;
+			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "bluetooth-power";
 			default-state = "off";
-- 
2.34.1

