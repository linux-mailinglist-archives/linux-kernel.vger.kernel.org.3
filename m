Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45E24EFAD1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351717AbiDAUMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351708AbiDAUMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:12:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E08215931
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:10:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b15so4244549edn.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sPCP8q2t9mmowMCPujklX+PmP86KwmADww9ebRiXDzI=;
        b=GhS363ByZRL86Pn4YX8QGeTEZNgcgve9rTtFhLsS6bfdKrvWBwj5oY8x5J9F2HfuCw
         ntx5GCboVcvYtoBfU5vFRJFlLkxNeOMIaqI8H9mmAGU1T0QP0qetLL6RDFLdg9VpBeZP
         bAqed/UQPjQgnOg/QA9bcvxkHke8iZ98KOl671sIP2vtyGdKSk3yu40naSh7LvNems29
         IDMAf1PZjfeahL6DCkr2ZUlnN9vzYKbMW+0pubDA1OBpl0bWnDXW2MMw4Jbww4YKytqV
         n5IW/G778o+MzJjO9FEXFKOsoq8JWdjdEmdQYdbxl6Pz0kd6onyIwam9uQumYGEtVC9s
         Q1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sPCP8q2t9mmowMCPujklX+PmP86KwmADww9ebRiXDzI=;
        b=VkYwq/EOwmnTquNdjnbEVpL7alCsLFC7f4NCNk0VXu/MOxxr0aOuYAA2Dt3d3xBkf4
         cZyBc1uX2yCp5WslzzlHBVFRJc6aWb4FNJTBkvvkxBN6KOLAabtCtKkWA4xNbAAkQloA
         K6BrKCNb92kVmkWuRDpUK6yWidaMnmRzTlQU7zCp1BeZHponsAK606Ysn2+a8N8XmSfU
         aY7C9iKMwof03z9EHJaG6Rxhgk5j4Sf5bsH9ZHTLGndCtq/ysZjTLhoRVAXjMlvlP4oW
         DE9/XvTS+zx2ev1hZ5cx8CiURPh5HRcBXkjHzNfuSenvB19JaemVRLadHoezTuVbv6d3
         dLfQ==
X-Gm-Message-State: AOAM532jTj6WwvWoebhuFZc20ojLDVOoifDxth+YpsUxfz+27kJ4g5UZ
        pTmzsrzKGFt0dEnnzr7d1zaUkQ==
X-Google-Smtp-Source: ABdhPJxO17RtK3iw3c/J8HVKLZjSSJh2uya5eLbv6I7iVraHoeBQFAiBf5MNJGKlZV3bDnlQ4kmZzA==
X-Received: by 2002:a05:6402:2794:b0:419:2ea9:7de3 with SMTP id b20-20020a056402279400b004192ea97de3mr22563439ede.169.1648843845493;
        Fri, 01 Apr 2022 13:10:45 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm1509041edb.27.2022.04.01.13.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:10:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/10] arm64: dts: qcom: add RPM clock controller fallback compatible
Date:   Fri,  1 Apr 2022 22:10:28 +0200
Message-Id: <20220401201035.189106-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
References: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
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

The bindings require a fallback compatible to RPM clock controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8992.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e34963505e07..cf0482fdf69d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -299,7 +299,7 @@ rpm_requests: rpm-requests {
 				qcom,smd-channels = "rpm_requests";
 
 				rpmcc: clock-controller {
-					compatible = "qcom,rpmcc-msm8916";
+					compatible = "qcom,rpmcc-msm8916", "qcom,rpmcc";
 					#clock-cells = <1>;
 				};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index aca13760bb75..4fa0091d7a5e 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -326,7 +326,7 @@ rpm_requests: rpm-requests {
 				qcom,smd-channels = "rpm_requests";
 
 				rpmcc: rpmcc {
-					compatible = "qcom,rpmcc-msm8953";
+					compatible = "qcom,rpmcc-msm8953", "qcom,rpmcc";
 					clocks = <&xo_board>;
 					clock-names = "xo";
 					#clock-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index 58fe58cc7703..c286381240ed 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -11,7 +11,7 @@
 /delete-node/ &cpu7_map;
 
 &rpmcc {
-	compatible = "qcom,rpmcc-msm8992";
+	compatible = "qcom,rpmcc-msm8992", "qcom,rpmcc";
 };
 
 &tcsr_mutex {
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 1ff7e2c03ce3..a36b1c7cf10e 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -240,7 +240,7 @@ rpm_requests: rpm-requests {
 				qcom,smd-channels = "rpm_requests";
 
 				rpmcc: rpmcc {
-					compatible = "qcom,rpmcc-msm8994";
+					compatible = "qcom,rpmcc-msm8994", "qcom,rpmcc";
 					#clock-cells = <1>;
 				};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index f0f81c23c16f..527afc90d9ef 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -456,7 +456,7 @@ rpm_requests: rpm-requests {
 			qcom,glink-channels = "rpm_requests";
 
 			rpmcc: qcom,rpmcc {
-				compatible = "qcom,rpmcc-msm8996";
+				compatible = "qcom,rpmcc-msm8996", "qcom,rpmcc";
 				#clock-cells = <1>;
 			};
 
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 3f06f7cd3cf2..f0ade6a03208 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -226,7 +226,7 @@ rpm_requests: glink-channel {
 			qcom,glink-channels = "rpm_requests";
 
 			rpmcc: clock-controller {
-				compatible = "qcom,rpmcc-qcs404";
+				compatible = "qcom,rpmcc-qcs404", "qcom,rpmcc";
 				#clock-cells = <1>;
 			};
 
-- 
2.32.0

