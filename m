Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882914C5671
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiBZN6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiBZN6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:58:21 -0500
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9995F8F5;
        Sat, 26 Feb 2022 05:57:43 -0800 (PST)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout1.routing.net (Postfix) with ESMTP id 85F8E3FC87;
        Sat, 26 Feb 2022 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1645883861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bVy4jm/0n6LtIGvvpekwTvwzXdFxC3XUkQ0plnn+i6c=;
        b=YCr2TYbKjg67OIHcCrrw8dQnGhePpz/gnforAMYtmCV0AekiZz9HcGlwdNbFuIavVBpHR2
        qTkRpo8WaIpB+7RhUiV94eibXH6EbmlZLYcLUsj/6pXSaSdTxdc7zLXrg+zNo3HCE1yWIP
        5jVD+HhUIZbVGVClBT73kTX55blDlzw=
Received: from localhost.localdomain (fttx-pool-80.245.79.12.bambit.de [80.245.79.12])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id A6C008059A;
        Sat, 26 Feb 2022 13:57:40 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: rockchip: Add sata2 node to rk356x
Date:   Sat, 26 Feb 2022 14:57:24 +0100
Message-Id: <20220226135724.61516-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 83e05a4e-de96-4b8f-a355-cdcf1bc5b4d7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

RK356x supports up to 3 sata controllers which were compatible with the
existing snps,dwc-ahci binding.

My board has only sata2 connected to combphy2 so only add this one.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 7cdef800cb3c..7b6c8a0c8b84 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -230,6 +230,21 @@ scmi_shmem: sram@0 {
 		};
 	};
 
+	sata2: sata@fc800000 {
+		compatible = "snps,dwc-ahci";
+		reg = <0 0xfc800000 0 0x1000>;
+		clocks = <&cru ACLK_SATA2>, <&cru CLK_SATA2_PMALIVE>,
+			 <&cru CLK_SATA2_RXOOB>;
+		clock-names = "sata", "pmalive", "rxoob";
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "hostc";
+		phys = <&combphy2 PHY_TYPE_SATA>;
+		phy-names = "sata-phy";
+		ports-implemented = <0x1>;
+		power-domains = <&power RK3568_PD_PIPE>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller@fd400000 {
 		compatible = "arm,gic-v3";
 		reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
-- 
2.25.1

