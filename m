Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7DD4BAE98
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiBRAay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:30:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiBRAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:39 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9E9606F8;
        Thu, 17 Feb 2022 16:30:10 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v12so11790226wrv.2;
        Thu, 17 Feb 2022 16:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+1VYbMqYXYk/nrcO50yFLaIf+M6b7LtE3hpy+aBels=;
        b=aWXn3iOZzgCxTZbsZKhOeovRputQ4CCMj1yZKPSPuPcjT4Mg3ADLi6aAQgXxPRqqzW
         p2ZPEV6hq5nPi9e3Gwz3v3jdmc16OR4RjWW2gOkQ1W0hMSuUxrCG0YSt+vCoyaZ10QCx
         jJIRXD2GKnq88RZak3LwEht+M9yrbt6PqsAN+uPYcy4yGFgKTQCDxTsRYBEk1VfduECm
         eqJqKkNbrqgjAY+WvlBH8mD+IVc5KvxSC77NbKyUpWwLCMFS9k3Xaw6dV8hGVT9NXkGB
         0MeccceIVW7vSqbMMHrkTtBjSCHkwvgkcsMoDcKtx0HezYaoBKilIbmrum4m3s6YHZdL
         9Xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+1VYbMqYXYk/nrcO50yFLaIf+M6b7LtE3hpy+aBels=;
        b=EV1ahNfaAnx3mLlhYVcC8KivTvRduumjXPHt6DesrLo+y9xVPyM2Ss41jjJjkyyCzM
         C71Lrj3tkqcT+QGDC3xwUrNfsJdxWG6TaHWJbX8teVHrRGzX2UuK9aINtrHI5fc06vIf
         9Iyq9Tre0vqKMwv0QcujP/vWboDkpEEZHFy0xwb1TZ/4fVqQtQFH7F4mQSHjBS2MBmcy
         QLQeGs/CN3v2zNsZ0lwqeh4pfXVQoiWRcGLU1xB0i+LPyIWmSObFQoJL1rxRJra0Z6LQ
         nBEfrnAQS9iHaFxA7TOEb5ui5jJ6/YTDZ3XTWjbA9ulxo/pY7FBVCaGLNSpnf7i4M5vr
         20kw==
X-Gm-Message-State: AOAM532w0u3wXNhe7MQrJtJpaAuHDYfJhVEv55rlxj6b+Na9Vty4+8fU
        w1IPIxnF+SZHiy5zGp/3u5cwy/KbLvY=
X-Google-Smtp-Source: ABdhPJzZYm75d8QTJQ+TnjK2lrIt+wi5zWHjCrlO5T7TS1DXu66mwd3P4jiOVWdqua/jYdNztrewoQ==
X-Received: by 2002:a05:6000:1817:b0:1e4:bb97:d844 with SMTP id m23-20020a056000181700b001e4bb97d844mr3862237wrh.628.1645144205256;
        Thu, 17 Feb 2022 16:30:05 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:30:04 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 10/18] ARM: dts: qcom: add saw for l2 cache and kraitcc for ipq8064
Date:   Fri, 18 Feb 2022 01:29:48 +0100
Message-Id: <20220218002956.6590-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218002956.6590-1-ansuelsmth@gmail.com>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add saw compatible for l2 cache and kraitcc node for ipq8064 dtsi.
Also declare clock-output-names for acc0 and acc1 and qsb fixed clock
for the secondary mux.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 34 +++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index c579fb09e768..7df1c1482220 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -298,6 +298,12 @@ smem: smem@41000000 {
 	};
 
 	clocks {
+		qsb: qsb {
+			compatible = "fixed-clock";
+			clock-frequency = <384000000>;
+			#clock-cells = <0>;
+		};
+
 		cxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
@@ -504,11 +510,19 @@ IRQ_TYPE_EDGE_RISING)>,
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clock-output-names = "acpu0_aux";
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clock-output-names = "acpu1_aux";
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		adm_dma: dma-controller@18300000 {
@@ -532,17 +546,23 @@ adm_dma: dma-controller@18300000 {
 		};
 
 		saw0: regulator@2089000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,saw2", "qcom,apq8064-saw2-v1.1-cpu", "syscon";
 			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
 		saw1: regulator@2099000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,saw2", "qcom,apq8064-saw2-v1.1-cpu", "syscon";
 			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
+		saw_l2: regulator@02012000 {
+			compatible = "qcom,saw2", "syscon";
+			reg = <0x02012000 0x1000>;
+			regulator;
+		};
+
 		gsbi2: gsbi@12480000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			cell-index = <2>;
@@ -899,6 +919,16 @@ l2cc: clock-controller@2011000 {
 			clock-output-names = "acpu_l2_aux";
 		};
 
+		kraitcc: clock-controller {
+			compatible = "qcom,krait-cc-v1";
+			clocks = <&gcc PLL9>, <&gcc PLL10>, <&gcc PLL12>,
+				 <&acc0>, <&acc1>, <&l2cc>, <&qsb>;
+			clock-names = "hfpll0", "hfpll1", "hfpll_l2",
+				      "acpu0_aux", "acpu1_aux", "acpu_l2_aux",
+				      "qsb";
+			#clock-cells = <1>;
+		};
+
 		lcc: clock-controller@28000000 {
 			compatible = "qcom,lcc-ipq8064";
 			reg = <0x28000000 0x1000>;
-- 
2.34.1

