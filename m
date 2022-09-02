Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1485AA9BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbiIBIRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiIBIQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:16:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D18FBCC3B;
        Fri,  2 Sep 2022 01:16:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AF41620F9;
        Fri,  2 Sep 2022 08:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3FBC433B5;
        Fri,  2 Sep 2022 08:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662106616;
        bh=yTgawAW56lCntF7v9ECkXPcih/9P0T01LFVRxmmbYyQ=;
        h=From:To:Cc:Subject:Date:From;
        b=mWncWnoKf1DDggP6tvED/YdnsXXs4O2YISewwSI0Dx0kdjc3cEvWygLE2exxdW1SC
         Nd1NIlIz10is57sfJS4Bv30VTkwp1P3DdxkLZ1dZbf6BN9IoLWrJcrQqyrq+15gXFm
         fZiY80SnLWnYNpmUn2ZKkifKe2pCLg0kN9HFXQY2T2dhRBPXkFuB67J9TuCG/S5UZL
         h9CLHqA+Vh1eF57/rOMthAXzc2Bd6+ChZ+kGjB6JX9l9kUhq/yFbXcNJdCYijGk21P
         BCcpb2Bls6NXQIHKASGajiU3JytN6m3RzxMG5LoydOkojRtd9vX6cRBqNsdnQDUYSc
         ajWU6Ba65AqqQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oU1rH-0003Hu-7j; Fri, 02 Sep 2022 10:16:59 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp: mark USB controllers as wakeup-sources
Date:   Fri,  2 Sep 2022 10:16:52 +0200
Message-Id: <20220902081652.12631-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
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

The primary and secondary USB controllers can be used to wake the system
from suspend so mark them accordingly.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 3bbaec97aee9..e441d632c3e8 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1872,6 +1872,8 @@ usb_0: usb@a6f8800 {
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
+			wakeup-source;
+
 			status = "disabled";
 
 			usb_0_dwc3: usb@a600000 {
@@ -1924,6 +1926,8 @@ usb_1: usb@a8f8800 {
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
+			wakeup-source;
+
 			status = "disabled";
 
 			usb_1_dwc3: usb@a800000 {
-- 
2.35.1

