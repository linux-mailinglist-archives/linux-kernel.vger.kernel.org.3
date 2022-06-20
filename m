Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610DF55235C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244914AbiFTR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244916AbiFTR5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:57:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5B81EEEA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:57:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eq6so8833709edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdYt/KuZ8ZY9+ff+QpyUq9uIL2yZfZHFaxnC+UiSozk=;
        b=qLTElkzwNBDDwmCKMVWclmi43W4+alHdokrH8RMkKOesGUAkWBitUjkLetqlPBvlLm
         gNuJ4oVMlAUa8WE7tMEs8IRNSLsZzaVPayI/Lj8BmWMtXSiDqQqnrNRXt7Z2A+l6t0SF
         YD5vaW/+C39T0QMGweFTdnBtKsAi1lvSaoDEsCeFclz+hUDaX+hbiwF7rRtIk4R7hSll
         PX+GcMKf405+ZYNuYph2fmfu93bQpSZTsfDVp7VL1V8M+ZyrUMjiuKKmR2F4An9yZ1x2
         AYZTuSlKZGsrjBz/2bPMNh0qvLL6Xj8vv/C6+Nq5QEoQxd10YZHT9HZkiM9fueA1rW9j
         ooTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdYt/KuZ8ZY9+ff+QpyUq9uIL2yZfZHFaxnC+UiSozk=;
        b=N4y+3B9Uu8JQ4ZDtdwt7Ut5ye5dIrSOcWxEO7+3yWnw60etkb5SguyL6pOJgPO5k0I
         kJ07FKCbVXlLuE3hX/IFcE5ibR6H3qfFSFcA9s3I8V8CSJBzJP64Nf8UUTHe1AOUOjrG
         FdkU+aZ2klLI+x7W9UslsC1UeL/B9PM/+PDWWkPFZKv+2Ic1Vg8Ulj+0It605X1HVDPA
         VndlSVbcrzLxFtUhyl8ZTaRLaI52OY2NefIZMmLfxMh7hrg3uzyf8TSRExfR+Hmr/Qu+
         7jO2Tu2m/98ImhOmI7CWhjJXMzW8crBxaZNZhMkE3KFiGEwvdhST7Y6s4IwExemcn96i
         DI4w==
X-Gm-Message-State: AJIora9Ry4XcMlxjzDYWZ/AdlAGl9z6GyAq6YDMRs/u+aPY9n1qDmK3i
        VATVtV0pES9m84PBo5OSRH/jDA==
X-Google-Smtp-Source: AGRyM1uMebg0/BpFhY5Q5IqpYhWsyjyLUKCGWnRAk/WrVI15dgi8rFqj9bqqwWpi9+FapDAJJdhKOw==
X-Received: by 2002:a05:6402:3713:b0:435:539e:a939 with SMTP id ek19-20020a056402371300b00435539ea939mr26643572edb.160.1655747856830;
        Mon, 20 Jun 2022 10:57:36 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7c84d000000b004357b717a96sm4309925edt.85.2022.06.20.10.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:57:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 6/8] ARM: dts: exynos: add function and color to LED node in Odroid HC1
Date:   Mon, 20 Jun 2022 19:57:14 +0200
Message-Id: <20220620175716.132143-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220620175716.132143-1-krzysztof.kozlowski@linaro.org>
References: <20220620175716.132143-1-krzysztof.kozlowski@linaro.org>
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

Add common LED properties - the function and color - to LED node in
Exynos5422 Odroid HC1, so we can drop deprecated label property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos5422-odroidhc1.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidhc1.dts b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
index d91f7fa2cf80..3de7019572a2 100644
--- a/arch/arm/boot/dts/exynos5422-odroidhc1.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
@@ -8,6 +8,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/leds/common.h>
 #include "exynos5422-odroid-core.dtsi"
 
 / {
@@ -19,7 +20,8 @@ led-controller {
 		compatible = "pwm-leds";
 
 		led-1 {
-			label = "blue:heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_BLUE>;
 			pwms = <&pwm 2 2000000 0>;
 			pwm-names = "pwm2";
 			max-brightness = <255>;
-- 
2.34.1

