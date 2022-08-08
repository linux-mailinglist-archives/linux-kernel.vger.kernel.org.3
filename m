Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA5B58CF03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244218AbiHHURe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244031AbiHHUR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:17:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A50E1A3B5
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:17:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso20776wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Q1IvuqZCql+9A8pHcbxWkSw01AqXYXJWClm+TmLFvpw=;
        b=UJQ9OpPgQpDZz3xq6tsj6pEvBia7xFPyTrAv0fW2vxR9X+I3hZHdrKiA6n/ft3vS7m
         EUY/qHbICxrG0mpm0kXD0BK7hIdLaRHeNtXaLwt0hr5hSjbFkM7YbgsWFyP61y0E8zPw
         hPBeApCD+4lvr32N3bTjRtBpPfSIw6LMLmexobWCqTMM49j28UAKBL2x6FA93rk2U0b2
         GijJANUGoZQvHC5ReIxmA8IdTffZ+kHl+Q5LdxQAHwxCqQnuRQZA7JcHEx0NrwNIgZL3
         iRrZF02WcPuMeUndSeAq+/r9+OtjbjW/0Lla7vuM/Nt82pqzam+b71hSi7e9Amy5Jwc+
         L19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Q1IvuqZCql+9A8pHcbxWkSw01AqXYXJWClm+TmLFvpw=;
        b=wUeG5MUF9Gl8yPGvdB1JGL8M0y8Ux3YgTSL/A6oLK3sP+z50oyNxF0enYFNDch0e7b
         a7kwFZE3afwEfig4OF1lZDXCXITQnQUIbjRZDx3vX7SQQ9OSb3ElBsTtP1A04rq0Zz7r
         qqvlIuFN78zSBgQv1cON1PAitCjzVYOOAuOVXXvN3x86EGp8EFQckPPrHcpwVd4/B1/j
         ynVqsaSvurgT2FKOcfI/brF7xImCKdr4xOunKesFOzrvwRJhDmS7oTfzTkxel/h8nHcV
         zZVj16Nb/SywH5UQ9Zrsp3rPascZKLqD3xKBq4eFUSvhGNIMWWeGEFYgNV35G1NgWkYG
         9MqA==
X-Gm-Message-State: ACgBeo3k72z1Qc7tcGhc1JRJd2cBR+6LjZDva9yivyyuO8HPCMnlFQDB
        r7XKFex5Rgew9ALsen91qKSOJg==
X-Google-Smtp-Source: AA6agR7+YxNoNmnEdpS/HV2rm9vcWQ7tOQemFeGEYjlKwigN1Uo1IIZ6M9cuWYqDlqO1B+IZCGWMPw==
X-Received: by 2002:a05:600c:4196:b0:3a5:3da4:ef78 with SMTP id p22-20020a05600c419600b003a53da4ef78mr4888750wmh.156.1659989847194;
        Mon, 08 Aug 2022 13:17:27 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id w15-20020adfec4f000000b0021e6b62fde2sm11894480wrn.59.2022.08.08.13.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 13:17:26 -0700 (PDT)
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
Subject: [PATCH 1/2] arm64: dts: exynos: Add CMU_AUD, CMU_IS and CMU_MFCMSCL for Exynos850
Date:   Mon,  8 Aug 2022 23:17:23 +0300
Message-Id: <20220808201724.27831-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220808201724.27831-1-semen.protsenko@linaro.org>
References: <20220808201724.27831-1-semen.protsenko@linaro.org>
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

Add missing clock domains to Exynos850 SoC device tree.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos850.dtsi | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index 9076afd4bb3e..8e78b50416d8 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -286,6 +286,21 @@ cmu_top: clock-controller@120e0000 {
 			clock-names = "oscclk";
 		};
 
+		cmu_mfcmscl: clock-controller@12c00000 {
+			compatible = "samsung,exynos850-cmu-mfcmscl";
+			reg = <0x12c00000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>,
+				 <&cmu_top CLK_DOUT_MFCMSCL_MFC>,
+				 <&cmu_top CLK_DOUT_MFCMSCL_M2M>,
+				 <&cmu_top CLK_DOUT_MFCMSCL_MCSC>,
+				 <&cmu_top CLK_DOUT_MFCMSCL_JPEG>;
+			clock-names = "oscclk", "dout_mfcmscl_mfc",
+				      "dout_mfcmscl_m2m", "dout_mfcmscl_mcsc",
+				      "dout_mfcmscl_jpeg";
+		};
+
 		cmu_dpu: clock-controller@13000000 {
 			compatible = "samsung,exynos850-cmu-dpu";
 			reg = <0x13000000 0x8000>;
@@ -308,6 +323,29 @@ cmu_hsi: clock-controller@13400000 {
 				      "dout_hsi_mmc_card", "dout_hsi_usb20drd";
 		};
 
+		cmu_is: clock-controller@14500000 {
+			compatible = "samsung,exynos850-cmu-is";
+			reg = <0x14500000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>,
+				 <&cmu_top CLK_DOUT_IS_BUS>,
+				 <&cmu_top CLK_DOUT_IS_ITP>,
+				 <&cmu_top CLK_DOUT_IS_VRA>,
+				 <&cmu_top CLK_DOUT_IS_GDC>;
+			clock-names = "oscclk", "dout_is_bus", "dout_is_itp",
+				      "dout_is_vra", "dout_is_gdc";
+		};
+
+		cmu_aud: clock-controller@14a00000 {
+			compatible = "samsung,exynos850-cmu-aud";
+			reg = <0x14a00000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>, <&cmu_top CLK_DOUT_AUD>;
+			clock-names = "oscclk", "dout_aud";
+		};
+
 		pinctrl_alive: pinctrl@11850000 {
 			compatible = "samsung,exynos850-pinctrl";
 			reg = <0x11850000 0x1000>;
-- 
2.30.2

