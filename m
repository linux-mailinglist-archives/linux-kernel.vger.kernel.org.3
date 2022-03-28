Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9707B4E999E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243899AbiC1Ock (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbiC1Oce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:32:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725FC43AF5;
        Mon, 28 Mar 2022 07:30:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBA8CB81128;
        Mon, 28 Mar 2022 14:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283F2C34100;
        Mon, 28 Mar 2022 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648477850;
        bh=iY0oBcbrfcx72dXSODFvNoT62YnyauRm64dbK+nhK+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcsvghI1p32YDnBaCUpgR1mA7h3rKOxVfFq6Hbe5hPhPB1CZrFaJc5k3WUMpFodJo
         mZOf07DjjCSjXBdxT8vQjQlWIOgj5SpwHzTNC7TcpMZxmc/mvU/SVaO4JaCRH1vJr0
         I0Jr+8tLKzH+fXWlmDOKrs5NAvpayGWKHQ3CoX2vvNSa2dGylv5quvH3R8I3dvuiWD
         qEssqmevEGqZjhB7heRr6VB0OFyCEAEw60fSHRv2D4mDrbQNk7iBdV5jSFQufJE/SN
         WdGSoy0mYvCQlwCQy90ysfGuqFek2eY+HZnsIo4SukLdBbjVfeXIGI8simU0VF1Bv+
         TmcE969wzy9ow==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] arm64: dts: qcom: sm8350: move qup-opp-tables out of soc node
Date:   Mon, 28 Mar 2022 20:00:31 +0530
Message-Id: <20220328143035.519909-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328143035.519909-1-vkoul@kernel.org>
References: <20220328143035.519909-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 76 ++++++++++++++--------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index d242bab69c2e..846ddd290d08 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -340,6 +340,44 @@ CLUSTER_PD: cpu-cluster0 {
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
@@ -637,44 +675,6 @@ ipcc: mailbox@408000 {
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
 		qupv3_id_2: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x008c0000 0x0 0x6000>;
-- 
2.34.1

