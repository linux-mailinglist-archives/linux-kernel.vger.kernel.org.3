Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE0A52B60D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiERJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiERJUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4D9149D83;
        Wed, 18 May 2022 02:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4FAA616EE;
        Wed, 18 May 2022 09:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E57C385A5;
        Wed, 18 May 2022 09:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652865615;
        bh=dVZYSzx+0qQBUTfJJpAOYcy8u90n3GUuzGRiIDYrCuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpaEEGUbE8KBow5df1dmVhKtl8p3xqzGr5H8EAoYPKr42TZwh2GMWKSPUPapbMbwb
         TJoELzACbt0LlVYA4PGpxQ3bcjtAr3Wa///UFrIJ++id6AoUqsEPAfjOqL5+SMW5o8
         AuyFfTJ4JImFVvnJu036lFWTBIeKgiEzi9MtZcE1oiJOMnIj4XEXX8R3STjCF1Ln2z
         meH5Fznl+/txnuGA3+UUCy/DH5RJ3u1x8BeWVbK8DD46IfrFG3bg4tsCA9hJ1+DqsB
         1Z7J7Py8jaNwyrbTHiRsSPvmnkMg/zMG/m8sBqv8CKuWCHft2tQl56aqtjO3iAkiNA
         2vrEI5wkA7C1A==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] arm64: dts: qcom: sm8350: Move qup-opp-tables out of soc node
Date:   Wed, 18 May 2022 14:50:00 +0530
Message-Id: <20220518092001.2262024-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220518092001.2262024-1-vkoul@kernel.org>
References: <20220518092001.2262024-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The soc node expects all the nodes to have unit addresses. The
qup-opp-tables do not have that which causes warnings:

arch/arm64/boot/dts/qcom/sm8350.dtsi:640.46-657.5:
	Warning (simple_bus_reg): /soc@0/qup-100mhz-opp-table:
	missing or empty reg/ranges property
arch/arm64/boot/dts/qcom/sm8350.dtsi:659.46-676.5:
	Warning (simple_bus_reg): /soc@0/qup-120mhz-opp-table:
	missing or empty reg/ranges property

Move the qup-opp-tables out of soc node to fix these warnings

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 76 ++++++++++++++--------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index c0137bdcf94b..8d1efe2704ec 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -341,6 +341,44 @@ CLUSTER_PD: cpu-cluster0 {
 		};
 	};
 
+	qup_opp_table_100mhz: qup-100mhz-opp-table {
+		compatible = "operating-points-v2";
+
+		opp-50000000 {
+			opp-hz = /bits/ 64 <50000000>;
+			required-opps = <&rpmhpd_opp_min_svs>;
+		};
+
+		opp-75000000 {
+			opp-hz = /bits/ 64 <75000000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			required-opps = <&rpmhpd_opp_svs>;
+		};
+	};
+
+	qup_opp_table_120mhz: qup-120mhz-opp-table {
+		compatible = "operating-points-v2";
+
+		opp-50000000 {
+			opp-hz = /bits/ 64 <50000000>;
+			required-opps = <&rpmhpd_opp_min_svs>;
+		};
+
+		opp-75000000 {
+			opp-hz = /bits/ 64 <75000000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
+		opp-120000000 {
+			opp-hz = /bits/ 64 <120000000>;
+			required-opps = <&rpmhpd_opp_svs>;
+		};
+	};
+
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -638,44 +676,6 @@ ipcc: mailbox@408000 {
 			#mbox-cells = <2>;
 		};
 
-		qup_opp_table_100mhz: qup-100mhz-opp-table {
-			compatible = "operating-points-v2";
-
-			opp-50000000 {
-				opp-hz = /bits/ 64 <50000000>;
-				required-opps = <&rpmhpd_opp_min_svs>;
-			};
-
-			opp-75000000 {
-				opp-hz = /bits/ 64 <75000000>;
-				required-opps = <&rpmhpd_opp_low_svs>;
-			};
-
-			opp-100000000 {
-				opp-hz = /bits/ 64 <100000000>;
-				required-opps = <&rpmhpd_opp_svs>;
-			};
-		};
-
-		qup_opp_table_120mhz: qup-120mhz-opp-table {
-			compatible = "operating-points-v2";
-
-			opp-50000000 {
-				opp-hz = /bits/ 64 <50000000>;
-				required-opps = <&rpmhpd_opp_min_svs>;
-			};
-
-			opp-75000000 {
-				opp-hz = /bits/ 64 <75000000>;
-				required-opps = <&rpmhpd_opp_low_svs>;
-			};
-
-			opp-120000000 {
-				opp-hz = /bits/ 64 <120000000>;
-				required-opps = <&rpmhpd_opp_svs>;
-			};
-		};
-
 		gpi_dma2: dma-controller@800000 {
 			compatible = "qcom,sm8350-gpi-dma";
 			reg = <0 0x00800000 0 0x60000>;
-- 
2.34.1

