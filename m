Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BE755FF84
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiF2MPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiF2MPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:15:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF2A205FE;
        Wed, 29 Jun 2022 05:15:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mf9so32289442ejb.0;
        Wed, 29 Jun 2022 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PoUQzbLJkyVrF51dotVxEGbCuNBkKwJlXvB0YY0dPUE=;
        b=YDi6Wv3mbnMmqgVPxYDENBNCWxa+WZlsVZ6cRMfPegJzl5U2cJcJi1Ogi8ZNcNvl2W
         g31PZ9M4bi+DR+cHVg7b8bfuRGWCxAKd2VdiAQ7AzGBbjkz6qvu9W8V+91sufRJMNZ04
         KMHB47dBrdQ6urag65AAr3LMky6CPnakvBbNCOm3yIZyfHQlTGUaQj/sS9K4tUpMTJE1
         N0ffnmIITwRqaAZLbHQNpfcRzlQrFZmCmJU2fz7mGPlTNWfAyYu6fRoYEc108H+p+Jca
         si/MIJvucdPkNXSMksd35cjR5CK8iSFt2hVqZumYIK+uEkLeyHgkumgAXmOUSYkYMJIs
         k4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoUQzbLJkyVrF51dotVxEGbCuNBkKwJlXvB0YY0dPUE=;
        b=KwtJ0tXMt1J97L4ExGLkAgTBxZmPDaqtOOSvmj36+Hay7k67E5Kza+xwCw2U0Tpxzb
         0CcrYAdBHcYlV0rRAoUR+RsHIGmXbyKtr9Rq/dT50h38bX3ZkMjhoOsdtz9ychuGaKQZ
         M9+ZlFDckKuv9+oOgDX3V/TEAITkeKv7x9Rjqb/B/bSheoTTYFkOIcOX23RoY0dlI6uo
         r5l8gPBBP6U2z95yshGxoD0cifvw4upI+5JQ1GKGSF5OTslXBDw69IG4jokS/4bXEfry
         JDnNxxVeIRrF0aedDBrxRD56qNwVTQ98Dzdjz7gNjQM1m6QiaPMshRAQ7VvVL8rup1kp
         cFOA==
X-Gm-Message-State: AJIora9hmyZh4giEodyVn5dbDN/RCDJQanAnMdI8uc6NQptacDodMWKk
        6EfBRHIQE40PcNbfapPaW10=
X-Google-Smtp-Source: AGRyM1tRwdaaLJG8hlOcYxgWIDXdNiJA2IpXMR2o+03A05legWkmcDqnlHFdxFGHNG4dImDC98vpBw==
X-Received: by 2002:a17:906:9c82:b0:6df:c5f0:d456 with SMTP id fj2-20020a1709069c8200b006dfc5f0d456mr3075377ejc.287.1656504904168;
        Wed, 29 Jun 2022 05:15:04 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id l23-20020aa7cad7000000b004356afc7009sm11224421edt.59.2022.06.29.05.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:15:03 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 5/5] ARM: dts: qcom: fix various wrong definition for kpss-acc
Date:   Wed, 29 Jun 2022 14:14:41 +0200
Message-Id: <20220629121441.6552-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629121441.6552-1-ansuelsmth@gmail.com>
References: <20220629121441.6552-1-ansuelsmth@gmail.com>
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

Fix dtbs_check warning now that we have a correct kpss-acc yaml
schema.
Add missing clocks, clock-names, clock-output-names and #clock-cells
bindings for each kpss-acc-v1 clock-controller.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi |  8 ++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index a5b4574be095..6cf36a171e6d 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -388,21 +388,37 @@ timer@200a000 {
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu0_aux";
+			#clock-cells = <0>;
 		};
 
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu1_aux";
+			#clock-cells = <0>;
 		};
 
 		acc2: clock-controller@20a8000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x020a8000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu2_aux";
+			#clock-cells = <0>;
 		};
 
 		acc3: clock-controller@20b8000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x020b8000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu3_aux";
+			#clock-cells = <0>;
 		};
 
 		saw0: power-controller@2089000 {
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index ba94fb4c3d55..7ed78a74fbf4 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -468,11 +468,19 @@ IRQ_TYPE_EDGE_RISING)>,
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu0_aux";
+			#clock-cells = <0>;
 		};
 
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu1_aux";
+			#clock-cells = <0>;
 		};
 
 		adm_dma: dma-controller@18300000 {
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index a11a0fe7e0a9..497bb45785e5 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -173,11 +173,19 @@ regulators {
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu0_aux";
+			#clock-cells = <0>;
 		};
 
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu1_aux";
+			#clock-cells = <0>;
 		};
 
 		saw0: regulator@2089000 {
-- 
2.36.1

