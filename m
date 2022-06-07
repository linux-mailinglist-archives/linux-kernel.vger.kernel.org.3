Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE91553F8B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbiFGIww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbiFGIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:52:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E12167C9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:52:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v25so22052755eda.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qh3Q8zeGGFs4NZvI256UuSMbulRCxHF8EyCSRlLMmBU=;
        b=V8MnplV7tM2O9koqV83l91wOu4UZ72fncx/MM5oAAg5dLy6XrzetHE7dI/y2TMJNqb
         bICAPaQEEu9UQ3mfn/A3bHC5HttioOtjzIeVplu7mu+kB675LtGIEoZ3uzd8la3DOfwD
         wxZH1ox6J+jcmzFb6mKnDgGUzdI09ejnwz6lS/ar90xdy1RMhEaNE63Be8KSz5TXM4gC
         9Dfph8BaLW86pJt/+x8ynOF/HzLB8T5tsHT6Bc1B1YtO40D9TZxJN24cSBmu18CCFJVK
         lGdHA1euL0rXSnbqlvLDloF60O/De2hcnurd2aXjO/3HSL8cROXNbFKEvail53f+m190
         AW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qh3Q8zeGGFs4NZvI256UuSMbulRCxHF8EyCSRlLMmBU=;
        b=eVCeBMhgJNBE3oX9ihkBmI2MQpkTbJ/GgVrahfVz5GzGgc0tykAT2AqcdIElSbqJ/q
         Z0yGs7VGvtH2v15SLaHsKu6uOteTe9AIpU4aDkZAEiDeucilqAg9uwX5BsZDkX+7r06i
         A+uMJjr8ZTAGTP7P+vu1XgymtGjZHsxvagcEku+J9OSAeQkk7bzaa/zbtLl7bKknHRE1
         RZJ00JGYTtmp86BDJQcFJjPq8kz/5ApnCWQdau6CRQG6xkUA+HIpIUCcjN83SIx88nOw
         L953ua2XwASnVNYmSv0NrntVIuz78DEvikE11ZaXZ+PYkzYDHK4fe+moW/+VbQTMO0OR
         eTag==
X-Gm-Message-State: AOAM531SCaqM0XLLuMGo/84Iyun2FhQFSKP8EB4vAKgEA7+mZeFmcOr9
        +CyibhpQXEu10PV/4hu57GaBsw==
X-Google-Smtp-Source: ABdhPJxrs3dT9lmh3cltzk1QMQDGMeU9iFHbuoW1PmB1ccZYkzvHZ9gd6RibypRT+77UNA3T9DGm7A==
X-Received: by 2002:aa7:d1ce:0:b0:42d:cf0e:3389 with SMTP id g14-20020aa7d1ce000000b0042dcf0e3389mr32019205edp.4.1654591956181;
        Tue, 07 Jun 2022 01:52:36 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lk24-20020a170906cb1800b006fa84a0af2asm7458137ejb.16.2022.06.07.01.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:52:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/8] ARM: dts: exynos: add function to LED nodes in Tiny4412
Date:   Tue,  7 Jun 2022 10:52:25 +0200
Message-Id: <20220607085231.72246-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607085231.72246-1-krzysztof.kozlowski@linaro.org>
References: <20220607085231.72246-1-krzysztof.kozlowski@linaro.org>
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

Add common LED property - the function - to LED nodes in Tiny4412.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4412-tiny4412.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index 017b26108bb0..04388c575efe 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 #include "exynos4412.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "FriendlyARM TINY4412 board based on Exynos4412";
@@ -30,6 +31,7 @@ leds {
 
 		led1 {
 			label = "led1";
+			function = LED_FUNCTION_HEARTBEAT;
 			gpios = <&gpm4 0 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 			linux,default-trigger = "heartbeat";
@@ -49,6 +51,7 @@ led3 {
 
 		led4 {
 			label = "led4";
+			function = LED_FUNCTION_DISK_ACTIVITY;
 			gpios = <&gpm4 3 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 			linux,default-trigger = "mmc0";
-- 
2.34.1

