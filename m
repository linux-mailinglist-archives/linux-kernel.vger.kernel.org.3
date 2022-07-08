Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4856B34E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbiGHHTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbiGHHTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:19:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5B079684;
        Fri,  8 Jul 2022 00:19:13 -0700 (PDT)
X-UUID: 25ec25eaea8b4b75aa3f8ac01a79a4b5-20220708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:45a82aec-60f7-4b96-b732-3fda5676c3d4,OB:0,LO
        B:10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:45a82aec-60f7-4b96-b732-3fda5676c3d4,OB:0,LOB:
        10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:0ab6f3d6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:adb7ddad82c4,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 25ec25eaea8b4b75aa3f8ac01a79a4b5-20220708
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 199479320; Fri, 08 Jul 2022 15:19:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 8 Jul 2022 15:19:07 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jul 2022 15:19:07 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 2/5] usb: mtu3: print endpoint type as string
Date:   Fri, 8 Jul 2022 15:19:00 +0800
Message-ID: <20220708071903.25752-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708071903.25752-1-chunfeng.yun@mediatek.com>
References: <20220708071903.25752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print endpoint type as string instead of decimal value to make
the log more readable.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_debugfs.c | 8 ++++----
 drivers/usb/mtu3/mtu3_trace.h   | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
index a6f72494b819..ea9186d5504d 100644
--- a/drivers/usb/mtu3/mtu3_debugfs.c
+++ b/drivers/usb/mtu3/mtu3_debugfs.c
@@ -101,13 +101,13 @@ static int mtu3_ep_used_show(struct seq_file *sf, void *unused)
 	for (i = 0; i < mtu->num_eps; i++) {
 		mep = mtu->in_eps + i;
 		if (mep->flags & MTU3_EP_ENABLED) {
-			seq_printf(sf, "%s - type: %d\n", mep->name, mep->type);
+			seq_printf(sf, "%s - type: %s\n", mep->name, usb_ep_type_string(mep->type));
 			used++;
 		}
 
 		mep = mtu->out_eps + i;
 		if (mep->flags & MTU3_EP_ENABLED) {
-			seq_printf(sf, "%s - type: %d\n", mep->name, mep->type);
+			seq_printf(sf, "%s - type: %s\n", mep->name, usb_ep_type_string(mep->type));
 			used++;
 		}
 	}
@@ -177,8 +177,8 @@ static int mtu3_ep_info_show(struct seq_file *sf, void *unused)
 	unsigned long flags;
 
 	spin_lock_irqsave(&mtu->lock, flags);
-	seq_printf(sf, "ep - type:%d, maxp:%d, slot:%d, flags:%x\n",
-		   mep->type, mep->maxp, mep->slot, mep->flags);
+	seq_printf(sf, "ep - type:%s, maxp:%d, slot:%d, flags:%x\n",
+		   usb_ep_type_string(mep->type), mep->maxp, mep->slot, mep->flags);
 	spin_unlock_irqrestore(&mtu->lock, flags);
 
 	return 0;
diff --git a/drivers/usb/mtu3/mtu3_trace.h b/drivers/usb/mtu3/mtu3_trace.h
index 1b897636daf2..a09deae1146f 100644
--- a/drivers/usb/mtu3/mtu3_trace.h
+++ b/drivers/usb/mtu3/mtu3_trace.h
@@ -238,8 +238,8 @@ DECLARE_EVENT_CLASS(mtu3_log_ep,
 		__entry->direction = mep->is_in;
 		__entry->gpd_ring = &mep->gpd_ring;
 	),
-	TP_printk("%s: type %d maxp %d slot %d mult %d burst %d ring %p/%pad flags %c:%c%c%c:%c",
-		__get_str(name), __entry->type,
+	TP_printk("%s: type %s maxp %d slot %d mult %d burst %d ring %p/%pad flags %c:%c%c%c:%c",
+		__get_str(name), usb_ep_type_string(__entry->type),
 		__entry->maxp, __entry->slot,
 		__entry->mult, __entry->maxburst,
 		__entry->gpd_ring, &__entry->gpd_ring->dma,
-- 
2.18.0

