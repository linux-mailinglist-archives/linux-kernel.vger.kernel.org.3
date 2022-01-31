Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232654A3EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 09:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348104AbiAaIuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 03:50:02 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:28507 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347238AbiAaIt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 03:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643618999; x=1675154999;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=02ugfjiLkbxnQcgKy8zAdct+rc6P0z1PKGXJP2Nzrk8=;
  b=eHufxLaVIxFyP7Ptl5OkRZWzeR9pSsHuL8/CPf4Kdch9MYfxHx7Ftcni
   YH98fP3WNs3Qy0myxv93Kp2OWoxjqHBnfIqmBRkL+27qT7zRBPHs4nQoc
   iYsBaWEbsJLtJjUEOrKtlqe3BKT37dd+cvdVSeuVc5FHqloPoSlzR7rWs
   51hPDz/p06gQOjsiuR6Dzbhse18Z6hIshv0hic1sXmgkNTvXcCX3zK8JZ
   Q7edprRc9H8EY6bffQa96TSoefP4jL+meoXcFUF0MRyJLk8J4OucR10Ls
   Jv05j3mUkp0BzSEqgwK2clkYToLSfyVKL6ZG0TjZPrAxM4pfyUznbIvcn
   Q==;
IronPort-SDR: oVEZb1MW5E0wmtu4Nw39uvOCXk0CK9r7Y275ZeoncAfHScYDdqFGfQUDbKiJlUqXfl+Lh1sDwL
 kPFXi5Pubd6WGMd9QkQOxNkPjjcyRpfL3yxl+N7QrnLaWVgfnXCumzdCSBSw0QGxxN5y83FAoD
 mMcJ5KP4zn5yr7fC/TpXzw3TNo4NVRDU9QAcimBt9Hdn4CMGd0QSMuztM6sYpAP+NBzIWH7l0/
 zoioU7XID3gDPgigFVLnP4Y+1FEkPVH/rcBvnZK9YDudBjz9t7sFT6uejQ09eGOpzwzGwvCuLR
 RTMj2ZSybQsE+BIQaALRcw1p
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="84168654"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jan 2022 01:49:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 31 Jan 2022 01:49:57 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 31 Jan 2022 01:49:56 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <linus.walleij@linaro.org>,
        <colin.foster@in-advantage.com>, <andy.shevchenko@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2] pinctrl: microchip-sgpio: Fix support for regmap
Date:   Mon, 31 Jan 2022 09:52:01 +0100
Message-ID: <20220131085201.307031-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially the driver accessed the registers using u32 __iomem but then
in the blamed commit it changed it to use regmap. The problem is that now
the offset of the registers is not calculated anymore at word offset but
at byte offset. Therefore make sure to multiply the offset with word size.

Acked-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Colin Foster <colin.foster@in-advantage.com>
Fixes: 2afbbab45c261a ("pinctrl: microchip-sgpio: update to support regmap")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

---
v1->v2:
- use regmap_get_reg_stride() instead of regmap_config.reg_stride
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index 8e081c90bdb2..639f1130e989 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -137,7 +137,8 @@ static inline int sgpio_addr_to_pin(struct sgpio_priv *priv, int port, int bit)
 
 static inline u32 sgpio_get_addr(struct sgpio_priv *priv, u32 rno, u32 off)
 {
-	return priv->properties->regoff[rno] + off;
+	return (priv->properties->regoff[rno] + off) *
+		regmap_get_reg_stride(priv->regs);
 }
 
 static u32 sgpio_readl(struct sgpio_priv *priv, u32 rno, u32 off)
-- 
2.33.0

