Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7E5570FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiGLBoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiGLBoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:44:24 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6B111445;
        Mon, 11 Jul 2022 18:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657590263; x=1689126263;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=LizhqP0nwUIsGnaAlCxRNXh+P5gA1s2ZlqdE1oPtHR4=;
  b=cHKr1Pk8okNFiKnnTHo442HfWcTi/T14Mmt/ZgdiZuOR3cuuJe0U+wVc
   iYk3oF/QjWGYQ77Mr/2Yj6+MVnhnJdXuDZe9R7aks/RmW6kz5ij9rvE0P
   gZlsF68NgZvLhnyANkOAvpwzmAmBKnkm/Cni6KzqM17Rhx7EVStYfTG6R
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 11 Jul 2022 18:44:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 18:44:22 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Jul 2022 18:44:22 -0700
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Jul 2022 18:44:21 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH] usb: dwc3: ep0: Properly handle setup_packet_pending scenario in data stage
Date:   Mon, 11 Jul 2022 18:44:03 -0700
Message-ID: <20220712014403.2977-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
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

During a 3 stage SETUP transfer, if the host sends another SETUP token
before completing the status phase, it signifies that the host has aborted
the current control transfer.  Currently, if a setup_packet_pending is
received, there are no subsequent calls to dwc3_ep0_out_start() to fetch
the new SETUP packet.  This leads to a stall on EP0, as host does not
expect another STATUS phase as it has aborted the current transfer.

Fix this issue by explicitly stalling and restarting EP0, as well as
resetting the trb_enqueue indexes.  (without this, there is a chance the
SETUP TRB is set up on trb_endqueue == 1)

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/ep0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 5851b0e9db0a..e64ad9ce6e30 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -239,6 +239,8 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 		dwc3_gadget_giveback(dep, req, -ECONNRESET);
 	}
 
+	dwc->eps[0]->trb_enqueue = 0;
+	dwc->eps[1]->trb_enqueue = 0;
 	dwc->ep0state = EP0_SETUP_PHASE;
 	dwc3_ep0_out_start(dwc);
 }
@@ -1141,6 +1143,11 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		if (dwc->ep0_next_event != DWC3_EP0_NRDY_STATUS)
 			return;
 
+		if (dwc->setup_packet_pending) {
+			dwc3_ep0_stall_and_restart(dwc);
+			return;
+		}
+
 		dwc->ep0state = EP0_STATUS_PHASE;
 
 		if (dwc->delayed_status) {
