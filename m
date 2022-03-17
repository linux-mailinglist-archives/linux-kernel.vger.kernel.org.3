Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B204DC105
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiCQIZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiCQIYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:24:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698A416A6BB;
        Thu, 17 Mar 2022 01:23:24 -0700 (PDT)
X-UUID: c41d20993ecf4b85836556dd65525dd9-20220317
X-UUID: c41d20993ecf4b85836556dd65525dd9-20220317
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1137129936; Thu, 17 Mar 2022 16:23:17 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 17 Mar 2022 16:23:16 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 16:23:14 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
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
Subject: [PATCH v3, 06/10] media: mtk-vcodec: Add venc power on/off interface
Date:   Thu, 17 Mar 2022 16:22:26 +0800
Message-ID: <20220317082230.23622-7-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317082230.23622-1-irui.wang@mediatek.com>
References: <20220317082230.23622-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

venc_multi_core mode power on/off all venc available power, pm_runtime_xx
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
index 0d1b065048a9..b0bc71f00930 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -12,6 +12,7 @@
 
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_enc.h"
+#include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_intr.h"
 #include "mtk_vcodec_util.h"
 #include "venc_drv_if.h"
@@ -849,7 +850,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 {
 	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(q);
 	struct venc_enc_param param;
-	int ret, pm_ret;
+	int ret;
 	int i;
 
 	/* Once state turn into MTK_STATE_ABORT, we need stop_streaming
@@ -857,7 +858,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 	  */
 	if ((ctx->state == MTK_STATE_ABORT) || (ctx->state == MTK_STATE_FREE)) {
 		ret = -EIO;
-		goto err_start_stream;
+		goto err_set_param;
 	}
 
 	/* Do the initialization when both start_streaming have been called */
@@ -869,12 +870,6 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
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
@@ -901,11 +896,6 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 	return 0;
 
 err_set_param:
-	pm_ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
-	if (pm_ret < 0)
-		mtk_v4l2_err("pm_runtime_put fail %d", pm_ret);
-
-err_start_stream:
 	for (i = 0; i < q->num_buffers; ++i) {
 		struct vb2_buffer *buf = vb2_get_buffer(q, i);
 
@@ -988,10 +978,6 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 	if (ret)
 		mtk_v4l2_err("venc_if_deinit failed=%d", ret);
 
-	ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
-	if (ret < 0)
-		mtk_v4l2_err("pm_runtime_put fail %d", ret);
-
 	ctx->state = MTK_STATE_FREE;
 }
 
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index 1b1c17b03ef5..d2937e62df29 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -173,6 +173,12 @@ static int fops_vcodec_open(struct file *file)
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
 
@@ -207,6 +213,7 @@ static int fops_vcodec_release(struct file *file)
 
 	v4l2_m2m_ctx_release(ctx->m2m_ctx);
 	mtk_vcodec_enc_release(ctx);
+	mtk_vcodec_enc_pw_off(dev);
 	v4l2_fh_del(&ctx->fh);
 	v4l2_fh_exit(&ctx->fh);
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
index 1e814fc3172f..22b2eb867998 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
@@ -9,6 +9,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 
+#include "mtk_vcodec_enc_core.h"
 #include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_util.h"
 
@@ -87,3 +88,85 @@ void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
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
+	if (dev->venc_multi_core) {
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
+	if (dev->venc_multi_core) {
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

