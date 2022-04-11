Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FA24FC15A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348290AbiDKPrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348205AbiDKPq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:46:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898D6B7C0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:44:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w18so18918524edi.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fU0hWQzn7l8dJNLIMz5BIxCZUns693+M8CLZSpbHGLA=;
        b=TMn/tnTA+w5TRa4vNuxS5vEJFOk5yiXG5dLIwTHI+6D9zp71rfgpAnjTEpO4zmD3di
         hSiK6prSo1T1hrLP4OM47zkcxCeGCa5N71/Mh043fmIZmyoawgPhb9oyqm0hnNcttIgq
         eo8c0K35dQmvk2Xi29V4HadfSMbrnFl0dnIKXUtPyuve7F32+GnsbY8KZUlrIxV8NU3K
         ON+HX/M+XVMrMprIQ/U1GhyrBbFH5yKRUhju/TgdlQUnk5iI7nSaznj2TIZXRmxYRGdg
         qYa+8sxevq25oPSMmILdZRNnK7rSZKDE3eEbIYoFm0jHR1/SjtBBdQosvohu0P5PBLY6
         fI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fU0hWQzn7l8dJNLIMz5BIxCZUns693+M8CLZSpbHGLA=;
        b=oCY1pT0lxDWjkSiY+i8Xvkxq6MsR0W5P+eu1fGcixXgNKIbEh72Lbbfr5gDkBvFML7
         BHi0w/iXBmtowWAxY94Hh2yuWabcHzvgyDWllydoQyv6TS28yDCgJemGEj310qReKrKf
         K6F3s5DuM6IVb49pLlDn1CYyLn2QWkDIs5aXoSAseIXgHu+eUStnFd/ZP5gN1JWPZ+ih
         TUXUDc3nRD/VoIx81oGU0I+vDoPoX4Lui1pDsJbi8mITuZ3Y23B0EQVL4JUgFytHo3jU
         0oH91Ae3ciGwVv5NPn6S5jcNcQUbtq8+DN9mpfUlYRcHvMdHahpbrp34TPNAzD4CdZda
         Cr9A==
X-Gm-Message-State: AOAM5338Ix1MehepZoB5jxX6qVglKSK15ZWYglqvI1YXCA6aR/0VVL0a
        AQa/koHVxVK2q9I6VWvbyPzjqA==
X-Google-Smtp-Source: ABdhPJyBq4Yl6LDEdydbHJ5/4b8uC0V4SNm/51/Z48/ZlLGb4PTPG74I33M/AeumvQmbioftCHhorw==
X-Received: by 2002:a05:6402:11cf:b0:41c:dbc7:79d2 with SMTP id j15-20020a05640211cf00b0041cdbc779d2mr34495460edw.50.1649691851702;
        Mon, 11 Apr 2022 08:44:11 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906608e00b006d1455acc62sm12173177ejj.74.2022.04.11.08.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:44:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC PATCH v2 6/6] arm64: dts: qcom: sdm845: control RPMHPD performance states with UFS
Date:   Mon, 11 Apr 2022 17:43:47 +0200
Message-Id: <20220411154347.491396-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
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

UFS, when scaling gears, should choose appropriate performance state of
RPMHPD power domain controller.  Since UFS belongs to UFS_PHY_GDSC power
domain, add necessary parent power domain to GCC.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 43 +++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b31bf62e8680..920e4b0c71cf 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1078,6 +1078,7 @@ gcc: clock-controller@100000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+			power-domains = <&rpmhpd SDM845_CX>;
 		};
 
 		qfprom@784000 {
@@ -2326,18 +2327,40 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
 				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
-			freq-table-hz =
-				<50000000 200000000>,
-				<0 0>,
-				<0 0>,
-				<37500000 150000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 300000000>;
 
+			operating-points-v2 = <&ufs_opp_table>;
 			status = "disabled";
+
+			ufs_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-50000000 {
+					opp-hz = /bits/ 64 <50000000
+						 0
+						 0
+						 37500000
+						 0
+						 0
+						 0
+						 0
+						 // FIXME: value 0 copied from freq-table-hz
+						 0>;
+					required-opps = <&rpmhpd_opp_svs>;
+				};
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000
+						 0
+						 0
+						 150000000
+						 0
+						 0
+						 0
+						 0
+						 300000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		ufs_mem_phy: phy@1d87000 {
-- 
2.32.0

