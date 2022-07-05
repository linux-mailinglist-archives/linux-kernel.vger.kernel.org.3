Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876C85678E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiGEU4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiGEU4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:56:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8924140AA;
        Tue,  5 Jul 2022 13:56:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r6so5417360edd.7;
        Tue, 05 Jul 2022 13:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jhCunu7o7fyLkxoFCy5X4R/JUxZNFSkDzNenHSRMMQQ=;
        b=dEV8et8Zf+CrYW5SJ80XB/rtAajkrIHXkxnP8cMbcFsm7Ife6JrWfcLYiDGxdSMdbT
         2NqW3fQOD4EDYbx9uVckHzVb1uacBsfCqv8W46W+HgywDj63JZ6/y2s5uFWn5wzdqe6D
         y5OxyzydFnwgT3dD7FdBqXn7K8A/eRzAB5nxUjr38LBCp6TLOMtdwDqFX+VKa6wLR0Ht
         wD8s0HVFXYVT+oIPj251fQwkwmvO3fYHNcg3Qzj21Gf9E5AzVpvwCl+5yMrs9sStJ3TL
         kaEnjubSGUD2+R0vZXzgB6taqRHbhSz+q4U/BsQ9TNFEpX+6LXqBSJ2VbsesUKR/w2so
         7vuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhCunu7o7fyLkxoFCy5X4R/JUxZNFSkDzNenHSRMMQQ=;
        b=V137ikr7KZ2rzEgPLRATtvzqH53K6hfD9vK5TFWxZH81Wl9Poyh/aaTro6hr3NuURn
         mbAxphTxya9XxnQ4Dhr7w/lXr6GZBnFARBRYMukh32tR5iwOnqIPFMY1wI79STWwdUfv
         S2w4baSLJURLyxZBjwxhkz6LUfJYjXh0I3S1yUhxSxIRjbx/dY/gGzj/nDmLyY593xUj
         8azyl4ucl51c7Q6IAqXFe7Ag/1wngb/7jd5jdaE0MpFsc14DjpGjmCLLa8Cjpm7ZGHox
         7NP7CUcoax3ArQMrKB0JKZZjPrWiRC8iMuyqiThpXAktXC3X3L+zy2KGLyOCWtKL4PL4
         IKPQ==
X-Gm-Message-State: AJIora9t/bYWhDtvvwoU1mOOCQiPzZo6SjLnS8O/95rspTnrxxBm4T82
        qO1XEbosA6KoQpHDIpgozrg=
X-Google-Smtp-Source: AGRyM1tG2k/YpJN2FtkeEhUTabwe/2KLJDr/j982j5/jouqXLOKmkjFBIMDOPLtvpKixtVoYOKIdMA==
X-Received: by 2002:aa7:df12:0:b0:43a:4991:1725 with SMTP id c18-20020aa7df12000000b0043a49911725mr19304594edy.55.1657054562369;
        Tue, 05 Jul 2022 13:56:02 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id dm3-20020a05640222c300b0043a70c51470sm3836956edb.55.2022.07.05.13.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:56:01 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/5] ARM: DTS: qcom: fix dtbs_check warning with new rpmcc clocks
Date:   Tue,  5 Jul 2022 22:28:34 +0200
Message-Id: <20220705202837.667-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705202837.667-1-ansuelsmth@gmail.com>
References: <20220705202837.667-1-ansuelsmth@gmail.com>
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

Fix dtbs_check warning for new rpmcc Documentation changes and add the
required clocks.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 ++
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 ++
 arch/arm/boot/dts/qcom-msm8660.dtsi | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 91adcbd54b17..6a88e616ea01 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -853,6 +853,8 @@ rpm@108000 {
 			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-apq8064", "qcom,rpmcc";
 				#clock-cells = <1>;
+				clocks = <&pxo_board>, <&cxo_board>;
+				clock-names = "pxo", "cxo";
 			};
 
 			regulators {
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 4b475d98343c..1425a4e4283f 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -773,6 +773,8 @@ rpm: rpm@108000 {
 			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
 				#clock-cells = <1>;
+				clocks = <&pxo_board>;
+				clock-names = "pxo";
 			};
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index b9cded35b1cc..63a501c63cf8 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -56,7 +56,7 @@ cxo_board {
 			clock-frequency = <19200000>;
 		};
 
-		pxo_board {
+		pxo_board: pxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <27000000>;
@@ -411,6 +411,8 @@ rpm: rpm@104000 {
 			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-msm8660", "qcom,rpmcc";
 				#clock-cells = <1>;
+				clocks = <&pxo_board>;
+				clock-names = "pxo";
 			};
 
 			pm8901-regulators {
-- 
2.36.1

