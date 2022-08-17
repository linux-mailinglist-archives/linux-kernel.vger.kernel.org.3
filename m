Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792DE5979A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiHQWbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbiHQWbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:31:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B3A89CFD;
        Wed, 17 Aug 2022 15:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A572FB81FC3;
        Wed, 17 Aug 2022 22:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E512C433B5;
        Wed, 17 Aug 2022 22:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660775482;
        bh=vFxF1nbCDjQv/y8evl6poNGkf2A13slq4rZJGZmX7pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrjFVaVnDM/m0E/59VfKaUWAuHOwwSdhkfU6Ir0bCyfHaNrieeb+tsGiI2fFSawYG
         wNTLrjVRfY21JzAqwTVN2hEmvb1qimOOD/EUH+7l83cXjpc1qFdyv+PX6gdUpquXj6
         LQTlke3uAmtyZY3Gf4CtlqioCR7YIiJMQ5juRm56utS4NuOSPEldI+T+B5Rddn5aOC
         2j0vzAXxBoXcVwDvj3kHtV5Zm55b6TLXztDxl9INmdqHHyVGp/WeGfX0At7RIV9Db/
         0TOSW0jWqHpm1kn1DZpLunYsAFYYjfQY4y1E9gP49TCKldbnGpfdo/zvppr081Lq8x
         8XgL2yrxdlK1w==
Received: by pali.im (Postfix)
        id 47FC32799; Thu, 18 Aug 2022 00:31:19 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 1/6] ARM: dts: dove: Fix assigned-addresses for every PCIe Root Port
Date:   Thu, 18 Aug 2022 00:30:48 +0200
Message-Id: <20220817223053.31141-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220817223053.31141-1-pali@kernel.org>
References: <20220817223053.31141-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

BDF of resource in DT assigned-addresses property of Marvell PCIe Root Port
(PCI-to-PCI bridge) should match BDF in address part in that DT node name
as specified resource belongs to Marvell PCIe Root Port itself.

Fixes: 74ecaa403a74 ("ARM: dove: add PCIe controllers to SoC DT")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/dove.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 00a36fba2fd2..9aee3cfd3e98 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -139,7 +139,7 @@
 			pcie1: pcie@2 {
 				device_type = "pci";
 				status = "disabled";
-				assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
+				assigned-addresses = <0x82001000 0 0x80000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
 				clocks = <&gate_clk 5>;
 				marvell,pcie-port = <1>;
-- 
2.20.1

