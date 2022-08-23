Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B586C59D239
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbiHWHaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240956AbiHWHaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:30:14 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B647562A93
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:30:12 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x10so12709602ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=31EpOHbl+nrYiysahic+51blRSoZd90XSQRkgmuZH8Q=;
        b=L3txLJbzNASJ23txY0RNdj71aCCiDk/ZgPs0vd6IuBr9Jv6qjFsL+DguB2evwx37e7
         qo4/+MYuYGWPNLgSL57Rm2eeWZ0HZ679AAcpgNEiFasaUq9yWOO1vzzYHiv66AA+BpOR
         q3iJj0TRj0U6/9X3QnNeitZxTTQebAAcJncBbhkUsEraYO3eM+aSY59qlihVBwx5nzOk
         94AX7APlauoQ9znqABTxQg9Mzq4dUkgFtJPUmGf9CWyI/yxlEgcUxsz7IB/MJMoz6HFj
         /mKsPjjmnBKxWQr7rHvftyc/piBxizSgIumInoNChwp9dy3mD42mvjbK8o5G6lpeATl2
         UL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=31EpOHbl+nrYiysahic+51blRSoZd90XSQRkgmuZH8Q=;
        b=jko+iADFkDNyVla2CuqrumCQjDaf2sxTPxsKgIddW0GXUOu+p3/mozcCIqjlYbsjBg
         wuB94/B1JQkBLANcxK2pqPc3R6dCvE/zofYQAgZ3BRx1SDIgQwFJWc07O3uh0ECNiXLE
         ls1bRzoRhAGvcqhzjrvYMBVI6Y1mQu4OXOmJyC/Qr+4KG9Qvk04aRF+UY92jToPJTkjV
         qgVV37RPJuzf7f+3EEXyOXX3UjOP0QDn7lCdxwofqDPZBTxMI1ophxogv5hi90nhVh0j
         Gb/lCPZRKDbF0DTE8baoywSlUKl8fKSR77+IdmdhKicNtT9GCo2H/9heNDKh8xG1wuoz
         7TbQ==
X-Gm-Message-State: ACgBeo3v5CNknklaloBkRO5saiYPXZdbtfQC3+PIV9TXXpRr2jwylG9p
        mn29WZs39YZWXiBfMSOkz95Ijw==
X-Google-Smtp-Source: AA6agR7UsstB+zMX2Ji4pK97oKYfHBo72sTQaY6/pQpWOeEaDcMW0YiVsuF5zXcBH40oxBMg2GQp0A==
X-Received: by 2002:a2e:a593:0:b0:25f:e6ac:c28e with SMTP id m19-20020a2ea593000000b0025fe6acc28emr7003949ljp.485.1661239811099;
        Tue, 23 Aug 2022 00:30:11 -0700 (PDT)
Received: from krzk-bin.. (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b0048a7ef09b22sm2361230lfr.274.2022.08.23.00.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:30:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: exynos: Add SysMMU nodes for Exynos850
Date:   Tue, 23 Aug 2022 10:30:06 +0300
Message-Id: <20220823073006.358764-1-krzysztof.kozlowski@linaro.org>
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

From: Sam Protsenko <semen.protsenko@linaro.org>

Add all SysMMU nodes to Exynos850 SoC device tree.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220809113323.29965-10-semen.protsenko@linaro.org
---
 arch/arm64/boot/dts/exynos/exynos850.dtsi | 45 +++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index 8e78b50416d8..c61441f3a89a 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -503,6 +503,51 @@ i2c_6: i2c@13890000 {
 			status = "disabled";
 		};
 
+		sysmmu_mfcmscl: sysmmu@12c50000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x12c50000 0x9000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "sysmmu";
+			clocks = <&cmu_mfcmscl CLK_GOUT_MFCMSCL_SYSMMU_CLK>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_dpu: sysmmu@130c0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x130c0000 0x9000>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "sysmmu";
+			clocks = <&cmu_dpu CLK_GOUT_DPU_SMMU_CLK>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_is0: sysmmu@14550000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x14550000 0x9000>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "sysmmu";
+			clocks = <&cmu_is CLK_GOUT_IS_SYSMMU_IS0_CLK>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_is1: sysmmu@14570000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x14570000 0x9000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "sysmmu";
+			clocks = <&cmu_is CLK_GOUT_IS_SYSMMU_IS1_CLK>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_aud: sysmmu@14850000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x14850000 0x9000>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "sysmmu";
+			clocks = <&cmu_aud CLK_GOUT_AUD_SYSMMU_CLK>;
+			#iommu-cells = <0>;
+		};
+
 		sysreg_peri: syscon@10020000 {
 			compatible = "samsung,exynos850-sysreg", "syscon";
 			reg = <0x10020000 0x10000>;
-- 
2.34.1

