Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A80E4E4034
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbiCVOJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbiCVOJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:09:42 -0400
Received: from ZXSHCAS1.zhaoxin.com (ZXSHCAS1.zhaoxin.com [203.148.12.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4278167C1;
        Tue, 22 Mar 2022 07:07:56 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Tue, 22 Mar
 2022 22:07:23 +0800
Received: from L440.zhaoxin.com (10.29.8.49) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 22 Mar
 2022 22:07:23 +0800
From:   WeitaoWangoc <WeitaoWang-oc@zhaoxin.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <hzpeterchen@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>,
        <CobeChen@zhaoxin.com>, Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Subject: [PATCH v2] USB: Fix xhci ERDP update issue
Date:   Tue, 22 Mar 2022 22:07:23 +0800
Message-ID: <20220322140723.9554-1-WeitaoWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.29.8.49]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some situations, software handles TRB events slower than adding TRBs.
If the number of TRB events to be processed in a given interrupt is 256.
The local variable "event_ring_deq" that records in interrupt handler
is equal to software_dequeue. It will cause driver not update ERDP,then
software dequeue pointer is out of sync with ERDP on interrupt exit.
On the next interrupt, the event ring may full but driver will not
update ERDP as software_dequeue is equal to ERDP.

[  536.377115] xhci_hcd 0000:00:12.0: ERROR unknown event type 37
[  566.933173] sd 8:0:0:0: [sdb] tag#27 uas_eh_abort_handler 0 uas-tag 7
inflight: CMD OUT
[  566.933181] sd 8:0:0:0: [sdb] tag#27 CDB: Write(10) 2a 00 17 71 e6 78
00 00 08 00
[  572.041186] xhci_hcd On some situataions,the 0000:00:12.0: xHCI host
not responding to stop endpoint command.
[  572.057193] xhci_hcd 0000:00:12.0: Host halt failed, -110
[  572.057196] xhci_hcd 0000:00:12.0: xHCI host controller not
responding, assume dead
[  572.057236] sd 8:0:0:0: [sdb] tag#26 uas_eh_abort_handler 0 uas-tag 6
inflight: CMD
[  572.057240] sd 8:0:0:0: [sdb] tag#26 CDB: Write(10) 2a 00 38 eb cc d8
00 00 08 00
[  572.057244] sd 8:0:0:0: [sdb] tag#25 uas_eh_abort_handler 0 uas-tag 5
inflight: CMD

Fixed this issue by update software record local variable when
handles 128 TRB events.

Fixes: dc0ffbea5729 ("usb: host: xhci: update event ring dequeue pointer on purpose")
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
v1->v2:
 - Add fixes information with improved commit messages.
 - Fix "tabs converted to spaces" issue.

 drivers/usb/host/xhci-ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index d0b6806275e0..f9707997969d 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3141,6 +3141,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 		if (event_loop++ < TRBS_PER_SEGMENT / 2)
 			continue;
 		xhci_update_erst_dequeue(xhci, event_ring_deq);
+		event_ring_deq = xhci->event_ring->dequeue;
 
 		/* ring is half-full, force isoc trbs to interrupt more often */
 		if (xhci->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
-- 
2.32.0
