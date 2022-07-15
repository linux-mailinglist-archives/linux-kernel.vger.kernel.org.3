Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFE1576593
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiGOQ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbiGOQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:57:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324E07AB3F;
        Fri, 15 Jul 2022 09:57:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6C8C6221F;
        Fri, 15 Jul 2022 16:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1399BC34115;
        Fri, 15 Jul 2022 16:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657904236;
        bh=lTXY5Gcc+Y7ick0QSIPmtVgKN3YWDrJFLRIIWMaoFj0=;
        h=From:To:Cc:Subject:Date:From;
        b=kTp24Ltg2XWxJiXYdG9XYpFHTTqgCUqwgMMfL6BYpuQSq26ew5b8oZ2x/IghY71/b
         XwcEJmNXHQETPLW3PQYySu5z+ozk8eQWtKRbGqT52xY24ZSnY6xxyR5f0MzmcfNW2R
         HW6rt3Ox1sFJHsOw4suNBbGdmg+XJmG5EGzeLC14QmT252240mhJHjDJAhM/CWc7uq
         Ay0CfdCLJkWPQQeCppM/UjXGhlq+Ac9IPq0clb8YDm2uLLhnfQTf+y/5vGLyRMFfVG
         76LlP05DgmuaMwfkrgzY06xhdZIKDqNrgXpiBzVuo4CPa7pC/MD/kw9Zdf6cxgS5a0
         st4AVTEwyHkmg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oCOcz-0007XA-KN; Fri, 15 Jul 2022 18:57:22 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp: fix usb_1 ssphy irq
Date:   Fri, 15 Jul 2022 18:53:44 +0200
Message-Id: <20220715165344.28822-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Fix the usb_1 SS PHY interrupt, which was mistakingly replaced with one
of the usb_2 PHY interrupts.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Bjorn,

I pointed this one out during the review of the base dtsi:

	https://lore.kernel.org/lkml/YqDHjTkD%2FQZFS2Ub@hovoldconsulting.com/

but it never made it into the final submission.

This patch should be applied before the series I posted this morning:

	https://lore.kernel.org/lkml/20220715070248.19078-1-johan+linaro@kernel.org/

Johan


diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index a10af542942b..ee62556a1481 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1384,7 +1384,7 @@ usb_1: usb@a8f8800 {
 			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 12 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 13 IRQ_TYPE_EDGE_BOTH>,
-					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>;
+					      <&pdc 136 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
 					  "dm_hs_phy_irq", "ss_phy_irq";
 
-- 
2.35.1

