Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C4747CC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 06:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhLVFTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 00:19:44 -0500
Received: from mx.socionext.com ([202.248.49.38]:22044 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229509AbhLVFTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 00:19:42 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 22 Dec 2021 14:19:42 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 1843320584CE;
        Wed, 22 Dec 2021 14:19:42 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 22 Dec 2021 14:19:42 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id C13AFB568B;
        Wed, 22 Dec 2021 14:19:41 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ryuta NAKANISHI <nakanishi.ryuta@socionext.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] phy: uniphier-usb3ss: fix unintended writing zeros to PHY register
Date:   Wed, 22 Dec 2021 14:19:29 +0900
Message-Id: <1640150369-4134-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryuta NAKANISHI <nakanishi.ryuta@socionext.com>

Similar to commit 4a90bbb478db ("phy: uniphier-pcie: Fix updating phy
parameters"), in function uniphier_u3ssphy_set_param(), unintentionally
write zeros to other fields when writing PHY registers.

Fixes: 5ab43d0f8697 ("phy: socionext: add USB3 PHY driver for UniPhier SoC")
Signed-off-by: Ryuta NAKANISHI <nakanishi.ryuta@socionext.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/phy-uniphier-usb3ss.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/socionext/phy-uniphier-usb3ss.c b/drivers/phy/socionext/phy-uniphier-usb3ss.c
index 7ce611c2088b..f402ed8732fd 100644
--- a/drivers/phy/socionext/phy-uniphier-usb3ss.c
+++ b/drivers/phy/socionext/phy-uniphier-usb3ss.c
@@ -22,11 +22,13 @@
 #include <linux/reset.h>
 
 #define SSPHY_TESTI		0x0
-#define SSPHY_TESTO		0x4
 #define TESTI_DAT_MASK		GENMASK(13, 6)
 #define TESTI_ADR_MASK		GENMASK(5, 1)
 #define TESTI_WR_EN		BIT(0)
 
+#define SSPHY_TESTO		0x4
+#define TESTO_DAT_MASK		GENMASK(7, 0)
+
 #define PHY_F(regno, msb, lsb) { (regno), (msb), (lsb) }
 
 #define CDR_CPD_TRIM	PHY_F(7, 3, 0)	/* RxPLL charge pump current */
@@ -84,12 +86,12 @@ static void uniphier_u3ssphy_set_param(struct uniphier_u3ssphy_priv *priv,
 	val  = FIELD_PREP(TESTI_DAT_MASK, 1);
 	val |= FIELD_PREP(TESTI_ADR_MASK, p->field.reg_no);
 	uniphier_u3ssphy_testio_write(priv, val);
-	val = readl(priv->base + SSPHY_TESTO);
+	val = readl(priv->base + SSPHY_TESTO) & TESTO_DAT_MASK;
 
 	/* update value */
-	val &= ~FIELD_PREP(TESTI_DAT_MASK, field_mask);
+	val &= ~field_mask;
 	data = field_mask & (p->value << p->field.lsb);
-	val  = FIELD_PREP(TESTI_DAT_MASK, data);
+	val  = FIELD_PREP(TESTI_DAT_MASK, data | val);
 	val |= FIELD_PREP(TESTI_ADR_MASK, p->field.reg_no);
 	uniphier_u3ssphy_testio_write(priv, val);
 	uniphier_u3ssphy_testio_write(priv, val | TESTI_WR_EN);
-- 
2.7.4

