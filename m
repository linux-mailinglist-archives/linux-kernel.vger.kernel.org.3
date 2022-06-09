Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5DC544A9B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbiFILlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243940AbiFILkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:40:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2A31DD4E3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:39:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v19so30804602edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAhmJJMLt+dZsJwSy+3+Zt2MW08hnmRQ8CsVMDcBXk8=;
        b=wOphX0hATInbjEuhOehzkYfJVnR2wUqmiRCKN/AH0JXYY8e/VdR9SgYnsl1ZZXB+1i
         JMdBZgUz5HDY34LT5ZUPpPaEw6aKptfeAkCtg4jx9alB4DTjsGVY6JsGYM1RCgcqPeE5
         5FcyFYTgrDIV12Vp3hE84Yy+pB68Xn4G1GL467uG9IGDUZxxgrybnlsVq8iK4rEExpfo
         WSmuqAy+rodu1kOLj6U7HWmXz4g4ez4iLFKkLEAos0xCuV1+XCe5WXoptEA5jDkRUgo1
         XvGcGTdvvhPKbk+QFc0ErMKZf1YOeA9yZ86UNzMdElizz8Z/HTZn7OvX3RAW2/8qGVFo
         ywww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAhmJJMLt+dZsJwSy+3+Zt2MW08hnmRQ8CsVMDcBXk8=;
        b=T6ovFc2rD2rjwbwobUDCNFmfo2nr3iGpvpehq7zHRkVR2ozJ2gXsB7zRzZ5WDwo5vt
         dlZ9c36jve0TIlwS0LDXoXQ3tXd1TOGeYvZjCjJ5ifISZ0OB4lyLInH0Mn+Vtv+h1wpk
         dWIDTEq+spnx0v7u6sWoqC9K7b9aqVglJNOcmGjPCgOdgEoXIttidhv6iWtftEYr/fcg
         5dmicaat1R6hzqRDQoQu6cg/VkUdPCB8qAguECIAzzC5nlKCkKCbThN4DfiZ1dOh9USu
         ZnYhfa73dJI7qY5NTOEhvpiozLxeVvcWD17khPNE6kAPiiqTKXlI0hlNsL7RfUQiDe2o
         Id3g==
X-Gm-Message-State: AOAM533mmekpxbTKLwnpN2hBfhD7oDB/w/zP08R8a6QfeK3IMnEX9im1
        nTy9Pv2ExWHYDPgTzu90eokp9w==
X-Google-Smtp-Source: ABdhPJyXuzZml/Ae44uC3j9MoTsQwFrnLkBEzS4hrOMongxAnomnNX7dMHgx4zK91+BRghOrPp5oYw==
X-Received: by 2002:aa7:c744:0:b0:42d:f68f:13de with SMTP id c4-20020aa7c744000000b0042df68f13demr44159095eds.294.1654774790650;
        Thu, 09 Jun 2022 04:39:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906528a00b0070a80f03a44sm9460415ejm.119.2022.06.09.04.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:39:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 15/48] arm64: dts: hisilicon: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:39:34 +0200
Message-Id: <20220609113938.380466-6-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 2 +-
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index f68580dc87d8..0fe0542bf40e 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -74,7 +74,7 @@ keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key_pmx_func &pwr_key_cfg_func>;
 
-		power {
+		key-power {
 			wakeup-source;
 			gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
diff --git a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
index 40f3e00ac832..ad53066ac495 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
@@ -27,12 +27,12 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pwrbutton {
+		pwr-button {
 			label = "Power Button";
 			gpios = <&porta 8 GPIO_ACTIVE_LOW>;
 			linux,code = <116>;
-- 
2.34.1

