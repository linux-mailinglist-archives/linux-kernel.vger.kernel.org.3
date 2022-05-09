Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BD5520039
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbiEIOv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237673AbiEIOvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:51:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C1524BB26
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:47:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i27so27272695ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mjrvp1Hm7vOindUfGtrE7gurv1Xo3OI98bE9K/MwSFs=;
        b=GrpaA/8vdoQ0feSdPdXYv/uw6XfWC1FuzNh2IOeG7iyRn6cCulGzW/oyDovSCHjX4U
         lhH1h/GcPPy/XQKpdDjwZy71iS4HDrZYz1ft6hbApC2eUkFhFnSTVEHCvOY02CFx2DVB
         WIxptKgEp5wHXcmDflRJjL0jv3y3RbBO/FN+on09ULb7t45iDVrQBMhPJp9pQky7un1Y
         hHjupf/To+xpulFQVg7f5toTR2Inmkh8eykR3Q73l8NnZJHQhq2EecnNC8zLThUocm0E
         +gVOLicDKMEvQCeeoL+93JH0xPuXNVILC9ItVU7dImsqfU3HFoTFM778IAAcWaN/TueS
         65og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjrvp1Hm7vOindUfGtrE7gurv1Xo3OI98bE9K/MwSFs=;
        b=e8/hoYDfu/B+a/craik3Jzhde80kZQCsf314yPTM8dQOyMI/+Grt0df95K3VcasVX7
         /cBljblYNG/C2nUPPDiqpBn00R/tSWZ/KYLoH/Z3rQUN4K8IdzWgegnJwe/d7jWhN7RJ
         VjFu2Y18Yf3VjA8B0cF4/WqI3TVL9yNnOVrQ8/ZvsbOwbvp1jUosMYyXixJsXW8aHl64
         ZZ0AIEs8c5eIOov5hGk6GcT1/xzrsEEvKj1KI1CK4wIt0QQdf8IhrSZeuvZ6Qm3jhSsA
         cluS009DtXLWgkci4xeSAJkeS0pNkhwuwVINv48B8a32woiguyJoz695h7qTqILZ6sSq
         jRCw==
X-Gm-Message-State: AOAM5322k03DUFGIbImuqrA0PmuVETDoem1VOk5mhLRAQ0oYLz64LGi6
        hI1/crcRoxbwLAnrPB7N1eb3sg==
X-Google-Smtp-Source: ABdhPJyV85p3CRvl/hPJcJeHo3iJvQ+mcdXiasUjKX53LqOQ9TCcXbuwVG86Cb92HrSh1QPu6SWsjA==
X-Received: by 2002:a17:907:1625:b0:6f4:55aa:4213 with SMTP id hb37-20020a170907162500b006f455aa4213mr15254274ejc.594.1652107645930;
        Mon, 09 May 2022 07:47:25 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u9-20020a05640207c900b0042617ba637bsm6451828edy.5.2022.05.09.07.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 07:47:25 -0700 (PDT)
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
Subject: [PATCH 3/4] arm64: dts: qcom: sdm630: order regs according to bindings
Date:   Mon,  9 May 2022 16:47:13 +0200
Message-Id: <20220509144714.144154-3-krzysztof.kozlowski@linaro.org>
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
got the regs ordered differently then specified in the bindings:

  sdm636-sony-xperia-ganges-mermaid.dtb: camss@ca00000: reg-names:0: 'csi_clk_mux' was expected

Reordering them to match bindings should not cause ABI issues, because
the driver relies on names, not ordering.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 8f623238c238..594a802e9429 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1842,32 +1842,32 @@ pil-reloc@94c {
 
 		camss: camss@ca00000 {
 			compatible = "qcom,sdm660-camss";
-			reg = <0x0c824000 0x1000>,
+			reg = <0x0ca00020 0x10>,
+			      <0x0ca30000 0x100>,
+			      <0x0ca30400 0x100>,
+			      <0x0ca30800 0x100>,
+			      <0x0ca30c00 0x100>,
+			      <0x0c824000 0x1000>,
 			      <0x0ca00120 0x4>,
 			      <0x0c825000 0x1000>,
 			      <0x0ca00124 0x4>,
 			      <0x0c826000 0x1000>,
 			      <0x0ca00128 0x4>,
-			      <0x0ca30000 0x100>,
-			      <0x0ca30400 0x100>,
-			      <0x0ca30800 0x100>,
-			      <0x0ca30c00 0x100>,
 			      <0x0ca31000 0x500>,
-			      <0x0ca00020 0x10>,
 			      <0x0ca10000 0x1000>,
 			      <0x0ca14000 0x1000>;
-			reg-names = "csiphy0",
+			reg-names = "csi_clk_mux",
+				    "csid0",
+				    "csid1",
+				    "csid2",
+				    "csid3",
+				    "csiphy0",
 				    "csiphy0_clk_mux",
 				    "csiphy1",
 				    "csiphy1_clk_mux",
 				    "csiphy2",
 				    "csiphy2_clk_mux",
-				    "csid0",
-				    "csid1",
-				    "csid2",
-				    "csid3",
 				    "ispif",
-				    "csi_clk_mux",
 				    "vfe0",
 				    "vfe1";
 			interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>,
-- 
2.32.0

