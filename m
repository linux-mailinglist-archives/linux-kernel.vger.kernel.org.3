Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9442058CF04
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244244AbiHHURn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244134AbiHHURb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:17:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9E71A800
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:17:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p10so12072747wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 13:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+dc2Wr5R8DkIR7Sm+I5+T7mhvoBamdjHee3gcWWSuJo=;
        b=uabJrolrTPyF1qLICQ8TpBepRoWYZnlEAhQgFjivjeMzBVzfD93dk6u6l8O2xkJVHQ
         4RGVeoNcpPWfyHL+mbwcYM4R3BT+evvCv3E/f0UKOQKmzTi0bZZQ0TmodcOsKf09S3sp
         loVX0/zXg1eJcZaO2wvA4/V/DlTtrxPP9U73KmgeOr4TElRHAuJmEdWA1Y9sSs4mOK5L
         LD6mtxQfeHX7W7n6PDQB+c7Qx5bHiS9SIf9Ky/bIe7F5AyyR0xS94kQbPSeneY5PqxJS
         v7BfapRw+gr31Zdw8wcbwZHbVrAQHtowq623som7SWXlSgpT9r++LAXsUeG4vULA15rt
         +Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+dc2Wr5R8DkIR7Sm+I5+T7mhvoBamdjHee3gcWWSuJo=;
        b=B5rDLcNSCYCERRBK+n/QUwuKNSNT5RUNL3Ht57jVcDRSRuDWFlmv4TzFp2QiDDYAIM
         1qyJX/bEn9313xtXvuuo42/CHi57H+DJFRu2GaxBTCn0HcUQm3f9I4V+xIK2dgKYGf4n
         EH2XECeE7vsrDGmES/8ip9ZBQXAhmH1jvsu26FfNGllHSTnlkNl5XmeVMaYkmVT4n4u2
         ghggCTZnDQyJSPNV1hqTa/TBLKhQSPx4Jsx7pBD9OVS1Fnc8pNFkZYlitTwnzebIqjBh
         pp0M+CHXTQtyUyKiIqGd5XfsdSQB26GjjgV3K1kd2gY9WLpJ20mPjViR0l52WFhr3Qvm
         6rhQ==
X-Gm-Message-State: ACgBeo2sxBiebyQIBzMIQCbw6hPyikCap4OcOJyibAbiRkiOi7SdM2uW
        TzykYXRFVHUMMLIyoZb8MDHmjw==
X-Google-Smtp-Source: AA6agR4El7NQSSoWoZfNjns26MLZnLRuSF49GPdQbZYqrN61O2+SXmNc/xvHVZO+ufi4KB42EnCdJA==
X-Received: by 2002:a5d:6d0e:0:b0:21e:fc95:3dfc with SMTP id e14-20020a5d6d0e000000b0021efc953dfcmr12458195wrq.112.1659989848614;
        Mon, 08 Aug 2022 13:17:28 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id j20-20020adfd214000000b0021ec32d130asm11868629wrh.74.2022.08.08.13.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 13:17:28 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: exynos: Add SysMMU nodes for Exynos850
Date:   Mon,  8 Aug 2022 23:17:24 +0300
Message-Id: <20220808201724.27831-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220808201724.27831-1-semen.protsenko@linaro.org>
References: <20220808201724.27831-1-semen.protsenko@linaro.org>
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

Add all SysMMU nodes to Exynos850 SoC device tree.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos850.dtsi | 45 +++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index 8e78b50416d8..4204a443ea4a 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -503,6 +503,51 @@ i2c_6: i2c@13890000 {
 			status = "disabled";
 		};
 
+		sysmmu_aud: sysmmu@14850000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x14850000 0x9000>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "sysmmu";
+			clocks = <&cmu_aud CLK_GOUT_AUD_SYSMMU_CLK>;
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
+		sysmmu_mfcmscl: sysmmu@12c50000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x12c50000 0x9000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "sysmmu";
+			clocks = <&cmu_mfcmscl CLK_GOUT_MFCMSCL_SYSMMU_CLK>;
+			#iommu-cells = <0>;
+		};
+
 		sysreg_peri: syscon@10020000 {
 			compatible = "samsung,exynos850-sysreg", "syscon";
 			reg = <0x10020000 0x10000>;
-- 
2.30.2

