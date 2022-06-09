Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485C5544AC4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbiFILnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244405AbiFILmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:42:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B34C1EC543
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d14so5262574eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRK+N8glfjkwW89EeiwLUV26aVUV7wxe9krThCPLJyE=;
        b=KSf2X/2PX5zWHc4IMpXABVZVkeiiIbY6pXoOyfX+XhOf0Zc2UA97UxUpBIFwguLtgA
         DdT/uVqpINr1h6XDAZzcMin4sOCbCEb8tEn6WRllGoisRpyPuB64jRQmzzgUlu8w9XNY
         HhcEm3xhpI73Go/ZpFJ8a8l5O9kWExZSQ8RETAXTqEQYlmjZjAa1wqKYDTDQFqaSepxi
         vvp5qeRLVX6dOzvwL7jytokDoo+Y62MkG0dSck7Q43GHj6Ph02tRaxXjl9BjYOl17Ke5
         i48dCCJgceMkSJiz/eCnRQSvQPOJrn4Xuo+FokNYjXiUPvC58qkwsLDDgpfVabwRpTm3
         L5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRK+N8glfjkwW89EeiwLUV26aVUV7wxe9krThCPLJyE=;
        b=F7nm/A0ykPcWTUCcFlkBipECH68SAFD5ZpftbXbNPEo3j608mXC1w5nr4wxhtgjPUt
         OU5GCd1pyoWVxFEG1heRFzY8qg9zt15UicsaN+CzY+JfHfZVmbE08S2FLRFFIp0UEEhR
         C13BIGVcc/agMv5Y7LMpF2WaG/NudpFesy/0QgM1vYwlvZdH7iNhm1ZtNO/e4IYlEWeM
         sK2/b2TKqXa4GO/L0vbx9Os3W+20vd5WUU+uAt0kTATkfk5oua8/DUP3Zcx/1yee5aic
         HqNQwOm5FJTgJ9x0pfT3g7ASQ11vGhIk6YA8caSFLgN3N1wDOBqA9xEq0fSZVkZc0IDh
         +Zng==
X-Gm-Message-State: AOAM530Tj/9PhqYYWxlCRzvceKLBMHiPNoGNvibrq+uNEi69kgDc1hwN
        k7hlRWKFbWGKpg3wNygHzAO9EQ==
X-Google-Smtp-Source: ABdhPJxpEa3U4pgU0/TBuX/8kv2dV4LLwzkuty0j9z+lzZl7j01fgTsLGoyhF7H10B0iimLJWCtITQ==
X-Received: by 2002:a05:6402:d05:b0:425:b5c8:faeb with SMTP id eb5-20020a0564020d0500b00425b5c8faebmr44926306edb.273.1654774841241;
        Thu, 09 Jun 2022 04:40:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906058a00b007101f6f0720sm7760844ejn.120.2022.06.09.04.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 36/48] arm64: dts: xilinx: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:40:23 +0200
Message-Id: <20220609114026.380682-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index bb2602dd2805..20e83ca47b5d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -52,7 +52,7 @@ memory@0 {
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		fwuen {
+		key-fwuen {
 			label = "fwuen";
 			gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index f6aad4159ccd..d61a297a2090 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -49,7 +49,7 @@ memory@0 {
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		sw4 {
+		switch-4 {
 			label = "sw4";
 			gpios = <&gpio 23 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 7b9a88b125d1..5fd6b70a154a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -47,7 +47,7 @@ memory@0 {
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		sw19 {
+		switch-19 {
 			label = "sw19";
 			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_DOWN>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 20b7c75bb1d3..e2dd72fe33ce 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -47,7 +47,7 @@ memory@0 {
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		sw19 {
+		switch-19 {
 			label = "sw19";
 			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_DOWN>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index e36df6adbeee..d685d8fbc36a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -47,7 +47,7 @@ memory@0 {
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		sw19 {
+		switch-19 {
 			label = "sw19";
 			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_DOWN>;
-- 
2.34.1

