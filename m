Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBB0588C06
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiHCM0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237945AbiHCM0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D709D140C2;
        Wed,  3 Aug 2022 05:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7389F61335;
        Wed,  3 Aug 2022 12:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51D6C433C1;
        Wed,  3 Aug 2022 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659529554;
        bh=JksqEOHcOQcY9NA389jx3qM8+GNX/OiFQy05VDmzsvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WV+jicp3hjzi6yY2ZJgEmsW2gM6+Gfan3PckAX+n+a+Z3I2l0f1XVoWiGPgIhJEYS
         DCs8bC+pGqJknXC4gm9GoTjdZeS4YcWpgkBIFdRV3nVIx5f1CWim6PUwRAm+Xel2zF
         eidKBZNzJQO8W99cV1o64qy9lZU/4wUleGZOntEqQP7W5kNcotaIYsj/+xNZ3HTwlz
         EWrukm6Onu94VoHsFeHPBG8B1mzIbVW6NuaAbrB1r5bDcYmKMugkuLHEeuQhhtpkZr
         tH4e/vEUKqDEDeFGyYy62O5xGLG3X8OllHj7j8Q0G2kbrstNrsajCYV3Atw+VL1d7e
         SmXZLYXvmnNzg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJDS1-00021g-P5; Wed, 03 Aug 2022 14:26:13 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sa8295p-adp: disallow regulator mode switches
Date:   Wed,  3 Aug 2022 14:19:42 +0200
Message-Id: <20220803121942.30236-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220803121942.30236-1-johan+linaro@kernel.org>
References: <20220803121942.30236-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not allow the RPMh regulators to switch to low-power mode with an
exception for the UFS regulators (l3c, l6c, l10c and l17c) as UFS
supports an idle mode.

This specifically avoids having regulators be but in low-power mode when
only some consumers specify loads while the actual total load really
warrants high-power mode.

Fixes: 519183af39b2 ("arm64: dts: qcom: add SA8540P and ADP")
Link: https://lore.kernel.org/all/YtkrDcjTGhpaU1e0@hovoldconsulting.com
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index 9398f0349944..ca5f5ad32ce5 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -35,7 +35,6 @@ vreg_l3a: ldo3 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1208000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 
 		vreg_l5a: ldo5 {
@@ -43,7 +42,6 @@ vreg_l5a: ldo5 {
 			regulator-min-microvolt = <912000>;
 			regulator-max-microvolt = <912000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 
 		vreg_l7a: ldo7 {
@@ -51,7 +49,6 @@ vreg_l7a: ldo7 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 
 		vreg_l13a: ldo13 {
@@ -59,7 +56,6 @@ vreg_l13a: ldo13 {
 			regulator-min-microvolt = <3072000>;
 			regulator-max-microvolt = <3072000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 	};
 
@@ -72,7 +68,6 @@ vreg_l1c: ldo1 {
 			regulator-min-microvolt = <912000>;
 			regulator-max-microvolt = <912000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 
 		vreg_l2c: ldo2 {
@@ -80,7 +75,6 @@ vreg_l2c: ldo2 {
 			regulator-min-microvolt = <3072000>;
 			regulator-max-microvolt = <3072000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 
 		vreg_l3c: ldo3 {
@@ -96,7 +90,6 @@ vreg_l4c: ldo4 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1208000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 
 		vreg_l6c: ldo6 {
@@ -112,7 +105,6 @@ vreg_l7c: ldo7 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 
 		vreg_l10c: ldo10 {
@@ -141,7 +133,6 @@ vreg_l3g: ldo3 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 
 		vreg_l7g: ldo7 {
@@ -149,7 +140,6 @@ vreg_l7g: ldo7 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 
 		vreg_l8g: ldo8 {
@@ -157,7 +147,6 @@ vreg_l8g: ldo8 {
 			regulator-min-microvolt = <880000>;
 			regulator-max-microvolt = <880000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 	};
 };
-- 
2.35.1

