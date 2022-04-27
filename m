Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8C4511E03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbiD0QCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241175AbiD0QCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:02:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AE2169417
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:58:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y3so4275374ejo.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MKjLCUlOQvdpI7FmKAK8Um8s2AvYcZEoiKQJO1h/+7Q=;
        b=jV5dkMpL8DMNsYEhimDMDFrNviKnXilTKfixSFASCo7FkFdj5jGKav2rglWw4a0Tvg
         LdL1UChY18gfncekKP/RvUMVNuLSOgh6QrNa1QaBSp6pf0Zim0l+HcZJjCyBOHmul2Ik
         Nk1osJMnmiFIJQKsiu0wNjkQVzEtbLxZgT/n6WNcb0HW/v9b6qdDRgd8CVDiLUYPYbrr
         8caBZE18NXwy7djZkwvFTFAuVHWvVRWJaSejiCK2+RHaAIaUIqjUj6/wOfTyvfngOBGt
         01HlL52fAZjRraOEeBGMxlZpvac5ew/gNZ92WVOyfLFCjhErySkyMk6M799fuOaOopOA
         3qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MKjLCUlOQvdpI7FmKAK8Um8s2AvYcZEoiKQJO1h/+7Q=;
        b=7UIkcrUlta9ICPYgIuwuLfJo3E+Fc2vyXJD99Zg/6P8lKm7ZjHkN2vCRrRDqFovCVl
         +tWgwAnElhd/Ft+4ahCJlNfGj8JqlBPqFmQ07Dzd19cnLynw9Lv261WqNwNdSPJRa1OM
         FpgGzVeod6sLIHjxfK6MrAWnInGLZl2wwU4w69MBnVzWWUNbRJQwVs0PEMsIGXdI+/pR
         3cpjfsRqN0h5a2xkE2pIpUHg4bE1EfMybJoeXrap2fLNqYAE4+o8Lr17gVQ9oLrKHeBR
         51rlEuV7LIFWeT50N4fgYzMArRWR/KH8z1+UTGpHgPQMYeVqMvKDrD9ZQ+t9FmCKH2qI
         NaiA==
X-Gm-Message-State: AOAM530CaY6mHMtNomXRhIiHqT+fGDi8oQjrx1XlkWUP65Z0mAjwoow8
        Ts0S299BQUm663eQpBgy7C5TNw==
X-Google-Smtp-Source: ABdhPJwgDgUDyTITCSSTY6QkoaxRAdqwIx735kozAEcyj2uLvbYu824QguLZougmsAmYQRNxtRSZYA==
X-Received: by 2002:a17:907:6d22:b0:6f3:a9e5:d074 with SMTP id sa34-20020a1709076d2200b006f3a9e5d074mr10320453ejc.639.1651075132678;
        Wed, 27 Apr 2022 08:58:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm6931993eje.183.2022.04.27.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:58:52 -0700 (PDT)
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
Subject: [PATCH 05/10] arm64: dts: broadcom: use proper 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 17:58:35 +0200
Message-Id: <20220427155840.596535-6-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 4 ++--
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index f59fa3979a04..230ccb685be6 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -289,8 +289,8 @@ dma0: dma-controller@61360000 {
 				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 			clocks = <&iprocslow>;
 			clock-names = "apb_pclk";
 		};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 7f1b8efd0883..2a58c1b43f6f 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -556,8 +556,8 @@ dma0: dma-controller@310000 {
 				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 			clocks = <&hsls_div2_clk>;
 			clock-names = "apb_pclk";
 			iommus = <&smmu 0x6000 0x0000>;
-- 
2.32.0

