Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA934CD43E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbiCDM0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbiCDM0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:26:00 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523C81B3713
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:25:11 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 916A13F611
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646396708;
        bh=ro6EmjNQtTARcIDRl9rR+ZuulwNuQEnHoOGAjteVwBA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=tkZIlbXZg3AfUdEZtIuBd8PiMTEcJxQmVEo5ixFm94YsFxPkmaMssnItc949WUsto
         3bO4zFGP3Yowe+G6uJh/hByFCxT34JBf4rxgE8M5r7AX/67Ht56unTmST9ZsdA63lG
         uK503qyvbJUStw4J21kX9NVQtZnO9c5Onytf49sT/tSoidvHq9AI1ubgoVIOusuHKx
         bpnAB8odVjPshdeKRBf0fYb0BytEGEzTzzl+UtFqwsTwSRPvVIFTc6fSjZNXrEZEEg
         F8ewc3ydKR0/eGTYXDMV+KfubmRKRjOUv53g6sebgXRwY95ayahCSr5OU6FwpJqmXC
         ayxT8k/ocYvqw==
Received: by mail-ed1-f70.google.com with SMTP id x22-20020a05640226d600b0041380e16645so4521562edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 04:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ro6EmjNQtTARcIDRl9rR+ZuulwNuQEnHoOGAjteVwBA=;
        b=T0YohBnYEnv6DN/ku83J6+4uiHdjQsfwq2arh9k+Zot0wJBNikkiZ5p/vmnmjkGvIH
         lh2QRTHqLOaiUiSdHHIl5ppZDJpYe464ZpFRGUs2R5/4qqb4FvcBjI/SJHhhQHFcgP+u
         O1jtAIEPYlHljp2UnxmIs0kp5Syjss4MUM0ELmTbQTz5bPyvlATSJEfsY/hChRMz/TAN
         G48OnlrALSWJLBihCJkCXfmM7kZTDrNyTYrs8sPyZxqUXMWZkI7qBbzbhaNuqD/9sMGy
         qESLUqouYa/UJKKWfYDvVi2zqjOAByg6rzRTFdKij31FNtnlenAaFIR4Le21F6HSnr0F
         s5cg==
X-Gm-Message-State: AOAM531A9iqCtAH4CaiqMxjuSuA/suaGI7FlpHELLTj2CKYOxfeBSwkL
        A2PL/pRT3rgGozpBKADvRvsi9Z7VEq7yLOL4QjoZAHeywGWubnMUjUIE7q9kiYL43y+jYnP1rVt
        X0gTyFwTcKu7RijI+JAWrEdrQ7bNuIT4txUyLuN1R+w==
X-Received: by 2002:a17:907:da6:b0:6d6:f8ce:e03 with SMTP id go38-20020a1709070da600b006d6f8ce0e03mr13707466ejc.516.1646396704530;
        Fri, 04 Mar 2022 04:25:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9E5PWp+lrl3OL2lDlQRole/yVnG6bMeI2HXzqoiizpGaQQxWBjhH2J8aOcejstMV3oomogg==
X-Received: by 2002:a17:907:da6:b0:6d6:f8ce:e03 with SMTP id go38-20020a1709070da600b006d6f8ce0e03mr13707446ejc.516.1646396704377;
        Fri, 04 Mar 2022 04:25:04 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7da17000000b00415a1431488sm2047368eds.4.2022.03.04.04.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 04:25:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: exynos: add a specific compatible to MCT
Date:   Fri,  4 Mar 2022 13:24:23 +0100
Message-Id: <20220304122424.307885-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304122424.307885-1-krzysztof.kozlowski@canonical.com>
References: <20220304122424.307885-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One compatible is used for the Multi-Core Timer on most of the Samsung
Exynos SoCs, which is correct but not specific enough.  These MCT blocks
have different number of interrupts, so add a second specific
compatible to Exynos5433 and Exynos850.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 3 ++-
 arch/arm64/boot/dts/exynos/exynos850.dtsi  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 661567d2dd7a..017ccc2f4650 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -806,7 +806,8 @@ tmu_isp: tmu@1007c000 {
 		};
 
 		timer@101c0000 {
-			compatible = "samsung,exynos4210-mct";
+			compatible = "samsung,exynos5433-mct",
+				     "samsung,exynos4210-mct";
 			reg = <0x101c0000 0x800>;
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index d1700e96fee2..12f7ddc6fd0a 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -181,7 +181,8 @@ chipid@10000000 {
 		};
 
 		timer@10040000 {
-			compatible = "samsung,exynos4210-mct";
+			compatible = "samsung,exynos850-mct",
+				     "samsung,exynos4210-mct";
 			reg = <0x10040000 0x800>;
 			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.32.0

