Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C25588264
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiHBTSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiHBTSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:18:45 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F82713CD9;
        Tue,  2 Aug 2022 12:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659467924; x=1691003924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=rQ6Hq/Z43PzcHLHa0X0VopuTrR/clg6tyIPhusfsMT4=;
  b=KBBy+rqnKloSuXRXUIzsQF794GpqDOmAF8cdY0KJXhoXTgZPiMb6i/2H
   fULkoaVPd7RzuNnTVB9iIMY/cI4m/CRaM6JuT/BGqG4BMk4PH1mdQBSKK
   kRVmK0YIivCNF02WoqfUa80jqEC+rMDLqM/lxbrReoq1HRCkXM04y3RJR
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 02 Aug 2022 12:18:42 -0700
X-QCInternal: smtphost
Received: from hu-eserrao-lv.qualcomm.com (HELO hu-devc-lv-c.qualcomm.com) ([10.47.235.164])
  by ironmsg09-lv.qualcomm.com with ESMTP; 02 Aug 2022 12:18:42 -0700
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 7263D2106D; Tue,  2 Aug 2022 12:18:42 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        quic_mrana@quicinc.com, Thinh.Nguyen@synopsys.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH 1/5] usb: dwc3: Add remote wakeup handling
Date:   Tue,  2 Aug 2022 12:18:36 -0700
Message-Id: <1659467920-9095-2-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
References: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An usb device can initate a remote wakeup and bring the link out of
suspend as dictated by the DEVICE_REMOTE_WAKEUP feature selector.
Add support to handle this packet and set the remote wakeup capability
accordingly.

Some hosts may take longer time to initiate the resume
signaling after device triggers a remote wakeup. So improve the
gadget_wakeup op to interrupt based rather than polling based by
enabling link status change events.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/dwc3/core.h   |  4 +++
 drivers/usb/dwc3/ep0.c    |  4 +++
 drivers/usb/dwc3/gadget.c | 69 ++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4fe4287..3306b1c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1113,6 +1113,8 @@ struct dwc3_scratchpad_array {
  *		     address.
  * @num_ep_resized: carries the current number endpoints which have had its tx
  *		    fifo resized.
+ * @is_remote_wakeup_enabled: remote wakeup status from host perspective
+ * @is_gadget_wakeup: remote wakeup requested via gadget op.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1326,6 +1328,8 @@ struct dwc3 {
 	int			max_cfg_eps;
 	int			last_fifo_depth;
 	int			num_ep_resized;
+	bool			is_remote_wakeup_enabled;
+	bool			is_gadget_wakeup;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 197af63..4cc3d3a 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -353,6 +353,9 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 				usb_status |= 1 << USB_DEV_STAT_U1_ENABLED;
 			if (reg & DWC3_DCTL_INITU2ENA)
 				usb_status |= 1 << USB_DEV_STAT_U2_ENABLED;
+		} else {
+			usb_status |= dwc->is_remote_wakeup_enabled <<
+						USB_DEVICE_REMOTE_WAKEUP;
 		}
 
 		break;
@@ -473,6 +476,7 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 
 	switch (wValue) {
 	case USB_DEVICE_REMOTE_WAKEUP:
+		dwc->is_remote_wakeup_enabled = set;
 		break;
 	/*
 	 * 9.4.1 says only for SS, in AddressState only for
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4366c45..d6697da 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2232,6 +2232,22 @@ static const struct usb_ep_ops dwc3_gadget_ep_ops = {
 
 /* -------------------------------------------------------------------------- */
 
+static void linksts_change_events_set(struct dwc3 *dwc, bool set)
+{
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DEVTEN);
+	if (set)
+		reg |= DWC3_DEVTEN_ULSTCNGEN;
+	else
+		reg &= ~DWC3_DEVTEN_ULSTCNGEN;
+
+	dwc3_writel(dwc->regs, DWC3_DEVTEN, reg);
+
+	/* Required to complete this operation before returning */
+	mb();
+}
+
 static int dwc3_gadget_get_frame(struct usb_gadget *g)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
@@ -2270,9 +2286,13 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 		return -EINVAL;
 	}
 
+	linksts_change_events_set(dwc, true);
+
 	ret = dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RECOV);
 	if (ret < 0) {
 		dev_err(dwc->dev, "failed to put link in Recovery\n");
+		linksts_change_events_set(dwc, false);
+		dwc->is_gadget_wakeup = false;
 		return ret;
 	}
 
@@ -2284,9 +2304,15 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 	}
 
+	/* If remote wakeup is triggered from function driver, bail out.
+	 * Since link status change events are enabled we would receive
+	 * an U0 event when wakeup is successful.
+	 */
+	if (dwc->is_gadget_wakeup)
+		return -EAGAIN;
+
 	/* poll until Link State changes to ON */
 	retries = 20000;
-
 	while (retries--) {
 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 
@@ -2295,6 +2321,8 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 			break;
 	}
 
+	linksts_change_events_set(dwc, false);
+
 	if (DWC3_DSTS_USBLNKST(reg) != DWC3_LINK_STATE_U0) {
 		dev_err(dwc->dev, "failed to send remote wakeup\n");
 		return -EINVAL;
@@ -2310,7 +2338,20 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	int			ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (g->speed < USB_SPEED_SUPER && !dwc->is_remote_wakeup_enabled) {
+		dev_err(dwc->dev, "%s:remote wakeup not supported\n", __func__);
+		ret =  -EPERM;
+		goto out;
+	}
+	if (dwc->is_gadget_wakeup) {
+		dev_err(dwc->dev, "%s: remote wakeup in progress\n", __func__);
+		ret = -EINVAL;
+		goto out;
+	}
+	dwc->is_gadget_wakeup = true;
 	ret = __dwc3_gadget_wakeup(dwc);
+
+out:
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
@@ -2766,6 +2807,9 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= driver;
+	linksts_change_events_set(dwc, false);
+	dwc->is_remote_wakeup_enabled = false;
+	dwc->is_gadget_wakeup = false;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
@@ -2785,6 +2829,9 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= NULL;
+	linksts_change_events_set(dwc, false);
+	dwc->is_remote_wakeup_enabled = false;
+	dwc->is_gadget_wakeup = false;
 	dwc->max_cfg_eps = 0;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -3768,6 +3815,8 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
 
 	dwc->connected = false;
+	linksts_change_events_set(dwc, false);
+	dwc->is_gadget_wakeup = false;
 }
 
 static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
@@ -3855,6 +3904,10 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
 	reg &= ~(DWC3_DCFG_DEVADDR_MASK);
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+
+	dwc->is_remote_wakeup_enabled = false;
+	linksts_change_events_set(dwc, false);
+	dwc->is_gadget_wakeup = false;
 }
 
 static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
@@ -3998,8 +4051,9 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	 */
 }
 
-static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
+static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc, unsigned int evtinfo)
 {
+	enum dwc3_link_state next = evtinfo & DWC3_LINK_STATE_MASK;
 	/*
 	 * TODO take core out of low power mode when that's
 	 * implemented.
@@ -4010,6 +4064,8 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
+
+	dwc->link_state = next;
 }
 
 static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
@@ -4091,6 +4147,13 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 	}
 
 	switch (next) {
+	case DWC3_LINK_STATE_U0:
+		if (dwc->is_gadget_wakeup) {
+			linksts_change_events_set(dwc, false);
+			dwc3_resume_gadget(dwc);
+			dwc->is_gadget_wakeup = false;
+		}
+		break;
 	case DWC3_LINK_STATE_U1:
 		if (dwc->speed == USB_SPEED_SUPER)
 			dwc3_suspend_gadget(dwc);
@@ -4159,7 +4222,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_conndone_interrupt(dwc);
 		break;
 	case DWC3_DEVICE_EVENT_WAKEUP:
-		dwc3_gadget_wakeup_interrupt(dwc);
+		dwc3_gadget_wakeup_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_HIBER_REQ:
 		if (dev_WARN_ONCE(dwc->dev, !dwc->has_hibernation,
-- 
2.7.4

