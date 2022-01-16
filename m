Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8FF48FD03
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiAPMuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:50:04 -0500
Received: from mxwww.masterlogin.de ([95.129.51.170]:41532 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiAPMuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:50:03 -0500
Received: from mxout4.routing.net (unknown [192.168.10.112])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id 9B29F2C45D;
        Sun, 16 Jan 2022 12:49:25 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout4.routing.net (Postfix) with ESMTP id 19374100831;
        Sun, 16 Jan 2022 12:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1642337362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WiQVaK3pUcDZG2qVFe1jh3LhY+kB3zA5MYcwhdW6fWg=;
        b=MmAlMulOCJ8bwHyI6kNRiGOANqjqGCebTixbrsgoqligP9FWlr53II7pAwtWgUAmb1/e0A
        9uB9e9iJyjiqUj/iDIiZz80YAD+s01eM31Y+V+ZvJ0zTY/TFp5JoQ4OX81mh5RDi7zeyWn
        OHnk2NvX0xG/J+4hEY30VGQ+OnQC7fA=
Received: from localhost.localdomain (fttx-pool-80.245.74.150.bambit.de [80.245.74.150])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 8640336014D;
        Sun, 16 Jan 2022 12:49:21 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dts64: rk3568: drop pclk_xpcs from gmac0
Date:   Sun, 16 Jan 2022 13:49:09 +0100
Message-Id: <20220116124911.65203-2-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220116124911.65203-1-linux@fw-web.de>
References: <20220116124911.65203-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: b8095039-615f-4c07-8ac2-bd24ddf50522
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

pclk_xpcs is not supported and breaks dtbs_check, so remove it

following warnings occour, and many more

rk3568-evb1-v10.dt.yaml: ethernet@fe2a0000: clocks:
    [[15, 386], [15, 389], [15, 389], [15, 184], [15, 180], [15, 181],
    [15, 389], [15, 185], [15, 172]] is too long
	From schema: Documentation/devicetree/bindings/net/snps,dwmac.yaml
rk3568-evb1-v10.dt.yaml: ethernet@fe2a0000: clock-names:
    ['stmmaceth', 'mac_clk_rx', 'mac_clk_tx', 'clk_mac_refout', 'aclk_mac',
    'pclk_mac', 'clk_mac_speed', 'ptp_ref', 'pclk_xpcs'] is too long
	From schema: Documentation/devicetree/bindings/net/snps,dwmac.yaml

after removing the clock the other warnings are also gone.

Co-developed-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
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

