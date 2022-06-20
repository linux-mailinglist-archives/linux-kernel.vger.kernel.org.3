Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D64555234F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244831AbiFTR5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244822AbiFTR5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:57:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068741DA76
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:57:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u12so22591220eja.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rD/1Bx8Gd7OKYwtuHbi2Y1F/IfDjcD3uslaR6lEC5yw=;
        b=ipFDuv4n3A1+nSYNYbYqP4cwwOOxYGDeDoT73Hwaj1DFAB+JRAgNKMJFgr4qHgMqfd
         Qh2KjLziahDKA+HISDeMsTd9uUqE4+vYzkk25EhjzATWhVLJDOXpXXwCXvUYGeljfWkB
         lgNX1Hve9Bd0DdlLwZt1rNvp1wCrIEKIkiHVI9G/TwE6tk/Rc3sZLi/tE56rV6O59s7e
         luHo8jLctvl70fE7onDQAKy5lrrc61ln98NPl7FkgrGob7oK6++vmtIItnXVWtCzqNJl
         wIMtfmNPrHrv92mhQ7cFCa3kDru/TtpAJvRqpsv9n7sqlFLo1+LK/6DYNoMuIrBbvQG4
         2Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rD/1Bx8Gd7OKYwtuHbi2Y1F/IfDjcD3uslaR6lEC5yw=;
        b=BH5ap1Im6mqbN8s0SXjRRg5CMMNWTNdkGqA9rbS2GF4y47jDgQpCQ+IelvC88a/ysN
         ohJ2fVFSLbh3vp3aqMb4jrFn/RtTU/jGGZ4DLFzcOc3tM5KrALI/Wtamj70W5owkaSoq
         dpFVJ9EHxkAbGvEjITz4KAGPSm1+AIRbQ98ukRsGFzIKCr0uNmfwEybOOazlYdzDbRar
         XkUc7cRgWlxSSTLCpjVgb/NFfXjHp6+92amPuA1EWB02V3erLY26eke3Sj/2j/WGClNS
         qKn/i1uoDjwRrHlOhNH3FhrBdMk/Gxt0oLx93mK8TiNZ58KG/29nt1nwYntJHdpT+KYl
         ccqw==
X-Gm-Message-State: AJIora/tkg+28BVoesvIVQZnXDT96bGFfMNO9hxxzshsZHwnbKj8NQJr
        yutMR67hY7YBQoenOzfLHHjMbA==
X-Google-Smtp-Source: AGRyM1u+9YCsOQ1AZPpIAWblqHkPcR65S+1pJ2KFrv7M8q6Tf2EKagfh41Ip0cxx1YDAa8W/7iiAQA==
X-Received: by 2002:a17:906:29d:b0:6f0:18d8:7be0 with SMTP id 29-20020a170906029d00b006f018d87be0mr21750796ejf.561.1655747851602;
        Mon, 20 Jun 2022 10:57:31 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7c84d000000b004357b717a96sm4309925edt.85.2022.06.20.10.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:57:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/8] ARM: dts: exynos: add function to LED node in Origen 4210
Date:   Mon, 20 Jun 2022 19:57:09 +0200
Message-Id: <20220620175716.132143-2-krzysztof.kozlowski@linaro.org>
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

