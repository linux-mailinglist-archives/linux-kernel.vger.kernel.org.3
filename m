Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6EB597CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243023AbiHRER0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242958AbiHRERO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:17:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E248F967;
        Wed, 17 Aug 2022 21:17:12 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I2wAvt014008;
        Thu, 18 Aug 2022 04:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=DRWikNkPlVsisUcguWxzgNwA/BUR1iL4zGO99SgeeJs=;
 b=IhpZuHgipESK0EFTRNhEkjYSX9qEkbQp7LLD91Rak7wftE83ni5jSXO4rjWX88AeWd2y
 s+/oNKHSlcoGYUROrW939po2aGOTuSPj/F+VY5BTdpel8Szlh8OlGbFfFcmJWWqYeMhN
 1XBV5fIAntIAfMHPty5r+mOXEGeVpmFKb3c0Ael/oI4f4HNNsWKpUoE7Hv18Yu5nbX0K
 dUGAkx7Yj7sRWUJ9K3uXWmjwCcCThwG0mRvtSn/07gbZeakfPoyfFAJFyl2Bk7dQcjws
 zYNAy0gqh1B9xcfBIZcaSRCJpHkrb62xuD+nSz8xpi9YqW/HdUufML/oBai7PI0oo7+G NA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j13v1j9rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:17:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27I4GxVP017882
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:17:01 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 19:24:08 -0700
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 11:24:12 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v4 5/9] usb: dwc3: Avoid unmapping USB requests if endxfer is not complete
Date:   Wed, 17 Aug 2022 11:23:55 -0700
Message-ID: <20220817182359.13550-6-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: sU1i_6AOQjsn7nP2wrL9pUzy2YyRzZUw
X-Proofpoint-ORIG-GUID: sU1i_6AOQjsn7nP2wrL9pUzy2YyRzZUw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 mlxlogscore=889 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DWC3_EP_DELAYED_STOP is set during stop active transfers, then do not
continue attempting to unmap request buffers during dwc3_remove_requests().
This can lead to SMMU faults, as the controller has not stopped the
processing of the TRB.  Defer this sequence to the EP0 out start, which
ensures that there are no pending SETUP transactions before issuing the
endxfer.

Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/core.h   | 3 +++
 drivers/usb/dwc3/ep0.c    | 5 ++++-
 drivers/usb/dwc3/gadget.c | 6 +++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4fe4287dc934..7327e5767df9 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1560,6 +1560,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 		u32 param);
 void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
@@ -1581,6 +1582,8 @@ static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
 { return 0; }
 static inline void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
 { }
+static inline void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)
+{ }
 #endif
 
 #if IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 33cee0089609..fbb154a5ee1f 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -293,7 +293,10 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 			continue;
 
 		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
-		dwc3_stop_active_transfer(dwc3_ep, true, true);
+		if (dwc->connected)
+			dwc3_stop_active_transfer(dwc3_ep, true, true);
+		else
+			dwc3_remove_requests(dwc, dwc3_ep);
 	}
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index aff288b7baeb..7b66a54250a0 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -965,12 +965,16 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	return 0;
 }
 
-static void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
 	struct dwc3_request		*req;
 
 	dwc3_stop_active_transfer(dep, true, false);
 
+	/* If endxfer is delayed, avoid unmapping requests */
+	if (dep->flags & DWC3_EP_DELAY_STOP)
+		return;
+
 	/* - giveback all requests to gadget driver */
 	while (!list_empty(&dep->started_list)) {
 		req = next_request(&dep->started_list);
