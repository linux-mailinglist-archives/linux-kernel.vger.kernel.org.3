Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55CF572A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 02:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiGMAgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 20:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiGMAf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 20:35:57 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5047C904CC;
        Tue, 12 Jul 2022 17:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657672556; x=1689208556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BI4jOeUuHo0akw4+/jtNSMe67l8hias/ucwXx8rSUP8=;
  b=S3qx+PsfKizljy8WrjNmL3YTdjC+s37VOoipzgnWVp9Xd8CR2wp70KyP
   z1ynVmhJwrJvTqirl2Uoz0d3Xr0VrQ/CVuqEfT5lLCcjk7eEjfw0dP3MC
   ZVWjtfnjW3SLgup8pIP/NeVLLTu01cjoeV3CY3/ZVMxTW+9TSDVAWzWrf
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Jul 2022 17:35:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 17:35:54 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Jul 2022 17:35:37 -0700
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Jul 2022 17:35:36 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v2 3/5] usb: dwc3: gadget: Adjust IRQ management during soft disconnect/connect
Date:   Tue, 12 Jul 2022 17:35:21 -0700
Message-ID: <20220713003523.29309-4-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220713003523.29309-1-quic_wcheng@quicinc.com>
References: <20220713003523.29309-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
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

Fixes: 861c010a2ee1 ("usb: dwc3: gadget: Refactor pullup()")
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a455f8d4631d..ee85b773e3fe 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1674,6 +1674,7 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
 static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
 {
 	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3 *dwc = dep->dwc;
 	u32 cmd;
 	int ret;
 
@@ -1682,7 +1683,9 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	cmd |= interrupt ? DWC3_DEPCMD_CMDIOC : 0;
 	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
 	memset(&params, 0, sizeof(params));
+	spin_unlock(&dwc->lock);
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+	spin_lock(&dwc->lock);
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
@@ -2029,12 +2032,11 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
 	struct dwc3			*dwc = dep->dwc;
 
-	unsigned long			flags;
 	int				ret = 0;
 
 	trace_dwc3_ep_dequeue(req);
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock(&dwc->lock);
 
 	list_for_each_entry(r, &dep->cancelled_list, list) {
 		if (r == req)
@@ -2073,7 +2075,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		request, ep->name);
 	ret = -EINVAL;
 out:
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock(&dwc->lock);
 
 	return ret;
 }
@@ -2489,9 +2491,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc);
 
 static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock(&dwc->lock);
 	dwc->connected = false;
 
 	/*
@@ -2506,10 +2506,10 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 
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
@@ -2523,7 +2523,7 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 */
 	dwc3_stop_active_transfers(dwc);
 	__dwc3_gadget_stop(dwc);
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock(&dwc->lock);
 
 	/*
 	 * Note: if the GEVNTCOUNT indicates events in the event buffer, the
@@ -2569,6 +2569,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		return 0;
 	}
 
+	synchronize_irq(dwc->irq_gadget);
+
 	if (!is_on) {
 		ret = dwc3_gadget_soft_disconnect(dwc);
 	} else {
@@ -3729,6 +3731,7 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	 */
 
 	__dwc3_stop_active_transfer(dep, force, interrupt);
+
 }
 
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
