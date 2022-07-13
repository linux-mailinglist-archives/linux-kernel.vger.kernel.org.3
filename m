Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E557572A45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 02:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiGMAgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 20:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGMAf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 20:35:57 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF38795C2A;
        Tue, 12 Jul 2022 17:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657672556; x=1689208556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+SUBg7VmfpDJk8DbV9zlCP/oaaU5j9wRDSrdHrLZVow=;
  b=B34pg6s37VXHJEDbnlYvT7MIUVPO8JBheX9MwIxlz14CXVXk01lhsUP8
   +QjdzdQH0AIVMdKNPz2gbD60DaIzF1UqFGwidNa2/qGafng5VZfotvhFU
   BLMlGYb44xq8C4OpLstR0JlbZNAqReAsjd8z0irLvIyFXNo6DEfvCRRvb
   s=;
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
 15.2.986.22; Tue, 12 Jul 2022 17:35:37 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v2 4/5] usb: dwc3: Allow end transfer commands to be sent during soft disconnect
Date:   Tue, 12 Jul 2022 17:35:22 -0700
Message-ID: <20220713003523.29309-5-quic_wcheng@quicinc.com>
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

If soft disconnect is in progress, allow the endxfer command to be sent,
without this, there is an issue where the stop active transfer call
(during pullup disable) wouldn't actually issue the endxfer command,
while clearing the DEP flag.

In addition, if the DWC3_EP_DELAY_STOP flag was set before soft disconnect
started (i.e. from the dequeue path), ensure that when the EP0 transaction
completes during soft disconnect, to issue the endxfer with the force
parameter set, as it does not expect a command complete event.

Fixes: e4cf6580ac740 ("usb: dwc3: gadget: Wait for ep0 xfers to complete during dequeue")
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
Link:
  https://lore.kernel.org/linux-usb/1a1a5485-790e-79ce-f5a6-1e96d9b49a47@synopsys.com/

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
index ee85b773e3fe..41b7007358de 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1693,6 +1693,7 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	else if (!ret)
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
+	dep->flags &= ~DWC3_EP_DELAY_STOP;
 
 	return ret;
 }
@@ -3686,8 +3687,10 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	if (dep->number <= 1 && dwc->ep0state != EP0_DATA_PHASE)
 		return;
 
+	if (interrupt && (dep->flags & DWC3_EP_DELAY_STOP))
+		return;
+
 	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
-	    (dep->flags & DWC3_EP_DELAY_STOP) ||
 	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
 		return;
 
