Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BAA56B373
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiGHHZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbiGHHYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:24:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DE81837B;
        Fri,  8 Jul 2022 00:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11946621CD;
        Fri,  8 Jul 2022 07:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F50C341C0;
        Fri,  8 Jul 2022 07:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657265091;
        bh=DUtyY1YHWoJv3J3dWpcYBPdrvr1+jh1mszXtpz/A4VE=;
        h=From:To:Cc:Subject:Date:From;
        b=gMr1FArgGErDRnJxe78qkxJm8lOIfcWLxd1aS15NsHN1GAmWE8E0UuEyhUnBV4b/m
         QQeGdfrJiloWfwrormxh/Xhsw3JQcNfpk+rjBj06HIBIybkVBJk1D78uCPvkA4BNOE
         u4WFiQqwqviByQQHYQmbnjKzbMB23vmM9J5YammkSwsZXmTA+d50LIUocRsB75c7H1
         ybKgm3EDMFZVLQ2TTBseP0nGGAEKUzuv3kLM61qoYKknDYNJ1AijjImVGtsj8Qlx9P
         yu7Q7PU0M7Uu6NBTjggwRczLzMgb1G5zEkj/wsFW5HL0tgegOMBGDTZIzkdVvGbnbX
         BQ1OTEEOYwABQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o9iM9-0001Ce-BA; Fri, 08 Jul 2022 09:24:54 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp: fix usb_0 HS PHY ref clock
Date:   Fri,  8 Jul 2022 09:23:58 +0200
Message-Id: <20220708072358.4583-1-johan+linaro@kernel.org>
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

Fix the usb_0 HS PHY reference clock which was mistakingly replaced with
the first usb_2 PHY clock.

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index d0fabbf99ec5..9de6dedb102f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -985,7 +985,7 @@ usb_0_hsphy: phy@88e5000 {
 			compatible = "qcom,sc8280xp-usb-hs-phy",
 				     "qcom,usb-snps-hs-5nm-phy";
 			reg = <0 0x088e5000 0 0x400>;
-			clocks = <&gcc GCC_USB2_HS0_CLKREF_CLK>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "ref";
 			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
 
-- 
2.35.1

