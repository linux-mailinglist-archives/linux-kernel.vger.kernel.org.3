Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07A154D6A7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350577AbiFPAzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350436AbiFPAy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:54:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767DD57999
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gd1so111395pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P7ZvfBFlgPRJsl6DK8VefG3/ZMxJo+DUINNCMnWClFY=;
        b=AmdVaSSwEogVe/9M1TOoUc2KNBC85KjowawNQ5OditenjCVKoATZy1xzGH0AWvY0PW
         +ruwOoIknYWN8oXkuND6gyo6SGV5QaVTkJmugDPEVIs9O/36GFB4YgbPqSFa/qlDyuuh
         oqY3gLkQ5my1bmTcQyGQquh7GIbxTRrpnmrUELsBEBSIMlKBR3fuUfSh+T8lrAc1WG90
         S3GSsuFxXJFDfFfg07AMTh+KhT3iOT9/WNT/6sHImC8K1kjtTJGbmYTpcO/k09QK3LZ/
         G4bF72u/oRkqYE5xDdIrzDbkDndwVAqfb9CK5GsZKWhUE337//+lRz6fuyGIx+HZmBgD
         qGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P7ZvfBFlgPRJsl6DK8VefG3/ZMxJo+DUINNCMnWClFY=;
        b=zs5Mr0hIuINNkZYak6V/t6nXnQNMA/R0g0CHccp20otH2TZ+ViaLYa88vD15VuyioR
         QaAQrEVLFMnNQgzBzNV/w+dE0tXnTG/+dsr1fI8Uc5HnVisXR4s/dNYWADaP8JyEGw8s
         0yvBPNMPLbTE2vvzD0FCk26XmXR+RipLHA5cjDx8ZzsGDy/3iTiqNk5Ej4RvM1iU++Gh
         cgiQSeUbnuqiwodkAUbxEblZlO3hR/rVRurOvTSCEyfdcbJ30f/C+Q291rRyWc+uO+eI
         iVobSLH4vO86djrvqFmTJJV9LxDC4d9mbRKDg7ZiSkGh/9w1qof25KjRSGUiGMsZl1on
         1x6A==
X-Gm-Message-State: AJIora+ML8uu0cxeYYUnzUiTKphQmunIqEIQsA5TzgO/Oy2hGYlBnROr
        DwSOBcK5g5Wun+tVDGGp1eUg1A==
X-Google-Smtp-Source: AGRyM1sNObqkH52c07IQavirEDgcKWdNXNYQtVpTlkyBYahg7ZgiY+wBXJWdOuZmeBkQ5uH7e65xHw==
X-Received: by 2002:a17:902:cec2:b0:166:4e45:e1b2 with SMTP id d2-20020a170902cec200b001664e45e1b2mr2353533plg.73.1655340856999;
        Wed, 15 Jun 2022 17:54:16 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 16/40] arm64: dts: mediatek: mt7622-bananapi-bpi-r64: align led node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:09 -0700
Message-Id: <20220616005333.18491-16-krzysztof.kozlowski@linaro.org>
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

