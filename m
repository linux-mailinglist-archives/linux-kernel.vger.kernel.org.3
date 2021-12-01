Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4075846488F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347579AbhLAHeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347537AbhLAHdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5376FC06175C;
        Tue, 30 Nov 2021 23:30:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9FCE3CE1D67;
        Wed,  1 Dec 2021 07:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C7FC53FD2;
        Wed,  1 Dec 2021 07:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343800;
        bh=O3yKs0vj19W5/BZ/Tdv8ra+JxyZYiCDB3WZbbopGoNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CKfWPz/ywrjiFAqe+TH4KwsnbY7lON0wrCdS1J/EFEfmoC0Cmne5FJ5TvtKL4Rc4m
         c6iQwTbR7vR/aY4mEsjiET5CG1mL18l75+jeaeRQEb6BQJPV7bcRCIWfShfmIIwZ3y
         CMv0+llIQIKRndOZyJu+xGHHAXF04mx7Uo8t2RHmPbkHIz1/zGr2epAU//djG4lvpt
         1ApFj5VtsbcpGvRZ32cFHXesb9KmVU2L5/ob9YQuTrSVSkqjDdcJ2598bW1Lvv/r/Z
         j0knfwdviW7eGqVCaRI4GLI/BLj2AjtehOzeWD2vyAh5hhOBE1O2I9moGsk4kn2qcX
         UfF9ib3Q8If2w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 13/15] arm64: dts: qcom: sm8450: Add rpmhpd node
Date:   Wed,  1 Dec 2021 12:59:13 +0530
Message-Id: <20211201072915.3969178-14-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072915.3969178-1-vkoul@kernel.org>
References: <20211201072915.3969178-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

This adds RPMH power domain found in SM8450 SoC

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 52 ++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 25d93a51ac19..8f0819df8039 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/qcom,gcc-sm8450.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interconnect/qcom,sm8450.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -889,6 +890,57 @@ rpmhcc: clock-controller {
 				clock-names = "xo";
 				clocks = <&xo_board>;
 			};
+
+			rpmhpd: power-controller {
+				compatible = "qcom,sm8450-rpmhpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmhpd_opp_table>;
+
+				rpmhpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmhpd_opp_ret: opp1 {
+						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+					};
+
+					rpmhpd_opp_min_svs: opp2 {
+						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+					};
+
+					rpmhpd_opp_low_svs: opp3 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					};
+
+					rpmhpd_opp_svs: opp4 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					};
+
+					rpmhpd_opp_svs_l1: opp5 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					};
+
+					rpmhpd_opp_nom: opp6 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					};
+
+					rpmhpd_opp_nom_l1: opp7 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					};
+
+					rpmhpd_opp_nom_l2: opp8 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
+					};
+
+					rpmhpd_opp_turbo: opp9 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					};
+
+					rpmhpd_opp_turbo_l1: opp10 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					};
+				};
+			};
+
 		};
 
 		gem_noc: interconnect@19100000 {
-- 
2.31.1

