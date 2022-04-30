Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1748B515CCE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356184AbiD3MWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 08:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353389AbiD3MWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:22:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8382670
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 05:19:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y3so19908300ejo.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YA95cmLs9HBsY5LdKnVl3A/xf0998I/bRtENwU6KXBY=;
        b=jjjMkcBCoWHRhZIM4y0A/RpoRPkOVRFlSfQyQUJ+PNYbYk1MrxyWgkEblb6Jk+9y/B
         9zH5MfrrcZHgjnSE5PcP+/j6u4BwqVRQ39/rpLfaCuqOpPo2hDMCpLnM92GbLweeM4Z/
         hZeNQ7MuHpD4xJbFD6JfFescllYjro05cxv/YWijjPaFK7VvQbay9MLC3liHva4bolqa
         3Q0hIgNomNmPlaBpOca3kVUEjv/d6MDPtPZRm09RFWy/F7Y1qVVIet9g2AYsWCN3AJ1Z
         UM4IhPg1eW8P8H6VeuH/d/6t9XXX/JlOB0NDIs2/aZju2cfdUpojxOmWaHeRLu7AggNI
         yS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YA95cmLs9HBsY5LdKnVl3A/xf0998I/bRtENwU6KXBY=;
        b=f9QIaWLh8PTwdgxGrtA3yoX/eU3cbiRehWBAqkB/uGW5+ASfh30vWdu/dj1sbfKRIs
         elMlAcL6/yV6MIOk8Au/TfAcXBL7oiUhDApUBhrNRFkjDr3+X+o3Xtyc8kHsylN4P2Sw
         56vsEA7liuBLo0QL0+5PDlW6rIfpmL1vsOJ+2AiAEOWNPaPh2VhcebMyXFrc+ysExb2u
         5u1MaSHIOuJwug7fyJfLIgkkw9EqdDi5LBUDnzv53PZnE+KjMHvf7bRdqZfcMkKuhgZ/
         RRAPViFt0Ay8OmTLf4h225JMYCCE0knjDHTAByhLRg3aEPLVR/SCj8NsHJG8eAisCh/k
         nblQ==
X-Gm-Message-State: AOAM530y7SGVP2nztKkHzA0OqSYzq2pa2EnzZs9APLtIR21J9bx8th6n
        0s6Rk3xkf582jTCPCnsIK6uvFg==
X-Google-Smtp-Source: ABdhPJxNfQBhNV0VJwNOcI8JD5QVzijRk8NMFXCsaGhRCYT+IP+WhtdkxmjE2d+b0WfV2zK8BvDt4g==
X-Received: by 2002:a17:907:1c0d:b0:6f3:b742:ef56 with SMTP id nc13-20020a1709071c0d00b006f3b742ef56mr3685842ejc.504.1651321151497;
        Sat, 30 Apr 2022 05:19:11 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c26-20020a056402159a00b0042617ba63d1sm4059091edv.91.2022.04.30.05.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 05:19:11 -0700 (PDT)
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
Subject: [PATCH v2 2/9] ARM: dts: socfpga: drop useless 'dma-channels/requests' properties
Date:   Sat, 30 Apr 2022 14:18:55 +0200
Message-Id: <20220430121902.59895-3-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/socfpga.dtsi         | 2 --
 arch/arm/boot/dts/socfpga_arria10.dtsi | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index b8c5dd7860cb..bfaef45bdd04 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -80,8 +80,6 @@ pdma: pdma@ffe01000 {
 					     <0 110 4>,
 					     <0 111 4>;
 				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
 				clocks = <&l4_main_clk>;
 				clock-names = "apb_pclk";
 				resets = <&rst DMA_RESET>;
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index f1e50d2e623a..26bda2557fe8 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -73,8 +73,6 @@ pdma: pdma@ffda1000 {
 					     <0 90 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 91 IRQ_TYPE_LEVEL_HIGH>;
 				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
 				clocks = <&l4_main_clk>;
 				clock-names = "apb_pclk";
 				resets = <&rst DMA_RESET>, <&rst DMA_OCP_RESET>;
-- 
2.32.0

