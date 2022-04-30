Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3039A515CCB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359002AbiD3MWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 08:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355055AbiD3MWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:22:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCE333E93
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 05:19:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t5so1186549edw.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5kf3y2M7fy8iPzpUwHWQL83aZ36k2Uw1ck+FQf0ju8=;
        b=AFP6mba/7P9HcbJqFT7v0yz7OS9fTLfs2qGRSUDRTTc0IUFlzm8WApVcajerOLqZpb
         4O0WM1rMPlfF0CjUlxALNLVboKFCe9t+HEjrVq9Nzjo27SEWSXPDoqbIlGZRXTemMang
         4jX+wI5gEl3Rz1FtGQwke7bA1NdwOK4vJWGsv6KSyLxeurgrCI+n4fmdOpzbEFLsusOJ
         wEUKOZ6ya5WHdOsr5/gZXQTIU8ldyM+BgD2JXsEj8Iu41pT4Nz/RY6ZnQgahuzM0HCeo
         UprogZYE3B8/tQrUAFKHmpqJ9joSIQGl/BUCkn3uFR2uFLQt9b2+GQyKMhrBpB9O6Goh
         +8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5kf3y2M7fy8iPzpUwHWQL83aZ36k2Uw1ck+FQf0ju8=;
        b=ntTB2K9GOVU20rPehaTK4C3QWWUtEgKHidyVcRDxUU4AcAux7UtspyvEc5y0AGIvd6
         +/kBisvympH94dAY9FclH28ojqWiHQKrf+Vj5dExSspVUjNjr3gXyBHEgLDQW+0a+irw
         zFxhvNm5kW5BCQRZSNxRqp9pohNVwa3/PVO23kJilAquvZk+GPdElI3esSXskG4lQZ6n
         CoWCcQjKZwM2Rvm9joRPcYbzxIu563xRUUq79ccsXVFahEhEY2wkMNjfjynuAEhVQ5+C
         nrVugxX4v8N8MLcdSbK51G43u3ngoLrbYsPLBgUlHHEmgJvks67vn9UQ6nl21xU0XrrP
         O0IQ==
X-Gm-Message-State: AOAM532xN2/3Wlzer6zXSkTUZt0URw4xHmbeQF48P8LNuA/hfN/uLLDD
        ovSNdGDWWbcckQc9VIX7ilcdNw==
X-Google-Smtp-Source: ABdhPJxtWWrrtZbl39jx7xyI9RksIBurQ9DcfP+anq2xMaGPQkQ0yTyW8lJ3p10615dHqYj8q07/pg==
X-Received: by 2002:a05:6402:1908:b0:426:30d3:7e1f with SMTP id e8-20020a056402190800b0042630d37e1fmr4139168edz.174.1651321152591;
        Sat, 30 Apr 2022 05:19:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c26-20020a056402159a00b0042617ba63d1sm4059091edv.91.2022.04.30.05.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 05:19:12 -0700 (PDT)
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
Subject: [PATCH v2 3/9] arm64: dts: stratix10/agilex: drop useless 'dma-channels/requests' properties
Date:   Sat, 30 Apr 2022 14:18:56 +0200
Message-Id: <20220430121902.59895-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220430121902.59895-1-krzysztof.kozlowski@linaro.org>
References: <20220430121902.59895-1-krzysztof.kozlowski@linaro.org>
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

The pl330 DMA controller provides number of DMA channels and requests
through its registers, so duplicating this information (with a chance of
mistakes) in DTS is pointless.  Additionally the DTS used always wrong
property names which causes DT schema check failures - the bindings
documented 'dma-channels' and 'dma-requests' properties without leading
hash sign.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 2 --
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 884bda106399..aa2bba75265f 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -346,8 +346,6 @@ pdma: dma-controller@ffda0000 {
 				     <0 88 4>,
 				     <0 89 4>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
 			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
 			clock-names = "apb_pclk";
 			resets = <&rst DMA_RESET>, <&rst DMA_OCP_RESET>;
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index c78371703e76..caccb0334ada 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -350,8 +350,6 @@ pdma: dma-controller@ffda0000 {
 				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
 			resets = <&rst DMA_RESET>, <&rst DMA_OCP_RESET>;
 			reset-names = "dma", "dma-ocp";
 			clocks = <&clkmgr AGILEX_L4_MAIN_CLK>;
-- 
2.32.0

