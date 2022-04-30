Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41595515CC0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377689AbiD3MW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 08:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356476AbiD3MWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:22:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715A3AAB6E
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 05:19:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kq17so19967239ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0RO6TI8wBg0VQ3uuEGgiZnjVHvc3YXcFjypcH3ATw2o=;
        b=kqy3uhmr7+EaED713/fDAmt7SFPSxLznugLtOtmyrNbjgasz+7wrOADQox+8vUI89z
         6YMMPfgafPSBy++xyIlIQUuV11Op8O2hL4MDHc75xqy++EU1RkBpnf/vo109ol3Gf8I0
         q2MrG2ywCYpbfg99f48CPeLixRlIyCZLJdqbNW7jCFATs6X4SQyWNSgxot/LsZdwWYYM
         Tfjw3ctAa9mguyREMbQWXmiNeaRGmvYkFxDKsrTvc1m2xGYZXc0wCMwABJAbRedZ4L0/
         8u/z48FMI/RhLpiR8GmgSCTVvGgZ/l0VpHvYyDIlFUvUwqkypK4YdnCtbPgeVJYwc2LJ
         LUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0RO6TI8wBg0VQ3uuEGgiZnjVHvc3YXcFjypcH3ATw2o=;
        b=kZiCoMMPLzbJH0KxKbPIFOPVwb40cTNrgo/rnL+Buqm5MxLTeHIoQEGY7c4XlG1iY7
         miRxd9gr16xr6hu7Gyx9VCU7jGiwT6rcq/0kGhjkU0hgW3Hi0hV5lOUkgp7EHb7mQkPP
         UK+Z8IcsvKtrKCPiLf9o6hy1XlrDHOZlqqkrdlh3xiZrIGmUcTx/QnVve2wo4B6gt6vj
         k3OQtoRjlz76HaiPVIePvP2anWK0mUwu4r02gSrd3d+f+R972w/nagS0naveq7S3hx/E
         lRxa2x7WvHaBMh8jAhw8PanE6HbSWFUd1TGiqGqoOc/AM3pF4leaBG1Jj0Mfy10QOcoS
         r99A==
X-Gm-Message-State: AOAM532QbuN4ndfLk3XVLjkUg9rv6JOOPA0YAWepiVgI8utpWWtI6dzx
        zTxkAAzANT3REMUK6uN4OdHttA==
X-Google-Smtp-Source: ABdhPJyYGqhym5nLmyrbCINZFxIxRIbBtXjym7LVAEMHv/1/Mi9Xk1QiTAgjU6cRbZExeUPQIIkQUA==
X-Received: by 2002:a17:907:962a:b0:6f3:b0f5:5db9 with SMTP id gb42-20020a170907962a00b006f3b0f55db9mr3680869ejc.644.1651321154857;
        Sat, 30 Apr 2022 05:19:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c26-20020a056402159a00b0042617ba63d1sm4059091edv.91.2022.04.30.05.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 05:19:14 -0700 (PDT)
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
Subject: [PATCH v2 5/9] arm64: dts: broadcom: drop useless 'dma-channels/requests' properties
Date:   Sat, 30 Apr 2022 14:18:58 +0200
Message-Id: <20220430121902.59895-6-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 2 --
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index f59fa3979a04..fda97c47f4e9 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -289,8 +289,6 @@ dma0: dma-controller@61360000 {
 				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
 			clocks = <&iprocslow>;
 			clock-names = "apb_pclk";
 		};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 7f1b8efd0883..09d4aa8ae1d6 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -556,8 +556,6 @@ dma0: dma-controller@310000 {
 				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
 			clocks = <&hsls_div2_clk>;
 			clock-names = "apb_pclk";
 			iommus = <&smmu 0x6000 0x0000>;
-- 
2.32.0

