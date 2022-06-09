Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7C4544ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244295AbiFILmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244111AbiFILke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:40:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B571E0C05
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gl15so33031399ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P7ZvfBFlgPRJsl6DK8VefG3/ZMxJo+DUINNCMnWClFY=;
        b=yVmsRslMEUy7wlHAqgMJFz72yzFAB5LWmuXwc4lfybSFvT3pJvwKfsMXOpG8Puc1dD
         tUDQdzsuJ1GhS5m1t3K1uoPGE09QfML9JqzWT+yOPdMgxllbLb5NByOiPpxregbU5Qcq
         92H0Vw4/mfkcG+kehOeqpgbKYMxUEs1BO4C2Yv3SXqqZKkZut1xVnDwt2k4ZikG+8A+f
         EKHKFcO+T+FVtl8kEVHkS5E3E/9D+4z9TZjw6dgqIDnAb+MELuBv8wgFSZXT10dWWRlr
         7QpOxpDw/5wLtngLULFgEF8ZB+0TZ8rbtn8MJxHDuqrRGMP5fbHQCUFGpbzAFVldeB7B
         1yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P7ZvfBFlgPRJsl6DK8VefG3/ZMxJo+DUINNCMnWClFY=;
        b=GeE3LbbRhKPe1lckawxcMl9ysgHjTUJ7IzB0KvYSALvyBrYgg1h8g75nIcX/lt0HGW
         LjQ8ZvBi0WXAWwNUzmO6zcWHL5UPEiW58Gt0wWefVOAGPWd25dtXPELFajfY3MJZoyxw
         89MgPniDC5AjOxPtzAkhEz/MNvbgdVtRpkk4O55GBpkDtxTQ0OHaC8vEldtE0ro0X3ha
         11j/IJV2zTIq7W37HvV5iqgjFRDKHexq2ra9UaWl8FaOIsAo1qzfYcpUBl05kDZGcLS5
         iduhoG0Qt/JzBz90jsbl9h5u0vDYdt030wZsv5O3skAnDtBfTFzix+Y9keKpwYSkZxrF
         p+NA==
X-Gm-Message-State: AOAM533t+2TAKVruS+DG2YuwnDjYMQv1srKg5o+X7fJNWftKORZIf4BG
        riPZTkLB1Je9Z0iSdyqtxUP4WQ==
X-Google-Smtp-Source: ABdhPJy4nNBXEdz+l/Sj3rWUAf/e1lV1tSllqUAwXDG63YFIeAVjqjH96BstlWGTQkxOJxGYYXiQCA==
X-Received: by 2002:a17:906:acb:b0:709:d274:611b with SMTP id z11-20020a1709060acb00b00709d274611bmr35686861ejf.147.1654774811641;
        Thu, 09 Jun 2022 04:40:11 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q1-20020a170906360100b006ff59151e34sm10638441ejb.39.2022.06.09.04.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 22/48] arm64: dts: mediatek: mt7622-bananapi-bpi-r64: align led node names with dtschema
Date:   Thu,  9 Jun 2022 13:39:55 +0200
Message-Id: <20220609114002.380563-3-krzysztof.kozlowski@linaro.org>
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
with 'led'.  Use generic color properties instead of the node name.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index c2311733d2de..7d1ecf72a6c3 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 #include "mt7622.dtsi"
 #include "mt6380.dtsi"
@@ -56,14 +57,16 @@ wps-key {
 	leds {
 		compatible = "gpio-leds";
 
-		green {
+		led-0 {
 			label = "bpi-r64:pio:green";
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&pio 89 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		red {
+		led-1 {
 			label = "bpi-r64:pio:red";
+			color = <LED_COLOR_ID_RED>;
 			gpios = <&pio 88 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-- 
2.34.1

