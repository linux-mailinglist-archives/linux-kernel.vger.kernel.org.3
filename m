Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C22594E28
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiHPBj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiHPBim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:38:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4011EE4BC;
        Mon, 15 Aug 2022 14:31:57 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FLSg9C009589;
        Mon, 15 Aug 2022 21:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=IfLBQRIyDRcOznHBEvg0dD9pPG7KWb7hB+bhOy1gJYk=;
 b=DnLYUc8LJ0Te5gTgj+xYhzOfPLXrazC6cgsF3Pkr7chYcRWBZqAt9AuD5FSXH4NTyPXd
 csWs498BbbpeiypIra6lUROfJYL6J7/eWBi3/VgT9F1pvAlRsEhAkRNNFSPuoK7VZ6nm
 35gfJQP3BdpyD8yjXm6C6J35YPcepyNPjNlniaEOJxrjF2p4GEx1qZk5qKdi40mbomP1
 jfmXdgcQcIFTaa6kuL0zBGp+IFHsGhpgqIcmIAlpQXwkEDjRz1JVywT2VsdnzJGU5McG
 5JPo5e2aSzg5egZRHeyipPBCcyCFNZVJaQYlF3l4JViKYgnjHKF1XELjY1aGVIRk0fLe xA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx4qpxg9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 21:31:53 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27FLVrnq021064
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 21:31:53 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 15 Aug 2022 14:31:52 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v3 1/8] usb: dwc3: Do not service EP0 and conndone events if soft disconnected
Date:   Mon, 15 Aug 2022 14:31:27 -0700
Message-ID: <20220815213134.23783-2-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220815213134.23783-1-quic_wcheng@quicinc.com>
References: <20220815213134.23783-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Hg18ksVhzcPLlm7ZK6nhilapoiyDRLsp
X-Proofpoint-GUID: Hg18ksVhzcPLlm7ZK6nhilapoiyDRLsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0
 mlxlogscore=925 priorityscore=1501 malwarescore=0 impostorscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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
index 197af63f8d05..33cee0089609 100644
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
@@ -815,7 +815,7 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 	int ret = -EINVAL;
 	u32 len;
 
-	if (!dwc->gadget_driver || !dwc->connected)
+	if (!dwc->gadget_driver || !dwc->softconnect || !dwc->connected)
 		goto out;
 
 	trace_dwc3_ctrl_req(ctrl);
@@ -1118,6 +1118,8 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 {
 	switch (event->status) {
 	case DEPEVT_STATUS_CONTROL_DATA:
+		if (!dwc->softconnect || !dwc->connected)
+			return;
 		/*
 		 * We already have a DATA transfer in the controller's cache,
 		 * if we receive a XferNotReady(DATA) we will ignore it, unless
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index aeeec751c53c..2818e3317064 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3865,6 +3865,9 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	u8			lanes = 1;
 	u8			speed;
 
+	if (!dwc->softconnect)
+		return;
+
 	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 	speed = reg & DWC3_DSTS_CONNECTSPD;
 	dwc->speed = speed;
