Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E39490831
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbiAQMGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:06:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36694 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239554AbiAQMGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:06:33 -0500
X-UUID: 79eca5885b7c48bcbd8666ea03d3df5f-20220117
X-UUID: 79eca5885b7c48bcbd8666ea03d3df5f-20220117
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1089449713; Mon, 17 Jan 2022 20:06:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Jan 2022 20:06:28 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 20:06:27 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2, 02/10] media: mtk-vcodec: export encoder functions
Date:   Mon, 17 Jan 2022 20:06:07 +0800
Message-ID: <20220117120615.21687-3-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117120615.21687-1-irui.wang@mediatek.com>
References: <20220117120615.21687-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk vcodec is built as a module, export some functions to make them
visible by other modules.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c    | 2 ++
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index ffb046eec610..134dc53e4855 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -1432,6 +1432,7 @@ int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx)
 	mutex_unlock(&dev->enc_mutex);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_venc_unlock);
 
 int mtk_venc_lock(struct mtk_vcodec_ctx *ctx)
 {
@@ -1440,6 +1441,7 @@ int mtk_venc_lock(struct mtk_vcodec_ctx *ctx)
 	mutex_lock(&dev->enc_mutex);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_venc_lock);
 
 void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx)
 {
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
index 0825c6ec4eb7..7eba1a990ed7 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
@@ -85,6 +85,7 @@ int mtk_vcodec_init_enc_clk(struct mtk_vcodec_dev *mtkdev)
 	put_device(pm->larbvenc);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mtk_vcodec_init_enc_clk);
 
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
 {
@@ -111,6 +112,7 @@ void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
 	for (i -= 1; i >= 0; i--)
 		clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
 }
+EXPORT_SYMBOL_GPL(mtk_vcodec_enc_clock_on);
 
 void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
 {
@@ -121,3 +123,4 @@ void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
 	for (i = enc_clk->clk_num - 1; i >= 0; i--)
 		clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
 }
+EXPORT_SYMBOL_GPL(mtk_vcodec_enc_clock_off);
-- 
2.18.0

