Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1999511EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241250AbiD0QCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbiD0QCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:02:23 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2C3163D0A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:58:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i27so4294099ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3dtCogE+SAcSJ5Db+VnZ4c0f5WnBEqvHUWyxz2QP74w=;
        b=Zm29Qnp/nmmh8p4d2DCNGi7rClqLQTnkfd+6NBizcIwYdr9cNb3c21woXy+2fIQVaK
         rSdRckr+k3QU9uU4WctQk9753Aky3NhKrnWQhhuQiWHcOOdTPKlr8RPYUIc3P14FSkDB
         d1q3ommRGAufKlK4BGWD1Gr6OSF6EpeyWsWSSgY0+6IiEvCyqTJYPMM1vf4gEHX7aG3A
         l8OFfCJ7WDSfkAOaiAQlDsV4JIHIqAwiIVporr++6HeZZQcYd2vYmidpb0FtaR7wDjIM
         MtWtRupdrG6Nv8y8GgPX8OZp5Hvv+whfhYosrJN2Krqx13lNoZ7pU2it1n8J/be7sMlQ
         m+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dtCogE+SAcSJ5Db+VnZ4c0f5WnBEqvHUWyxz2QP74w=;
        b=yoR3erqyISgrobq6A4lrhw+REkYD++nAXPJAdbqkE5f5HwLkNjd1/iP3rWm6hzGjep
         bSJBOi3Be5wBU8odRMk6ZC6aq9Zi3qd+x89Dci2wf/6Gb22/HK8FCEI/ueU3AhFE8mEC
         7Pa7opzM9oiYO1n3VNRQddByPqT9+IbxMY5aCB00XzhiPBUqRoPEHRMgnK2Fb1XMUF9Q
         bBntiC5O9qIcPCEo5/4v+t9wWoVBzRj2HlnAVP5BLAOSVhNu5TzdgY5bqNJQ2GtI/neX
         cgwP+XDiNPd4MMpVEeXvf2NyIVmxtn3bSVXIGLgGjLauRLjQP7lrCz6Lm2lyU+tKZhNW
         DYWw==
X-Gm-Message-State: AOAM5325u0RaTREQ5jYQn+Op5hMvqqojhVKDvkEOK5XpiwwLc0IFj9bu
        yf2tQygGpeQVXkJt57K5JzdPoQ==
X-Google-Smtp-Source: ABdhPJw9Som5p5H+C+616fLW8c09GFbZ29OzLFxuQ5Lh/jDun7pKXw4Kxr+tc0PcoDTU00qm8yeXCw==
X-Received: by 2002:a17:907:7f13:b0:6f3:bfbb:2f9b with SMTP id qf19-20020a1709077f1300b006f3bfbb2f9bmr5202247ejc.101.1651075130113;
        Wed, 27 Apr 2022 08:58:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm6931993eje.183.2022.04.27.08.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:58:49 -0700 (PDT)
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
Subject: [PATCH 03/10] arm64: dts: stratix10/agilex: use proper 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 17:58:33 +0200
Message-Id: <20220427155840.596535-4-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 4 ++--
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 884bda106399..b743e625f482 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -346,8 +346,8 @@ pdma: dma-controller@ffda0000 {
 				     <0 88 4>,
 				     <0 89 4>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
 			clock-names = "apb_pclk";
 			resets = <&rst DMA_RESET>, <&rst DMA_OCP_RESET>;
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index c78371703e76..2bf632edc3ad 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -350,8 +350,8 @@ pdma: dma-controller@ffda0000 {
 				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 			resets = <&rst DMA_RESET>, <&rst DMA_OCP_RESET>;
 			reset-names = "dma", "dma-ocp";
 			clocks = <&clkmgr AGILEX_L4_MAIN_CLK>;
-- 
2.32.0

