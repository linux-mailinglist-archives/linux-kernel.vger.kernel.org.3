Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9EF4EFAD2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351767AbiDAUMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351714AbiDAUMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:12:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21B221A8AB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:10:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u26so4191269eda.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yLz7aILXGbmCujlTI/g4EfDEC7wYnFYansE6wl1+BpI=;
        b=PxHyDvJR26H9mDD/PwV4JiYvxj7YL0fkB7i5YMP1Gf2xT7q1GpkA/Sm0jVGd19n3FY
         WUU+Zo9FwAAqqwN/cQN6MRC9XqY1PmcZ0kDsCkdSOPceSM2d27c8HqHjHZ68GSedte6h
         wwDhzr16zY5wnQ1pp+IrwTzagBcaEq7a9qurEf3wGnL+Tz/JrTCWAXzjH00mVt/OfRGV
         QJMLDSbFmkmIwk6Q1r4nplyUOjldlccOsJHdUcCbV3P8uRNiBNBEiziDi7UBdTG4ne1N
         oofhk2pIaQV/9lZnjc6xLEa6wP1LVKmNf5ozhLU3BnmWoVrJV8vvO6GQcQVV+P09QSyT
         kr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yLz7aILXGbmCujlTI/g4EfDEC7wYnFYansE6wl1+BpI=;
        b=4ROUOnz+oU8EaeVaOcIH1BvhPJkRqkLTeZq2/xy72wsAO5nhGLhYiXvOgivbZS1/TC
         RR3Wjl1gG2eyevkGm1HMDstACD71WYmSRQmJgXqQfJxOur4Mz7IeNTnZuTPpeyIjudyd
         95TwC3ZYFrIKZBKokJM59v8COx4c+pPhEQg9uMvpoeplBiRadZJXyYliWvc/1XvluEho
         C1BsCD1U7OMkhbJY7UgY5hqFWzziWCGJmC88gIsfaYnRlw+I5mZok/GPkwgvrbgQMDbT
         EFERK/Sae5FDWJWZXIUTsy0zfB37l1V+A/cE5C5W5+gri4/Tq+KFvn/7HcACV10Wf29I
         pYxg==
X-Gm-Message-State: AOAM530iNBqpWc0LpfPnmjpkz24bFgb7L4ATbXElnqG5WOgUKasNoiUO
        OgvOxwty7GebUclxjSYBfpXw8w==
X-Google-Smtp-Source: ABdhPJzw259othySLhLy7RggcO11QlDizMLjwIjmeo/ASWp80QmrYaKNi/O++Se0nG6Wx35SN2iAwg==
X-Received: by 2002:a05:6402:6da:b0:3fd:cacb:f4b2 with SMTP id n26-20020a05640206da00b003fdcacbf4b2mr22483918edy.332.1648843847292;
        Fri, 01 Apr 2022 13:10:47 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm1509041edb.27.2022.04.01.13.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:10:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 04/10] ARM: dts: qcom: msm8974-lge-nexus5: move gpio-keys out of soc
Date:   Fri,  1 Apr 2022 22:10:29 +0200
Message-Id: <20220401201035.189106-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
References: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
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

The GPIO keys are not part of SoC and they should be defined inside of
the root node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 069136170198..6d5fb60e798f 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -19,6 +19,27 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_pin_a>;
+
+		volume-up {
+			label = "volume_up";
+			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		volume-down {
+			label = "volume_down";
+			gpios = <&pm8941_gpios 3 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+	};
+
 	smd {
 		rpm {
 			rpm_requests {
@@ -448,27 +469,6 @@ bcrmf@1 {
 		};
 	};
 
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_keys_pin_a>;
-
-		volume-up {
-			label = "volume_up";
-			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
-			linux,code = <KEY_VOLUMEUP>;
-		};
-
-		volume-down {
-			label = "volume_down";
-			gpios = <&pm8941_gpios 3 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
-			linux,code = <KEY_VOLUMEDOWN>;
-		};
-	};
-
 	serial@f9960000 {
 		status = "okay";
 
-- 
2.32.0

