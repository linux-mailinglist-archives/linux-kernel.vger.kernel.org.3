Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF6051211E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbiD0QDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241197AbiD0QCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:02:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB001869E8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:59:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a1so2479454edt.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=63VeYgzArcJTAJPbGvfo3jR2495WIely7Cl6nb2vvt4=;
        b=ptUeoIdrGVpAlxgfm3SHHA/2ZZYRkB1tr41w4xLCIFu+v1tBxUR8EKRrA22d3aqLFK
         lHkr2M/0Ek9Gxz9mNDmxnyddPkTpB0zAwH4h5WgmXXPWVRvQzP+bn3PGIy+1ttDo0NHu
         6NpRv8nG57JtjPD5P/mxp2lYiGubwu1ugphT9FhhFJ+WUkkD3uwEFdK4rsIESN+SaZVj
         mTXG08wUSyIs9KZopuUHhutWfHyGXi6kU7sWj/yfWgVFoT8Nsb6mpPSq7qoHEhrgVsvR
         g/sBCyVF7QRkcvnpuYXY7h2qhmhqKqeK/RnhXz1Ut2JLcG4G7XudGpe2wrMMhvb7mCfp
         STxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=63VeYgzArcJTAJPbGvfo3jR2495WIely7Cl6nb2vvt4=;
        b=uO+PoqaM3hfY1lCkJGd3bTwyH9a6nWOkUpsNeOXYOjS8sZrczVjvW96DhtxxjGZur7
         Z5AZTFmbdihiWRczCZ/ANaj+JfttXAio7/DyBB3C1Nbmgsum86ez7k9VTFc9r9Utow8E
         XcmJOWxxYUWamwCL6iXCd0JwfnXx2goe8vbIsqnAP9eYeM/XVnQ1mgfYfAMIKIBFxoYt
         Kut1mnoMoTNRsykl4RADI68bNcz/jchSBjs5lcMvdMijINDcf9l4kUoNEI44G/BgB46w
         SpN6S3Yjz1ZcWqOeVuATUEkX8DySQKw7TZK/ytE2d9D5cpZdhJxlV2wYf0FxBR2dxT8b
         hRQA==
X-Gm-Message-State: AOAM530XcZ/f1hH45csS5dK/t84VlzIQpji55ly1ZcSx3x/t4b08rlrJ
        MctO/7pDmc9NkjawGNFezO2INQ==
X-Google-Smtp-Source: ABdhPJzy/efEMnS4dAAty/FMYgqViLiv7F+JrXcmW96LxbDzDhkVE0m0Uv5c16HuMio/TX6Np4dhZA==
X-Received: by 2002:a05:6402:524e:b0:423:e919:8eb4 with SMTP id t14-20020a056402524e00b00423e9198eb4mr31487595edd.153.1651075140245;
        Wed, 27 Apr 2022 08:59:00 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm6931993eje.183.2022.04.27.08.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:58:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 09/10] arm64: dts: exynos: use proper 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 17:58:39 +0200
Message-Id: <20220427155840.596535-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pl330 DMA controller bindings documented 'dma-channels' and
'dma-requests' properties (without leading hash sign), so fix the DTS to
match the bindings.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 12 ++++++------
 arch/arm64/boot/dts/exynos/exynos7.dtsi    |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 017ccc2f4650..91e82e4283b2 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1866,8 +1866,8 @@ pdma0: dma-controller@15610000 {
 			clocks = <&cmu_fsys CLK_PDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		pdma1: dma-controller@15600000 {
@@ -1877,8 +1877,8 @@ pdma1: dma-controller@15600000 {
 			clocks = <&cmu_fsys CLK_PDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		audio-subsystem@11400000 {
@@ -1898,8 +1898,8 @@ adma: dma-controller@11420000 {
 				clocks = <&cmu_aud CLK_ACLK_DMAC>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
+				dma-channels = <8>;
+				dma-requests = <32>;
 				power-domains = <&pd_aud>;
 			};
 
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index e38bb02a2152..c31534771620 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -149,8 +149,8 @@ pdma0: dma-controller@10e10000 {
 			clocks = <&clock_fsys0 ACLK_PDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		pdma1: dma-controller@10eb0000 {
@@ -160,8 +160,8 @@ pdma1: dma-controller@10eb0000 {
 			clocks = <&clock_fsys0 ACLK_PDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		clock_topc: clock-controller@10570000 {
-- 
2.32.0

