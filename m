Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1722B482E44
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 06:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiACFrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 00:47:16 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51484 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229527AbiACFrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 00:47:15 -0500
X-UUID: b5def2786cb1486898923cf77f51cd3a-20220103
X-UUID: b5def2786cb1486898923cf77f51cd3a-20220103
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2031834010; Mon, 03 Jan 2022 13:47:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 3 Jan 2022 13:47:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Jan 2022 13:47:07 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Junzhi Zhao <junzhi.zhao@mediatek.com>,
        Jie Qiu <jie.qiu@mediatek.com>
CC:     Miles Chen <miles.chen@mediatek.com>,
        Zhiqiang Lin <zhiqiang.lin@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] drm/mediatek: Fix mtk_cec_mask()
Date:   Mon, 3 Jan 2022 13:47:06 +0800
Message-ID: <20220103054706.8072-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current implementation, mtk_cec_mask() writes val into target register
and ignores the mask. After talking to our hdmi experts, mtk_cec_mask()
should read a register, clean only mask bits, and update (val | mask) bits
to the register.

Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")

Cc: Zhiqiang Lin <zhiqiang.lin@mediatek.com>
Cc: CK Hu <ck.hu@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>

Signed-off-by: Miles Chen <miles.chen@mediatek.com>

---

Change since v1:
add Fixes tag

Change since v2:
add explanation of mtk_cec_mask()

Change since v3:
change misleading subject and modify the commit message since this is a bug fix patch

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

