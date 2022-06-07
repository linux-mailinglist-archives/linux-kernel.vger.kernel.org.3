Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972FC53F8AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiFGIwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiFGIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:52:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE501054B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:52:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z7so22017755edm.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 01:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rD/1Bx8Gd7OKYwtuHbi2Y1F/IfDjcD3uslaR6lEC5yw=;
        b=RRpooTaCdmWQ70hmo6aYhrzwCvxGXEsQ//HkFOZplQM+4KbF94ucjCBARufO0jmAor
         9aKvuFAc14q5EZWvj+PIxcsa+S7u4h24HOMm3zdKAOIIRnnY4XBd1eaMDcSe3RIIrpqA
         KhWCi7KRWk8U1qsk87VkSJTr8b3/K8rHZd8LAyN0TCkElbJTc8qVOL0y53cCA7Wyu9j9
         ZMQ0M9jJIUZ3E7lIm4s2Sbky2X7NEaj4HwMjcWz3aIGHTRlXIy5ZcUnofRQFdoeUDgQ6
         9UK92LcD2hg7mURo2fFZlaYhN7mSltJ1vW9xYFerfGaKqATo0MviUEg4ZbgiGpb/i/BI
         QhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rD/1Bx8Gd7OKYwtuHbi2Y1F/IfDjcD3uslaR6lEC5yw=;
        b=jXkDyKVdYm8riGsTdPGVjiZljIQjAD0leDcC9BDLI39Pxdz3ZcAD62ULBU9vDPDRYc
         wi3W2cpQ9kfe16wj06Das3ieuNZx2tPXWvjFNgZTefKI9o+gt+hibXGT+P3yglDohOz7
         MIgAKxW/tlFyasC2TdHHTxu/RnTBRnLlDeOk8jebDq1uliFXJ7yR9Fhb7wAPl4i88bQ3
         5mo84hdby1DJraAH6/anK5gO+wTA1CzkPQ8PnCbaalBt/tJQSrovUu8g0dGTfo250NqG
         RLoX9Juh+vPMQtQzZMlZcVkGrXuO4WCCoG5MQ7nbIHbipp9Qw2eXHHfkKoWmq89IXRXg
         iRqw==
X-Gm-Message-State: AOAM533YE+XQuL+T7hyqLu0nk/U+nAqt9U9hQjaTvP5tfiR0GyebpfsM
        HsZQ3y2NF1Ewin+w+/dIRsgr1A==
X-Google-Smtp-Source: ABdhPJxYbFqv7g0vrUkta7V3cYoskbZV2DjV9lp6k5ZCI5T2LBGY8n6vRGjnp7ldQ1Gu9EO+zBJ1iw==
X-Received: by 2002:a05:6402:b09:b0:42d:bd80:11ac with SMTP id bm9-20020a0564020b0900b0042dbd8011acmr32349165edb.244.1654591955176;
        Tue, 07 Jun 2022 01:52:35 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lk24-20020a170906cb1800b006fa84a0af2asm7458137ejb.16.2022.06.07.01.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:52:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/8] ARM: dts: exynos: add function to LED node in Origen 4210
Date:   Tue,  7 Jun 2022 10:52:24 +0200
Message-Id: <20220607085231.72246-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add common LED property - the function - to LED node in Origen 4210.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4210-origen.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index a08ce2f37ea2..82c4ebdf98ac 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -15,6 +15,7 @@
 #include "exynos4210.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include "exynos-mfc-reserved-memory.dtsi"
 
 / {
@@ -86,6 +87,7 @@ leds {
 		compatible = "gpio-leds";
 		status {
 			gpios = <&gpx1 3 GPIO_ACTIVE_LOW>;
+			function = LED_FUNCTION_HEARTBEAT;
 			linux,default-trigger = "heartbeat";
 		};
 	};
-- 
2.34.1

