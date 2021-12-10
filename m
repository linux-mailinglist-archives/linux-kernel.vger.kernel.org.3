Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A624707BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244863AbhLJR4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:56:45 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:44692 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244826AbhLJR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:56:16 -0500
X-UUID: 1d12d83c1db0411ba7f306d0e10d676e-20211211
X-UUID: 1d12d83c1db0411ba7f306d0e10d676e-20211211
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1684738223; Sat, 11 Dec 2021 01:52:36 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 11 Dec 2021 01:52:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Dec
 2021 01:52:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:52:35 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>,
        "JB Tsai" <jb.tsai@mediatek.com>
Subject: [PATCH 05/12] remoteproc: mediatek: Add MT8195 APU remoteproc support
Date:   Sat, 11 Dec 2021 01:52:16 +0800
Message-ID: <20211210175223.31131-6-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210175223.31131-1-flora.fu@mediatek.com>
References: <20211210175223.31131-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 platform data in the APU remoteproc driver.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 drivers/remoteproc/mtk-apu-rproc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/remoteproc/mtk-apu-rproc.c b/drivers/remoteproc/mtk-apu-rproc.c
index 40af8e88f41a..dc54b87ad661 100644
--- a/drivers/remoteproc/mtk-apu-rproc.c
+++ b/drivers/remoteproc/mtk-apu-rproc.c
@@ -997,8 +997,23 @@ const struct mtk_apu_platdata mt8192_platdata = {
 	},
 };
 
+const struct mtk_apu_platdata mt8195_platdata = {
+	.flags = F_AUTO_BOOT,
+	.ipi_attrs = mt81xx_ipi_attrs,
+	.ops = {
+		.start = mt81xx_rproc_start,
+		.stop = mt81xx_rproc_stop,
+		.resume = mt81xx_rproc_resume,
+		.apu_memmap_init = mt81xx_apu_memmap_init,
+		.apu_memmap_remove = mt81xx_apu_memmap_remove,
+		.power_on = mt81xx_apu_power_on,
+		.power_off = mt81xx_apu_power_off,
+	},
+};
+
 static const struct of_device_id apu_of_match[] = {
 	{ .compatible = "mediatek,mt8192-apusys-rv", .data = &mt8192_platdata},
+	{ .compatible = "mediatek,mt8195-apusys-rv", .data = &mt8195_platdata},
 	{},
 };
 MODULE_DEVICE_TABLE(of, apu_of_match);
-- 
2.18.0

