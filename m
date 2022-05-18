Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2160552B5FB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiERJUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiERJUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:20:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43379149DB0;
        Wed, 18 May 2022 02:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB64CB81EF6;
        Wed, 18 May 2022 09:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9EBC34115;
        Wed, 18 May 2022 09:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652865618;
        bh=GVtQ1D/5rasgxQKJP/2uiyFKctowcLcycCv/LRdZjec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OiZ7jcty3m3zGqp4Rd8NVqSOJ+Q91887HYZQ48ciu9sxP0kD8r7yy4zn5lcg7dqQ1
         N/C3Ds9jaDr4BFaLhZHipqD3XNRUQcWIlmI+kZuwBlQ8Wh7zL3+Jhb9s+BfDphS8Jj
         0YnbaBrBNzve13ETLIkk0ndPrLlwplN85MLQme9Ym7slr0zV82nqeMLZ2eF+pGZqgq
         xWFNR47k9TFTATA8vojVk/X30sQ0mx322k3YCqwMcXbtChOdcsQ34PqNHYEXv96Ba/
         Otk5iKgDfvppVS1kg526kkmd/WLw9lI5uy0qC8064mpGi3WpL5rwD6qepgqv8Vm9O/
         mPTNFtaVEE8Vw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm8250: Move qup-opp-table out of soc node
Date:   Wed, 18 May 2022 14:50:01 +0530
Message-Id: <20220518092001.2262024-4-vkoul@kernel.org>
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
index dc2562070336..1c2d85abf72e 100644
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

