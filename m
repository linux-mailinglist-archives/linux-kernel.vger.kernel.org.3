Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3744EFAD9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351763AbiDAUMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351735AbiDAUMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:12:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C72521C064
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:10:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lr4so8048422ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9KUw4q+j+PkM/aYrJwy81EirlGgfz0uvY4K3Ls2IZB0=;
        b=BpFwrRepLyui6gXaecZa3WVCkf/wzwdD1YlV8iGfLjjORT55EyQWplOvSvoLViR8xI
         uAAHTh1eccIdfJi7b73lfcDaXLAGRXGRqYJJFXPZrcfm7BDp9wY6GKrL4BC8GlL0Hzy2
         wg5ztOn6Ar8uQQkgJGZfDgxCgmAWm1WHxCHqxkZ0u9ycwDWInZdp8OKItOsK2MIRsn1E
         CT0+wLRWJPNxnQ9VlGYTs4ZFj6WsRo+q0Kg8/OdIsvQcdoKPd5cGQFOm4rdrj/3iJVXT
         ER7/hvLmRk/KlVU1ZIu3d0cie2kELof6Kav2Z0HSBwaJpkpqO4YEC1zxW3qbSye38t1T
         ka8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9KUw4q+j+PkM/aYrJwy81EirlGgfz0uvY4K3Ls2IZB0=;
        b=jQLJ/jS5HpzEEus6kFG7kA+NKv8KgfTzPGypifUovx9QXaKq5UWnmNzz/xf6kTsmfD
         VEvhdCLggQqIXaiZ2X3WwoZgAR4zmdpwixghhti9bPZqIRZIHUklFpyr6omdMPne9wkC
         9xxoo5Y5lgLHMNF3QsAxDLNXejS/4wK+KYb7f4PKXyewvMqPV0um4uLPO1FuVnTqAqQQ
         eI0CRZfWvj6ZFB35ckd6lV5qWNVXzfN6ooUrW46imqu+vyLdAZxlPGSis/RUXkjfIXc3
         52biLQwf4Fkz4LwSnAVt9v2rnLj+nHYUB2u4pBDyndeiiKd/XZ3kX0XMfChGpPskdMJy
         Xcaw==
X-Gm-Message-State: AOAM531fFdsjWnJWEJ9ITKooLH3s3/RNeAVQ/9g1SJxN0OrkhX3L9/9O
        GyBVFzU/6qJ8iIFmUB1pl09ZJw==
X-Google-Smtp-Source: ABdhPJxlK455fS4hKBklASLqBLdG2YFxVh3hWggdL4wwu9rjt+VAJTGViomKGuj5Q3ubvKQ4HPoO8g==
X-Received: by 2002:a17:907:6d0a:b0:6db:f0f8:6528 with SMTP id sa10-20020a1709076d0a00b006dbf0f86528mr1272712ejc.466.1648843848774;
        Fri, 01 Apr 2022 13:10:48 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm1509041edb.27.2022.04.01.13.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:10:48 -0700 (PDT)
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
Subject: [PATCH 05/10] ARM: dts: qcom: msm8974-samsung-klte: move gpio-keys out of soc
Date:   Fri,  1 Apr 2022 22:10:30 +0200
Message-Id: <20220401201035.189106-6-krzysztof.kozlowski@linaro.org>
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
 .../boot/dts/qcom-msm8974-samsung-klte.dts    | 64 +++++++++----------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
index 96e1c978b878..6e036a440532 100644
--- a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
@@ -20,6 +20,38 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_pin_a>;
+
+		volume-down {
+			label = "volume_down";
+			gpios = <&pma8084_gpios 2 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <15>;
+		};
+
+		home-key {
+			label = "home_key";
+			gpios = <&pma8084_gpios 3 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_HOMEPAGE>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+
+		volume-up {
+			label = "volume_up";
+			gpios = <&pma8084_gpios 5 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+	};
+
 	smd {
 		rpm {
 			rpm_requests {
@@ -347,38 +379,6 @@ bluetooth {
 		};
 	};
 
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_keys_pin_a>;
-
-		volume-down {
-			label = "volume_down";
-			gpios = <&pma8084_gpios 2 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
-			linux,code = <KEY_VOLUMEDOWN>;
-			debounce-interval = <15>;
-		};
-
-		home-key {
-			label = "home_key";
-			gpios = <&pma8084_gpios 3 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
-			linux,code = <KEY_HOMEPAGE>;
-			wakeup-source;
-			debounce-interval = <15>;
-		};
-
-		volume-up {
-			label = "volume_up";
-			gpios = <&pma8084_gpios 5 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
-			linux,code = <KEY_VOLUMEUP>;
-			debounce-interval = <15>;
-		};
-	};
-
 	pinctrl@fd510000 {
 		blsp2_uart8_pins_active: blsp2-uart8-pins-active {
 			pins = "gpio45", "gpio46", "gpio47", "gpio48";
-- 
2.32.0

