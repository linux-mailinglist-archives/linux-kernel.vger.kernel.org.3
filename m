Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B864807CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 10:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhL1JZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 04:25:36 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:49778 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231414AbhL1JZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 04:25:35 -0500
X-UUID: 9c23fad9d08a4a279e792dba60973575-20211228
X-UUID: 9c23fad9d08a4a279e792dba60973575-20211228
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 791067865; Tue, 28 Dec 2021 17:25:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Dec 2021 17:25:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Dec 2021 17:25:29 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Miles Chen <miles.chen@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/mediatek: Fix unused-but-set variable warning
Date:   Tue, 28 Dec 2021 17:25:27 +0800
Message-ID: <20211228092527.29894-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix unused-but-set variable warning:
drivers/gpu/drm/mediatek/mtk_cec.c:85:6: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
index e9cef5c0c8f7..cdfa648910b2 100644
--- a/drivers/gpu/drm/mediatek/mtk_cec.c
+++ b/drivers/gpu/drm/mediatek/mtk_cec.c
@@ -85,7 +85,7 @@ static void mtk_cec_mask(struct mtk_cec *cec, unsigned int offset,
 	u32 tmp = readl(cec->regs + offset) & ~mask;
 
 	tmp |= val & mask;
-	writel(val, cec->regs + offset);
+	writel(tmp, cec->regs + offset);
 }
 
 void mtk_cec_set_hpd_event(struct device *dev,
-- 
2.18.0

