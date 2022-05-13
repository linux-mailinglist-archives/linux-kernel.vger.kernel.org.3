Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F331525B51
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377265AbiEMGOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377224AbiEMGOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:14:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FF226FA01
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:14:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q23so10015938wra.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZOjg8XaBh6CCn6Js3G6uXfs3Op7yvcsYaras8GIlj8=;
        b=mQSh+ms5+NL9ibLzhzevs3/7uTZWbcZSWelheKfn5E66Rm84nIBINpLsidC1xbazL4
         ZkVzZ2AWThUzGbRkvSYVkwTwjyFhVD25zTEPUcJg9L7OaoqmvwO/cWckLFXYs0kALyjl
         r5Ib42OtKSswbevBRFxUqk3laoOMdp/9qfUsFoENplsmwjTMmAFxeZpgccTfJUoUO9vU
         bkP0/73/2NNzkbDIM4jFAqa9GBMMqTfCuPqm7jkKvEmSuN88QRb0ienHxf2eUmm+18cP
         3Y9zb4NXVi3M4yr5E6YNPPWsZfxPLnF0xVYdjoZnYVESZuWg7yuAw9fYg4v/r2tS7YBA
         SqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZOjg8XaBh6CCn6Js3G6uXfs3Op7yvcsYaras8GIlj8=;
        b=eUKzsAySr5XTuYeps6T88JV57oFa21KFzLMVlGdCfP3rukG4gKNMkT5E/uHjeSERmJ
         URAR+Yp8UxQAPHaa7jMhCe9JnxyH3fSTjVeNHEtsOrSLUKY1+yEwBHet6eVHCj2rCeAz
         aKk7fA6R2LGYoT20VuIBc6eFii4UnFtDvy7y2HX+1aICaMt4/jiEg9AG9ofC72sjB/VZ
         ZtvAbAnByR6M856kRCq3P2ljri/wf0NECsKx5UxOKJdg+Z4kVzmbB7XaL0z0sGnJhXpH
         E8tgQKmxAl/rS4bpQQoRfYggkc6mHu/NZuQRKsHszdbjmq3Mv9NBwRUAhZB2P23Gtrjo
         W6eA==
X-Gm-Message-State: AOAM530zP18kSDoXQwTPTkwDUnMwDDA4C62ica7TG/HLQl6bh9E1YB+t
        hCxbINgR2WW+v5SYp9c18TrDlg==
X-Google-Smtp-Source: ABdhPJx2CIvfrYk5wtBGS086/J/W4yDfOHmMCCEUwK9Xdb+yFj+w25mFVpRT7qXoE/PEk1kDR64olw==
X-Received: by 2002:a5d:6d0b:0:b0:20c:4ec7:8e84 with SMTP id e11-20020a5d6d0b000000b0020c4ec78e84mr2413197wrq.281.1652422457425;
        Thu, 12 May 2022 23:14:17 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g4-20020adfbc84000000b0020c5253d8f3sm1477760wrh.63.2022.05.12.23.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 23:14:16 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 4/7] arm64: dts: qcom: sdm845: control RPMHPD performance states with UFS
Date:   Fri, 13 May 2022 08:13:44 +0200
Message-Id: <20220513061347.46480-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
References: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
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

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 43 +++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 692cf4be4eef..befcdd04d832 100644
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

