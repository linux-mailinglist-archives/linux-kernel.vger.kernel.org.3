Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7AC531E15
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiEWVkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiEWVkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:40:45 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A461605;
        Mon, 23 May 2022 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653342042; x=1684878042;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=O0X78NDShcEC3E1BhKeb5ph3+0rFHeFiCWCbSngXDXI=;
  b=bEMAE9hgYXOqfeu5ON0ToEb06dZPuKP/Vahh8nbCzgt2lLNCFSK93+Ps
   t8TZ29a5ORJphuvAZl5MaDrPUSv74pS4J2eDRopiBKpPUbkxDafKmco+p
   Kz3thze+F4iFkEwsOu6O+CTIO5aX2UOgGn8sdeS5J4VFjDji9GhrKMEyt
   U=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 23 May 2022 14:40:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 14:40:41 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 14:40:01 -0700
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 14:40:00 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <quic_jackp@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH] usb: dwc3: gadget: Fix IN endpoint max packet size allocation
Date:   Mon, 23 May 2022 14:39:48 -0700
Message-ID: <20220523213948.22142-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
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

The current logic to assign the max packet limit for IN endpoints attempts
to take the default HW value and apply the optimal endpoint settings based
on it.  However, if the default value reports a TxFIFO size large enough
for only one max packet, it will divide the value and assign a smaller ep
max packet limit.

For example, if the default TxFIFO size fits 1024B, current logic will
assign 1024/3 = 341B to ep max packet size.  If function drivers attempt to
request for an endpoint with a wMaxPacketSize of 1024B (SS BULK max packet
size) then it will fail, as the gadget is unable to find an endpoint which
can fit the requested size.

Functionally, if the TxFIFO has enough space to fit one max packet, it will
be sufficient, at least when initializing the endpoints.

Fixes: d94ea5319813 ("usb: dwc3: gadget: Properly set maxpacket limit")
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4f54f0ef21df..c201df4743b9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2974,6 +2974,7 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 	struct dwc3 *dwc = dep->dwc;
 	u32 mdwidth;
 	int size;
+	int maxpacket;
 
 	mdwidth = dwc3_mdwidth(dwc);
 
@@ -2986,21 +2987,24 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 	else
 		size = DWC31_GTXFIFOSIZ_TXFDEP(size);
 
-	/* FIFO Depth is in MDWDITH bytes. Multiply */
-	size *= mdwidth;
-
 	/*
-	 * To meet performance requirement, a minimum TxFIFO size of 3x
-	 * MaxPacketSize is recommended for endpoints that support burst and a
-	 * minimum TxFIFO size of 2x MaxPacketSize for endpoints that don't
-	 * support burst. Use those numbers and we can calculate the max packet
-	 * limit as below.
+	 * maxpacket size is determined as part of the following, after assuming
+	 * a mult value of one maxpacket:
+	 * DWC3 revision 280A and prior:
+	 * fifo_size = mult * (max_packet / mdwidth) + 1;
+	 * maxpacket = mdwidth * (fifo_size - 1);
+	 *
+	 * DWC3 revision 290A and onwards:
+	 * fifo_size = mult * ((max_packet + mdwidth)/mdwidth + 1) + 1
+	 * maxpacket = mdwidth * ((fifo_size - 1) - 1) - mdwidth;
 	 */
-	if (dwc->maximum_speed >= USB_SPEED_SUPER)
-		size /= 3;
+	if (DWC3_VER_IS_PRIOR(DWC3, 290A))
+		maxpacket = mdwidth * (size - 1);
 	else
-		size /= 2;
+		maxpacket = mdwidth * ((size - 1) - 1) - mdwidth;
 
+	/* Functionally, space for one max packet is sufficient */
+	size = min_t(int, maxpacket, 1024);
 	usb_ep_set_maxpacket_limit(&dep->endpoint, size);
 
 	dep->endpoint.max_streams = 16;
