Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C2A4960C9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381081AbiAUO3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:29:45 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51330 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381084AbiAUO3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:29:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20LETWZh090839;
        Fri, 21 Jan 2022 08:29:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1642775372;
        bh=6nxm2h8Mq8kYm5aq3h1mR3MDiH7HwdVUGtwvOz7ldNo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mJ8GkyVcSNWHol8N8Eiyx9GmLa18cnIXKJhgl71hBeMmI8DGyx8T8UYxjwlxv9hLB
         cL4Y9w4yShr9RCUTJN10nE/3TowtN78Zxj6Qup2xBGAfFhEXMcRMKcZTSYttayVTlQ
         B0RbunxWvQ9rU8Dk7gptoW6BwztM2ecGRjQi1648=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20LETWIw048385
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jan 2022 08:29:32 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 21
 Jan 2022 08:29:32 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 21 Jan 2022 08:29:32 -0600
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20LET4Hr072129;
        Fri, 21 Jan 2022 08:29:28 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Benoit Parrot <bparrot@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>
Subject: [PATCH v6 06/14] media: cadence: csi2rx: Set the STOP bit when stopping a stream
Date:   Fri, 21 Jan 2022 19:58:56 +0530
Message-ID: <20220121142904.4091481-7-p.yadav@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121142904.4091481-1-p.yadav@ti.com>
References: <20220121142904.4091481-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stream stop procedure says that the STOP bit should be set when the
stream is to be stopped, and then the ready bit in stream status
register polled to make sure the STOP operation is finished.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---

(no changes since v5)

Changes in v5:
- Change %d to %u
- Add Laurent's R-by.

 drivers/media/platform/cadence/cdns-csi2rx.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 346afb3578ac..5cc18fe0f1b9 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
@@ -40,8 +41,12 @@
 
 #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
 #define CSI2RX_STREAM_CTRL_SOFT_RST			BIT(4)
+#define CSI2RX_STREAM_CTRL_STOP				BIT(1)
 #define CSI2RX_STREAM_CTRL_START			BIT(0)
 
+#define CSI2RX_STREAM_STATUS_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x004)
+#define CSI2RX_STREAM_STATUS_RDY			BIT(31)
+
 #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
 #define CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT		BIT(31)
 #define CSI2RX_STREAM_DATA_CFG_VC_SELECT(n)		BIT((n) + 16)
@@ -305,12 +310,23 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 {
 	unsigned int i;
+	u32 val;
+	int ret;
 
 	clk_prepare_enable(csi2rx->p_clk);
 	clk_disable_unprepare(csi2rx->sys_clk);
 
 	for (i = 0; i < csi2rx->max_streams; i++) {
-		writel(0, csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
+		writel(CSI2RX_STREAM_CTRL_STOP,
+		       csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
+
+		ret = readl_relaxed_poll_timeout(csi2rx->base +
+						 CSI2RX_STREAM_STATUS_REG(i),
+						 val,
+						 (val & CSI2RX_STREAM_STATUS_RDY),
+						 10, 10000);
+		if (ret)
+			dev_warn(csi2rx->dev, "Failed to stop stream%u\n", i);
 
 		clk_disable_unprepare(csi2rx->pixel_clk[i]);
 	}
-- 
2.34.1

