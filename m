Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6824A7A42
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347544AbiBBVYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347516AbiBBVYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:24:16 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1544C061749
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:24:14 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i30so404807pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bVsy7mC6OV+ZTsuxBz1mInaazBNug7TJhIqUVGCCLhk=;
        b=kjWq5FRKAbdMqgqWGIjewgpnPLPgdl86CapN4dR3ymRmPRue1Ctp3PMge7SUPhP6Mo
         TkZtMJZKiLs/UaQRfdh2N8SLHAFoUTqXVtNieUprqXxJfRLR8G5P6WGdcWkaVa89+7KC
         FoedlrfFlbgpw+h4pyM8tsZQQH6uMlNPaH4CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVsy7mC6OV+ZTsuxBz1mInaazBNug7TJhIqUVGCCLhk=;
        b=M0vJCC+njqsBWBzkc1p5iqJgN1VC73qKIHf3EeYDeSiimAsLJfKVQjciDi3n6KLELT
         9ZkNP0BC8rKX9bb5ECS5DuuRKmx8xwcHfplz7DEwgQNUKtH2MNKTq/PU/i4uWljNDRGZ
         662ewaeeT1dOtToRmgwkRZ9OG4i9TRTuqWxsktbSB03B8t79Z3lAltfGIENUADrJQqo0
         LSinfqnIzJkQLcYFF12NChQuKW1QQ8tIbVcvbK5qzaW5Ksw/QWCkIc+ILfDhZwPOEF9s
         8k0mdL1gJtzm7tCz455fppxZ7iRMQY6FLCnQGgYwtCaksNZPwEAVSmIxb2QT29k85NQu
         E+eA==
X-Gm-Message-State: AOAM530OQqxC+2Pmwcf4AgJsSMpR0mBGKpiwKxVczGuCUUlnivFKEXEB
        V3aWiAGQDF1i8G+IR0AnMtNybA==
X-Google-Smtp-Source: ABdhPJzXn9MxY83qUZRRch/YRy6F25vBzkegCXgRiqWSKcNcpiOfvYbbRC1pqmzeFm+im8dqVcHNHw==
X-Received: by 2002:a05:6a00:1345:: with SMTP id k5mr31488525pfu.37.1643837054360;
        Wed, 02 Feb 2022 13:24:14 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f1c4:10b6:b4ef:16e5])
        by smtp.gmail.com with ESMTPSA id on9sm7627983pjb.16.2022.02.02.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:24:13 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     pmaliset@codeaurora.org, mka@chromium.org,
        quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org, konrad.dybcio@somainline.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        sibis@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/14] arm64: dts: qcom: sc7280: Properly sort sdc pinctrl lines
Date:   Wed,  2 Feb 2022 13:23:37 -0800
Message-Id: <20220202132301.v3.3.I6ae594129a8ad3d18af9f5ebffd895b4f6353a0a@changeid>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202212348.1391534-1-dianders@chromium.org>
References: <20220202212348.1391534-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdc1 / sdc2 pinctrl lines were randomly stuffed in the middle of
the qup pinctrl lines. Sort them properly. This is a no-op
change. Just code movement.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 154 +++++++++++++--------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index d4009cc0bb78..40cb414bc377 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3783,83 +3783,6 @@ qup_uart7_rx: qup-uart7-rx {
 				function = "qup07";
 			};
 
-			sdc1_on: sdc1-on {
-				clk {
-					pins = "sdc1_clk";
-				};
-
-				cmd {
-					pins = "sdc1_cmd";
-				};
-
-				data {
-					pins = "sdc1_data";
-				};
-
-				rclk {
-					pins = "sdc1_rclk";
-				};
-			};
-
-			sdc1_off: sdc1-off {
-				clk {
-					pins = "sdc1_clk";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
-
-				cmd {
-					pins = "sdc1_cmd";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
-
-				data {
-					pins = "sdc1_data";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
-
-				rclk {
-					pins = "sdc1_rclk";
-					bias-bus-hold;
-				};
-			};
-
-			sdc2_on: sdc2-on {
-				clk {
-					pins = "sdc2_clk";
-				};
-
-				cmd {
-					pins = "sdc2_cmd";
-				};
-
-				data {
-					pins = "sdc2_data";
-				};
-			};
-
-			sdc2_off: sdc2-off {
-				clk {
-					pins = "sdc2_clk";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
-
-				cmd {
-					pins ="sdc2_cmd";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
-
-				data {
-					pins ="sdc2_data";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
-			};
-
 			qup_uart8_cts: qup-uart8-cts {
 				pins = "gpio32";
 				function = "qup10";
@@ -4019,6 +3942,83 @@ qup_uart15_rx: qup-uart15-rx {
 				pins = "gpio63";
 				function = "qup17";
 			};
+
+			sdc1_on: sdc1-on {
+				clk {
+					pins = "sdc1_clk";
+				};
+
+				cmd {
+					pins = "sdc1_cmd";
+				};
+
+				data {
+					pins = "sdc1_data";
+				};
+
+				rclk {
+					pins = "sdc1_rclk";
+				};
+			};
+
+			sdc1_off: sdc1-off {
+				clk {
+					pins = "sdc1_clk";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				cmd {
+					pins = "sdc1_cmd";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				data {
+					pins = "sdc1_data";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				rclk {
+					pins = "sdc1_rclk";
+					bias-bus-hold;
+				};
+			};
+
+			sdc2_on: sdc2-on {
+				clk {
+					pins = "sdc2_clk";
+				};
+
+				cmd {
+					pins = "sdc2_cmd";
+				};
+
+				data {
+					pins = "sdc2_data";
+				};
+			};
+
+			sdc2_off: sdc2-off {
+				clk {
+					pins = "sdc2_clk";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				cmd {
+					pins ="sdc2_cmd";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				data {
+					pins ="sdc2_data";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+			};
 		};
 
 		imem@146a5000 {
-- 
2.35.0.rc2.247.g8bbb082509-goog

