Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8CF53F8BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbiFGIxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbiFGIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:52:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6211186EC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:52:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n28so22041644edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 01:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FAcjGt3UJf1b3YwbNE0HOPIn29zQv8jSwkJdfcFsjz8=;
        b=z3ZyWpaC851Sqq3rWnMXD2nSwvwMcRl8+i8lm8g3t+8W8SDD2/ewsnmxAMmqp8wtor
         Tq4z0WQM9We3AQ4DA6Fjs7q1yqqXThHyCfSMpP4ZUmj4Wma/B0O38BArCdTtB850NqiH
         7rCRObI49vcFLMCwkgNucbP98pzFL4Qn9C8/oCg8R1lKiJBJmLM0mNooLECmFvm7yi/1
         fYVbXU3SG1K3KlvLJr/vsXtgfBSkRTGUA9wqeeBo69zffd08BbGacpyqqCxkPb8q3xp4
         BiufxoK9UkJ6cndWuxjeVRmkBFrVmjjBQGjDXPYlC7J0jKg/Ihrlf6hKx5lpHintL/St
         AzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FAcjGt3UJf1b3YwbNE0HOPIn29zQv8jSwkJdfcFsjz8=;
        b=whimnEDR2Zbb2wqJMx0+kzmMUWOXFsViruCselGS8d1kYw5Y7RDPfI7ghhBXoBaBqn
         aseBbMxcvj0AE3JeLmRiwyW1mkHb6Qf4HQOJFOih6wqmXxb3h8hfeGINe8R7a13v1wRd
         F09qhANTlQyDUwF2gq/NcMf+fs3MfajXfaot0/PZdFeA0zLaeEeXuHt7FpigO1zzGHeJ
         fzSFPtF3wgtoeuRvxk7eASlw1kiy98clcs0UBngW9u1Q0VlaAF1Fc5MhWj1fgfiR3rLq
         bbs9MtMVq6LW/hGRG67oo5ChM0nZtPDJNRw+gdxiiOc3j+j/1mi1HQMEbZKP9oGwO6J/
         q7sw==
X-Gm-Message-State: AOAM530pNZq82PYc9DFD231VDuyzAju0mNR1UYsuPXsx9+BDTCOHEUiA
        dUhxBA9ncGXUVx704uWVaJlBUw==
X-Google-Smtp-Source: ABdhPJwDzZeVPYvS8ULxbJ1Jld+MuPMYUbVc4NwLrr8W3qBk4cP+m4ga1DgO3my3xt5+dYQxsCxkFg==
X-Received: by 2002:a50:ed12:0:b0:42d:d1d3:493c with SMTP id j18-20020a50ed12000000b0042dd1d3493cmr31295737eds.174.1654591959273;
        Tue, 07 Jun 2022 01:52:39 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lk24-20020a170906cb1800b006fa84a0af2asm7458137ejb.16.2022.06.07.01.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:52:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/8] ARM: dts: exynos: add function and color to LED nodes in Odroid X/X2
Date:   Tue,  7 Jun 2022 10:52:28 +0200
Message-Id: <20220607085231.72246-5-krzysztof.kozlowski@linaro.org>
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

Add common LED properties - the function and color - to LED nodes in
Exynos4412 Odroid X/X2.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4412-odroidx.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 1f17cc30ed14..dfa4adc9a767 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -9,6 +9,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/leds/common.h>
 #include "exynos4412-odroid-common.dtsi"
 
 / {
@@ -28,12 +29,15 @@ leds {
 		compatible = "gpio-leds";
 		led1 {
 			label = "led1:heart";
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

