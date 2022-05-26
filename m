Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39C535489
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345529AbiEZUhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348467AbiEZUhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:37:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC49E275C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:37:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gh17so5132197ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVzmyNRf2D+RLhRZdxjNSUvC/8pZXz4Xqz+PvOm0eOo=;
        b=zyqJ4gt1i2C5KklLMQsq4Bq+13DMP9BBrJRy9jgODN/Cswpx6TGfS74lQa+CTsRhJD
         gsghHvzW0YC++Ff1zBQp0HOCBfQhJCsaSx2XdmrFyF0PAuAOv6ygc6dEBgtwfS00J8LM
         CGLlK5oDtzqMHghiQ2E8mzIRt+4S0maBIl85Vkqtd4nWt3F/kamhENV0n+LMnWMLDXoq
         j1t6gPc78WenjYPHwa1RVmZCRXU7y9w6N0tPFRwYV7O/ebbKOhmFvTluxdRi9hnkx8T3
         2oQQ1p8LqdMfVl6fVUwi8tTBxus2rcg7VofhuLz4RLPvkPU4yMXJ9KtbjNlwYr6RlACw
         6bTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVzmyNRf2D+RLhRZdxjNSUvC/8pZXz4Xqz+PvOm0eOo=;
        b=muGFTsfC0J8Rygn+mPcbTQAU8QA64YUzHDDYeBJ2MsjZxks0wHmcFn01mF9N37sXb8
         LTpMlSH78cKhq7K1kJf0UkLDxrrD47LsDg0E3pNUnVycaqOUxBu773hjcRmAZRTzc9Dc
         bgsgTCapxa608VK1CPQw2GLSKuu+VBDv2yks45o4OQSI2dxruZw4hHiDjXT4Fv+wEWwc
         PNaXwVukwqfL0yCBPumLR7huX3UpouthN7mgNbwa3RmTnbHUJCuH45A9g2d+y+CfuTHP
         9oOzlHk2UuwHI8M74Hr4KdsBgfAs8B8Z6vfSQImx+eBOHNhoKAULRoRmpUUxbmsVtaeT
         lopw==
X-Gm-Message-State: AOAM532XDa4VI6CKNEorOolR2le+Q21Bz3P04GqkCe9LrY1BdoLJf6MJ
        PZgXPy4uS1JiANVMAq16k/qOhw==
X-Google-Smtp-Source: ABdhPJwCvACxI9eOs65N8EGyEe/eeh9Ti/MA66rp2IEPk0gPG+2+VhYH0HkinFXoqBynVYODga/SyA==
X-Received: by 2002:a17:906:478b:b0:6f8:5850:4da9 with SMTP id cw11-20020a170906478b00b006f858504da9mr34867413ejc.619.1653597447822;
        Thu, 26 May 2022 13:37:27 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gc21-20020a1709072b1500b006ff16f48e2asm807671ejc.76.2022.05.26.13.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:37:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: nuvoton: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:37:24 +0200
Message-Id: <20220526203724.831215-1-krzysztof.kozlowski@linaro.org>
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

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 2 +-
 arch/arm/boot/dts/nuvoton-npcm750.dtsi        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index 3696980a3da1..9633b50a9c6d 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -128,7 +128,7 @@ gmac0: eth@f0802000 {
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			ethernet = <0>;
-			clocks	= <&clk_rg1refck>, <&clk NPCM7XX_CLK_AHB>;
+			clocks = <&clk_rg1refck>, <&clk NPCM7XX_CLK_AHB>;
 			clock-names = "stmmaceth", "clk_gmac";
 			pinctrl-names = "default";
 			pinctrl-0 = <&rg1_pins
diff --git a/arch/arm/boot/dts/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
index 13eee0fe5642..30eed40b89b5 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750.dtsi
+++ b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
@@ -51,7 +51,7 @@ gmac1: eth@f0804000 {
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			ethernet = <1>;
-			clocks	= <&clk_rg2refck>, <&clk NPCM7XX_CLK_AHB>;
+			clocks = <&clk_rg2refck>, <&clk NPCM7XX_CLK_AHB>;
 			clock-names = "stmmaceth", "clk_gmac";
 			pinctrl-names = "default";
 			pinctrl-0 = <&rg2_pins
-- 
2.34.1

