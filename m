Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EF0515CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379251AbiD3MX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 08:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376280AbiD3MWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:22:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F353141637
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 05:19:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k23so19985113ejd.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9PrzlAjGmNeSX2t/TXGPbZCFJ6ftTzqZDscsydnon9s=;
        b=i/irFdjzBJgh54tgZ4//X6S0mWafLpwsgehVEM7BwkPqnDg9OvKTJ6dgosnzJF+rXF
         luGhopmRV6H54GMguL3OvUGPWeQTKbAK+DO4Z+qBCXof1beTo2VDFKZn/jsJ7UfxJOdB
         MWlcE+FxSFpcKb5Ldpf+JoelJ44BrUzi2wZGKp2Pv/A9SBs69PfOOTvfnN8/iYg2u3kh
         4z6gkHL3A4KbssQgMsuY/4Co6VJhZ4CFlNIKIP72e5bw6SjKo5qeBH1l1ICzcADaLj2F
         F+KS1sMCAruli5SPTjxgagHILCjRLsoosC7mFKYEAFq7AofXdHiLDJa2gtX/iTLPH+Js
         RMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9PrzlAjGmNeSX2t/TXGPbZCFJ6ftTzqZDscsydnon9s=;
        b=qOjri53IqXjtEFqbiMsFgEozzoH7XyKK9YGQ3nO1EcCMMkaZRdowb1xFmEWX3KNaQ/
         En6wfgz48n41vSJ3CCngLl3y4H58omEoG9N6Vd6fuiXMufTtuAuZZ5Ga6IV29FLHuOns
         WF9qlVS5dyyuMdMFxlRoKI/sWNJoyGUf2+zkARkUZ9zJRq1jbL8GN1nYJ+oxZgAVjiU8
         u7B37Y7jXFSO41/lz3ApTe530nCiU8yatmeWyddHM4JPmydl88BW3nuThEtDxtvenOwR
         i391aXsOGDx8c9yWDXV9a1dJub6Fp1efDTxG2ync3DAs17gbZCNAB+V3Hs7wLJqRz+Ev
         I5pw==
X-Gm-Message-State: AOAM530GHmhSnR11hFbFr9qp+SlmA7FQF7fYyQ1fDq3ajkOUJvsGU9YC
        4TSNHwwGZUe6edxCB3Rtvkr7Gg==
X-Google-Smtp-Source: ABdhPJy1iVrG4EYBeYhtmduhXaSa9bjJ6gFExbQgPOoPqYmL7ybmkMBOA4DSedXZgdWFWOvpViLMUQ==
X-Received: by 2002:a17:907:3e0e:b0:6f3:845a:8d2d with SMTP id hp14-20020a1709073e0e00b006f3845a8d2dmr3770364ejc.78.1651321159572;
        Sat, 30 Apr 2022 05:19:19 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c26-20020a056402159a00b0042617ba63d1sm4059091edv.91.2022.04.30.05.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 05:19:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
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
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 9/9] arm64: dts: fsd: drop useless 'dma-channels/requests' properties
Date:   Sat, 30 Apr 2022 14:19:02 +0200
Message-Id: <20220430121902.59895-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220430121902.59895-1-krzysztof.kozlowski@linaro.org>
References: <20220430121902.59895-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pl330 DMA controller provides number of DMA channels and requests
through its registers, so duplicating this information (with a chance of
mistakes) in DTS is pointless.  Additionally the DTS used always wrong
property names which causes DT schema check failures - the bindings
documented 'dma-channels' and 'dma-requests' properties without leading
hash sign.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/tesla/fsd.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 10c217a57a7d..af39655331de 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -432,8 +432,6 @@ mdma0: dma-controller@10100000 {
 			reg = <0x0 0x10100000 0x0 0x1000>;
 			interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
 			clocks = <&clock_imem IMEM_DMA0_IPCLKPORT_ACLK>;
 			clock-names = "apb_pclk";
 			iommus = <&smmu_imem 0x800 0x0>;
@@ -444,8 +442,6 @@ mdma1: dma-controller@10110000 {
 			reg = <0x0 0x10110000 0x0 0x1000>;
 			interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
 			clocks = <&clock_imem IMEM_DMA1_IPCLKPORT_ACLK>;
 			clock-names = "apb_pclk";
 			iommus = <&smmu_imem 0x801 0x0>;
@@ -456,8 +452,6 @@ pdma0: dma-controller@14280000 {
 			reg = <0x0 0x14280000 0x0 0x1000>;
 			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
 			clocks = <&clock_peric PERIC_DMA0_IPCLKPORT_ACLK>;
 			clock-names = "apb_pclk";
 			iommus = <&smmu_peric 0x2 0x0>;
@@ -468,8 +462,6 @@ pdma1: dma-controller@14290000 {
 			reg = <0x0 0x14290000 0x0 0x1000>;
 			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
 			clocks = <&clock_peric PERIC_DMA1_IPCLKPORT_ACLK>;
 			clock-names = "apb_pclk";
 			iommus = <&smmu_peric 0x1 0x0>;
-- 
2.32.0

