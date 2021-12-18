Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78ECE4799B5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 09:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhLRI2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 03:28:10 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:59488 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232281AbhLRI2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 03:28:08 -0500
X-UUID: 6c90f64fe4644fd9a3c91e64a0483d16-20211218
X-UUID: 6c90f64fe4644fd9a3c91e64a0483d16-20211218
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1428234005; Sat, 18 Dec 2021 16:28:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 18 Dec 2021 16:28:04 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 18 Dec 2021 16:28:03 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH v2 3/5] phy: mediatek: add helpers to update bits of registers
Date:   Sat, 18 Dec 2021 16:28:00 +0800
Message-ID: <20211218082802.5256-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211218082802.5256-1-chunfeng.yun@mediatek.com>
References: <20211218082802.5256-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add three helpers mtk_phy_clear/set/update_bits() for registers operation

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: new patch, add register access helpers,
    Add updatel() macro suggested by Vinod, here add more ones instead.
---
 drivers/phy/mediatek/phy-mtk-io.h | 38 +++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 drivers/phy/mediatek/phy-mtk-io.h

diff --git a/drivers/phy/mediatek/phy-mtk-io.h b/drivers/phy/mediatek/phy-mtk-io.h
new file mode 100644
index 000000000000..500fcdab165d
--- /dev/null
+++ b/drivers/phy/mediatek/phy-mtk-io.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ *
+ * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
+ */
+
+#ifndef __PHY_MTK_H__
+#define __PHY_MTK_H__
+
+#include <linux/io.h>
+
+static inline void mtk_phy_clear_bits(void __iomem *reg, u32 bits)
+{
+	u32 tmp = readl(reg);
+
+	tmp &= ~bits;
+	writel(tmp, reg);
+}
+
+static inline void mtk_phy_set_bits(void __iomem *reg, u32 bits)
+{
+	u32 tmp = readl(reg);
+
+	tmp |= bits;
+	writel(tmp, reg);
+}
+
+static inline void mtk_phy_update_bits(void __iomem *reg, u32 mask, u32 val)
+{
+	u32 tmp = readl(reg);
+
+	tmp &= ~mask;
+	tmp |= val & mask;
+	writel(tmp, reg);
+}
+
+#endif
-- 
2.18.0

