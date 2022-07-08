Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BBB56C23B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbiGHSuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239725AbiGHSuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:50:44 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C7D6410;
        Fri,  8 Jul 2022 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657306243; x=1688842243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=iLLN0bgHauzl53XPoFFOr0sBnjyYBeEUVLmD1uYq7eQ=;
  b=uFWPbUdo6sME5pv705vhxTn16+r4mJ+OkAtvFWAGbhKhLx2xN+LiNoOZ
   bRjG8FVQiAbvPto6JQkyNotL9U/E8Qah4G0teWmhwnX29QmO9VQa8OMUP
   nID5/djijN5qIpZVbJkojccO4YCe7Hwn7+VacF3rQ0RrbTmTIKdhNn9Ok
   M=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 08 Jul 2022 11:50:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 11:50:41 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 11:50:21 -0700
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 11:50:20 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <quic_jackp@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH 3/5] usb: dwc3: gadget: Adjust IRQ management during soft disconnect/connect
Date:   Fri, 8 Jul 2022 11:50:05 -0700
Message-ID: <20220708185007.21743-4-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220708185007.21743-1-quic_wcheng@quicinc.com>
References: <20220708185007.21743-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local interrupts are currently being disabled as part of aquiring the
spin lock before issuing the endxfer command.  Leave interrupts enabled, so
that EP0 events can continue to be processed.  Also, ensure that there are
no pending interrupts before attempting to handle any soft
connect/disconnect.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 75cbc3f185d0..bd40608b19df 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2046,7 +2046,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 	trace_dwc3_ep_dequeue(req);
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock(&dwc->lock);
 
 	list_for_each_entry(r, &dep->cancelled_list, list) {
 		if (r == req)
@@ -2085,7 +2085,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		request, ep->name);
 	ret = -EINVAL;
 out:
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock(&dwc->lock);
 
 	return ret;
 }
@@ -2501,9 +2501,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc);
 
 static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock(&dwc->lock);
 	dwc->connected = false;
 
 	/*
@@ -2518,10 +2516,10 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 
 		reinit_completion(&dwc->ep0_in_setup);
 
-		spin_unlock_irqrestore(&dwc->lock, flags);
+		spin_unlock(&dwc->lock);
 		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
 				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
-		spin_lock_irqsave(&dwc->lock, flags);
+		spin_lock(&dwc->lock);
 		if (ret == 0)
 			dev_warn(dwc->dev, "timed out waiting for SETUP phase\n");
 	}
@@ -2535,7 +2533,7 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 */
 	dwc3_stop_active_transfers(dwc);
 	__dwc3_gadget_stop(dwc);
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock(&dwc->lock);
 
 	/*
 	 * Note: if the GEVNTCOUNT indicates events in the event buffer, the
@@ -2581,6 +2579,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		return 0;
 	}
 
+	synchronize_irq(dwc->irq_gadget);
+
 	if (!is_on) {
 		ret = dwc3_gadget_soft_disconnect(dwc);
 	} else {
@@ -3740,7 +3740,10 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	 * This mode is NOT available on the DWC_usb31 IP.
 	 */
 
+	spin_unlock(&dwc->lock);
 	__dwc3_stop_active_transfer(dep, force, interrupt);
+	spin_lock(&dwc->lock);
+
 }
 
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
