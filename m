Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275E947B3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240859AbhLTTdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:33:45 -0500
Received: from aposti.net ([89.234.176.197]:38784 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240847AbhLTTdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:33:44 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 2/2] clk: ingenic: Add MDMA and BDMA clocks
Date:   Mon, 20 Dec 2021 19:33:19 +0000
Message-Id: <20211220193319.114974-3-paul@crapouillou.net>
In-Reply-To: <20211220193319.114974-1-paul@crapouillou.net>
References: <20211220193319.114974-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ingenic JZ4760 and JZ4770 both have an extra DMA core named BDMA
dedicated to the NAND and BCH controller, but which can also do
memory-to-memory transfers. The JZ4760 additionally has a DMA core named
MDMA dedicated to memory-to-memory transfers. The programming manual for
the JZ4770 does have a bit for a MDMA clock, but does not seem to have
the hardware wired in.

Add the BDMA and MDMA clocks to the JZ4760 CGU code, and the BDMA clock
to the JZ4770 code, so that the BDMA and MDMA controllers can be used.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: No change
    
    v3: Split off dt-bindings include changes to its own patch

 drivers/clk/ingenic/jz4760-cgu.c | 10 ++++++++++
 drivers/clk/ingenic/jz4770-cgu.c |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/clk/ingenic/jz4760-cgu.c b/drivers/clk/ingenic/jz4760-cgu.c
index 080d492ac95c..8fdd383560fb 100644
--- a/drivers/clk/ingenic/jz4760-cgu.c
+++ b/drivers/clk/ingenic/jz4760-cgu.c
@@ -313,6 +313,16 @@ static const struct ingenic_cgu_clk_info jz4760_cgu_clocks[] = {
 		.parents = { JZ4760_CLK_H2CLK, },
 		.gate = { CGU_REG_CLKGR0, 21 },
 	},
+	[JZ4760_CLK_MDMA] = {
+		"mdma", CGU_CLK_GATE,
+		.parents = { JZ4760_CLK_HCLK, },
+		.gate = { CGU_REG_CLKGR0, 25 },
+	},
+	[JZ4760_CLK_BDMA] = {
+		"bdma", CGU_CLK_GATE,
+		.parents = { JZ4760_CLK_HCLK, },
+		.gate = { CGU_REG_CLKGR1, 0 },
+	},
 	[JZ4760_CLK_I2C0] = {
 		"i2c0", CGU_CLK_GATE,
 		.parents = { JZ4760_CLK_EXT, },
diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index 8c6c1208f462..7ef91257630e 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -329,6 +329,11 @@ static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] = {
 		.parents = { JZ4770_CLK_H2CLK, },
 		.gate = { CGU_REG_CLKGR0, 21 },
 	},
+	[JZ4770_CLK_BDMA] = {
+		"bdma", CGU_CLK_GATE,
+		.parents = { JZ4770_CLK_H2CLK, },
+		.gate = { CGU_REG_CLKGR1, 0 },
+	},
 	[JZ4770_CLK_I2C0] = {
 		"i2c0", CGU_CLK_GATE,
 		.parents = { JZ4770_CLK_EXT, },
-- 
2.34.1

