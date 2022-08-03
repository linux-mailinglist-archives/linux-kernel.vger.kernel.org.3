Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4572D588BFF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiHCM0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbiHCM0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2450B7D7;
        Wed,  3 Aug 2022 05:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F13E61344;
        Wed,  3 Aug 2022 12:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B616DC433B5;
        Wed,  3 Aug 2022 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659529554;
        bh=Ee8Ex2lAJHZMMPLtvcNC2dV++DcwVP/e/tyfghv38Nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PiP60JnKyTqdfiPnpVM5/22PsHy4EtfqpXwF9jiYtH29wHYLtLjHDtHotTZraBvph
         JO1lmVzR0KcOJHSt+DhExaxtD5CDX5TO2CYRSquSqGQaOORBfeLcnu6dgAYGiLnjav
         fGq/p2XMNk6Gchhzsoe1semWHsQ5gha6+uj6oL92yupt36v9xyWyeULL+n2MGoHar0
         O8VCEWUGFKZG2vygw+Rh7sHK6kv3Rnrfw1jmyOfbsAC+h3DR9xdTrmP1/iBH7eNXuO
         XTjSs0AXmZwxlXxYZp99J080chP/+/XDjpAVowsn8SsI+fB7QvTwfvRAYOjv6F/Wb8
         lReaiQmbIMlcg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJDS1-00021c-K0; Wed, 03 Aug 2022 14:26:13 +0200
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
Subject: [PATCH 1/3] arm64: dts: qcom: sc8280xp-crd: disallow regulator mode switches
Date:   Wed,  3 Aug 2022 14:19:40 +0200
Message-Id: <20220803121942.30236-2-johan+linaro@kernel.org>
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
exception for the UFS regulators (l7c and l3d) as UFS supports an idle
mode.

This specifically avoids having regulators be but in low-power mode when
only some consumers specify loads while the actual total load really
warrants high-power mode.

Fixes: ccd3517faf18 ("arm64: dts: qcom: sc8280xp: Add reference device")
Link: https://lore.kernel.org/all/YtkrDcjTGhpaU1e0@hovoldconsulting.com
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 45058ad0a1c8..6792e88b2c6c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -87,7 +87,6 @@ vreg_l3b: ldo3 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 			regulator-boot-on;
 			regulator-always-on;
 		};
@@ -97,7 +96,6 @@ vreg_l4b: ldo4 {
 			regulator-min-microvolt = <912000>;
 			regulator-max-microvolt = <912000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 
 		vreg_l6b: ldo6 {
@@ -105,7 +103,6 @@ vreg_l6b: ldo6 {
 			regulator-min-microvolt = <880000>;
 			regulator-max-microvolt = <880000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 			regulator-boot-on;
 		};
 	};
@@ -119,7 +116,6 @@ vreg_l1c: ldo1 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 
 		vreg_l7c: ldo7 {
@@ -135,7 +131,6 @@ vreg_l13c: ldo13 {
 			regulator-min-microvolt = <3072000>;
 			regulator-max-microvolt = <3072000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 	};
 
@@ -158,7 +153,6 @@ vreg_l4d: ldo4 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 
 		vreg_l6d: ldo6 {
@@ -166,7 +160,6 @@ vreg_l6d: ldo6 {
 			regulator-min-microvolt = <880000>;
 			regulator-max-microvolt = <880000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 
 		vreg_l7d: ldo7 {
@@ -174,7 +167,6 @@ vreg_l7d: ldo7 {
 			regulator-min-microvolt = <3072000>;
 			regulator-max-microvolt = <3072000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 
 		vreg_l9d: ldo9 {
@@ -182,7 +174,6 @@ vreg_l9d: ldo9 {
 			regulator-min-microvolt = <912000>;
 			regulator-max-microvolt = <912000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
 		};
 	};
 };
-- 
2.35.1

