Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4677B51ADE6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352186AbiEDTkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiEDTkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:40:41 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31363299A;
        Wed,  4 May 2022 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651693025; x=1683229025;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Jf6tngzF3V71emQN/niHDC62BLbJwpJBRPwYIfhp48s=;
  b=qR92w7CKCligRE4DAXeGE21xODByXgcd6KR5izmtNC1IdC+0jotvmrdj
   f0TdKWuTL8IigaCyg4109nun2ITj4r3WgcFMVYpUDgGbRh+47KRkiIlv1
   s5k4HMpabQvB8hF5mVXGo5BK+lksdDzgzfAm53wZxqYdr46Wk4PxlHZIe
   Y=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 04 May 2022 12:37:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 12:37:04 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 12:37:04 -0700
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 12:37:03 -0700
From:   Mayank Rana <quic_mrana@quicinc.com>
To:     <peter.chen@kernel.org>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <John.Youn@synopsys.com>,
        <quic_jackp@quicinc.com>, <quic_wcheng@quicinc.com>,
        Mayank Rana <quic_mrana@quicinc.com>
Subject: [PATCH] usb: dwc3: Fix ep0 handling when getting reset while doing control transfer
Date:   Wed, 4 May 2022 12:36:41 -0700
Message-ID: <1651693001-29891-1-git-send-email-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the databook ep0 should be in setup phase during reset.
If host issues reset between control transfers, ep0 will be  in an
invalid state. Fix this by issuing stall and restart on ep0 if it
is not in setup phase.

Also SW needs to complete pending control transfer and setup core for
next setup stage as per data book. Hence check ep0 state during reset
interrupt handling and make sure active transfers on ep0 out/in
endpoint are stopped by queuing ENDXFER command for that endpoint and
restart ep0 out again to receive next setup packet.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 drivers/usb/dwc3/ep0.c    | 11 ++++++++---
 drivers/usb/dwc3/gadget.c | 27 +++++++++++++++++++++++++--
 drivers/usb/dwc3/gadget.h |  2 ++
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 1064be5..9b6ebc3 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -218,7 +218,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 	return ret;
 }
 
-static void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
+void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 {
 	struct dwc3_ep		*dep;
 
@@ -1087,13 +1087,18 @@ void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
 	__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
 }
 
-static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
+void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	u32			cmd;
 	int			ret;
 
-	if (!dep->resource_index)
+	/*
+	 * For status/DATA OUT stage, TRB will be queued on ep0 out
+	 * endpoint for which resource index is zero. Hence allow
+	 * queuing ENDXFER command for ep0 out endpoint.
+	 */
+	if (!dep->resource_index && dep->number)
 		return;
 
 	cmd = DWC3_DEPCMD_ENDTRANSFER;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ab725d2..82a210f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -882,12 +882,13 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 		reg |= DWC3_DALEPENA_EP(dep->number);
 		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
+		dep->trb_dequeue = 0;
+		dep->trb_enqueue = 0;
+
 		if (usb_endpoint_xfer_control(desc))
 			goto out;
 
 		/* Initialize the TRB ring */
-		dep->trb_dequeue = 0;
-		dep->trb_enqueue = 0;
 		memset(dep->trb_pool, 0,
 		       sizeof(struct dwc3_trb) * DWC3_TRB_NUM);
 
@@ -2745,6 +2746,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 
 	/* begin to receive SETUP packets */
 	dwc->ep0state = EP0_SETUP_PHASE;
+	dwc->ep0_bounced = false;
 	dwc->link_state = DWC3_LINK_STATE_SS_DIS;
 	dwc->delayed_status = false;
 	dwc3_ep0_out_start(dwc);
@@ -3766,6 +3768,27 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	}
 
 	dwc3_reset_gadget(dwc);
+
+	/*
+	 * From SNPS databook section 8.1.2, the EP0 should be in setup
+	 * phase. So ensure that EP0 is in setup phase by issuing a stall
+	 * and restart if EP0 is not in setup phase.
+	 */
+	if (dwc->ep0state != EP0_SETUP_PHASE) {
+		unsigned int	dir;
+
+		dir = !!dwc->ep0_expect_in;
+		if (dwc->ep0state == EP0_DATA_PHASE)
+			dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
+		else
+			dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
+
+		dwc->eps[0]->trb_enqueue = 0;
+		dwc->eps[1]->trb_enqueue = 0;
+
+		dwc3_ep0_stall_and_restart(dwc);
+	}
+
 	/*
 	 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
 	 * Section 4.1.2 Table 4-2, it states that during a USB reset, the SW
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index f763380..55a56cf67 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -110,6 +110,8 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 void dwc3_ep0_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event);
 void dwc3_ep0_out_start(struct dwc3 *dwc);
+void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep);
+void dwc3_ep0_stall_and_restart(struct dwc3 *dwc);
 int __dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value);
 int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value);
 int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
-- 
2.7.4

