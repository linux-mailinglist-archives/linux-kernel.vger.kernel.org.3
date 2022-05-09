Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E71A52003A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbiEIOv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbiEIOvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:51:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685B624BB1D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:47:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a21so16588734edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=321PIVHP5NJ8SF3xR+tSNAO8vJqKIBbackfeUoBjZ+c=;
        b=A3Nb8Y+LUrYzmdwdJbKfMhZtRSTCJT8VBKQOj3PrAp5YoGdPotzJsvNHSvE612mEcT
         d8iHkoHwKm4uLnXYR1RCXGzzjuQjlSMR9CVSCplh38TYcrWmm+I4SGZLsOvpb4oA1OuI
         UVV+fiNSw+MphnToqCO9LbesE0FxnUvMfekhVflm2+WRBvEkthWhUOCda9Te6UWzUcx1
         oTmBDqlrGxnW6Vfx7uTLcDhct+QXXAliLmDg7hmifj+18de1K8B/+16wH+V5YF8VaQBF
         uUcKRyZ0flBokpi7LLxeomzZp/k/8DpWUQPripOXIT+4rfOAXhEfKkX72SgT3T9JzPdi
         fafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=321PIVHP5NJ8SF3xR+tSNAO8vJqKIBbackfeUoBjZ+c=;
        b=1gKz+pXhQrx96nqLj8FEpiU7A9zV8DRkdSkL+tC5F4aLLKj8I0XYQwRIWbbjhYATRo
         IFPapprJDqiaKPF2MRKqe4tSdZbhiGyZfJU8OjfiJ4AkW5HmIEnQVLpFdh58H8TLhrfw
         wmaQAW72UeCohbaWm2NvagdanKI6BZkq2vyg4PzWCDnOfSxuFlOwmcDPD/qdUWAnizPr
         Bq2YLtl5P6mwpR4mFBwh7Gd7qLvctupbtXen6GOuEKfdEN0fICesJP7GZorx7bCYYGBK
         6VCoou56RbnqgT1OvTNrR9fWSfsgPW4Ccp65RBxyHAtfjnT3GiOoOpJqea0jwAGMfuD+
         zaNA==
X-Gm-Message-State: AOAM532jvrXwUt8PESfVlD7kDCA524fMvQFOxx34GOle4OPxuU8iRSsP
        Vx0mUXqbROnNxturJNn5m0ZS0g==
X-Google-Smtp-Source: ABdhPJy8EUbRnlfNNEi9YDRlh9pQH4O0ylgZYVEUYy+S92gHznMpJhxvsi3ak/7fwvbY5Di3GzuOig==
X-Received: by 2002:a05:6402:4396:b0:427:f2dc:b11 with SMTP id o22-20020a056402439600b00427f2dc0b11mr17919840edc.298.1652107645011;
        Mon, 09 May 2022 07:47:25 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u9-20020a05640207c900b0042617ba637bsm6451828edy.5.2022.05.09.07.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 07:47:24 -0700 (PDT)
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
Subject: [PATCH 2/4] arm64: dts: qcom: sdm630: order clocks according to bindings
Date:   Mon,  9 May 2022 16:47:12 +0200
Message-Id: <20220509144714.144154-2-krzysztof.kozlowski@linaro.org>
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
got the clocks ordered differently then specified in the bindings:

  sdm636-sony-xperia-ganges-mermaid.dtb: camss@ca00000: reg-names:4: 'csid3' was expected

Reordering them to match bindings should not cause ABI issues, because
the driver relies on names, not ordering.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 168 +++++++++++++--------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 7f875bf9390a..8f623238c238 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1890,90 +1890,90 @@ camss: camss@ca00000 {
 					  "ispif",
 					  "vfe0",
 					  "vfe1";
-			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
-				<&mmcc THROTTLE_CAMSS_AXI_CLK>,
-				<&mmcc CAMSS_ISPIF_AHB_CLK>,
-				<&mmcc CAMSS_CSI0PHYTIMER_CLK>,
-				<&mmcc CAMSS_CSI1PHYTIMER_CLK>,
-				<&mmcc CAMSS_CSI2PHYTIMER_CLK>,
-				<&mmcc CAMSS_CSI0_AHB_CLK>,
-				<&mmcc CAMSS_CSI0_CLK>,
-				<&mmcc CAMSS_CPHY_CSID0_CLK>,
-				<&mmcc CAMSS_CSI0PIX_CLK>,
-				<&mmcc CAMSS_CSI0RDI_CLK>,
-				<&mmcc CAMSS_CSI1_AHB_CLK>,
-				<&mmcc CAMSS_CSI1_CLK>,
-				<&mmcc CAMSS_CPHY_CSID1_CLK>,
-				<&mmcc CAMSS_CSI1PIX_CLK>,
-				<&mmcc CAMSS_CSI1RDI_CLK>,
-				<&mmcc CAMSS_CSI2_AHB_CLK>,
-				<&mmcc CAMSS_CSI2_CLK>,
-				<&mmcc CAMSS_CPHY_CSID2_CLK>,
-				<&mmcc CAMSS_CSI2PIX_CLK>,
-				<&mmcc CAMSS_CSI2RDI_CLK>,
-				<&mmcc CAMSS_CSI3_AHB_CLK>,
-				<&mmcc CAMSS_CSI3_CLK>,
-				<&mmcc CAMSS_CPHY_CSID3_CLK>,
-				<&mmcc CAMSS_CSI3PIX_CLK>,
-				<&mmcc CAMSS_CSI3RDI_CLK>,
-				<&mmcc CAMSS_AHB_CLK>,
-				<&mmcc CAMSS_VFE0_CLK>,
-				<&mmcc CAMSS_CSI_VFE0_CLK>,
-				<&mmcc CAMSS_VFE0_AHB_CLK>,
-				<&mmcc CAMSS_VFE0_STREAM_CLK>,
-				<&mmcc CAMSS_VFE1_CLK>,
-				<&mmcc CAMSS_CSI_VFE1_CLK>,
-				<&mmcc CAMSS_VFE1_AHB_CLK>,
-				<&mmcc CAMSS_VFE1_STREAM_CLK>,
-				<&mmcc CAMSS_VFE_VBIF_AHB_CLK>,
-				<&mmcc CAMSS_VFE_VBIF_AXI_CLK>,
-				<&mmcc CSIPHY_AHB2CRIF_CLK>,
-				<&mmcc CAMSS_CPHY_CSID0_CLK>,
-				<&mmcc CAMSS_CPHY_CSID1_CLK>,
-				<&mmcc CAMSS_CPHY_CSID2_CLK>,
-				<&mmcc CAMSS_CPHY_CSID3_CLK>;
-			clock-names = "top_ahb",
-				"throttle_axi",
-				"ispif_ahb",
-				"csiphy0_timer",
-				"csiphy1_timer",
-				"csiphy2_timer",
-				"csi0_ahb",
-				"csi0",
-				"csi0_phy",
-				"csi0_pix",
-				"csi0_rdi",
-				"csi1_ahb",
-				"csi1",
-				"csi1_phy",
-				"csi1_pix",
-				"csi1_rdi",
-				"csi2_ahb",
-				"csi2",
-				"csi2_phy",
-				"csi2_pix",
-				"csi2_rdi",
-				"csi3_ahb",
-				"csi3",
-				"csi3_phy",
-				"csi3_pix",
-				"csi3_rdi",
-				"ahb",
-				"vfe0",
-				"csi_vfe0",
-				"vfe0_ahb",
-				"vfe0_stream",
-				"vfe1",
-				"csi_vfe1",
-				"vfe1_ahb",
-				"vfe1_stream",
-				"vfe_ahb",
-				"vfe_axi",
-				"csiphy_ahb2crif",
-				"cphy_csid0",
-				"cphy_csid1",
-				"cphy_csid2",
-				"cphy_csid3";
+			clocks = <&mmcc CAMSS_AHB_CLK>,
+				 <&mmcc CAMSS_CPHY_CSID0_CLK>,
+				 <&mmcc CAMSS_CPHY_CSID1_CLK>,
+				 <&mmcc CAMSS_CPHY_CSID2_CLK>,
+				 <&mmcc CAMSS_CPHY_CSID3_CLK>,
+				 <&mmcc CAMSS_CSI0_AHB_CLK>,
+				 <&mmcc CAMSS_CSI0_CLK>,
+				 <&mmcc CAMSS_CPHY_CSID0_CLK>,
+				 <&mmcc CAMSS_CSI0PIX_CLK>,
+				 <&mmcc CAMSS_CSI0RDI_CLK>,
+				 <&mmcc CAMSS_CSI1_AHB_CLK>,
+				 <&mmcc CAMSS_CSI1_CLK>,
+				 <&mmcc CAMSS_CPHY_CSID1_CLK>,
+				 <&mmcc CAMSS_CSI1PIX_CLK>,
+				 <&mmcc CAMSS_CSI1RDI_CLK>,
+				 <&mmcc CAMSS_CSI2_AHB_CLK>,
+				 <&mmcc CAMSS_CSI2_CLK>,
+				 <&mmcc CAMSS_CPHY_CSID2_CLK>,
+				 <&mmcc CAMSS_CSI2PIX_CLK>,
+				 <&mmcc CAMSS_CSI2RDI_CLK>,
+				 <&mmcc CAMSS_CSI3_AHB_CLK>,
+				 <&mmcc CAMSS_CSI3_CLK>,
+				 <&mmcc CAMSS_CPHY_CSID3_CLK>,
+				 <&mmcc CAMSS_CSI3PIX_CLK>,
+				 <&mmcc CAMSS_CSI3RDI_CLK>,
+				 <&mmcc CAMSS_CSI0PHYTIMER_CLK>,
+				 <&mmcc CAMSS_CSI1PHYTIMER_CLK>,
+				 <&mmcc CAMSS_CSI2PHYTIMER_CLK>,
+				 <&mmcc CSIPHY_AHB2CRIF_CLK>,
+				 <&mmcc CAMSS_CSI_VFE0_CLK>,
+				 <&mmcc CAMSS_CSI_VFE1_CLK>,
+				 <&mmcc CAMSS_ISPIF_AHB_CLK>,
+				 <&mmcc THROTTLE_CAMSS_AXI_CLK>,
+				 <&mmcc CAMSS_TOP_AHB_CLK>,
+				 <&mmcc CAMSS_VFE0_AHB_CLK>,
+				 <&mmcc CAMSS_VFE0_CLK>,
+				 <&mmcc CAMSS_VFE0_STREAM_CLK>,
+				 <&mmcc CAMSS_VFE1_AHB_CLK>,
+				 <&mmcc CAMSS_VFE1_CLK>,
+				 <&mmcc CAMSS_VFE1_STREAM_CLK>,
+				 <&mmcc CAMSS_VFE_VBIF_AHB_CLK>,
+				 <&mmcc CAMSS_VFE_VBIF_AXI_CLK>;
+			clock-names = "ahb",
+				      "cphy_csid0",
+				      "cphy_csid1",
+				      "cphy_csid2",
+				      "cphy_csid3",
+				      "csi0_ahb",
+				      "csi0",
+				      "csi0_phy",
+				      "csi0_pix",
+				      "csi0_rdi",
+				      "csi1_ahb",
+				      "csi1",
+				      "csi1_phy",
+				      "csi1_pix",
+				      "csi1_rdi",
+				      "csi2_ahb",
+				      "csi2",
+				      "csi2_phy",
+				      "csi2_pix",
+				      "csi2_rdi",
+				      "csi3_ahb",
+				      "csi3",
+				      "csi3_phy",
+				      "csi3_pix",
+				      "csi3_rdi",
+				      "csiphy0_timer",
+				      "csiphy1_timer",
+				      "csiphy2_timer",
+				      "csiphy_ahb2crif",
+				      "csi_vfe0",
+				      "csi_vfe1",
+				      "ispif_ahb",
+				      "throttle_axi",
+				      "top_ahb",
+				      "vfe0_ahb",
+				      "vfe0",
+				      "vfe0_stream",
+				      "vfe1_ahb",
+				      "vfe1",
+				      "vfe1_stream",
+				      "vfe_ahb",
+				      "vfe_axi";
 			interconnects = <&mnoc 5 &bimc 5>;
 			interconnect-names = "vfe-mem";
 			iommus = <&mmss_smmu 0xc00>,
-- 
2.32.0

