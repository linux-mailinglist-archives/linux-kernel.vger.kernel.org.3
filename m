Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77C74C9BC6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 04:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbiCBDIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 22:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiCBDIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:08:54 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01340E0D1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 19:08:11 -0800 (PST)
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 2222fMP6029341
        for <linux-kernel@vger.kernel.org>; Wed, 2 Mar 2022 10:41:22 +0800 (GMT-8)
        (envelope-from tommy_huang@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2222eJgK029207;
        Wed, 2 Mar 2022 10:40:19 +0800 (GMT-8)
        (envelope-from tommy_huang@aspeedtech.com)
Received: from tommy0527-VirtualBox.aspeedtech.com (192.168.2.141) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Mar 2022 10:49:40 +0800
From:   Tommy Haung <tommy_huang@aspeedtech.com>
To:     <joel@jms.id.au>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <robh+dt@kernel.org>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH v6 1/5] ARM: dts: aspeed: Add GFX node to AST2600
Date:   Wed, 2 Mar 2022 10:49:26 +0800
Message-ID: <20220302024930.18758-2-tommy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220302024930.18758-1-tommy_huang@aspeedtech.com>
References: <20220302024930.18758-1-tommy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.141]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2222eJgK029207
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

The GFX device is present in the AST2600 SoC.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Tommy Haung <tommy_huang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 1b47be1704f8..e38c3742761b 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -351,6 +351,17 @@
 				quality = <100>;
 			};
 
+			gfx: display@1e6e6000 {
+				compatible = "aspeed,ast2600-gfx", "aspeed,ast2500-gfx", "syscon";
+				reg = <0x1e6e6000 0x1000>;
+				reg-io-width = <4>;
+				clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
+				resets = <&syscon ASPEED_RESET_GRAPHICS>;
+				syscon = <&syscon>;
+				status = "disabled";
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			xdma: xdma@1e6e7000 {
 				compatible = "aspeed,ast2600-xdma";
 				reg = <0x1e6e7000 0x100>;
-- 
2.17.1

