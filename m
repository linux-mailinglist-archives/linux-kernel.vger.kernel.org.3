Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F355A9021
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiIAH0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiIAHZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:25:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE985723C;
        Thu,  1 Sep 2022 00:24:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s23so8514368wmj.4;
        Thu, 01 Sep 2022 00:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WeCYZ1NLeC6oWD37sHmXkbknX9yHBY6gYtZqQeU9o70=;
        b=Wiuhc43R0qeGSTJLrT6FAI5eGzncp2+QYzsCBo4E8/fHq4W8oarISlLFHcgCnbDqtl
         uTOD5Y5e1JMAGKPdQeh/tDvKZA/fgm2xg/pKOxLfceur4uQX1F+5SP7WFQwDxij6wtN1
         WEBWIHlbUa/KUyJZoLrAJtOLLhoDAwdWLLsVAlWpGi71G7gsGoufmAOADjUSHkqRVaAG
         g+Jj4Mdm8rAYaq9U25pZzroY17i/wiJBpaGHpsTiVPKLtk58gfgkmYtTF4yx3QUOy0Ql
         Sz+vL93cH/mGZtPZEM7III2mWvLsI8Qa4QAR9mwFa/4r35+6lRo3QPXT8nU6SYim5CXc
         Qg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WeCYZ1NLeC6oWD37sHmXkbknX9yHBY6gYtZqQeU9o70=;
        b=QvjlXub55vbk4IUtz/wRDFXn56zgSceq5jPfW8VIdzxAKxs+XeDwku8pHddEocqNIV
         p575HfL6TEUk2wnRIYqJ4qGrCy3mvwJkyOXsqif/WlWlTKhE4aGqMXeOq/3UgnDtR9vH
         ewR5ZzaJZYQ7FQAPT2jzHRhegSM/9JHsw5p67X4K62bgRfD5qXcyNJwZpHiIDQOKnZNX
         BLAvaWm7HlBz/nAimlT1Kq7SVjvG5sxqT2I8YEmBlt8YNSK7A9swR4DipSz6+Vv7LhmX
         vKDu7u2qKsQVQEjDfBLMS0E+vat13Lu13JsDPJvX2EV3mn6m3Z0VhRXLIkMToLuXxHxr
         yM+w==
X-Gm-Message-State: ACgBeo1xwMhiHcdCcjs0pWZchsfFta8vhjEw8VPs4fJ5iM7CJ1tV9Fok
        Ve/S32YiVUPxsYS7DsFjJyM=
X-Google-Smtp-Source: AA6agR5p2mYrRc/Bg7Ce6Ub0BdBarQijuTPpLXxdg0CpeqiO5OfVEIcAdI+7saDG/i55p6qj0TKNSA==
X-Received: by 2002:a05:600c:4f09:b0:3a8:3d5f:371f with SMTP id l9-20020a05600c4f0900b003a83d5f371fmr4159102wmq.94.1662017073210;
        Thu, 01 Sep 2022 00:24:33 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b003a319b67f64sm10887379wms.0.2022.09.01.00.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:24:32 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] arm64: dts: qcom: sm6115: Add pinctrl node
Date:   Thu,  1 Sep 2022 10:24:03 +0300
Message-Id: <20220901072414.1923075-5-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901072414.1923075-1-iskren.chernev@gmail.com>
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
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

Add support for the TLMM on the SM6115.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 5af915e80017..efbc81d2253b 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -388,6 +388,19 @@ soc: soc {
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		tlmm: pinctrl@500000 {
+			compatible = "qcom,sm6115-tlmm";
+			reg = <0x500000 0x400000>,
+				<0x900000 0x400000>,
+				<0xd00000 0x400000>;
+			reg-names = "west", "south", "east";
+			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 121>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+		};
+
 		gcc: clock-controller@1400000 {
 			compatible = "qcom,gcc-sm6115", "syscon";
 			reg = <0x1400000 0x1f0000>;
-- 
2.37.2

