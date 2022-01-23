Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7004971B0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 14:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiAWNkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 08:40:04 -0500
Received: from mxwww.masterlogin.de ([95.129.51.170]:46452 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiAWNkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 08:40:02 -0500
Received: from mxout2.routing.net (unknown [192.168.10.82])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id E8DB32C420;
        Sun, 23 Jan 2022 13:35:29 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id 75F2C5FD36;
        Sun, 23 Jan 2022 13:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1642944924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kyAI46PXFZta1W1LeVBMj4Z45GAo6fYKangEavewQgg=;
        b=AgK/n/8ym395X77+aJoMETITWME7G0FhMd2RmvbRvOAxSxI/lPKExo4HQIrSDSZGiLfOjA
        X8SCBvNUn0ObIrMRMVqeKaEdIKpdhubp1F5e111mLBrJfEz+/+sq4cEGAJ2k7GzkDgPa0e
        PSpHg9y8Pltqo8JfFXaoN339IJgBYAA=
Received: from localhost.localdomain (fttx-pool-80.245.79.232.bambit.de [80.245.79.232])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id AC2CC36019F;
        Sun, 23 Jan 2022 13:35:23 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v2] arm64: dts: rk3568: drop pclk_xpcs from gmac0
Date:   Sun, 23 Jan 2022 14:35:10 +0100
Message-Id: <20220123133510.135651-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 0bbcd62c-25de-453c-b067-23a97143c961
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

pclk_xpcs is not supported by mainline driver and breaks dtbs_check

following warnings occour, and many more

rk3568-evb1-v10.dt.yaml: ethernet@fe2a0000: clocks:
    [[15, 386], [15, 389], [15, 389], [15, 184], [15, 180], [15, 181],
    [15, 389], [15, 185], [15, 172]] is too long
	From schema: Documentation/devicetree/bindings/net/snps,dwmac.yaml
rk3568-evb1-v10.dt.yaml: ethernet@fe2a0000: clock-names:
    ['stmmaceth', 'mac_clk_rx', 'mac_clk_tx', 'clk_mac_refout', 'aclk_mac',
    'pclk_mac', 'clk_mac_speed', 'ptp_ref', 'pclk_xpcs'] is too long
	From schema: Documentation/devicetree/bindings/net/snps,dwmac.yaml

after removing it, the clock and other warnings are gone.

pclk_xpcs on gmac is used to support QSGMII, but this requires a driver
supporting it.
Once xpcs support is introduced, the clock can be added to the
documentation and both controllers.

Fixes: b8d41e5053cd ("arm64: dts: rockchip: add gmac0 node to rk3568")
Co-developed-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Michael Riesch <michael.riesch@wolfvision.net>
---
changes in v2:
  - rebase on 5.17-rc1
  - separate from bpi-r2pro series
  - changed commit-message

---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 2fd313a295f8..d91df1cde736 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -32,13 +32,11 @@ gmac0: ethernet@fe2a0000 {
 		clocks = <&cru SCLK_GMAC0>, <&cru SCLK_GMAC0_RX_TX>,
 			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_MAC0_REFOUT>,
 			 <&cru ACLK_GMAC0>, <&cru PCLK_GMAC0>,
-			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_GMAC0_PTP_REF>,
-			 <&cru PCLK_XPCS>;
+			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_GMAC0_PTP_REF>;
 		clock-names = "stmmaceth", "mac_clk_rx",
 			      "mac_clk_tx", "clk_mac_refout",
 			      "aclk_mac", "pclk_mac",
-			      "clk_mac_speed", "ptp_ref",
-			      "pclk_xpcs";
+			      "clk_mac_speed", "ptp_ref";
 		resets = <&cru SRST_A_GMAC0>;
 		reset-names = "stmmaceth";
 		rockchip,grf = <&grf>;
-- 
2.25.1

