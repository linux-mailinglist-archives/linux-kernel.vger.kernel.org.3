Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C8951A0BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350500AbiEDNYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350564AbiEDNXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:23:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BA841300
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:19:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y21so1686193edo.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRL36JMn5+lxomD6rxYAHBa4kgFK3m97JiXVWGmZ0W0=;
        b=x8MPezr9ln8FX6Sb+NYzJkzCXzID9H8Mq7OgSnQFfS7LrYG+o5yhksHy2D7D/vQ5BI
         Mxv2LKf2vZfqCzI7HZ0pJ/uuuHd7GVHd0NGoflpmSlmgL5yL3KuxaP9HMlZG1y7eA63X
         WBZI3eCig3y/oeD2joJYAPe7Xrvmk4V6uKrsg6VCCo6UXy9IULxne3siBTg8QuOe8s25
         FbfLpUE99r7lIaIHNtJlr6mdnP91EfKr7ED1bOE3qophPs+GST6YZRY29+ZkU3xYRzyf
         X95z6jPZYLJZ7qbZBLhbh68CBUNb7G3p9bJDFFGnj+l/qN1XdhqS4gVuaG2jBfR8amse
         VZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRL36JMn5+lxomD6rxYAHBa4kgFK3m97JiXVWGmZ0W0=;
        b=RwTowaYHEzkzkk/EupZS02pjcLX6g02ZG4/EOMEpLcW3tOCRnU8AGE/JFfgUVawL+E
         IwC9z1c4XlntUV4gIT5n1B3pyb9LQeISCchSoKv91jK1gmIT0RysgPvZo1r3jo2hDZby
         YPH4TZTpVfmWyWTv7l4+RiIuNu6cX3q0xSq5tEioE92INeZxb7UQ7UEQUzdWq0SbruyA
         7PZFmEdPLH668mOR2zFo0PpHqNAFNSJfSFLvE8q+Y11e58TNcaP5VYji7S0Hn3P9vsGc
         MW4GAAmLI4E8nYT4tHEOshCLoFlUP0eh+JLL/jWqO76sIyMl3GuyTxcVOX51H73botT7
         2wpA==
X-Gm-Message-State: AOAM533Lz2HDmz0g4CgzLI8tfceusIl8KDjsdrOBCpCWe0e6wpw7104J
        ZlcKL/WCYuQqVvSHPArk62ThTA==
X-Google-Smtp-Source: ABdhPJyLZ81r1bjDKTFjrp6N4nX7FaGiOpiHS919ZFKMq06jKAjhMyWh81OxXnULjmKdJHbQ9ewcgw==
X-Received: by 2002:a05:6402:90e:b0:425:a4bc:db86 with SMTP id g14-20020a056402090e00b00425a4bcdb86mr5730243edz.98.1651670382007;
        Wed, 04 May 2022 06:19:42 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gx3-20020a1709068a4300b006f3ef214dc4sm5660924ejc.42.2022.05.04.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 06:19:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 13/13] arm64: dts: qcom: align DWC3 USB interrupts with DT schema
Date:   Wed,  4 May 2022 15:19:23 +0200
Message-Id: <20220504131923.214367-14-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
References: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
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

Align order of interrupts with Qualcomm DWC3 USB DT schema.  No
functional impact expected.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 10 ++++++----
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 5d51b6ce45ef..3eafc50b6abd 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3265,11 +3265,13 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 17 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
-					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
-					  "dm_hs_phy_irq", "ss_phy_irq";
+					      <&pdc 14 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq",
+					  "ss_phy_irq",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq";
 
 			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index e8c19b37ca0e..7d08fad76371 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3122,11 +3122,13 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
-					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
-					  "dm_hs_phy_irq", "ss_phy_irq";
+					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "hs_phy_irq",
+					  "ss_phy_irq",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq";
 
 			power-domains = <&gcc USB30_PRIM_GDSC>;
 
-- 
2.32.0

