Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8984F465E24
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355758AbhLBGRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:17:00 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49276 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1355723AbhLBGQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:16:52 -0500
X-UUID: d257ff05d8a2497b82aaec5592be6779-20211202
X-UUID: d257ff05d8a2497b82aaec5592be6779-20211202
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 902142290; Thu, 02 Dec 2021 14:13:26 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 2 Dec 2021 14:13:25 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Dec
 2021 14:13:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Dec 2021 14:13:24 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <menghui.lin@mediatek.com>, <sj.huang@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <randy.wu@mediatek.com>,
        <moudy.ho@mediatek.com>, <jason-jh.lin@mediatek.com>,
        <roy-cw.yeh@mediatek.com>, <river.cheng@mediatek.com>,
        <srv_heupstream@mediatek.com>
Subject: [PATCH v10 1/4] soc: mediatek: mmsys: add support for MDP
Date:   Thu, 2 Dec 2021 14:13:19 +0800
Message-ID: <20211202061322.19917-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211202061322.19917-1-moudy.ho@mediatek.com>
References: <20211202061322.19917-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the purpose of module independence, related settings should be moved
from MDP to the corresponding driver.
This patch adds more 8183 MDP settings and interface. and MDP
related settings must be set via CMDQ to avoid frame unsynchronized.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/Kconfig           |   1 +
 drivers/soc/mediatek/mt8183-mmsys.h    | 268 +++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c       |  56 ++++++
 drivers/soc/mediatek/mtk-mmsys.h       |   2 +
 include/linux/soc/mediatek/mtk-mmsys.h |  56 ++++++
 5 files changed, 383 insertions(+)

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index fdd8bc08569e..172bc7828aca 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -69,6 +69,7 @@ config MTK_MMSYS
 	bool "MediaTek MMSYS Support"
 	default ARCH_MEDIATEK
 	depends on HAS_IOMEM
+	select MTK_CMDQ
 	help
 	  Say yes here to add support for the MediaTek Multimedia
 	  Subsystem (MMSYS).
diff --git a/drivers/soc/mediatek/mt8183-mmsys.h b/drivers/soc/mediatek/mt8183-mmsys.h
index 9dee485807c9..48865973314d 100644
--- a/drivers/soc/mediatek/mt8183-mmsys.h
+++ b/drivers/soc/mediatek/mt8183-mmsys.h
@@ -12,6 +12,25 @@
 #define MT8183_DISP_DPI0_SEL_IN			0xf30
 #define MT8183_DISP_RDMA0_SOUT_SEL_IN		0xf50
 #define MT8183_DISP_RDMA1_SOUT_SEL_IN		0xf54
+#define MT8183_MDP_ISP_MOUT_EN			0xf80
+#define MT8183_MDP_RDMA0_MOUT_EN		0xf84
+#define MT8183_MDP_PRZ0_MOUT_EN			0xf8c
+#define MT8183_MDP_PRZ1_MOUT_EN			0xf90
+#define MT8183_MDP_COLOR_MOUT_EN		0xf94
+#define MT8183_MDP_IPU_MOUT_EN			0xf98
+#define MT8183_MDP_PATH0_SOUT_SEL		0xfa8
+#define MT8183_MDP_PATH1_SOUT_SEL		0xfac
+#define MT8183_MDP_PRZ0_SEL_IN			0xfc0
+#define MT8183_MDP_PRZ1_SEL_IN			0xfc4
+#define MT8183_MDP_TDSHP_SEL_IN			0xfc8
+#define MT8183_MDP_WROT0_SEL_IN			0xfd0
+#define MT8183_MDP_WDMA_SEL_IN			0xfd4
+#define MT8183_MDP_PATH0_SEL_IN			0xfe0
+#define MT8183_MDP_PATH1_SEL_IN			0xfe4
+#define MT8183_MDP_AAL_MOUT_EN			0xfe8
+#define MT8183_MDP_AAL_SEL_IN			0xfec
+#define MT8183_MDP_CCORR_SEL_IN			0xff0
+#define MT8183_MDP_CCORR_SOUT_SEL		0xff4
 
 #define MT8183_OVL0_MOUT_EN_OVL0_2L		BIT(4)
 #define MT8183_OVL0_2L_MOUT_EN_DISP_PATH0	BIT(0)
@@ -24,6 +43,55 @@
 #define MT8183_DPI0_SEL_IN_RDMA1		0x2
 #define MT8183_RDMA0_SOUT_COLOR0		0x1
 #define MT8183_RDMA1_SOUT_DSI0			0x1
+#define MT8183_MDP_ISP_MOUT_EN_CCORR0		BIT(0)
+#define MT8183_MDP_ISP_MOUT_EN_RSZ1		BIT(1)
+#define MT8183_MDP_ISP_MOUT_EN_AAL0		BIT(2)
+#define MT8183_MDP_IPU_MOUT_EN_CCORR0		BIT(0)
+#define MT8183_MDP_IPU_MOUT_EN_RSZ1		BIT(1)
+#define MT8183_MDP_IPU_MOUT_EN_AAL0		BIT(2)
+#define MT8183_MDP_RDMA0_MOUT_EN_CCORR0		BIT(0)
+#define MT8183_MDP_RDMA0_MOUT_EN_RSZ1		BIT(1)
+#define MT8183_MDP_RDMA0_MOUT_EN_PATH0_OUT	BIT(2)
+#define MT8183_MDP_RDMA0_MOUT_EN_AAL0		BIT(3)
+#define MT8183_MDP_AAL_MOUT_EN_CCORR0		BIT(0)
+#define MT8183_MDP_AAL_MOUT_EN_RSZ1		BIT(1)
+#define MT8183_MDP_AAL_MOUT_EN_RSZ0		BIT(2)
+#define MT8183_MDP_PRZ0_MOUT_EN_PATH0_OUT	BIT(0)
+#define MT8183_MDP_PRZ0_MOUT_EN_TDSHP0		BIT(1)
+#define MT8183_MDP_PRZ1_MOUT_EN_PATH0_OUT	BIT(0)
+#define MT8183_MDP_PRZ1_MOUT_EN_TDSHP0		BIT(1)
+#define MT8183_MDP_PRZ1_MOUT_EN_PATH1_OUT	BIT(2)
+#define MT8183_MDP_PRZ1_MOUT_EN_COLOR0		BIT(4)
+#define MT8183_MDP_COLOR_MOUT_EN_PATH0_OUT	BIT(0)
+#define MT8183_MDP_COLOR_MOUT_EN_PATH1_OUT	BIT(1)
+#define MT8183_MDP_AAL_SEL_IN_CAMIN		0
+#define MT8183_MDP_AAL_SEL_IN_RDMA0		1
+#define MT8183_MDP_AAL_SEL_IN_CAMIN2		2
+#define MT8183_MDP_AAL_SEL_IN_CCORR0		3
+#define MT8183_MDP_CCORR_SEL_IN_CAMIN		0
+#define MT8183_MDP_CCORR_SEL_IN_RDMA0		1
+#define MT8183_MDP_CCORR_SEL_IN_CAMIN2		3
+#define MT8183_MDP_CCORR_SEL_IN_AAL0		4
+#define MT8183_MDP_PRZ0_SEL_IN_AAL0		0
+#define MT8183_MDP_PRZ0_SEL_IN_CCORR0		1
+#define MT8183_MDP_PRZ1_SEL_IN_CAMIN		0
+#define MT8183_MDP_PRZ1_SEL_IN_RDMA0		1
+#define MT8183_MDP_PRZ1_SEL_IN_CAMIN2		4
+#define MT8183_MDP_PRZ1_SEL_IN_AAL0		5
+#define MT8183_MDP_TDSHP_SEL_IN_RSZ0		0
+#define MT8183_MDP_TDSHP_SEL_IN_RSZ1		1
+#define MT8183_MDP_PATH0_SEL_IN_RSZ0		0
+#define MT8183_MDP_PATH0_SEL_IN_RSZ1		1
+#define MT8183_MDP_PATH0_SEL_IN_COLOR0		2
+#define MT8183_MDP_PATH0_SEL_IN_RDMA0		3
+#define MT8183_MDP_PATH1_SEL_IN_RSZ1		0
+#define MT8183_MDP_PATH1_SEL_IN_COLOR0		1
+#define MT8183_MDP_WROT0_SEL_IN_PATH0_OUT	0
+#define MT8183_MDP_WDMA_SEL_IN_PATH1_OUT	0
+#define MT8183_MDP_CCORR_SOUT_SEL_AAL0		0
+#define MT8183_MDP_CCORR_SOUT_SEL_RSZ0		1
+#define MT8183_MDP_PATH0_SOUT_SEL_WROT0		0
+#define MT8183_MDP_PATH1_SOUT_SEL_WDMA		0
 
 static const struct mtk_mmsys_routes mmsys_mt8183_routing_table[] = {
 	{
@@ -57,5 +125,205 @@ static const struct mtk_mmsys_routes mmsys_mt8183_routing_table[] = {
 	}
 };
 
+static const struct mtk_mmsys_routes mmsys_mt8183_mdp_routing_table[] = {
+	{
+		MDP_COMP_CAMIN, MDP_COMP_CCORR0,
+		MT8183_MDP_ISP_MOUT_EN, MT8183_MDP_ISP_MOUT_EN_CCORR0,
+		MT8183_MDP_ISP_MOUT_EN_CCORR0
+	}, {
+		MDP_COMP_CAMIN, MDP_COMP_RSZ1,
+		MT8183_MDP_ISP_MOUT_EN, MT8183_MDP_ISP_MOUT_EN_RSZ1,
+		MT8183_MDP_ISP_MOUT_EN_RSZ1
+	}, {
+		MDP_COMP_CAMIN, MDP_COMP_AAL0,
+		MT8183_MDP_ISP_MOUT_EN, MT8183_MDP_ISP_MOUT_EN_AAL0,
+		MT8183_MDP_ISP_MOUT_EN_AAL0
+	}, {
+		MDP_COMP_CAMIN2, MDP_COMP_CCORR0,
+		MT8183_MDP_IPU_MOUT_EN, MT8183_MDP_IPU_MOUT_EN_CCORR0,
+		MT8183_MDP_IPU_MOUT_EN_CCORR0
+	}, {
+		MDP_COMP_CAMIN2, MDP_COMP_RSZ1,
+		MT8183_MDP_IPU_MOUT_EN, MT8183_MDP_IPU_MOUT_EN_RSZ1,
+		MT8183_MDP_IPU_MOUT_EN_RSZ1
+	}, {
+		MDP_COMP_CAMIN2, MDP_COMP_AAL0,
+		MT8183_MDP_IPU_MOUT_EN, MT8183_MDP_IPU_MOUT_EN_AAL0,
+		MT8183_MDP_IPU_MOUT_EN_AAL0
+	}, {
+		MDP_COMP_RDMA0, MDP_COMP_CCORR0,
+		MT8183_MDP_RDMA0_MOUT_EN, MT8183_MDP_RDMA0_MOUT_EN_CCORR0,
+		MT8183_MDP_RDMA0_MOUT_EN_CCORR0
+	}, {
+		MDP_COMP_RDMA0, MDP_COMP_RSZ1,
+		MT8183_MDP_RDMA0_MOUT_EN, MT8183_MDP_RDMA0_MOUT_EN_RSZ1,
+		MT8183_MDP_RDMA0_MOUT_EN_RSZ1
+	}, {
+		MDP_COMP_RDMA0, MDP_COMP_PATH0_SOUT,
+		MT8183_MDP_RDMA0_MOUT_EN, MT8183_MDP_RDMA0_MOUT_EN_PATH0_OUT,
+		MT8183_MDP_RDMA0_MOUT_EN_PATH0_OUT
+	}, {
+		MDP_COMP_RDMA0, MDP_COMP_AAL0,
+		MT8183_MDP_RDMA0_MOUT_EN, MT8183_MDP_RDMA0_MOUT_EN_AAL0,
+		MT8183_MDP_RDMA0_MOUT_EN_AAL0
+	}, {
+		MDP_COMP_AAL0, MDP_COMP_CCORR0,
+		MT8183_MDP_AAL_MOUT_EN, MT8183_MDP_AAL_MOUT_EN_CCORR0,
+		MT8183_MDP_AAL_MOUT_EN_CCORR0
+	}, {
+		MDP_COMP_AAL0, MDP_COMP_RSZ1,
+		MT8183_MDP_AAL_MOUT_EN, MT8183_MDP_AAL_MOUT_EN_RSZ1,
+		MT8183_MDP_AAL_MOUT_EN_RSZ1
+	}, {
+		MDP_COMP_AAL0, MDP_COMP_RSZ0,
+		MT8183_MDP_AAL_MOUT_EN, MT8183_MDP_AAL_MOUT_EN_RSZ0,
+		MT8183_MDP_AAL_MOUT_EN_RSZ0
+	}, {
+		MDP_COMP_RSZ0, MDP_COMP_PATH0_SOUT,
+		MT8183_MDP_PRZ0_MOUT_EN, MT8183_MDP_PRZ0_MOUT_EN_PATH0_OUT,
+		MT8183_MDP_PRZ0_MOUT_EN_PATH0_OUT
+	}, {
+		MDP_COMP_RSZ0, MDP_COMP_TDSHP0,
+		MT8183_MDP_PRZ0_MOUT_EN, MT8183_MDP_PRZ0_MOUT_EN_TDSHP0,
+		MT8183_MDP_PRZ0_MOUT_EN_TDSHP0
+	}, {
+		MDP_COMP_RSZ1, MDP_COMP_PATH0_SOUT,
+		MT8183_MDP_PRZ1_MOUT_EN, MT8183_MDP_PRZ1_MOUT_EN_PATH0_OUT,
+		MT8183_MDP_PRZ1_MOUT_EN_PATH0_OUT
+	}, {
+		MDP_COMP_RSZ1, MDP_COMP_TDSHP0,
+		MT8183_MDP_PRZ1_MOUT_EN, MT8183_MDP_PRZ1_MOUT_EN_TDSHP0,
+		MT8183_MDP_PRZ1_MOUT_EN_TDSHP0
+	}, {
+		MDP_COMP_RSZ1, MDP_COMP_PATH1_SOUT,
+		MT8183_MDP_PRZ1_MOUT_EN, MT8183_MDP_PRZ1_MOUT_EN_PATH1_OUT,
+		MT8183_MDP_PRZ1_MOUT_EN_PATH1_OUT
+	}, {
+		MDP_COMP_RSZ1, MDP_COMP_COLOR0,
+		MT8183_MDP_PRZ1_MOUT_EN, MT8183_MDP_PRZ1_MOUT_EN_COLOR0,
+		MT8183_MDP_PRZ1_MOUT_EN_COLOR0
+	}, {
+		MDP_COMP_COLOR0, MDP_COMP_PATH0_SOUT,
+		MT8183_MDP_COLOR_MOUT_EN, MT8183_MDP_COLOR_MOUT_EN_PATH0_OUT,
+		MT8183_MDP_COLOR_MOUT_EN_PATH0_OUT
+	}, {
+		MDP_COMP_COLOR0, MDP_COMP_PATH1_SOUT,
+		MT8183_MDP_COLOR_MOUT_EN, MT8183_MDP_COLOR_MOUT_EN_PATH1_OUT,
+		MT8183_MDP_COLOR_MOUT_EN_PATH1_OUT
+	}, {
+		MDP_COMP_CAMIN, MDP_COMP_AAL0,
+		MT8183_MDP_AAL_SEL_IN, MT8183_MDP_AAL_SEL_IN_CAMIN,
+		MT8183_MDP_AAL_SEL_IN_CAMIN
+	}, {
+		MDP_COMP_RDMA0, MDP_COMP_AAL0,
+		MT8183_MDP_AAL_SEL_IN, MT8183_MDP_AAL_SEL_IN_RDMA0,
+		MT8183_MDP_AAL_SEL_IN_RDMA0
+	}, {
+		MDP_COMP_CAMIN2, MDP_COMP_AAL0,
+		MT8183_MDP_AAL_SEL_IN, MT8183_MDP_AAL_SEL_IN_CAMIN2,
+		MT8183_MDP_AAL_SEL_IN_CAMIN2
+	}, {
+		MDP_COMP_CCORR0, MDP_COMP_AAL0,
+		MT8183_MDP_AAL_SEL_IN, MT8183_MDP_AAL_SEL_IN_CCORR0,
+		MT8183_MDP_AAL_SEL_IN_CCORR0
+	}, {
+		MDP_COMP_CAMIN, MDP_COMP_CCORR0,
+		MT8183_MDP_CCORR_SEL_IN, MT8183_MDP_CCORR_SEL_IN_CAMIN,
+		MT8183_MDP_CCORR_SEL_IN_CAMIN
+	}, {
+		MDP_COMP_RDMA0, MDP_COMP_CCORR0,
+		MT8183_MDP_CCORR_SEL_IN, MT8183_MDP_CCORR_SEL_IN_RDMA0,
+		MT8183_MDP_CCORR_SEL_IN_RDMA0
+	}, {
+		MDP_COMP_CAMIN2, MDP_COMP_CCORR0,
+		MT8183_MDP_CCORR_SEL_IN, MT8183_MDP_CCORR_SEL_IN_CAMIN2,
+		MT8183_MDP_CCORR_SEL_IN_CAMIN2
+	}, {
+		MDP_COMP_AAL0, MDP_COMP_CCORR0,
+		MT8183_MDP_CCORR_SEL_IN, MT8183_MDP_CCORR_SEL_IN_AAL0,
+		MT8183_MDP_CCORR_SEL_IN_AAL0
+	}, {
+		MDP_COMP_AAL0, MDP_COMP_RSZ0,
+		MT8183_MDP_PRZ0_SEL_IN, MT8183_MDP_PRZ0_SEL_IN_AAL0,
+		MT8183_MDP_PRZ0_SEL_IN_AAL0
+	}, {
+		MDP_COMP_CCORR0, MDP_COMP_RSZ0,
+		MT8183_MDP_PRZ0_SEL_IN, MT8183_MDP_PRZ0_SEL_IN_CCORR0,
+		MT8183_MDP_PRZ0_SEL_IN_CCORR0
+	}, {
+		MDP_COMP_CAMIN, MDP_COMP_RSZ1,
+		MT8183_MDP_PRZ1_SEL_IN, MT8183_MDP_PRZ1_SEL_IN_CAMIN,
+		MT8183_MDP_PRZ1_SEL_IN_CAMIN
+	}, {
+		MDP_COMP_RDMA0, MDP_COMP_RSZ1,
+		MT8183_MDP_PRZ1_SEL_IN, MT8183_MDP_PRZ1_SEL_IN_RDMA0,
+		MT8183_MDP_PRZ1_SEL_IN_RDMA0
+	}, {
+		MDP_COMP_CAMIN2, MDP_COMP_RSZ1,
+		MT8183_MDP_PRZ1_SEL_IN, MT8183_MDP_PRZ1_SEL_IN_CAMIN2,
+		MT8183_MDP_PRZ1_SEL_IN_CAMIN2
+	}, {
+		MDP_COMP_AAL0, MDP_COMP_RSZ1,
+		MT8183_MDP_PRZ1_SEL_IN, MT8183_MDP_PRZ1_SEL_IN_AAL0,
+		MT8183_MDP_PRZ1_SEL_IN_AAL0
+	}, {
+		MDP_COMP_RSZ0, MDP_COMP_TDSHP0,
+		MT8183_MDP_TDSHP_SEL_IN, MT8183_MDP_TDSHP_SEL_IN_RSZ0,
+		MT8183_MDP_TDSHP_SEL_IN_RSZ0
+	}, {
+		MDP_COMP_RSZ1, MDP_COMP_TDSHP0,
+		MT8183_MDP_TDSHP_SEL_IN, MT8183_MDP_TDSHP_SEL_IN_RSZ1,
+		MT8183_MDP_TDSHP_SEL_IN_RSZ1
+	}, {
+		MDP_COMP_RSZ0, MDP_COMP_PATH0_SOUT,
+		MT8183_MDP_PATH0_SEL_IN, MT8183_MDP_PATH0_SEL_IN_RSZ0,
+		MT8183_MDP_PATH0_SEL_IN_RSZ0
+	}, {
+		MDP_COMP_RSZ1, MDP_COMP_PATH0_SOUT,
+		MT8183_MDP_PATH0_SEL_IN, MT8183_MDP_PATH0_SEL_IN_RSZ1,
+		MT8183_MDP_PATH0_SEL_IN_RSZ1
+	}, {
+		MDP_COMP_COLOR0, MDP_COMP_PATH0_SOUT,
+		MT8183_MDP_PATH0_SEL_IN, MT8183_MDP_PATH0_SEL_IN_COLOR0,
+		MT8183_MDP_PATH0_SEL_IN_COLOR0
+	}, {
+		MDP_COMP_RDMA0, MDP_COMP_PATH0_SOUT,
+		MT8183_MDP_PATH0_SEL_IN, MT8183_MDP_PATH0_SEL_IN_RDMA0,
+		MT8183_MDP_PATH0_SEL_IN_RDMA0
+	}, {
+		MDP_COMP_RSZ1, MDP_COMP_PATH1_SOUT,
+		MT8183_MDP_PATH1_SEL_IN, MT8183_MDP_PATH1_SEL_IN_RSZ1,
+		MT8183_MDP_PATH1_SEL_IN_RSZ1
+	}, {
+		MDP_COMP_COLOR0, MDP_COMP_PATH1_SOUT,
+		MT8183_MDP_PATH1_SEL_IN, MT8183_MDP_PATH1_SEL_IN_COLOR0,
+		MT8183_MDP_PATH1_SEL_IN_COLOR0
+	}, {
+		MDP_COMP_PATH0_SOUT, MDP_COMP_WROT0,
+		MT8183_MDP_WROT0_SEL_IN, MT8183_MDP_WROT0_SEL_IN_PATH0_OUT,
+		MT8183_MDP_WROT0_SEL_IN_PATH0_OUT
+	}, {
+		MDP_COMP_PATH1_SOUT, MDP_COMP_WDMA,
+		MT8183_MDP_WDMA_SEL_IN, MT8183_MDP_WDMA_SEL_IN_PATH1_OUT,
+		MT8183_MDP_WDMA_SEL_IN_PATH1_OUT
+	}, {
+		MDP_COMP_CCORR0, MDP_COMP_AAL0,
+		MT8183_MDP_CCORR_SOUT_SEL, MT8183_MDP_CCORR_SOUT_SEL_AAL0,
+		MT8183_MDP_CCORR_SOUT_SEL_AAL0
+	}, {
+		MDP_COMP_CCORR0, MDP_COMP_RSZ0,
+		MT8183_MDP_CCORR_SOUT_SEL, MT8183_MDP_CCORR_SOUT_SEL_RSZ0,
+		MT8183_MDP_CCORR_SOUT_SEL_RSZ0
+	}, {
+		MDP_COMP_PATH0_SOUT, MDP_COMP_WROT0,
+		MT8183_MDP_PATH0_SOUT_SEL, MT8183_MDP_PATH0_SOUT_SEL_WROT0,
+		MT8183_MDP_PATH0_SOUT_SEL_WROT0
+	}, {
+		MDP_COMP_PATH1_SOUT, MDP_COMP_WDMA,
+		MT8183_MDP_PATH1_SOUT_SEL, MT8183_MDP_PATH1_SOUT_SEL_WDMA,
+		MT8183_MDP_PATH1_SOUT_SEL_WDMA
+	}
+};
+
 #endif /* __SOC_MEDIATEK_MT8183_MMSYS_H */
 
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 1e448f1ffefb..905847d6e16c 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -8,9 +8,11 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/soc/mediatek/mtk-mmsys.h>
+#include <linux/soc/mediatek/mtk-cmdq.h>
 
 #include "mtk-mmsys.h"
 #include "mt8167-mmsys.h"
@@ -54,6 +56,8 @@ static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.clk_driver = "clk-mt8183-mm",
 	.routes = mmsys_mt8183_routing_table,
 	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
+	.mdp_routes = mmsys_mt8183_mdp_routing_table,
+	.mdp_num_routes = ARRAY_SIZE(mmsys_mt8183_mdp_routing_table),
 };
 
 static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
@@ -73,6 +77,8 @@ struct mtk_mmsys {
 	const struct mtk_mmsys_driver_data *data;
 	spinlock_t lock; /* protects mmsys_sw_rst_b reg */
 	struct reset_controller_dev rcdev;
+	phys_addr_t addr;
+	u8 subsys_id;
 };
 
 void mtk_mmsys_ddp_connect(struct device *dev,
@@ -112,6 +118,45 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
 
+void mtk_mmsys_mdp_connect(struct device *dev, struct mmsys_cmdq_cmd *cmd,
+			   enum mtk_mdp_comp_id cur,
+			   enum mtk_mdp_comp_id next)
+{
+	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
+	const struct mtk_mmsys_routes *routes = mmsys->data->mdp_routes;
+	int i;
+
+	if (!routes) {
+		WARN_ON(!routes);
+		return;
+	}
+
+	WARN_ON(mmsys->subsys_id == 0);
+	for (i = 0; i < mmsys->data->mdp_num_routes; i++)
+		if (cur == routes[i].from_comp && next == routes[i].to_comp)
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id,
+					    mmsys->addr + routes[i].addr,
+					    routes[i].val, routes[i].mask);
+}
+EXPORT_SYMBOL_GPL(mtk_mmsys_mdp_connect);
+
+void mtk_mmsys_mdp_disconnect(struct device *dev, struct mmsys_cmdq_cmd *cmd,
+			      enum mtk_mdp_comp_id cur,
+			      enum mtk_mdp_comp_id next)
+{
+	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
+	const struct mtk_mmsys_routes *routes = mmsys->data->mdp_routes;
+	int i;
+
+	WARN_ON(mmsys->subsys_id == 0);
+	for (i = 0; i < mmsys->data->mdp_num_routes; i++)
+		if (cur == routes[i].from_comp && next == routes[i].to_comp)
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id,
+					    mmsys->addr + routes[i].addr,
+					    0, routes[i].mask);
+}
+EXPORT_SYMBOL_GPL(mtk_mmsys_mdp_disconnect);
+
 static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned long id,
 				  bool assert)
 {
@@ -170,6 +215,8 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 	struct platform_device *clks;
 	struct platform_device *drm;
 	struct mtk_mmsys *mmsys;
+	struct resource res;
+	struct cmdq_client_reg cmdq_reg;
 	int ret;
 
 	mmsys = devm_kzalloc(dev, sizeof(*mmsys), GFP_KERNEL);
@@ -195,6 +242,15 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (of_address_to_resource(dev->of_node, 0, &res) < 0)
+		mmsys->addr = 0L;
+	else
+		mmsys->addr = res.start;
+
+	if (cmdq_dev_get_client_reg(dev, &cmdq_reg, 0) != 0)
+		dev_info(dev, "cmdq subsys id has not been set\n");
+	mmsys->subsys_id = cmdq_reg.subsys;
+
 	mmsys->data = of_device_get_match_data(&pdev->dev);
 	platform_set_drvdata(pdev, mmsys);
 
diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
index 8b0ed05117ea..7ec2107b9823 100644
--- a/drivers/soc/mediatek/mtk-mmsys.h
+++ b/drivers/soc/mediatek/mtk-mmsys.h
@@ -92,6 +92,8 @@ struct mtk_mmsys_driver_data {
 	const char *clk_driver;
 	const struct mtk_mmsys_routes *routes;
 	const unsigned int num_routes;
+	const struct mtk_mmsys_routes *mdp_routes;
+	const unsigned int mdp_num_routes;
 };
 
 /*
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index 4bba275e235a..c5a4d6b181ce 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -7,8 +7,14 @@
 #define __MTK_MMSYS_H
 
 enum mtk_ddp_comp_id;
+enum mtk_mdp_comp_id;
 struct device;
 
+struct mmsys_cmdq_cmd {
+	struct cmdq_pkt *pkt;
+	s32 *event;
+};
+
 enum mtk_ddp_comp_id {
 	DDP_COMPONENT_AAL0,
 	DDP_COMPONENT_AAL1,
@@ -45,6 +51,46 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_ID_MAX,
 };
 
+enum mtk_mdp_comp_id {
+	MDP_COMP_NONE = -1,	/* Invalid engine */
+
+	/* ISP */
+	MDP_COMP_WPEI = 0,
+	MDP_COMP_WPEO,		/* 1 */
+	MDP_COMP_WPEI2,		/* 2 */
+	MDP_COMP_WPEO2,		/* 3 */
+	MDP_COMP_ISP_IMGI,	/* 4 */
+	MDP_COMP_ISP_IMGO,	/* 5 */
+	MDP_COMP_ISP_IMG2O,	/* 6 */
+
+	/* IPU */
+	MDP_COMP_IPUI,		/* 7 */
+	MDP_COMP_IPUO,		/* 8 */
+
+	/* MDP */
+	MDP_COMP_CAMIN,		/* 9 */
+	MDP_COMP_CAMIN2,	/* 10 */
+	MDP_COMP_RDMA0,		/* 11 */
+	MDP_COMP_AAL0,		/* 12 */
+	MDP_COMP_CCORR0,	/* 13 */
+	MDP_COMP_RSZ0,		/* 14 */
+	MDP_COMP_RSZ1,		/* 15 */
+	MDP_COMP_TDSHP0,	/* 16 */
+	MDP_COMP_COLOR0,	/* 17 */
+	MDP_COMP_PATH0_SOUT,	/* 18 */
+	MDP_COMP_PATH1_SOUT,	/* 19 */
+	MDP_COMP_WROT0,		/* 20 */
+	MDP_COMP_WDMA,		/* 21 */
+
+	/* Dummy Engine */
+	MDP_COMP_RDMA1,		/* 22 */
+	MDP_COMP_RSZ2,		/* 23 */
+	MDP_COMP_TDSHP1,	/* 24 */
+	MDP_COMP_WROT1,		/* 25 */
+
+	MDP_MAX_COMP_COUNT	/* ALWAYS keep at the end */
+};
+
 void mtk_mmsys_ddp_connect(struct device *dev,
 			   enum mtk_ddp_comp_id cur,
 			   enum mtk_ddp_comp_id next);
@@ -53,4 +99,14 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next);
 
+void mtk_mmsys_mdp_connect(struct device *dev,
+			   struct mmsys_cmdq_cmd *cmd,
+			   enum mtk_mdp_comp_id cur,
+			   enum mtk_mdp_comp_id next);
+
+void mtk_mmsys_mdp_disconnect(struct device *dev,
+			      struct mmsys_cmdq_cmd *cmd,
+			      enum mtk_mdp_comp_id cur,
+			      enum mtk_mdp_comp_id next);
+
 #endif /* __MTK_MMSYS_H */
-- 
2.18.0

