Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DA54A8019
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349050AbiBCIAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:00:47 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59011 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242985AbiBCIAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643875235; x=1675411235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wjPKbnmsqRoXsfCoe3W7rEroDQtHnYf1Mhc0u4qe2qE=;
  b=QMQw2dZSZclpEMgHlEgkrSEOPvng6qLi4TQlxjnfXjoEig8lQL6u2WYX
   qW+0nADKxwIxCbThTiwrUpRtLXmwMx8N6VtutK8+kP1SVDLAGptYhmDeY
   EdXlBr0sC5a6S649J904EENnPQ0hhtKJUnQ2mWtMfJUysfyjqv4/eCT89
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Feb 2022 00:00:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 00:00:34 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 00:00:33 -0800
Received: from wcheng-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 00:00:33 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH 2/3] usb: dwc3: gadget: Wait for ep0 xfers to complete during dequeue
Date:   Thu, 3 Feb 2022 00:00:16 -0800
Message-ID: <20220203080017.27339-3-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220203080017.27339-1-quic_wcheng@quicinc.com>
References: <20220203080017.27339-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the request being dequeued is currently active, then the current
logic is to issue a stop transfer command, and allow the command
completion to cleanup the cancelled list.  The DWC3 controller will
run into endxfer command timeouts if there is an ongoing EP0
transaction.  If this is the case, wait for the EP0 completion event
before proceeding to retry the endxfer command again.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/core.h   |  5 +++++
 drivers/usb/dwc3/ep0.c    |  2 ++
 drivers/usb/dwc3/gadget.c | 47 +++++++++++++++++++++++++++++++++------
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a124694c0038..d418ed55a566 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -733,6 +733,7 @@ struct dwc3_ep {
 #define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
 #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
 #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
+#define DWC3_EP_PENDING_DEQUEUE		BIT(13)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN			BIT(31)
@@ -1267,6 +1268,7 @@ struct dwc3 {
 	unsigned		delayed_status:1;
 	unsigned		ep0_bounced:1;
 	unsigned		ep0_expect_in:1;
+	unsigned		ep_dequeue_pending:1;
 	unsigned		has_hibernation:1;
 	unsigned		sysdev_is_parent:1;
 	unsigned		has_lpm_erratum:1;
@@ -1548,6 +1550,7 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
 void dwc3_ep0_stall_and_restart(struct dwc3 *dwc);
 void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep);
+int dwc3_gadget_check_ep_dequeue(struct dwc3 *dwc);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
@@ -1574,6 +1577,8 @@ static inline void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 static inline void dwc3_ep0_end_control_data(struct dwc3 *dwc,
 					     struct dwc3_ep *dep)
 { }
+static inline int dwc3_gadget_check_ep_dequeue(struct dwc3 *dwc)
+{ return 0; }
 #endif
 
 #if IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index eb677b888610..cc3339e4308f 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -243,6 +243,7 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 
 	dwc->ep0state = EP0_SETUP_PHASE;
 	complete(&dwc->ep0_in_setup);
+	dwc3_gadget_check_ep_dequeue(dwc);
 	if (dwc->softconnect)
 		dwc3_ep0_out_start(dwc);
 }
@@ -925,6 +926,7 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
 
 	dwc->ep0state = EP0_SETUP_PHASE;
 	complete(&dwc->ep0_in_setup);
+	dwc3_gadget_check_ep_dequeue(dwc);
 	if (dwc->softconnect)
 		dwc3_ep0_out_start(dwc);
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 19b8d837e9d0..1efa30907d42 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -654,7 +654,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
 }
 
-static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
+static int dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 		bool interrupt);
 
 /**
@@ -1081,6 +1081,31 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 	return ret;
 }
 
+int dwc3_gadget_check_ep_dequeue(struct dwc3 *dwc)
+{
+	struct dwc3_ep *dep;
+	int ret = 0;
+	int i;
+
+	if (!dwc->ep_dequeue_pending)
+		return 0;
+
+	for (i = 0; i < dwc->num_eps; i++) {
+		dep = dwc->eps[i];
+		if (dep->flags & DWC3_EP_PENDING_DEQUEUE) {
+			ret = dwc3_stop_active_transfer(dep, false, true);
+			if (ret)
+				goto exit;
+
+			dep->flags &= ~DWC3_EP_PENDING_DEQUEUE;
+		}
+	}
+
+	dwc->ep_dequeue_pending = 0;
+exit:
+	return ret;
+}
+
 static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 {
 	struct dwc3_ep			*dep;
@@ -2020,10 +2045,6 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 	list_for_each_entry(r, &dep->started_list, list) {
 		if (r == req) {
 			struct dwc3_request *t;
-
-			/* wait until it is processed */
-			dwc3_stop_active_transfer(dep, true, true);
-
 			/*
 			 * Remove any started request if the transfer is
 			 * cancelled.
@@ -2032,6 +2053,12 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 				dwc3_gadget_move_cancelled_request(r,
 						DWC3_REQUEST_STATUS_DEQUEUED);
 
+			ret = dwc3_stop_active_transfer(dep, false, true);
+			if (ret == -ETIMEDOUT) {
+				dep->flags |= DWC3_EP_PENDING_DEQUEUE;
+				dwc->ep_dequeue_pending = 1;
+			}
+
 			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
 
 			goto out;
@@ -2306,6 +2333,7 @@ static void dwc3_stop_active_transfers(struct dwc3 *dwc)
 			continue;
 
 		dwc3_remove_requests(dwc, dep);
+		dep->flags &= ~DWC3_EP_PENDING_DEQUEUE;
 	}
 }
 
@@ -2702,6 +2730,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	dwc->ep0state = EP0_SETUP_PHASE;
 	dwc->link_state = DWC3_LINK_STATE_SS_DIS;
 	dwc->delayed_status = false;
+	dwc->ep_dequeue_pending = 0;
 	dwc3_ep0_out_start(dwc);
 
 	dwc3_gadget_enable_irq(dwc);
@@ -3420,6 +3449,7 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
 	if (dep->stream_capable)
 		dep->flags |= DWC3_EP_IGNORE_NEXT_NOSTREAM;
 
+	dep->flags &= ~DWC3_EP_PENDING_DEQUEUE;
 	dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
 	dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	dwc3_gadget_ep_cleanup_cancelled_requests(dep);
@@ -3596,7 +3626,7 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	}
 }
 
-static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
+static int dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	bool interrupt)
 {
 	struct dwc3_gadget_ep_cmd_params params;
@@ -3607,7 +3637,7 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 
 	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
 	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
-		return;
+		return 0;
 
 	/*
 	 * NOTICE: We are violating what the Databook says about the
@@ -3658,6 +3688,8 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 				dwc3_ep0_out_start(dwc);
 				goto retry;
 			}
+		} else {
+			return ret;
 		}
 	}
 	dep->resource_index = 0;
@@ -3666,6 +3698,7 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	else
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
+	return ret;
 }
 
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
