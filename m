Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1418B4A7A49
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347538AbiBBVY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347507AbiBBVYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:24:19 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404D1C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:24:19 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d5so514575pjk.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2cXStUZV/DOm3TsqdV/whSwf7t4bjeXpzaBygAmoNVI=;
        b=JmprhX1Jr++7BENYz/EHYTM042CmJVN+I81DJ7dtcITklD0jC8p5KI6VqOhO5xHfiA
         TWl9xcD8CGCCy6a9iPhMtG1ePob1sZ+tl3AfCzq7qreRqxhn/SW6Y2x8G2nheRkpV68e
         FCxGn1rAjpYm0lrdo3yEmK4TEvWzAMVOXJlzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2cXStUZV/DOm3TsqdV/whSwf7t4bjeXpzaBygAmoNVI=;
        b=zqKt5OoxJtwIUvXpl08qDwgxUDByKiIAskgUDtnBKtZdkvYLbtezIeWzPWluNcJQ4d
         ndXKEFFoVZoS70+3aJzMYS8s/SQWT/VR8r6JDKMVWzkXpqhQ+i2W1fB2Xfr8RwQENPeP
         KXOjN0qv6fkg1AONZ/Bq5onpUHMzmK7+vaPSF/SYyDOmJq45CRZrZpsS9MuybcunVjAl
         GAu9QUPf4dpoabBfg8n7ZZ96skfBFBKqYHwnem2djOhqEDhrQhF9P4vtrKtKKn1r1V7S
         TV0GVE54ztT5ss/yQT8n4L9C7tVw+IOlAcsH8qNWhN3kuvEl5NnPtn/gmlTAOZ6+vDY5
         rOBQ==
X-Gm-Message-State: AOAM533SkMf1DtZmpLDHaStz4tAvZ1dS+UiL/dh13li3UlqoIZU3h11N
        EwDPwMjpe9+jxDS8IfLVI0B9GA==
X-Google-Smtp-Source: ABdhPJwEvXg92MOi6sLLMMex8dQa5S8kCQnyi684dY54hTxZsaRcevI7hk93odxZwt2OoGBOC86imQ==
X-Received: by 2002:a17:902:ed44:: with SMTP id y4mr33302728plb.152.1643837058791;
        Wed, 02 Feb 2022 13:24:18 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f1c4:10b6:b4ef:16e5])
        by smtp.gmail.com with ESMTPSA id on9sm7627983pjb.16.2022.02.02.13.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:24:18 -0800 (PST)
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
Subject: [PATCH v3 06/14] arm64: dts: qcom: sc7280: Fix sort order of dp_hot_plug_det / pcie1_clkreq_n
Date:   Wed,  2 Feb 2022 13:23:40 -0800
Message-Id: <20220202132301.v3.6.I874c6f2a62b7922a33e10d390a8983219a76250b@changeid>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202212348.1391534-1-dianders@chromium.org>
References: <20220202212348.1391534-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two nodes were mis-sorted. Reorder. This is a no-op change.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("Fix sort order of dp_hot_plug_det") new for v3.

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 5b1e23991a6a..4d5892411a38 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3271,6 +3271,12 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 175>;
 			wakeup-parent = <&pdc>;
 
+			dp_hot_plug_det: dp-hot-plug-det {
+				pins = "gpio47";
+				function = "dp_hot";
+				bias-disable;
+			};
+
 			pcie1_clkreq_n: pcie1-clkreq-n {
 				pins = "gpio79";
 				function = "pcie1_clkreqn";
@@ -3278,12 +3284,6 @@ pcie1_clkreq_n: pcie1-clkreq-n {
 				bias-pull-up;
 			};
 
-			dp_hot_plug_det: dp-hot-plug-det {
-				pins = "gpio47";
-				function = "dp_hot";
-				bias-disable;
-			};
-
 			qspi_clk: qspi-clk {
 				pins = "gpio14";
 				function = "qspi_clk";
-- 
2.35.0.rc2.247.g8bbb082509-goog

