Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B4E53E376
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiFFGvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiFFGuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:50:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5C163C4;
        Sun,  5 Jun 2022 23:50:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 180AF610E8;
        Mon,  6 Jun 2022 06:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2B1C341C0;
        Mon,  6 Jun 2022 06:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654498253;
        bh=Qk9/ffEjmSeLWVANW6nMVZzHlvbbvnY1jfXwQOlyMTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oB4A9SxEKzpeXcxXXB4jEzKPCpORgKx5WVhH6mfDFuLlxkjlv/oxzhovULD7gkBOD
         vykxFuBGZ8/27/S0Q7V8twyIODH0p29g3XPbNFhk3zqT5aLWvZjrge9ftUrCaz5W5F
         cMDgctVyIR860mOtnWwA1TuPiEg1Zx3zQeTrTGqHWYTWIxjRO5T2vIsctR2gYDt+cN
         C7JBfROjF3LBW9KHv4/sOX2YivREjYqA6RwmF+dF0w2AQU9zjbRAhoaWwdAFXN+rnS
         InNHYvo/xbTwi16+1i+Iq5OHUexQqWPi5whMlArs/34aogzqWc4QM3GIZQ7ytCGsbz
         M6WA+y3XFAuxA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/3] arm64: dts: qcom: sm8250: Move qup-opp-table out of soc node
Date:   Mon,  6 Jun 2022 12:20:35 +0530
Message-Id: <20220606065035.553533-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220606065035.553533-1-vkoul@kernel.org>
References: <20220606065035.553533-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The soc node expects all the nodes to have unit addresses. The
qup-opp-table does not have that which causes warnings:

arch/arm64/boot/dts/qcom/sm8250.dtsi:916.32-933.5:
	Warning (simple_bus_reg): /soc@0/qup-opp-table:
	missing or empty reg/ranges property

Move the qup-opp-table out of soc node to fix these warnings

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 38 ++++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index cf0c97bd5ad3..6fd30064ea74 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -702,6 +702,25 @@ CLUSTER_PD: cpu-cluster0 {
 		};
 	};
 
+	qup_opp_table: qup-opp-table {
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
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -914,25 +933,6 @@ rng: rng@793000 {
 			clock-names = "core";
 		};
 
-		qup_opp_table: qup-opp-table {
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
 			compatible = "qcom,sm8250-gpi-dma";
 			reg = <0 0x00800000 0 0x70000>;
-- 
2.34.1

