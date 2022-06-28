Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5609855ED0C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbiF1SuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbiF1Str (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:49:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCCC2494B;
        Tue, 28 Jun 2022 11:49:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sb34so27571562ejc.11;
        Tue, 28 Jun 2022 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3hs1h6z81DTKF28gSkM1hmpoN1hgElxYH3buRnm51V4=;
        b=Rz6A0UYLrFVNp59roNRJ/OoDCj8CZW2aTol+JZVxP5SBujZ6Ypnx1J0xJfuKQs+UhB
         dGRyvhNFoZ8oS62bC21BtO0w+9w3U9k6l2ZBBWYpfoCmUvXKZA90orDcwjP6wnC7GsHL
         ZnZWg7Lyf2xONtDn/eE31A4ihKiEEcLJM1doPEAMYi6oOveQnquwD7n9eG7fY9XuXs9F
         AhmU3XAUY4esVgzREu1ExKfofz0fd0KIFvym7/2RU6Cdqiqnrm1SazWSpoPw7TN6VaKO
         Pxb8D5rolp8rga4TvNMPpPsuB0fhtEwG+O5u7cAuT7Hh6kU52JuUeKCd1guXOJNfQujO
         AoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hs1h6z81DTKF28gSkM1hmpoN1hgElxYH3buRnm51V4=;
        b=MnowJGb0x7uT8EybC2oUJcuT2x39Wvinw4qiCi3wbIQ2vyjGQCAMr84cJEa29widDo
         VEPGAzgXYaTQB8A5t1BmVO6Ao768/ePacpT1Bf3o2sXAy/+NbtGifCKh5qXCIYpGmvM8
         YoKvGcMbfaHdzkiJc8m17oIuy5JfrSFsi3rK85hXZMiUXWzfaX++BQ2kMPCMQVthAoS6
         gPdFL7evsWTe5LmjclrF9hlhXaZyIZk6rnt+lxYU2T2FAsTv033qdJ6/kOUpxHMyG5ux
         5oIXHqGefIcJ/9HJDi15upBd3Ei/hhRKxH1zEUYNssrYQsue2phRatP89ntlLRlZSkdR
         o19Q==
X-Gm-Message-State: AJIora/5yL0LvG2ikp0BBsSPjx1fULBw8NE7VueIClxlNs0k9C8/IPPU
        DsafKQGR6dF+P2s3qEAadBA=
X-Google-Smtp-Source: AGRyM1sFNqH2o0iEzWOXlPTJ+cex7HQa6KdetSBAEqklx7/FKY8oRD+IXSINVWhZGuby7hfHm7tMtg==
X-Received: by 2002:a17:907:1b25:b0:6da:8206:fc56 with SMTP id mp37-20020a1709071b2500b006da8206fc56mr851746ejc.81.1656442184865;
        Tue, 28 Jun 2022 11:49:44 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id t21-20020a05640203d500b0043573c59ea0sm9747593edw.90.2022.06.28.11.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:49:44 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 4/4] ARM: dts: qcom: fix various wrong definition for kpss-gcc node
Date:   Tue, 28 Jun 2022 20:41:37 +0200
Message-Id: <20220628184137.21678-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628184137.21678-1-ansuelsmth@gmail.com>
References: <20220628184137.21678-1-ansuelsmth@gmail.com>
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

Fix dtbs_check warning now that we have a correct kpss-gcc yaml
schema. Add additional qcom,kpss-gcc compatible to differentiate
devices where kpss-gcc should provide a clk and where kpss-gcc should
just provide the registers and the syscon phandle.
Add missing #clock-cells and remove useless clock-output-names for
ipq806x.
Add missing binding for msm8090 kpss-gcc node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++--
 arch/arm/boot/dts/qcom-mdm9615.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi | 7 +++++--
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index a1c8ae516d21..a79eda05a7c2 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -836,7 +836,7 @@ mmcc: clock-controller@4000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible	= "qcom,kpss-gcc", "syscon";
+			compatible	= "qcom,kpss-gcc-apq8064", "qcom,kpss-gcc", "syscon";
 			reg		= <0x2011000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 996f4458d9fc..34b20b3d2243 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -780,11 +780,11 @@ tcsr: syscon@1a400000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
 			clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
 			clock-names = "pll8_vote", "pxo";
-			clock-output-names = "acpu_l2_aux";
+			#clock-cells = <0>;
 		};
 
 		lcc: clock-controller@28000000 {
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index 4d4f37cebf21..216668b4f274 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -152,7 +152,7 @@ lcc: clock-controller@28000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-mdm9615", "qcom,kpss-gcc", "syscon";
 			reg = <0x02011000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index a258abb23a64..db90f336f029 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -391,7 +391,7 @@ vibrator@4a {
 		};
 
 		l2cc: clock-controller@2082000 {
-			compatible	= "qcom,kpss-gcc", "syscon";
+			compatible	= "qcom,kpss-gcc-msm8660", "qcom,kpss-gcc", "syscon";
 			reg		= <0x02082000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 4a2d74cf01d2..a11a0fe7e0a9 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -63,7 +63,7 @@ cxo_board {
 			clock-output-names = "cxo_board";
 		};
 
-		pxo_board {
+		pxo_board: pxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <27000000>;
@@ -148,8 +148,11 @@ clock-controller@4000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible	= "qcom,kpss-gcc", "syscon";
+			compatible	= "qcom,kpss-gcc-msm8960", "qcom,kpss-gcc", "syscon";
 			reg		= <0x2011000 0x1000>;
+			clocks		= <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names	= "pll8_vote", "pxo";
+			#clock-cells	= <0>;
 		};
 
 		rpm@108000 {
-- 
2.36.1

