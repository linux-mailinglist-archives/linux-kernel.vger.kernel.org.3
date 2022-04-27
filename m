Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CD451208B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbiD0QC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbiD0QCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:02:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540711A431E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:59:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a1so2479523edt.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=76W1cUhpVZ4S1kk1owDY4fNBWLgNIFgf8c4KyIt+188=;
        b=crGsQu75U2P+YiYm4OLO1RAMBFX+JBucI6Hse1p27B8vuZvTO1eDpVf3XiMTYBL7wf
         suuQgktoE/OB+Eo1RxJWXW1Bl9Uob8kZWOpCLMnAbbqLejmphreCc5bL+sccVJUfOKY0
         k77Hn91bAWF/nAUpynIHeo8Z1wtghV35s2Ua4NNuWhpGFKWeTy+8lw1PP8X9eXN9vhGt
         gWiaHW2XSZBD2+je5N3YWDyJihxaFCz1JZhj1s0Fh2xeuP6j+j5erROZLMHqF3RiCCNS
         aGKIlmFEX/BcDxzSyLq+r8+hTKDVT6zBUHk+83NXUz/8vq59DaqiwpJiRqwS8Fepgnm1
         0NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76W1cUhpVZ4S1kk1owDY4fNBWLgNIFgf8c4KyIt+188=;
        b=4dN0GqXB2ee9YqQh5ZlXlArUY8DqtdjMJHkh/aTrYO51KCk5BzEM+uytNmwWr1Gjgh
         kGwOtbF652CuqKCK8fUi8a2xKbRsRV1+JCph3nlHCBrb41ilwlKXsuZaKuZ0SrImt1bk
         gP/34hZHHPjvmRt2oxFmyZB0jw7UyMHPbuV0/fdCcRY61UtmB3LD7xUvcL9thY1Jjv8B
         VEb8FMwG3W1+4sM4sIroribqxO61e91l/VYCqoc8kNNycf+CcZKJs9nmWxeHb95GMmml
         LxpoEBLklRLfuObnlZtLzSUHpcwTvh0Mh9DC4BWU7VHGjyWixEdG2PickpbcE/cdggkF
         hTmA==
X-Gm-Message-State: AOAM531TFSRTIjk3nqFdBgdoUkVDVa8obSTHJkFopa7UbdQoxt5W5WQo
        WXfbScFUXxjjF1OzRAGUUM34XQ==
X-Google-Smtp-Source: ABdhPJykwglLB5mxEF++h8AEZRS2tUiHCIGL3J/BB834XWnFYca4p+5vl3EQBBArh/CVlfSqzcAmJw==
X-Received: by 2002:a50:9e61:0:b0:419:d8e5:6236 with SMTP id z88-20020a509e61000000b00419d8e56236mr31130749ede.327.1651075141506;
        Wed, 27 Apr 2022 08:59:01 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm6931993eje.183.2022.04.27.08.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:59:01 -0700 (PDT)
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
Subject: [PATCH 10/10] arm64: dts: fsd: use proper 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 17:58:40 +0200
Message-Id: <20220427155840.596535-11-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/tesla/fsd.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 10c217a57a7d..7fba37d860b2 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -432,8 +432,8 @@ mdma0: dma-controller@10100000 {
 			reg = <0x0 0x10100000 0x0 0x1000>;
 			interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 			clocks = <&clock_imem IMEM_DMA0_IPCLKPORT_ACLK>;
 			clock-names = "apb_pclk";
 			iommus = <&smmu_imem 0x800 0x0>;
@@ -444,8 +444,8 @@ mdma1: dma-controller@10110000 {
 			reg = <0x0 0x10110000 0x0 0x1000>;
 			interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 			clocks = <&clock_imem IMEM_DMA1_IPCLKPORT_ACLK>;
 			clock-names = "apb_pclk";
 			iommus = <&smmu_imem 0x801 0x0>;
@@ -456,8 +456,8 @@ pdma0: dma-controller@14280000 {
 			reg = <0x0 0x14280000 0x0 0x1000>;
 			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 			clocks = <&clock_peric PERIC_DMA0_IPCLKPORT_ACLK>;
 			clock-names = "apb_pclk";
 			iommus = <&smmu_peric 0x2 0x0>;
@@ -468,8 +468,8 @@ pdma1: dma-controller@14290000 {
 			reg = <0x0 0x14290000 0x0 0x1000>;
 			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 			clocks = <&clock_peric PERIC_DMA1_IPCLKPORT_ACLK>;
 			clock-names = "apb_pclk";
 			iommus = <&smmu_peric 0x1 0x0>;
-- 
2.32.0

