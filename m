Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4B0597D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbiHREfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241247AbiHREfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:35:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5038571732;
        Wed, 17 Aug 2022 21:35:49 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I2LHVB011178;
        Thu, 18 Aug 2022 04:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=9AsAETYmjXpioDL5Mkf8SV+OKVdlnGyi93GX2Vb5N8M=;
 b=FwDhPPI6kIdJFEuUAyhmQhYnnQPjuQ6fzHX+Riyvg8KtacRGJv8Jaqf5Me0qKn9Dnafv
 s/SxHnamV4XKrpTXgo+p571EB6KyOwrzORI6WjrKSC7ADjeUP3cnwJTNPixUchEQM1uk
 3bF+jb5LYiVNj8vQqeVVrDxBUcHfg4dpsZFB43umUMvi984oDGDdNPh9WwCEndFb/uqy
 MiwaONHghRNP54DKFnmAR5UApgVR9k3XE0UbCn1BU0UKiR+Q8ELc/4/tOwCs9ji1z7R7
 2svsfQ6hqQngPeQcwDsiwYo82WHNK0Vor10CAMRrDT5FkJnEt6sIwpwrDuvn5Ere0hRR NQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j127japv0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:35:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27I4H2OV017942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:17:02 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 19:24:13 -0700
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 11:24:11 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v4 1/9] usb: dwc3: Do not service EP0 and conndone events if soft disconnected
Date:   Wed, 17 Aug 2022 11:23:51 -0700
Message-ID: <20220817182359.13550-2-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220817182359.13550-1-quic_wcheng@quicinc.com>
References: <20220817182359.13550-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kchdetNQV4pleQTMRLTbB--p94jLVTN6
X-Proofpoint-ORIG-GUID: kchdetNQV4pleQTMRLTbB--p94jLVTN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208180014
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
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
