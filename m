Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765F64D3B6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiCIUzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiCIUzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:55:15 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFD3EA743;
        Wed,  9 Mar 2022 12:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646859255; x=1678395255;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/1Uy0HusF/qCAMDQY4I/Zn9aPVqrSxW/m9P8fu4Texo=;
  b=jKNT9NGNaGZhivHNdx6vZnm1shU/Z3zrgGtfuDj+rzUiw9PBPoyq28qQ
   LsxzGOgU21qw9CdoSjsLC70/3EZVNjwk5Fv3/6ByYZKh45gecE0+zDBzy
   Vh90hSFaBVk+NAwEwoBuc2AX8/jO9s68zD+O05AeWxUTKldhUY6kp9wrJ
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Mar 2022 12:54:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 12:54:14 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Mar 2022 12:54:14 -0800
Received: from wcheng-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Mar 2022 12:54:13 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_jackp@quicinc.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Wesley Cheng" <quic_wcheng@quicinc.com>
Subject: [PATCH v2] usb: dwc3: gadget: Wait for ep0 xfers to complete during dequeue
Date:   Wed, 9 Mar 2022 12:54:02 -0800
Message-ID: <20220309205402.4467-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

If a Setup packet is received but yet to DMA out, the controller will
not process the End Transfer command of any endpoint. Polling of its
DEPCMD.CmdAct may block setting up TRB for Setup packet, causing a
command timeout.

This may occur if the driver doesn’t service the completion interrupt of
the control status stage yet due to system latency, then it won’t
prepare TRB and start the transfer for the next Setup Stage. To the host
side, the control transfer had completed, and the host can send a new
Setup packet at this point.

In the meanwhile, if the driver receives an async call to dequeue a
request (triggering End Transfer) to any endpoint, then the driver will
service that End transfer first, blocking the control status stage
completion handler. Since no TRB is available for the Setup stage, the
Setup packet can’t be DMA’ed out and the End Transfer gets hung.

The driver must not block setting up of the Setup stage. So track and
only issue the End Transfer command only when there’s Setup TRB prepared
so that the controller can DMA out the Setup packet. Delay the End
transfer command if there's no Setup TRB available. This is applicable to
all DWC_usb3x IPs.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Co-developed-by: Wesley Cheng <quic_wcheng@quicinc.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 Changes in v2:
   - Updated commit message with further details about the symptom
     observed and how the patch addresses it.
   - Fixed placement of commit sign-off tags.
   - Added some comments to the changes to explain the issue details.

 Patch discussion below:
   https://lore.kernel.org/linux-usb/1644836933-141376-1-git-send-email-dh10.jung@samsung.com/T/#t

 drivers/usb/dwc3/core.h   |  1 +
 drivers/usb/dwc3/ep0.c    | 14 ++++++++++++++
 drivers/usb/dwc3/gadget.c | 20 +++++++++++++++-----
 drivers/usb/dwc3/gadget.h |  1 +
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index eb9c1efced05..52050e7fb46b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -736,6 +736,7 @@ struct dwc3_ep {
 #define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
 #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
 #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
+#define DWC3_EP_DELAY_STOP             BIT(13)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN			BIT(31)
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 658739410992..1064be5518f6 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -271,6 +271,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 {
 	struct dwc3_ep			*dep;
 	int				ret;
+	int                             i;
 
 	complete(&dwc->ep0_in_setup);
 
@@ -279,6 +280,19 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 			DWC3_TRBCTL_CONTROL_SETUP, false);
 	ret = dwc3_ep0_start_trans(dep);
 	WARN_ON(ret < 0);
+	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
+		struct dwc3_ep *dwc3_ep;
+
+		dwc3_ep = dwc->eps[i];
+		if (!dwc3_ep)
+			continue;
+
+		if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
+			continue;
+
+		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
+		dwc3_stop_active_transfer(dwc3_ep, true, true);
+	}
 }
 
 static struct dwc3_ep *dwc3_wIndex_to_dep(struct dwc3 *dwc, __le16 wIndex_le)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a0c883f19a41..9840f0bb7795 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -654,9 +654,6 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
 }
 
-static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
-		bool interrupt);
-
 /**
  * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
  * @dwc: pointer to the DWC3 context
@@ -1899,6 +1896,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	 */
 	if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
 	    (dep->flags & DWC3_EP_WEDGE) ||
+	    (dep->flags & DWC3_EP_DELAY_STOP) ||
 	    (dep->flags & DWC3_EP_STALL)) {
 		dep->flags |= DWC3_EP_DELAY_START;
 		return 0;
@@ -2033,6 +2031,16 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		if (r == req) {
 			struct dwc3_request *t;
 
+			/*
+			 * If a Setup packet is received but yet to DMA out, the controller will
+			 * not process the End Transfer command of any endpoint. Polling of its
+			 * DEPCMD.CmdAct may block setting up TRB for Setup packet, causing a
+			 * timeout. Delay issuing the End Transfer command until the Setup TRB is
+			 * prepared.
+			 */
+			if (dwc->ep0state != EP0_SETUP_PHASE && !dwc->delayed_status)
+				dep->flags |= DWC3_EP_DELAY_STOP;
+
 			/* wait until it is processed */
 			dwc3_stop_active_transfer(dep, true, true);
 
@@ -2116,7 +2124,8 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
 
-		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
+		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING ||
+		    (dep->flags & DWC3_EP_DELAY_STOP)) {
 			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
 			return 0;
 		}
@@ -3596,7 +3605,7 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	}
 }
 
-static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
+void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	bool interrupt)
 {
 	struct dwc3_gadget_ep_cmd_params params;
@@ -3604,6 +3613,7 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	int ret;
 
 	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
+	    (dep->flags & DWC3_EP_DELAY_STOP) ||
 	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
 		return;
 
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 77df4b6d6c13..f763380e672e 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -116,6 +116,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 		gfp_t gfp_flags);
 int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
 void dwc3_ep0_send_delayed_status(struct dwc3 *dwc);
+void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt);
 
 /**
  * dwc3_gadget_ep_get_transfer_index - Gets transfer index from HW
