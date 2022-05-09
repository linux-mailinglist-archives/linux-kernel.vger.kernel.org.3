Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9866520047
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbiEIOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237715AbiEIOvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:51:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7094D24BB2B
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:47:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dk23so27302913ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YReIlo2SA3OXXKOlZqVzpBGAEFmTXwOCuNhJW0SaYWY=;
        b=y0ykTPwUXzT2B12UESk2c0mNSFQvN19HIPC41BgWOWm9eApr1uFuPMRCsUTLEs11CI
         muoGtMrqLjqf5PFE0+nt1zB/vVkfRloOupyM7xusCrQWJi+ynB9xH2wA6Wvsmpm0+PLg
         nsBUUB+OA7phZqFyQEUOieLzoNavymWASJaVSaveRwZGAwERjslwj6Z+qc62VqsVnr84
         Nx3wJJs9GBiHVjxLFT+vk05g48a+flBS/lMy/MNEJK86ZAS0I961yNQglucmXV1YNix1
         bggkMitanpVmRFCJ1KAg9t2SU7fCqKhhqzIFzqtA7+H5v9sHkRMN+pm2RwjSGlj++0O5
         8zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YReIlo2SA3OXXKOlZqVzpBGAEFmTXwOCuNhJW0SaYWY=;
        b=NtCzinnVwZnpm91nyr6CnZVHM+XAuhBk8JMZy1gaz7hf39mF9elbWhclgFo/LeM/Dt
         4XlW5g7PKCELj1T+4vIc/0A/wHv1a7Lwc6bzCjtH65aVy3O1mKJmeUrx+MIxFEFqoFeV
         tXgEG8mUx6f6RgJ23XVS5ZvZN6pioKds7h5k6yktDdvxF32ZDUpktiD70svA5SJJeN64
         3ls1guPx/+reSJTvHmIA6mwBOow//aRJtbISfglFQduFfmibs9S5PkVZ8OGTGU7XLNuL
         6TxDjA9BpPaonL+wLW6xltvCV+REsgjBdUhOPLeyyDdrNtbnTeK8kwhb8pZIxOq/b7/r
         Pv+Q==
X-Gm-Message-State: AOAM533Qv2M+8SKdkoxhIvbkzCzgccM/obfhoLgobutdxDP38ZQEoWP1
        ivXEwtICn6AUE45VRkH2ZqYqHA==
X-Google-Smtp-Source: ABdhPJwUe+Mhortp2BoeLfOz+JnBpHFhsaIHaA71zlpV1VUi6ZcfHMF4GT0uGgC1stNA9o4EZpyHQw==
X-Received: by 2002:a17:906:ece3:b0:6f3:da10:138a with SMTP id qt3-20020a170906ece300b006f3da10138amr15043405ejb.438.1652107646916;
        Mon, 09 May 2022 07:47:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u9-20020a05640207c900b0042617ba637bsm6451828edy.5.2022.05.09.07.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 07:47:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] arm64: dts: qcom: sdm630: order interrupts according to bindings
Date:   Mon,  9 May 2022 16:47:14 +0200
Message-Id: <20220509144714.144154-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220509144714.144154-1-krzysztof.kozlowski@linaro.org>
References: <20220509144714.144154-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CAMSS DTSI device node, which came after the bindings were merged,
got the interrupts ordered differently then specified in the bindings:

  sdm630-sony-xperia-nile-pioneer.dtb: camss@ca00000: interrupt-names:0: 'csid0' was expected

Reordering them to match bindings should not cause ABI issues, because
the driver relies on names, not ordering.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 594a802e9429..2c540476a8be 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1870,23 +1870,23 @@ camss: camss@ca00000 {
 				    "ispif",
 				    "vfe0",
 				    "vfe1";
-			interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 80 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 296 IRQ_TYPE_EDGE_RISING>,
+			interrupts = <GIC_SPI 296 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 297 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 298 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 299 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 80 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 309 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 314 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 315 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "csiphy0",
-					  "csiphy1",
-					  "csiphy2",
-					  "csid0",
+			interrupt-names = "csid0",
 					  "csid1",
 					  "csid2",
 					  "csid3",
+					  "csiphy0",
+					  "csiphy1",
+					  "csiphy2",
 					  "ispif",
 					  "vfe0",
 					  "vfe1";
-- 
2.32.0

