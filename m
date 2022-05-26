Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6078F5354BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348985AbiEZUmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348999AbiEZUmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:42:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB33610C4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:42:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m20so5052092ejj.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIeUwDRMBW+HvfzrbBg1S1hCiyKcm2U6khE2zW1HMyo=;
        b=QYkPCRQ1h7K7vPwEeKS0wuCDOdPhUP512Xs5sRrnWhrzcU2wPrQ7iY1xnxI1V5MnnW
         SqljKOmNhDxc4h+zdyVR36yWqYgqjVywxgq95S+OT0vEI5RAJPFliPFInC8cNvgG72od
         4e3sJtMGcojHSHC2DynAWkw6zKLMun3J6kC+SWkPYsP9WdYeV3a9QNM36pF/uDOgwKmM
         Lzi/WCftcQwGGY61MttVUVTcDo3ZJvFW+vA+pHYHLNGk+cq3h5RnDs0hXjTjPuQcNblj
         peYLCBI4GkIRNM5RI63AiZOvOxOJlvjTmYwEH/d69A2Mot1SOVu8TmkXBrMtO6vGJUPr
         yYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIeUwDRMBW+HvfzrbBg1S1hCiyKcm2U6khE2zW1HMyo=;
        b=PAFDTIlJXXDhXkZ69KR0M2E9Ik/u1Tbbb1xV2QgPDiqn5F3FtxuMMGniblQKmhW4xf
         2Hvd4X+N9s+qZSDfXH5iERIScXIb4hVAFDbwuD/SikifnnfHTqetmF5rof+cgw7E5p1U
         uslLQF+jsQHm/atb2pW515u/nsHlE+eD8J1gq0CtSZZoFrXfjWl0xoJMW5QTVXfhvCOE
         3+TBCIyEBoknrCV95Q6rXEK0b2N3a/GuHr4fk3h4GRYGTxxkCTL71xh9lgdUYVpmEaxB
         PryCZjIGojS5YeUaMc8FTb53qGtvqNJ4hvIQV9tw7h9LYIQd38eMev9dtYs52mQhdn+N
         Lzzw==
X-Gm-Message-State: AOAM530zQDKa5QNF1luIAJ3bEuQPMdBaW4iXRxskkKIrPs3DyBrgfHlN
        qY61EE+1auXUJPOAomMuaaMPnw==
X-Google-Smtp-Source: ABdhPJzOvKv9gnnJLuvRGuOJGs7GPpZWMEmPdcFrDkptFpkhrYz3ivqQ2Zn6kXVsBGurafpBenMPSA==
X-Received: by 2002:a17:907:3e8b:b0:6fe:f848:f5b with SMTP id hs11-20020a1709073e8b00b006fef8480f5bmr17736688ejc.374.1653597725061;
        Thu, 26 May 2022 13:42:05 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i10-20020a1709064eca00b006fe0abb00f0sm816988ejv.209.2022.05.26.13.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:42:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: sprd: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:41:52 +0200
Message-Id: <20220526204152.831948-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/sprd/sc9836.dtsi  | 10 +++++-----
 arch/arm64/boot/dts/sprd/sc9863a.dtsi |  4 ++--
 arch/arm64/boot/dts/sprd/whale2.dtsi  |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9836.dtsi b/arch/arm64/boot/dts/sprd/sc9836.dtsi
index 231436be0e3f..8bb8a70966d2 100644
--- a/arch/arm64/boot/dts/sprd/sc9836.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9836.dtsi
@@ -207,11 +207,11 @@ gic: interrupt-controller@12001000 {
 	};
 
 	psci {
-		compatible	= "arm,psci";
-		method		= "smc";
-		cpu_on		= <0xc4000003>;
-		cpu_off		= <0x84000002>;
-		cpu_suspend	= <0xc4000001>;
+		compatible = "arm,psci";
+		method = "smc";
+		cpu_on = <0xc4000003>;
+		cpu_off = <0x84000002>;
+		cpu_suspend = <0xc4000001>;
 	};
 
 	timer {
diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
index 8cf4a6575980..22d81ace740a 100644
--- a/arch/arm64/boot/dts/sprd/sc9863a.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
@@ -552,7 +552,7 @@ ap-ahb {
 			ranges;
 
 			sdio0: sdio@20300000 {
-				compatible  = "sprd,sdhci-r11";
+				compatible = "sprd,sdhci-r11";
 				reg = <0 0x20300000 0 0x1000>;
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 
@@ -568,7 +568,7 @@ sdio0: sdio@20300000 {
 			};
 
 			sdio3: sdio@20600000 {
-				compatible  = "sprd,sdhci-r11";
+				compatible = "sprd,sdhci-r11";
 				reg = <0 0x20600000 0 0x1000>;
 				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 
diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 79b9591c37aa..957b2658e1fb 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -132,7 +132,7 @@ ap_dma: dma-controller@20100000 {
 			};
 
 			sdio3: sdio@50430000 {
-				compatible  = "sprd,sdhci-r11";
+				compatible = "sprd,sdhci-r11";
 				reg = <0 0x50430000 0 0x1000>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 
-- 
2.34.1

