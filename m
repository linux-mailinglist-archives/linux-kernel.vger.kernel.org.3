Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2C456C28D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbiGHSuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbiGHSuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:50:22 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F336374;
        Fri,  8 Jul 2022 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657306221; x=1688842221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=WuxqCOOJXOJI+VTcVx55HnGmLsEEsYHqj5wQxGBY3yo=;
  b=Y1/eBg+ltPoROSyZXO1hEg/IH+Ck+/Y26dWZTI+zx8NNpeeyerpIhz6o
   Or5bMCE2PUKyDgwcW2lmT7qAM/DkcXMZ1EzGUcvxauoqxdieNHAEu4SN6
   Cd0ehuuGdYJaUMxTkXj7MJ8cyuU2YVeHkh3nz+sX1H0jzlWKhXus0yKF4
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Jul 2022 11:50:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 11:50:20 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 11:50:20 -0700
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 11:50:20 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <quic_jackp@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH 1/5] usb: dwc3: Do not service EP0 and conndone events if soft disconnected
Date:   Fri, 8 Jul 2022 11:50:03 -0700
Message-ID: <20220708185007.21743-2-quic_wcheng@quicinc.com>
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

There are some operations that need to be ignored if there is a soft
disconnect in progress.  This is to avoid having a pending EP0 transfer in
progress while attempting to stop active transfers and halting the
controller.

There were several instances seen where a soft disconnect was able to occur
during early link negotiation, i.e. bus reset/conndone, which leads to the
conndone handler re-configuring EPs while attempting to halt the
controller, as DEP flags are cleared as part of the soft disconnect path.

ep0out: cmd 'Start New Configuration'
ep0out: cmd 'Set Endpoint Transfer Resource'
ep0in: cmd 'Set Endpoint Transfer Resource'
ep1out: cmd 'Set Endpoint Transfer Resource'
...
event (00030601): Suspend [U3]
event (00000101): Reset [U0]
ep0out: req ffffff87e5c9e100 length 0/0 zsI ==> 0
event (00000201): Connection Done [U0]
ep0out: cmd 'Start New Configuration'
ep0out: cmd 'Set Endpoint Transfer Resource'

In addition, if a soft disconnect occurs, EP0 events are still allowed to
process, however, it will stall/restart during the SETUP phase.  The
host is still able to query for the DATA phase, leading to a
xfernotready(DATA) event.  Since none of the SETUP transfer parameters are
populated, the xfernotready is treated as a "wrong direction" error,
leading to a duplicate stall/restart routine.

Add the proper softconnect/connected checks in sequences that are
potentially involved during soft disconnect processing.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/ep0.c    | 6 ++++--
 drivers/usb/dwc3/gadget.c | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 2a510e84eef4..506ef717fdc0 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -197,7 +197,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	if (!dep->endpoint.desc || !dwc->pullups_connected) {
+	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
 		ret = -ESHUTDOWN;
@@ -813,7 +813,7 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 	int ret = -EINVAL;
 	u32 len;
 
-	if (!dwc->gadget_driver || !dwc->connected)
+	if (!dwc->gadget_driver || !dwc->softconnect || !dwc->connected)
 		goto out;
 
 	trace_dwc3_ctrl_req(ctrl);
@@ -1116,6 +1116,8 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 {
 	switch (event->status) {
 	case DEPEVT_STATUS_CONTROL_DATA:
+		if (!dwc->softconnect || !dwc->connected)
+			return;
 		/*
 		 * We already have a DATA transfer in the controller's cache,
 		 * if we receive a XferNotReady(DATA) we will ignore it, unless
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a944c7a6c83a..298e842c384c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3877,6 +3877,9 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	u8			lanes = 1;
 	u8			speed;
 
+	if (!dwc->softconnect)
+		return;
+
 	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 	speed = reg & DWC3_DSTS_CONNECTSPD;
 	dwc->speed = speed;
