Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB5E4A53E0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiBAALM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiBAALJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:11:09 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FB6C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:11:09 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso844507pjv.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jbIE4iuiA0p3DjnEE2VhYT924iZ27y8GMOMWERDoj6A=;
        b=OUWPsi1/Y+JAKuLZjECoWQW2sonq0TknP/4cgf4+0y+2uLXtC184hrb1QN5+CWKCMy
         pxYL3AhhLDG61jFr+SdrYuMzufh7y7MDyr5ImVL7NkepEPmmV4NI59U3cmrPnqY3dfMn
         mDFW0uRrAzFmwzv81yqUN+LV+r62ytVic0LYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jbIE4iuiA0p3DjnEE2VhYT924iZ27y8GMOMWERDoj6A=;
        b=OP6C+ig3bM5PESB006nfmAynfOwXlS6I5n/zhFM5xtdxHsJtl4nMub/WA1iRayo5EC
         VrxXYIGbLg48PnjaQCesuoUWWCNQiU+J1y8feKIcRvr8z+xdSBsw6NFCvk5Vbkrj4Axq
         2MFetqqBHY/wwOjPffaDQ7BV9CXscljeGglJOLhYDpqqYdhJbkc27V7EkPkRiI/h16xD
         ExH8EUzjpKDHNlP9DgXbjzRLmyOKDUu+gjSvAOEOqEUQqK6yqe7deKpVFsla+aBdhFFe
         l3THTxMPw9Qrrx9aJKAjkVCLp4XGHUKeW5yG17hG71nt5zSfuF6X+AR7EGIztiqiBbHO
         MDAw==
X-Gm-Message-State: AOAM532n5YEafrfGA7aQ61Ycb8tppXUZWSOXQkiZu26mH0JDbJKYZfUa
        MfR5QX9g35WrsoyApDybqIBIOw==
X-Google-Smtp-Source: ABdhPJzk2QTnYgsMXAr7flyx95am+/DRTFm1A6vcXKURNula+eGCbfoSDdW9gaIfKX83NuPzNJWM9A==
X-Received: by 2002:a17:90b:1c0f:: with SMTP id oc15mr29904694pjb.17.1643674268851;
        Mon, 31 Jan 2022 16:11:08 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:c47e:986d:769b:ead2])
        by smtp.gmail.com with ESMTPSA id oj5sm424024pjb.53.2022.01.31.16.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 16:11:08 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>, mka@chromium.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64: dts: qcom: sc7280: Properly sort sdc pinctrl lines
Date:   Mon, 31 Jan 2022 16:10:40 -0800
Message-Id: <20220131161034.3.I6ae594129a8ad3d18af9f5ebffd895b4f6353a0a@changeid>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220201001042.3724523-1-dianders@chromium.org>
References: <20220201001042.3724523-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdc1 / sdc2 pinctrl lines were randomly stuffed in the middle of
the qup pinctrl lines. Sort them properly. This is a no-op
change. Just code movement.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

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

