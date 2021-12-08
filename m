Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD31B46CA02
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbhLHBh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:37:58 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:15435 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239304AbhLHBh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:37:58 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1B818k1j089263;
        Wed, 8 Dec 2021 09:08:46 +0800 (GMT-8)
        (envelope-from tommy_huang@aspeedtech.com)
Received: from tommy0527-VirtualBox.aspeedtech.com (192.168.2.141) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Dec 2021 09:33:44 +0800
From:   Tommy Haung <tommy_huang@aspeedtech.com>
To:     <joel@jms.id.au>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <robh+dt@kernel.org>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>, tommy-huang <tommy_huang@aspeedtech.com>
Subject: [PATCH v5 3/7] drm/aspeed: Update INTR_STS handling
Date:   Wed, 8 Dec 2021 09:33:33 +0800
Message-ID: <20211208013337.13806-4-tommy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208013337.13806-1-tommy_huang@aspeedtech.com>
References: <20211208013337.13806-1-tommy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.141]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1B818k1j089263
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tommy-huang <tommy_huang@aspeedtech.com>

Add interrupt clear register define for further chip support.

Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx.h     | 1 +
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
index 96501152bafa..4e6a442c3886 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
@@ -12,6 +12,7 @@ struct aspeed_gfx {
 	struct regmap			*scu;
 
 	u32				dac_reg;
+	u32				int_clr_reg;
 	u32				vga_scratch_reg;
 	u32				throd_val;
 	u32				scan_line_max;
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index b53fee6f1c17..d4b56b3c7597 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -60,6 +60,7 @@
 
 struct aspeed_gfx_config {
 	u32 dac_reg;		/* DAC register in SCU */
+	u32 int_clear_reg;	/* Interrupt clear register */
 	u32 vga_scratch_reg;	/* VGA scratch register in SCU */
 	u32 throd_val;		/* Default Threshold Seting */
 	u32 scan_line_max;	/* Max memory size of one scan line */
@@ -67,6 +68,7 @@ struct aspeed_gfx_config {
 
 static const struct aspeed_gfx_config ast2400_config = {
 	.dac_reg = 0x2c,
+	.int_clear_reg = 0x60,
 	.vga_scratch_reg = 0x50,
 	.throd_val = CRT_THROD_LOW(0x1e) | CRT_THROD_HIGH(0x12),
 	.scan_line_max = 64,
@@ -74,6 +76,7 @@ static const struct aspeed_gfx_config ast2400_config = {
 
 static const struct aspeed_gfx_config ast2500_config = {
 	.dac_reg = 0x2c,
+	.int_clear_reg = 0x60,
 	.vga_scratch_reg = 0x50,
 	.throd_val = CRT_THROD_LOW(0x24) | CRT_THROD_HIGH(0x3c),
 	.scan_line_max = 128,
@@ -119,7 +122,7 @@ static irqreturn_t aspeed_gfx_irq_handler(int irq, void *data)
 
 	if (reg & CRT_CTRL_VERTICAL_INTR_STS) {
 		drm_crtc_handle_vblank(&priv->pipe.crtc);
-		writel(reg, priv->base + CRT_CTRL1);
+		writel(reg, priv->base + priv->int_clr_reg);
 		return IRQ_HANDLED;
 	}
 
@@ -147,6 +150,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
 	config = match->data;
 
 	priv->dac_reg = config->dac_reg;
+	priv->int_clr_reg = config->int_clear_reg;
 	priv->vga_scratch_reg = config->vga_scratch_reg;
 	priv->throd_val = config->throd_val;
 	priv->scan_line_max = config->scan_line_max;
-- 
2.17.1

