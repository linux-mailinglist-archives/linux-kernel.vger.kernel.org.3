Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342794782B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhLQBzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:55:47 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:54884 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232170AbhLQBzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:55:45 -0500
X-UUID: f653e5f939bf4e0a9063484ba05334f5-20211217
X-UUID: f653e5f939bf4e0a9063484ba05334f5-20211217
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 815707452; Fri, 17 Dec 2021 09:55:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 17 Dec 2021 09:55:37 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 17 Dec 2021 09:55:35 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Steve Cho" <stevecho@chromium.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v17, 04/19] media: mtk-vcodec: export decoder pm functions
Date:   Fri, 17 Dec 2021 09:55:15 +0800
Message-ID: <20211217015530.23720-5-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217015530.23720-1-yunfei.dong@mediatek.com>
References: <20211217015530.23720-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mtk vcodec decoder is build as a module, we need to export
mtk-vcodec-dec pm functions to make them visible by the other components.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
index 20bd157a855c..221cf60e9fbf 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
@@ -77,12 +77,14 @@ int mtk_vcodec_init_dec_pm(struct platform_device *pdev,
 	put_device(pm->larbvdec);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mtk_vcodec_init_dec_pm);
 
 void mtk_vcodec_release_dec_pm(struct mtk_vcodec_pm *pm)
 {
 	pm_runtime_disable(pm->dev);
 	put_device(pm->larbvdec);
 }
+EXPORT_SYMBOL_GPL(mtk_vcodec_release_dec_pm);
 
 int mtk_vcodec_dec_pw_on(struct mtk_vcodec_pm *pm)
 {
@@ -94,6 +96,7 @@ int mtk_vcodec_dec_pw_on(struct mtk_vcodec_pm *pm)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mtk_vcodec_dec_pw_on);
 
 void mtk_vcodec_dec_pw_off(struct mtk_vcodec_pm *pm)
 {
@@ -103,6 +106,7 @@ void mtk_vcodec_dec_pw_off(struct mtk_vcodec_pm *pm)
 	if (ret)
 		mtk_v4l2_err("pm_runtime_put_sync fail %d", ret);
 }
+EXPORT_SYMBOL_GPL(mtk_vcodec_dec_pw_off);
 
 void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
 {
@@ -129,6 +133,7 @@ void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
 	for (i -= 1; i >= 0; i--)
 		clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
 }
+EXPORT_SYMBOL_GPL(mtk_vcodec_dec_clock_on);
 
 void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm)
 {
@@ -139,3 +144,4 @@ void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm)
 	for (i = dec_clk->clk_num - 1; i >= 0; i--)
 		clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
 }
+EXPORT_SYMBOL_GPL(mtk_vcodec_dec_clock_off);
-- 
2.25.1

