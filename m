Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC93552357
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244980AbiFTR6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244924AbiFTR5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:57:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5542E1EEEB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:57:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id o7so22634288eja.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=joP03Af22hkwu3KalwDqH+PPIBm/L0VrpPvnIX53/fI=;
        b=Z0oHIoda5XMiOVpIgbbyotj7nmbNFjYZACyvVG6Ejs75akHtE73Uh8fBjv3zXp0cUj
         UwEjfAbJ8t5daAoFl89pMsavkJrxgN0YB+A5jnNh91tMRmu2yQ5iGY4jeBa3ZBQ/IwsF
         7w38jBAmVCxw2tqrID8ZXSb/UkVZoAPqP3Bf36gVk8UkbT2gWXS7eqw6QjO/fx9iTmPq
         yRZJHeumYXWB//rqrU3d0TaNgS7TiYKqDGJO2o2Vi40MQ3f6De3369k9Ua6xt1hPE4ej
         1w1Gg6cLy9ZbGxIm47944EHLvaYp7v6lvw5lc64MYILyubdPMwoPnBSh1eLXXOHA+Q0l
         vQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=joP03Af22hkwu3KalwDqH+PPIBm/L0VrpPvnIX53/fI=;
        b=SsGoQJ/bDmYBihR8miRjsM1dQXZ1Vpc6GUM1j7Goozo0ROIcEyLmqSO1RNtVNhpROH
         oBtiCyJCu46eJ/+ir36A56Q5nhX200Dr1WESxFZULztbL8VTsMiMoS3zLpHCBwHDrgOe
         9v7TKQ3c0pbjHM4M380KMCEAXN82kpBv5Nqvi1od8MWSHQqHGsBm0CJpkgVBflmVEgAv
         +qlxXiExn32R2Dcx/Pa0Jkt6++DUjdOtPi794TaZVL65PUq12ADJuwiA+NVwejkrYf2N
         VPIIgs4cW205jeHkMIWCAojCPNkOJhPCZeVpS1RlcsDeM4wAY/Ph6+RUrec1crYIlkdu
         wBlQ==
X-Gm-Message-State: AJIora+GNSL/nsetSuUlNVx/pWHtPE+Uv0hZGnVxex04LXt81XJ7qOhA
        G6qbLneZVOI1OXD1MkRVv0GW0A==
X-Google-Smtp-Source: AGRyM1vsNjhVI2WjrfbSg9NB2/tJgra0FfoakSUJrfCHX5V2KYjR8NJdeWepCHBSJhH+Yp1b+iEKfg==
X-Received: by 2002:a17:906:72d7:b0:711:f778:113b with SMTP id m23-20020a17090672d700b00711f778113bmr22537580ejl.625.1655747855904;
        Mon, 20 Jun 2022 10:57:35 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7c84d000000b004357b717a96sm4309925edt.85.2022.06.20.10.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:57:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 5/8] ARM: dts: exynos: add function and color to LED nodes in Odroid X/X2
Date:   Mon, 20 Jun 2022 19:57:13 +0200
Message-Id: <20220620175716.132143-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220620175716.132143-1-krzysztof.kozlowski@linaro.org>
References: <20220620175716.132143-1-krzysztof.kozlowski@linaro.org>
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

Add common LED properties - the function and color - to LED nodes in
Exynos4412 Odroid X/X2, so we can drop in some places deprecated label
property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4412-odroidx.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 1f17cc30ed14..68d589e081bc 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -9,6 +9,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/leds/common.h>
 #include "exynos4412-odroid-common.dtsi"
 
 / {
@@ -27,13 +28,15 @@ memory@40000000 {
 	leds {
 		compatible = "gpio-leds";
 		led1 {
-			label = "led1:heart";
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&gpc1 0 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 		led2 {
 			label = "led2:mmc0";
+			function = LED_FUNCTION_DISK_ACTIVITY;
 			gpios = <&gpc1 2 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 			linux,default-trigger = "mmc0";
-- 
2.34.1

