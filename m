Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919484F71C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 03:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiDGBzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 21:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiDGBzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:55:50 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E5419B07C;
        Wed,  6 Apr 2022 18:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649296431; x=1680832431;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GfoMu1rSQjLGCY+LsK9hopMjy06xNe7EDG2XcdKQJC8=;
  b=Zcz6IYvCo8Xe7I+WwsAv90jpPUK7K2+AlbM/ZxnF8VM0Js2bhVmjm04Z
   7mFKwqNwmEwYmk3HUlFL2TyGo7DFtMDrRvrokxPwHsC32XrycErK494aA
   I44T3ZcK9NGZ4PL2/K6ivXtXagQ32I7z65teNu3UnKgrUeqi7vLVplt98
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Apr 2022 18:53:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 18:53:51 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 18:53:50 -0700
Received: from wcheng-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 18:53:49 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH] usb: dwc3: EP clear halt leading to incorrect submission of delayed_status
Date:   Wed, 6 Apr 2022 18:53:36 -0700
Message-ID: <20220407015336.19455-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/usb/dwc3/core.h   | 1 +
 drivers/usb/dwc3/ep0.c    | 1 +
 drivers/usb/dwc3/gadget.c | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5c9d467195a6..55f98485c54c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1272,6 +1272,7 @@ struct dwc3 {
 	unsigned		connected:1;
 	unsigned		softconnect:1;
 	unsigned		delayed_status:1;
+	unsigned		clear_stall_protocol:1;
 	unsigned		ep0_bounced:1;
 	unsigned		ep0_expect_in:1;
 	unsigned		has_hibernation:1;
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
index ab725d2262d6..c427ddae016f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2152,6 +2152,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING ||
 		    (dep->flags & DWC3_EP_DELAY_STOP)) {
 			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
+			dwc->clear_stall_protocol = protocol;
 			return 0;
 		}
 
@@ -3483,7 +3484,7 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
 		}
 
 		dep->flags &= ~(DWC3_EP_STALL | DWC3_EP_WEDGE);
-		if (dwc->delayed_status)
+		if (dwc->clear_stall_protocol)
 			dwc3_ep0_send_delayed_status(dwc);
 	}
 
