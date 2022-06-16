Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0052354D660
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350352AbiFPAyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349081AbiFPAyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:54:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE19E5716E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k7so12758plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAhmJJMLt+dZsJwSy+3+Zt2MW08hnmRQ8CsVMDcBXk8=;
        b=XpJypG1PqVJijPFXMhshyEGhFTjzLT1zr9/dt9OPg/kf7Mz0onmMT6LzlId/BPek0v
         SNCWb22y8I8WkTMjojQ9bzUKWsylwLq3qifRwDEZUHtcFrDzflSAQMp6wgG8+NY+BBCc
         V769tA+Nd9fzR7EQyIJbvnIBEQeU1eE12qs80oTTaasuiuNdVWQvcn3fxtPR6jcPXiDr
         MVgYNB4oW6mXrz+QS+uK2Kix6DErvBuSGQuJbxrbexCofV3hZScjIXGEkv961JbbNvPC
         +6TiBL+iK/mxHyr513xRcWwtwmBW8S2MpBercg901WImFJlhGd0d1V9pftNPB3TqKmKe
         XcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAhmJJMLt+dZsJwSy+3+Zt2MW08hnmRQ8CsVMDcBXk8=;
        b=yGV0kEAWCmkvWsO7vzBND+/aEXf7a5sfH9t0uHZ90lKCY47dJWEZZNpBTu6mQCjAFc
         QmOtJrHXsFazbKR+tiXU9pNCN0EYLh7jQtRIFWtcecqaPl9vxP/GDNAUTJbZo92fPiGq
         G7+gbpgbrmuxbkyfVC5OFeWt9dL2rowUO46sQIAzsT7upVjRAlBChEd5qGi3ZZPeQxw5
         AbBNkZ92Kg2fVDkQzdUu8/D503mvHbpxFrh6a/dn4omDy+UiaQuUTwBjXYjQaJ9LpAHG
         xp6Q6LpaTd0BTwxSy8at6wDFzD+iJjx1wNYB0MaVa9bbhQC6fwtUwPEsrB2NuFt6Lxrb
         yCIA==
X-Gm-Message-State: AJIora8saq2wLUbUjSI4BgzDhzBvIqYaaxqOoQpj36LeAlJIWJiDiAs1
        PW/GG8W+EeoJtjEjZ5dyIoYvKA==
X-Google-Smtp-Source: AGRyM1tlfUjwzSCWhGKQW3q+Dq56sqBcx82ObxjiMPph4KVF0w1gBdY62NGgyTxYpOcuu7KoVT1CrQ==
X-Received: by 2002:a17:90a:a22:b0:1ea:e934:3079 with SMTP id o31-20020a17090a0a2200b001eae9343079mr1337262pjo.46.1655340847110;
        Wed, 15 Jun 2022 17:54:07 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 09/40] arm64: dts: hisilicon: align gpio-key node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:02 -0700
Message-Id: <20220616005333.18491-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
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

