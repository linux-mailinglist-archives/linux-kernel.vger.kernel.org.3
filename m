Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A185253FB59
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbiFGKeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241018AbiFGKdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:33:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F1F5D19E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:33:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v25so22397805eda.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LvnR6cnpgmDRvwfNHKxOBJt+HY/LO1fEYGyHnVTDA/Q=;
        b=X2//BewNVt+G3WqsLf1YFSVktvR/LTRIrmfH4RQB/wuu5hCb7IlNMCAYSKC6TNEOlp
         oTTtXqWvbcwJ+CszIfJdV4yEzBxbeO+8C4rGHyfyFIqo1Mn2CuqhoRcOdTSpt9XJK16N
         DgJu97jppHT4szre1mXlTsGntPzri/j2h7KfaqnaDd08E+gQvHShRcvkzyhPjsf+R5qh
         fEmPTXWmA1kEvlsJulXg3resxygcUVsh2xL3jU+9aCgfgUeESxJtvRXvMcmhcMCvrZ/p
         PU0VQzrTIJKvD2Io32Fayvb0z5u0XXEQorvXgyXebCI4co+9ppzHiaxLnQHc2w2HHbXU
         bJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LvnR6cnpgmDRvwfNHKxOBJt+HY/LO1fEYGyHnVTDA/Q=;
        b=Ql9iDLmDWOfRFmF03uwB8dPTBskGFi/YfJ8aDOCjWomFVRHF72vlL1mtohBAsqmbFc
         CZfxAhaz6vAgcv4s6LJpapmCm9E/o1Z6EErDbObGrHCR426Wn/mn8QR+T93aJYm9hgua
         QK3zs3NZrQevK2lORmGK1E48knm+VUYtXZlTl9YNdx5oooxcYG6dRbt2IQVcK+PGXeO0
         irQErV2q6pvubFyzNhCwA7RBLvY0E4KPXsKDd+2NHHVrQzWcR5FG2aJa6PVGcsipSzQE
         S3k26VmHLkln7G+uKLidGz1SE8SYslijKYgV+kIlFo7wIz+7Oq7XVqgialt8ewrowP4s
         tTuA==
X-Gm-Message-State: AOAM5338nSIp5SPFRiGTJQUVIDYGnkzeMwGAb/TEOyH0GACYRaMf2yz+
        T83vvienEJqeMupNgNctZ0en7A==
X-Google-Smtp-Source: ABdhPJwKe00IxJnJOFOGrxesMijt5vWvWpdZ2XxfqK9y0YGoiRWJUXlnmcEWnyBZ9lko2VvfalbHIg==
X-Received: by 2002:a05:6402:3819:b0:42b:ddcc:2109 with SMTP id es25-20020a056402381900b0042bddcc2109mr32716394edb.246.1654598032694;
        Tue, 07 Jun 2022 03:33:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709065ac400b00704fa2748ffsm7505359ejs.99.2022.06.07.03.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 03:33:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/10] ARM: dts: qcom: ipq4018-ap120c-ac: add function and color to LED nodes
Date:   Tue,  7 Jun 2022 12:29:24 +0200
Message-Id: <20220607102931.102805-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
References: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
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

Add common LED properties - the function and color - to LED nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts | 6 ++++++
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts     | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
index 028ac8e24797..cf7da1ab177c 100644
--- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
+++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 
+#include <dt-bindings/leds/common.h>
 #include "qcom-ipq4018-ap120c-ac.dtsi"
 
 / {
@@ -10,17 +11,22 @@ leds {
 
 		power {
 			label = "ap120c-ac:green:power";
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&tlmm 5 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
 		wlan {
 			label = "ap120c-ac:green:wlan";
+			function = LED_FUNCTION_WLAN;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
 		};
 
 		support {
 			label = "ap120c-ac:green:support";
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&tlmm 2 GPIO_ACTIVE_HIGH>;
 			panic-indicator;
 		};
diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
index b7916fc26d68..c4f89b712fd9 100644
--- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
+++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 
+#include <dt-bindings/leds/common.h>
 #include "qcom-ipq4018-ap120c-ac.dtsi"
 
 / {
@@ -8,18 +9,24 @@ leds {
 
 		status: status {
 			label = "ap120c-ac:blue:status";
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&tlmm 5 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
 		};
 
 		wlan2g {
 			label = "ap120c-ac:green:wlan2g";
+			function = LED_FUNCTION_WLAN;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "phy0tpt";
 		};
 
 		wlan5g {
 			label = "ap120c-ac:red:wlan5g";
+			function = LED_FUNCTION_WLAN;
+			color = <LED_COLOR_ID_RED>;
 			gpios = <&tlmm 2 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "phy1tpt";
 		};
-- 
2.34.1

