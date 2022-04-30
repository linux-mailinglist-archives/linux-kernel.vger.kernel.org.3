Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91466515CD3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355067AbiD3MWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 08:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344725AbiD3MWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:22:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18133135D
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 05:19:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g6so19996328ejw.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lhzs630Ku48cr1hsvUIAdB76W0wVhhR948l4JWHPvns=;
        b=d9Q9DkqetFM3OzssY3M5rpFVWC1QKfFxCU8E3RAoRj9Cs6XLK7sBrbQuxiJErNSsbb
         OyYNBMA2LOjH96nTDZJx+dDSI9sxoHeFx5hv73lCrAWvKnM4nJ8EKLH966sWqOLlxfkW
         T69bVd7/1lsu7N+clMbj8EvwKQnmBVaCyNIPQArT6KewQ+8hUGAYfyoOQffj0X+RD8Ui
         Bo6lrAP1cT35vGVaFzvnqZNbJo2fEQnp2ElIwZcBuVVVCJccBOS2ce94nASn19tEYK7U
         ZVpyi6vUsuQPrV7k057ylb/tdarvxih5PafS8mcS4CfXOmExd/90v3JizzLicFKj3NLr
         n9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lhzs630Ku48cr1hsvUIAdB76W0wVhhR948l4JWHPvns=;
        b=fLwaSI0gGNKjf4hrwhzBpBRxmEAuG9woMVruLTh1cBvgCNB1yKl5DyWkA+wULk5qY0
         HCV7NgEtOEeA9Ct+PANCHxRWqumU+OE5UisWSdrxmdFO2sV7qqa0H2swlMeq/xurb+4E
         +QzDUhFyTlLIw0FffCa5qMIbDsOzp+2ZtSAl304g8jHujV4yDJKd/7fNN8f14Dh5P6tx
         7Zf+LdsKh4lmfOxIsFpv0bTOxvsl9TMCElpD8cl2tqmEpecS2Z0N0dzvKrvGQm78fBUI
         Xuzx0d/wck546tjjn63SWC3ggce8WS7zyn9DvBUtnrtAyupRLbhhoca92INg5XLe0nmz
         33+g==
X-Gm-Message-State: AOAM5310kq0hy0y59RFjpHTNPRPivTKcbZiqyBfLfNCjqMCapD7bfqe9
        mmUMn/+FBvwEX5L9DuVBnCPbpw==
X-Google-Smtp-Source: ABdhPJxNi5omVt9+ibh14BfAJmJrUJ8HVnpKDSYGjjSBZN+woQC0gqCzDIx3YnH6MvxyNKtTPB2XLQ==
X-Received: by 2002:a17:907:62a6:b0:6ef:8118:d3e2 with SMTP id nd38-20020a17090762a600b006ef8118d3e2mr3564918ejc.605.1651321150246;
        Sat, 30 Apr 2022 05:19:10 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c26-20020a056402159a00b0042617ba63d1sm4059091edv.91.2022.04.30.05.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 05:19:09 -0700 (PDT)
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
Subject: [PATCH v2 1/9] ARM: dts: zynq-7000: drop useless 'dma-channels/requests' properties
Date:   Sat, 30 Apr 2022 14:18:54 +0200
Message-Id: <20220430121902.59895-2-krzysztof.kozlowski@linaro.org>
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

Not adding acquired review tag because of significant change.
---
 arch/arm/boot/dts/zynq-7000.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 47c2a4b14c06..c193264a86ff 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -343,8 +343,6 @@ dmac_s: dmac@f8003000 {
 			             <0 40 4>, <0 41 4>,
 			             <0 42 4>, <0 43 4>;
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <4>;
 			clocks = <&clkc 27>;
 			clock-names = "apb_pclk";
 		};
-- 
2.32.0

