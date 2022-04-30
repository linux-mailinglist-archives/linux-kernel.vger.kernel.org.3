Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DF8515CD1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382600AbiD3MXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 08:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356725AbiD3MWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:22:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACDDAAB7B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 05:19:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i19so19915472eja.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVU+HyGPvDq4Ad26182u3753XqKolh2zdBKACINyN/M=;
        b=z2Ju8wcf62pztJwxKYamzJ6kihOLF7cgd6EI9ikBHkSqLOF4Qn80OpkSZkv+ZLcDDO
         mZZPCgxvPWcTKuXrpdAwaeMCeivsCjx+PWNf76JYN9+VX/KF94PH0erTmNV7niydcIKv
         3KSB87Ni0AlSR79I9r7YKXX9HboDCpJjnNGtIpAO1Y/YXQiIY339gNxJzqvAzpVyxt4K
         /vDRXE5RRlXRgW4tJ6K+sfzXefixElebre6mZii/xvoc0L8SFsahIRSFhekwhtEeBV4B
         gBg55PQ/zZB1zqTPgmBZ9F5dcchIQyIAedS3HHECjLNYUhb0+amMD7p2KKlONCU2wGo3
         KNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVU+HyGPvDq4Ad26182u3753XqKolh2zdBKACINyN/M=;
        b=wyXiN+9+gNIk40tvpIuo/o5ml7rgHLmHlsEEihR88HQ9pmUKNWwdzWmCzqlSN7wTIC
         Hx9Ahcd8Q6E5TYIV+GKnFQ0DF45eDm8Mr9+vpU6FtuYrX8FTO2NNP6Z8wErLuY5kfg9z
         zP29+0Cll7QuK6fqsoRHXolkDOSr7vFHrd/L3TBFAyVYRC64edTk30E8RCk7g7onY5XV
         a0Bdpz34dzfsDY/B5uttkdzPu2Qh76BCraFvJPc81kkiz2TkF9QCSFpUyeQu1fSaCusp
         WDbky2bBtGKQH7bo5ruppMXEHPOAIa+nB9QFYm//Vye63LPGc8XG+XEvuE6W2qkEyZ8g
         jx/g==
X-Gm-Message-State: AOAM533FdxYpJTVFtQiCcvEpMFBnXXcjN90Ce/1rkdM6w3Evx0UWBICN
        T2bMyOrGtxis51GqiVVXVDk0Fw==
X-Google-Smtp-Source: ABdhPJyx0rP9PLsYenZ7A3IngtRJNpNScCw5DbUxYcmFPPRYw+VKw3/DCQKDCSdbeWXRQetyuhoEXQ==
X-Received: by 2002:a17:906:9b8a:b0:6f3:fcc9:f863 with SMTP id dd10-20020a1709069b8a00b006f3fcc9f863mr3632098ejc.672.1651321156115;
        Sat, 30 Apr 2022 05:19:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c26-20020a056402159a00b0042617ba63d1sm4059091edv.91.2022.04.30.05.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 05:19:15 -0700 (PDT)
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
Subject: [PATCH v2 6/9] ARM: dts: s5pv210: drop useless 'dma-channels/requests' properties
Date:   Sat, 30 Apr 2022 14:18:59 +0200
Message-Id: <20220430121902.59895-7-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/s5pv210.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index ac281f42e8f5..f1b85aae8842 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -125,8 +125,6 @@ pdma0: dma-controller@e0900000 {
 			clocks = <&clocks CLK_PDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
 		};
 
 		pdma1: dma-controller@e0a00000 {
@@ -137,8 +135,6 @@ pdma1: dma-controller@e0a00000 {
 			clocks = <&clocks CLK_PDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
 		};
 
 		adc: adc@e1700000 {
@@ -526,8 +522,6 @@ mdma1: dma-controller@fa200000 {
 			clocks = <&clocks CLK_MDMA>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <1>;
 		};
 
 		rotator: rotator@fa300000 {
-- 
2.32.0

