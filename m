Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91B749084A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbiAQMHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:07:05 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:48456 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239622AbiAQMGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:06:43 -0500
X-UUID: 5b29f4de2f754f4ca724638f3879a06e-20220117
X-UUID: 5b29f4de2f754f4ca724638f3879a06e-20220117
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 78366877; Mon, 17 Jan 2022 20:06:40 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 17 Jan 2022 20:06:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 17 Jan
 2022 20:06:38 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 20:06:36 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        "Tiffany Lin" <tiffany.lin@mediatek.com>,
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
Subject: [PATCH v2, 06/10] media: mtk-vcodec: Add venc power on/off interface
Date:   Mon, 17 Jan 2022 20:06:11 +0800
Message-ID: <20220117120615.21687-7-irui.wang@mediatek.com>
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

Dual-core mode power on/off all venc available power, pm_runtime_xx
helper is not appropriate called directly, add new power on/off
interface for it.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 20 +----
 .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  7 ++
 .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 83 +++++++++++++++++++
 .../platform/mtk-vcodec/mtk_vcodec_enc_pm.h   |  5 ++
 4 files changed, 98 insertions(+), 17 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 134dc53e4855..df231e67cdb2 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -13,6 +13,7 @@
 
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_enc.h"
+#include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_intr.h"
 #include "mtk_vcodec_util.h"
 #include "venc_drv_if.h"
@@ -850,7 +851,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 {
 	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(q);
 	struct venc_enc_param param;
-	int ret, pm_ret;
+	int ret;
 	int i;
 
 	/* Once state turn into MTK_STATE_ABORT, we need stop_streaming
@@ -858,7 +859,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 	  */
 	if ((ctx->state == MTK_STATE_ABORT) || (ctx->state == MTK_STATE_FREE)) {
 		ret = -EIO;
-		goto err_start_stream;
+		goto err_set_param;
 	}
 
 	/* Do the initialization when both start_streaming have been called */
@@ -870,12 +871,6 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 			return 0;
 	}
 
-	ret = pm_runtime_resume_and_get(&ctx->dev->plat_dev->dev);
-	if (ret < 0) {
-		mtk_v4l2_err("pm_runtime_resume_and_get fail %d", ret);
-		goto err_start_stream;
-	}
-
 	mtk_venc_set_param(ctx, &param);
 	ret = venc_if_set_param(ctx, VENC_SET_PARAM_ENC, &param);
 	if (ret) {
@@ -902,11 +897,6 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 	return 0;
 
 err_set_param:
-	pm_ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
-	if (pm_ret < 0)
-		mtk_v4l2_err("pm_runtime_put fail %d", pm_ret);
-
-err_start_stream:
 	for (i = 0; i < q->num_buffers; ++i) {
 		struct vb2_buffer *buf = vb2_get_buffer(q, i);
 
@@ -989,10 +979,6 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 	if (ret)
 		mtk_v4l2_err("venc_if_deinit failed=%d", ret);
 
-	ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
-	if (ret < 0)
-		mtk_v4l2_err("pm_runtime_put fail %d", ret);
-
 	ctx->state = MTK_STATE_FREE;
 }
 
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index a601d534d26b..cef134bb6e83 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -174,6 +174,12 @@ static int fops_vcodec_open(struct file *file)
 		mtk_v4l2_debug(0, "encoder capability %x", dev->enc_capability);
 	}
 
+	ret = mtk_vcodec_enc_pw_on(dev);
+	if (ret < 0) {
+		mtk_v4l2_err("encoder power on failed %d", ret);
+		goto err_load_fw;
+	}
+
 	mtk_v4l2_debug(2, "Create instance [%d]@%p m2m_ctx=%p ",
 			ctx->id, ctx, ctx->m2m_ctx);
 
@@ -208,6 +214,7 @@ static int fops_vcodec_release(struct file *file)
 
 	v4l2_m2m_ctx_release(ctx->m2m_ctx);
 	mtk_vcodec_enc_release(ctx);
+	mtk_vcodec_enc_pw_off(dev);
 	v4l2_fh_del(&ctx->fh);
 	v4l2_fh_exit(&ctx->fh);
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
index c8a7042d7830..dfaef884e6e3 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
@@ -10,6 +10,7 @@
 #include <linux/pm_runtime.h>
 #include <soc/mediatek/smi.h>
 
+#include "mtk_vcodec_enc_core.h"
 #include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_util.h"
 
@@ -119,3 +120,85 @@ void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
 		clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_enc_clock_off);
+
+int mtk_venc_core_pw_on(struct mtk_vcodec_dev *dev)
+{
+	int i, ret;
+	struct mtk_venc_core_dev *core;
+
+	/* power on all available venc cores */
+	for (i = 0; i < MTK_VENC_CORE_MAX; i++) {
+		core = (struct mtk_venc_core_dev *)dev->enc_core_dev[i];
+		if (!core)
+			return 0;
+
+		ret = pm_runtime_resume_and_get(&core->plat_dev->dev);
+		if (ret < 0) {
+			mtk_v4l2_err("power on core[%d] fail %d", i, ret);
+			goto pw_on_fail;
+		}
+	}
+	return 0;
+
+pw_on_fail:
+	for (i -= 1; i >= 0; i--) {
+		core = (struct mtk_venc_core_dev *)dev->enc_core_dev[i];
+		pm_runtime_put_sync(&core->plat_dev->dev);
+	}
+	return ret;
+}
+
+int mtk_venc_core_pw_off(struct mtk_vcodec_dev *dev)
+{
+	int i, ret;
+	struct mtk_venc_core_dev *core;
+
+	/* power off all available venc cores */
+	for (i = 0; i < MTK_VENC_CORE_MAX; i++) {
+		core = (struct mtk_venc_core_dev *)dev->enc_core_dev[i];
+		if (!core)
+			return 0;
+
+		ret = pm_runtime_put_sync(&core->plat_dev->dev);
+		if (ret < 0)
+			mtk_v4l2_err("power off core[%d] fail %d", i, ret);
+	}
+	return ret;
+}
+
+int mtk_vcodec_enc_pw_on(struct mtk_vcodec_dev *dev)
+{
+	int ret;
+
+	if (dev->venc_pdata->core_mode == VENC_DUAL_CORE_MODE) {
+		ret = mtk_venc_core_pw_on(dev);
+		if (ret < 0) {
+			mtk_v4l2_err("venc core power on fail: %d", ret);
+			return ret;
+		}
+	} else {
+		ret = pm_runtime_resume_and_get(&dev->plat_dev->dev);
+		if (ret < 0) {
+			mtk_v4l2_err("pm_runtime_resume_and_get fail %d", ret);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+int mtk_vcodec_enc_pw_off(struct mtk_vcodec_dev *dev)
+{
+	int ret;
+
+	if (dev->venc_pdata->core_mode == VENC_DUAL_CORE_MODE) {
+		ret = mtk_venc_core_pw_off(dev);
+		if (ret < 0)
+			mtk_v4l2_err("venc core power off fail: %d", ret);
+
+	} else {
+		ret = pm_runtime_put_sync(&dev->plat_dev->dev);
+		if (ret < 0)
+			mtk_v4l2_err("pm_runtime_put_sync fail %d", ret);
+	}
+	return ret;
+}
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
index 97a394c68f4e..99b6b6e29e35 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
@@ -14,4 +14,9 @@ int mtk_vcodec_init_enc_clk(struct platform_device *pdev,
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm);
 
+int mtk_venc_core_pw_on(struct mtk_vcodec_dev *dev);
+int mtk_venc_core_pw_off(struct mtk_vcodec_dev *dev);
+int mtk_vcodec_enc_pw_on(struct mtk_vcodec_dev *dev);
+int mtk_vcodec_enc_pw_off(struct mtk_vcodec_dev *dev);
+
 #endif /* _MTK_VCODEC_ENC_PM_H_ */
-- 
2.18.0

