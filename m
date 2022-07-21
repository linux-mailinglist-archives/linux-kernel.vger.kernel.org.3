Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A61557C492
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiGUGkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiGUGkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:40:12 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Jul 2022 23:40:08 PDT
Received: from ZXSHCAS1.zhaoxin.com (ZXSHCAS1.zhaoxin.com [210.0.225.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BF12DFA;
        Wed, 20 Jul 2022 23:40:07 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 21 Jul
 2022 14:08:34 +0800
Received: from L440.zhaoxin.com (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 21 Jul
 2022 14:08:34 +0800
From:   Weitao Wang <WeitaoWang-oc@zhaoxin.com>
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <dianders@chromium.org>, <s.shtylyov@omp.ru>,
        <mka@chromium.org>, <ming.lei@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>,
        <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>
Subject: [PATCH] USB: HCD: Fix URB giveback issue in tasklet function
Date:   Thu, 21 Jul 2022 14:08:33 +0800
Message-ID: <20220721060833.4173-1-WeitaoWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.29.8.21]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usb core introduce the mechanism of giveback of URB in tasklet context to
reduce hardware interrupt handling time. On some test situation(such as
FIO with 4KB block size), when tasklet callback function called to
giveback URB, interrupt handler add URB node to the bh->head list also.
If check bh->head list again after finish all URB giveback of local_list,
then it may introduce a "dynamic balance" between giveback URB and add URB
to bh->head list. This tasklet callback function may not exit for a long
time, which will cause other tasklet function calls to be delayed. Some
real-time applications(such as KB and Mouse) will see noticeable lag.

Fix this issue by taking new URBs giveback in next tasklet function call.

Fixes: 94dfd7edfd5c ("USB: HCD: support giveback of URB in tasklet context")
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
 drivers/usb/core/hcd.c  | 24 ++++++++++++++----------
 include/linux/usb/hcd.h |  1 +
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 06eea8848ccc..149c045dfdc1 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1705,10 +1705,16 @@ static void usb_giveback_urb_bh(struct tasklet_struct *t)
 		bh->completing_ep = NULL;
 	}
 
-	/* check if there are new URBs to giveback */
+	/* giveback new URBs next time to prevent this function from
+	 * not exiting for a long time.
+	 */
 	spin_lock_irq(&bh->lock);
-	if (!list_empty(&bh->head))
-		goto restart;
+	if (!list_empty(&bh->head)) {
+		if (bh->hi_priority)
+			tasklet_hi_schedule(&bh->bh);
+		else
+			tasklet_schedule(&bh->bh);
+	}
 	bh->running = false;
 	spin_unlock_irq(&bh->lock);
 }
@@ -1737,7 +1743,7 @@ static void usb_giveback_urb_bh(struct tasklet_struct *t)
 void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
 {
 	struct giveback_urb_bh *bh;
-	bool running, high_prio_bh;
+	bool running;
 
 	/* pass status to tasklet via unlinked */
 	if (likely(!urb->unlinked))
@@ -1748,13 +1754,10 @@ void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
 		return;
 	}
 
-	if (usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe)) {
+	if (usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe))
 		bh = &hcd->high_prio_bh;
-		high_prio_bh = true;
-	} else {
+	else
 		bh = &hcd->low_prio_bh;
-		high_prio_bh = false;
-	}
 
 	spin_lock(&bh->lock);
 	list_add_tail(&urb->urb_list, &bh->head);
@@ -1763,7 +1766,7 @@ void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
 
 	if (running)
 		;
-	else if (high_prio_bh)
+	else if (bh->hi_priority)
 		tasklet_hi_schedule(&bh->bh);
 	else
 		tasklet_schedule(&bh->bh);
@@ -2959,6 +2962,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 
 	/* initialize tasklets */
 	init_giveback_urb_bh(&hcd->high_prio_bh);
+	hcd->high_prio_bh.hi_priority = 1;
 	init_giveback_urb_bh(&hcd->low_prio_bh);
 
 	/* enable irqs just before we start the controller,
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 2c1fc9212cf2..13d67239c66c 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -66,6 +66,7 @@
 
 struct giveback_urb_bh {
 	bool running;
+	bool hi_priority;
 	spinlock_t lock;
 	struct list_head  head;
 	struct tasklet_struct bh;
-- 
2.32.0

