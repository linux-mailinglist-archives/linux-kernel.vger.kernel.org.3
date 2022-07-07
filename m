Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5717569AA3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiGGGmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiGGGmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:42:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1922A25F;
        Wed,  6 Jul 2022 23:42:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB86962244;
        Thu,  7 Jul 2022 06:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40070C3411E;
        Thu,  7 Jul 2022 06:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657176169;
        bh=7KNiT9A/9qFq7ecKeqsFpcWOS7hOTpqT2VHEnm4G894=;
        h=From:To:Cc:Subject:Date:From;
        b=f0RwdVKbw74IsgRyg8uZJLsTyMssitnBGuTPWReExo1AZoyrT8smYM24UvDjUAvEg
         9j5oVymhmN9kvLzyPWfruk/DApTHMLwbAh3Yiz1c7/O2/iVfSlmctn8c4TtoBJpsLH
         AaWMph0ao4Bli+kfeM2cj7e98XkqsQbBt18iEXE9DaXZ8Zu/XdbeOB7QnSzdE7d7ZT
         rs3b6/r8QzAU5OJBSWqtxhmbEhfGeUATbx3JK1fwcOdJebKl5e7NPjtch0PRJmtZKu
         0RVm0f0SWQyRDZCsZVYIOY9eslW3Ks7z/8oANDBTDQl8QiCEcL89U31xz3XLZMaf2I
         h99X8htfGmGJA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o9LDv-00045x-59; Thu, 07 Jul 2022 08:42:51 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sc7280: fix PCIe clock reference
Date:   Thu,  7 Jul 2022 08:42:22 +0200
Message-Id: <20220707064222.15717-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent commit that dropped the PCIe PHY clock index failed to update
the PCIe node reference.

Fixes: 531c738fb360 ("arm64: dts: qcom: sc7280: drop PCIe PHY clock index")
Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

The QMP DTS fixes were applied before I was able to send a v2 so here's
a follow-up fix for an issue caught by Dmitry during review.

Feel free to squash it in or apply on top.

Johan


 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index b0ae2dbba50f..9052c93c7845 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2035,7 +2035,7 @@ pcie1: pci@1c08000 {
 
 			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
 				 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
-				 <&pcie1_lane 0>,
+				 <&pcie1_lane>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_PCIE_1_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
-- 
2.35.1

