Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7091150071B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbiDNHlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiDNHlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:41:39 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93A56752;
        Thu, 14 Apr 2022 00:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649921955; x=1681457955;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=wxmRBxyHS+dg9xLU3QSbb0YU+y3j4+3+2rDE+ovnt+E=;
  b=jUB0q3x976/f9P62HoxD6NTb+E38F0AUp4My84Ng3nGNYG3xgk21JLpo
   86asEU8VSCwi4eNNJiqaXB7PGFLlMCJJpTZUz/M4lcfRWOwgoGuAEVoEn
   511tQhT4MnXItN+Bb/+aQsdCmY+2lOaPhu8h0k1uo/LrbXNVa7g8dhpe+
   k=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 14 Apr 2022 00:39:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 00:39:15 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 00:39:14 -0700
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 00:39:14 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <quic_pkondeti@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v2] usb: dwc3: EP clear halt leading to clearing of delayed_status
Date:   Thu, 14 Apr 2022 00:39:02 -0700
Message-ID: <20220414073902.21960-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb_ep_clear_halt() API can be called from the function driver, and
translates to dwc3_gadget_ep_set_halt().  This routine is shared with when
the host issues a clear feature ENDPOINT_HALT, and is differentiated by the
protocol argument.  If the following sequence occurs, there can be a
situation where the delayed_status flag is improperly cleared for the wrong
SETUP transaction:

1. Vendor specific control transfer returns USB_GADGET_DELAYED_STATUS.
2. DWC3 gadget sets dwc->delayed_status to '1'.
3. Another function driver issues a usb_ep_clear_halt() call.
4. DWC3 gadget issues dwc3_stop_active_transfer() and sets
   DWC3_EP_PENDING_CLEAR_STALL.
5. EP command complete interrupt triggers for the end transfer, and
   dwc3_ep0_send_delayed_status() is allowed to run, as delayed_status
   is '1' due to step#1.
6. STATUS phase is sent, and delayed_status is cleared.
7. Vendor specific control transfer is finished being handled, and issues
   usb_composite_setup_continue().  This results in queuing of a data
   phase.

Cache the protocol flag so that DWC3 gadget is aware of when the clear halt
is due to a SETUP request from the host versus when it is sourced from a
function driver.  This allows for the EP command complete interrupt to know
if it needs to issue a delayed status phase.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
Changes in v2:
 - Modified clear_stall_protocol to carry the ep num for the clear halt
   from PC.  Clear halts on other endpoints in parallel should not
   affect/interrupt the clear halt from the host.

 drivers/usb/dwc3/core.h   | 2 ++
 drivers/usb/dwc3/ep0.c    | 1 +
 drivers/usb/dwc3/gadget.c | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5c9d467195a6..81c486b3941c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1046,6 +1046,7 @@ struct dwc3_scratchpad_array {
  * @tx_thr_num_pkt_prd: periodic ESS transmit packet count
  * @tx_max_burst_prd: max periodic ESS transmit burst size
  * @tx_fifo_resize_max_num: max number of fifos allocated during txfifo resize
+ * @clear_stall_protocol: endpoint number that requires a delayed status phase
  * @hsphy_interface: "utmi" or "ulpi"
  * @connected: true when we're connected to a host, false otherwise
  * @softconnect: true when gadget connect is called, false when disconnect runs
@@ -1266,6 +1267,7 @@ struct dwc3 {
 	u8			tx_thr_num_pkt_prd;
 	u8			tx_max_burst_prd;
 	u8			tx_fifo_resize_max_num;
+	u8			clear_stall_protocol;
 
 	const char		*hsphy_interface;
 
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 1064be5518f6..aa8476da222d 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1080,6 +1080,7 @@ void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
 	unsigned int direction = !dwc->ep0_expect_in;
 
 	dwc->delayed_status = false;
+	dwc->clear_stall_protocol = 0;
 
 	if (dwc->ep0state != EP0_STATUS_PHASE)
 		return;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ab725d2262d6..ce1b130202c5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2152,6 +2152,9 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING ||
 		    (dep->flags & DWC3_EP_DELAY_STOP)) {
 			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
+			if (protocol)
+				dwc->clear_stall_protocol = dep->number;
+
 			return 0;
 		}
 
@@ -3483,7 +3486,7 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
 		}
 
 		dep->flags &= ~(DWC3_EP_STALL | DWC3_EP_WEDGE);
-		if (dwc->delayed_status)
+		if (dwc->clear_stall_protocol == dep->number)
 			dwc3_ep0_send_delayed_status(dwc);
 	}
 
