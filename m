Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4882956C252
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbiGHSup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbiGHSum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:50:42 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0986374;
        Fri,  8 Jul 2022 11:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657306241; x=1688842241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=PRssGgBUZwlGxNiKF6O3YP6arGGvINBAbocWe53cn9c=;
  b=OmCpwhikHYvBqKgOIDX0gqusWbbxIwIxR/SL9A+MsDKq0Cni3cpkcUxs
   TIF7t8E5OzaPgO3LBmm0UeTVEEFgp0a1uT8YbdmFkdMoQa+WvkCyDQY8c
   muUw1oKvaBB3aHsZl2Cc+BIgr2YctzU1qb5ePJc4sTXndN+hf5N8i5t3W
   o=;
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
 15.2.986.22; Fri, 8 Jul 2022 11:50:21 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <quic_jackp@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH 4/5] usb: dwc3: Allow end transfer commands to be sent during soft disconnect
Date:   Fri, 8 Jul 2022 11:50:06 -0700
Message-ID: <20220708185007.21743-5-quic_wcheng@quicinc.com>
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

If soft disconnect is in progress, allow the endxfer command to be sent,
without this, there is an issue where the stop active transfer call
(during pullup disable) wouldn't actually issue the endxfer command,
while clearing the DEP flag.

In addition, if the DWC3_EP_DELAY_STOP flag was set before soft disconnect
started (i.e. from the dequeue path), ensure that when the EP0 transaction
completes during soft disconnect, to issue the endxfer with the force
parameter set, as it does not expect a command complete event.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/ep0.c    | 3 +--
 drivers/usb/dwc3/gadget.c | 5 ++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 506ef717fdc0..5851b0e9db0a 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -290,8 +290,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 		if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
 			continue;
 
-		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
-		dwc3_stop_active_transfer(dwc3_ep, true, true);
+		dwc3_stop_active_transfer(dwc3_ep, true, dwc->connected);
 	}
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index bd40608b19df..fba2797ad9ae 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3696,8 +3696,10 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	if (dep->number <= 1 && dwc->ep0state != EP0_DATA_PHASE)
 		return;
 
+	if (interrupt && (dep->flags & DWC3_EP_DELAY_STOP))
+		return;
+
 	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
-	    (dep->flags & DWC3_EP_DELAY_STOP) ||
 	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
 		return;
 
@@ -3744,6 +3746,7 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	__dwc3_stop_active_transfer(dep, force, interrupt);
 	spin_lock(&dwc->lock);
 
+	dep->flags &= ~DWC3_EP_DELAY_STOP;
 }
 
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
