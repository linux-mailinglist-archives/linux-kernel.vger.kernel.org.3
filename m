Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A1F4B7B97
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244975AbiBPAJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:09:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbiBPAJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:09:01 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1AFAEF1D;
        Tue, 15 Feb 2022 16:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644970130; x=1676506130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oN4NWytvEcUVUp7v1buldlNzHy56+BuMGRT2tVQLD2A=;
  b=Ug65FQNKfxecU87bZHf63kB8+Ji0s7Ym9SmgAjTJWF9sMG88UpZSlxJu
   95rWGEEAv9lcFz3bNFVcTkLOiCVH+FGE1ySkFpddb1c62/1VEMzN7Cenm
   FXDit1CRU6GVvI4AL7a0LwAuEOCiYDSLt3q5HDFeCfC/+DWPcJGXr1wKm
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Feb 2022 16:08:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 16:08:49 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 16:08:49 -0800
Received: from wcheng-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 16:08:48 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH v2 2/3] usb: dwc3: gadget: Wait for ep0 xfers to complete during dequeue
Date:   Tue, 15 Feb 2022 16:08:34 -0800
Message-ID: <20220216000835.25400-3-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220216000835.25400-1-quic_wcheng@quicinc.com>
References: <20220216000835.25400-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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
index a411682e7f44..00348d6d479b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -736,6 +736,7 @@ struct dwc3_ep {
 #define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
 #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
 #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
+#define DWC3_EP_PENDING_DEQUEUE		BIT(13)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN			BIT(31)
@@ -1272,6 +1273,7 @@ struct dwc3 {
 	unsigned		delayed_status:1;
 	unsigned		ep0_bounced:1;
 	unsigned		ep0_expect_in:1;
+	unsigned		ep_dequeue_pending:1;
 	unsigned		has_hibernation:1;
 	unsigned		sysdev_is_parent:1;
 	unsigned		has_lpm_erratum:1;
@@ -1553,6 +1555,7 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
 void dwc3_ep0_stall_and_restart(struct dwc3 *dwc);
 void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep);
+int dwc3_gadget_check_ep_dequeue(struct dwc3 *dwc);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
@@ -1579,6 +1582,8 @@ static inline void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 static inline void dwc3_ep0_end_control_data(struct dwc3 *dwc,
 					     struct dwc3_ep *dep)
 { }
+static inline int dwc3_gadget_check_ep_dequeue(struct dwc3 *dwc)
+{ return 0; }
 #endif
 
 #if IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index a2cc94c25dcf..99202f5a613e 100644
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
index f6801199440c..0c89baedf220 100644
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
@@ -2033,10 +2058,6 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
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
@@ -2045,6 +2066,12 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
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
@@ -2319,6 +2346,7 @@ static void dwc3_stop_active_transfers(struct dwc3 *dwc)
 			continue;
 
 		dwc3_remove_requests(dwc, dep);
+		dep->flags &= ~DWC3_EP_PENDING_DEQUEUE;
 	}
 }
 
@@ -2715,6 +2743,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	dwc->ep0state = EP0_SETUP_PHASE;
 	dwc->link_state = DWC3_LINK_STATE_SS_DIS;
 	dwc->delayed_status = false;
+	dwc->ep_dequeue_pending = 0;
 	dwc3_ep0_out_start(dwc);
 
 	dwc3_gadget_enable_irq(dwc);
@@ -3433,6 +3462,7 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
 	if (dep->stream_capable)
 		dep->flags |= DWC3_EP_IGNORE_NEXT_NOSTREAM;
 
+	dep->flags &= ~DWC3_EP_PENDING_DEQUEUE;
 	dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
 	dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	dwc3_gadget_ep_cleanup_cancelled_requests(dep);
@@ -3609,7 +3639,7 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	}
 }
 
-static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
+static int dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	bool interrupt)
 {
 	struct dwc3_gadget_ep_cmd_params params;
@@ -3620,7 +3650,7 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 
 	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
 	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
-		return;
+		return 0;
 
 	/*
 	 * NOTICE: We are violating what the Databook says about the
@@ -3671,6 +3701,8 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 				dwc3_ep0_out_start(dwc);
 				goto retry;
 			}
+		} else {
+			return ret;
 		}
 	}
 	dep->resource_index = 0;
@@ -3679,6 +3711,7 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	else
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
+	return ret;
 }
 
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
