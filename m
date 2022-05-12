Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76B0524620
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350540AbiELGuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiELGuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:50:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759E61FD862;
        Wed, 11 May 2022 23:50:02 -0700 (PDT)
X-UUID: 6313bf50c53a40b894193d01d1405805-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:8cbb2581-c8ae-4193-bf4c-12821782587b,OB:0,LO
        B:10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:105
X-CID-INFO: VERSION:1.1.4,REQID:8cbb2581-c8ae-4193-bf4c-12821782587b,OB:0,LOB:
        10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:105
X-CID-META: VersionHash:faefae9,CLOUDID:f8ad05a7-eab7-4b74-a74d-5359964535a9,C
        OID:a4daee569091,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 6313bf50c53a40b894193d01d1405805-20220512
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 277784755; Thu, 12 May 2022 14:49:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 12 May 2022 14:49:57 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 May 2022 14:49:56 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: [PATCH 2/2] usb: xhci-mtk: remove bandwidth budget table
Date:   Thu, 12 May 2022 14:49:31 +0800
Message-ID: <20220512064931.31670-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512064931.31670-1-chunfeng.yun@mediatek.com>
References: <20220512064931.31670-1-chunfeng.yun@mediatek.com>
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

The bandwidth budget table is introduced to trace ideal bandwidth used
by each INT/ISOC endpoint, but in fact the endpoint may consume more
bandwidth and cause data transfer error, so it's better to leave some
margin. Obviously it's difficult to find the best margin for all cases,
instead take use of the worst-case scenario.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 74 ++++++---------------------------
 drivers/usb/host/xhci-mtk.h     |  2 -
 2 files changed, 12 insertions(+), 64 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 953d2cd1d4cc..06a6b19acaae 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -19,11 +19,6 @@
 #define HS_BW_BOUNDARY	6144
 /* usb2 spec section11.18.1: at most 188 FS bytes per microframe */
 #define FS_PAYLOAD_MAX 188
-/*
- * max number of microframes for split transfer,
- * for fs isoc in : 1 ss + 1 idle + 7 cs
- */
-#define TT_MICROFRAMES_MAX 9
 
 #define DBG_BUF_EN	64
 
@@ -242,28 +237,17 @@ static void drop_tt(struct usb_device *udev)
 
 static struct mu3h_sch_ep_info *
 create_sch_ep(struct xhci_hcd_mtk *mtk, struct usb_device *udev,
-	      struct usb_host_endpoint *ep, struct xhci_ep_ctx *ep_ctx)
+	      struct usb_host_endpoint *ep)
 {
 	struct mu3h_sch_ep_info *sch_ep;
 	struct mu3h_sch_bw_info *bw_info;
 	struct mu3h_sch_tt *tt = NULL;
-	u32 len_bw_budget_table;
 
 	bw_info = get_bw_info(mtk, udev, ep);
 	if (!bw_info)
 		return ERR_PTR(-ENODEV);
 
-	if (is_fs_or_ls(udev->speed))
-		len_bw_budget_table = TT_MICROFRAMES_MAX;
-	else if ((udev->speed >= USB_SPEED_SUPER)
-			&& usb_endpoint_xfer_isoc(&ep->desc))
-		len_bw_budget_table = get_esit(ep_ctx);
-	else
-		len_bw_budget_table = 1;
-
-	sch_ep = kzalloc(struct_size(sch_ep, bw_budget_table,
-				     len_bw_budget_table),
-			 GFP_KERNEL);
+	sch_ep = kzalloc(sizeof(*sch_ep), GFP_KERNEL);
 	if (!sch_ep)
 		return ERR_PTR(-ENOMEM);
 
@@ -295,8 +279,6 @@ static void setup_sch_info(struct xhci_ep_ctx *ep_ctx,
 	u32 mult;
 	u32 esit_pkts;
 	u32 max_esit_payload;
-	u32 *bwb_table = sch_ep->bw_budget_table;
-	int i;
 
 	ep_type = CTX_TO_EP_TYPE(le32_to_cpu(ep_ctx->ep_info2));
 	maxpkt = MAX_PACKET_DECODED(le32_to_cpu(ep_ctx->ep_info2));
@@ -332,7 +314,6 @@ static void setup_sch_info(struct xhci_ep_ctx *ep_ctx,
 		 */
 		sch_ep->pkts = max_burst + 1;
 		sch_ep->bw_cost_per_microframe = maxpkt * sch_ep->pkts;
-		bwb_table[0] = sch_ep->bw_cost_per_microframe;
 	} else if (sch_ep->speed >= USB_SPEED_SUPER) {
 		/* usb3_r1 spec section4.4.7 & 4.4.8 */
 		sch_ep->cs_count = 0;
@@ -349,7 +330,6 @@ static void setup_sch_info(struct xhci_ep_ctx *ep_ctx,
 		if (ep_type == INT_IN_EP || ep_type == INT_OUT_EP) {
 			sch_ep->pkts = esit_pkts;
 			sch_ep->num_budget_microframes = 1;
-			bwb_table[0] = maxpkt * sch_ep->pkts;
 		}
 
 		if (ep_type == ISOC_IN_EP || ep_type == ISOC_OUT_EP) {
@@ -366,15 +346,8 @@ static void setup_sch_info(struct xhci_ep_ctx *ep_ctx,
 				DIV_ROUND_UP(esit_pkts, sch_ep->pkts);
 
 			sch_ep->repeat = !!(sch_ep->num_budget_microframes > 1);
-			sch_ep->bw_cost_per_microframe = maxpkt * sch_ep->pkts;
-
-			for (i = 0; i < sch_ep->num_budget_microframes - 1; i++)
-				bwb_table[i] = sch_ep->bw_cost_per_microframe;
-
-			/* last one <= bw_cost_per_microframe */
-			bwb_table[i] = maxpkt * esit_pkts
-				       - i * sch_ep->bw_cost_per_microframe;
 		}
+		sch_ep->bw_cost_per_microframe = maxpkt * sch_ep->pkts;
 	} else if (is_fs_or_ls(sch_ep->speed)) {
 		sch_ep->pkts = 1; /* at most one packet for each microframe */
 
@@ -384,28 +357,7 @@ static void setup_sch_info(struct xhci_ep_ctx *ep_ctx,
 		 */
 		sch_ep->cs_count = DIV_ROUND_UP(maxpkt, FS_PAYLOAD_MAX);
 		sch_ep->num_budget_microframes = sch_ep->cs_count;
-		sch_ep->bw_cost_per_microframe =
-			(maxpkt < FS_PAYLOAD_MAX) ? maxpkt : FS_PAYLOAD_MAX;
-
-		/* init budget table */
-		if (ep_type == ISOC_OUT_EP) {
-			for (i = 0; i < sch_ep->num_budget_microframes; i++)
-				bwb_table[i] =	sch_ep->bw_cost_per_microframe;
-		} else if (ep_type == INT_OUT_EP) {
-			/* only first one consumes bandwidth, others as zero */
-			bwb_table[0] = sch_ep->bw_cost_per_microframe;
-		} else { /* INT_IN_EP or ISOC_IN_EP */
-			bwb_table[0] = 0; /* start split */
-			bwb_table[1] = 0; /* idle */
-			/*
-			 * due to cs_count will be updated according to cs
-			 * position, assign all remainder budget array
-			 * elements as @bw_cost_per_microframe, but only first
-			 * @num_budget_microframes elements will be used later
-			 */
-			for (i = 2; i < TT_MICROFRAMES_MAX; i++)
-				bwb_table[i] =	sch_ep->bw_cost_per_microframe;
-		}
+		sch_ep->bw_cost_per_microframe = min_t(u32, maxpkt, FS_PAYLOAD_MAX);
 	}
 }
 
@@ -422,7 +374,7 @@ static u32 get_max_bw(struct mu3h_sch_bw_info *sch_bw,
 
 		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
 			k = XHCI_MTK_BW_INDEX(base + j);
-			bw = sch_bw->bus_bw[k] + sch_ep->bw_budget_table[j];
+			bw = sch_bw->bus_bw[k] + sch_ep->bw_cost_per_microframe;
 			if (bw > max_bw)
 				max_bw = bw;
 		}
@@ -433,18 +385,16 @@ static u32 get_max_bw(struct mu3h_sch_bw_info *sch_bw,
 static void update_bus_bw(struct mu3h_sch_bw_info *sch_bw,
 	struct mu3h_sch_ep_info *sch_ep, bool used)
 {
+	int bw_updated;
 	u32 base;
-	int i, j, k;
+	int i, j;
+
+	bw_updated = sch_ep->bw_cost_per_microframe * (used ? 1 : -1);
 
 	for (i = 0; i < sch_ep->num_esit; i++) {
 		base = sch_ep->offset + i * sch_ep->esit;
-		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
-			k = XHCI_MTK_BW_INDEX(base + j);
-			if (used)
-				sch_bw->bus_bw[k] += sch_ep->bw_budget_table[j];
-			else
-				sch_bw->bus_bw[k] -= sch_ep->bw_budget_table[j];
-		}
+		for (j = 0; j < sch_ep->num_budget_microframes; j++)
+			sch_bw->bus_bw[XHCI_MTK_BW_INDEX(base + j)] += bw_updated;
 	}
 }
 
@@ -708,7 +658,7 @@ static int add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 
 	xhci_dbg(xhci, "%s %s\n", __func__, decode_ep(ep, udev->speed));
 
-	sch_ep = create_sch_ep(mtk, udev, ep, ep_ctx);
+	sch_ep = create_sch_ep(mtk, udev, ep);
 	if (IS_ERR_OR_NULL(sch_ep))
 		return -ENOMEM;
 
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index ffd4b493b4ba..1174a510dd38 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -83,7 +83,6 @@ struct mu3h_sch_bw_info {
  *		times; 1: distribute the (bMaxBurst+1)*(Mult+1) packets
  *		according to @pkts and @repeat. normal mode is used by
  *		default
- * @bw_budget_table: table to record bandwidth budget per microframe
  */
 struct mu3h_sch_ep_info {
 	u32 esit;
@@ -109,7 +108,6 @@ struct mu3h_sch_ep_info {
 	u32 pkts;
 	u32 cs_count;
 	u32 burst_mode;
-	u32 bw_budget_table[];
 };
 
 #define MU3C_U3_PORT_MAX 4
-- 
2.18.0

