Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443214E999B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243919AbiC1Oco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243895AbiC1Oci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:32:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D87343AD1;
        Mon, 28 Mar 2022 07:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13C84B80E72;
        Mon, 28 Mar 2022 14:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEA3C34111;
        Mon, 28 Mar 2022 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648477853;
        bh=jU5fTmunGGnC6lg6eTG9ET0TEidj2lyYESe/UhhpeyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZdPwqDwlNXVOu/9uy/RIqXntzFR4QKlmbqhil5aUICYe7E7K9vlrqr0JHiWsLZNxP
         gA5iQylzDBLQ1IjtKcOb55x8drpLI43obqORFFmiW8FfdlCKIbEyBWoTXv43vJVK9C
         BhjNy3CL2NFldi05016nHu3bI9OTJHNQ+lKKR/5k9ew5H54SNxH5vRFsoGeMUQPiEo
         0zvSh/VFSBVP9UIA7uJ71F6DqnGYRTIUOR3rNB3SUfEPcG7wZLNHtg9EOKVBAo0ynl
         /JR3lAGjHB1CLApw4st+rhqAXH7QUJ9iy7ZtDg6iy45wR1NVVJniP/XhDxGGuO0sIw
         rFFyY7PejW51A==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: qcom: sm8250: move qup-opp-table out of soc node
Date:   Mon, 28 Mar 2022 20:00:32 +0530
Message-Id: <20220328143035.519909-4-vkoul@kernel.org>
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
qup-opp-table does not have that which causes warnings:

arch/arm64/boot/dts/qcom/sm8250.dtsi:916.32-933.5:
	Warning (simple_bus_reg): /soc@0/qup-opp-table:
	missing or empty reg/ranges property

Move the qup-opp-table out of soc node to fix these warnings

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 38 ++++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index fdaf303ba047..b120babdb26c 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -701,6 +701,25 @@ CLUSTER_PD: cpu-cluster0 {
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
@@ -913,25 +932,6 @@ rng: rng@793000 {
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

