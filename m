Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC265AA026
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiIATgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiIATgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:36:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640E874DE4;
        Thu,  1 Sep 2022 12:36:41 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281JHWEd018923;
        Thu, 1 Sep 2022 19:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=7Ayr88upFoAxOPJlgVTA7aDSTmbLOGrnVb+89Sm6Lj4=;
 b=c+vGDo0UmSPlL5JH9VNASYsPvcK8RZlRHZWBOqF6yOAsxs1M/dlESGpyIQP0B5kmxF9J
 novVfHhaDYpYTN6pzuseAM20DII3XQWt/YmCjlWuWuBnG/odI6lXYTVUXX+1ITVrIc+I
 nvlwIFDiDHv74MHfTBYTG1UDGxGFTuCVUzXmqu9z/HPQq/ScV6qIUrb/TBCI2gSu8K7P
 Envgw1te3syJqABLOXKpuySXDvNrxxjEORGBdohILVFbV5qIdle614gUPXhTC+HpxMDW
 dbBIFPM3kkd28lb2FvzKnLqsm8GXD06OtZgErYZNgfL2qiQpt8E7wK5xWJ2E4gjBMCq/ bg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jabgcvucw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 19:36:37 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 281JabMb025583
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 19:36:37 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 1 Sep 2022 12:36:36 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v8 1/5] usb: dwc3: Avoid unmapping USB requests if endxfer is not complete
Date:   Thu, 1 Sep 2022 12:36:21 -0700
Message-ID: <20220901193625.8727-2-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220901193625.8727-1-quic_wcheng@quicinc.com>
References: <20220901193625.8727-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Kte_YrRP_VVelE_EUwdJWrVwaF2xAhdY
X-Proofpoint-GUID: Kte_YrRP_VVelE_EUwdJWrVwaF2xAhdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=849 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/usb/dwc3/core.h   | 1 +
 drivers/usb/dwc3/ep0.c    | 5 ++++-
 drivers/usb/dwc3/gadget.c | 6 +++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4fe4287dc934..7c9368145f37 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1560,6 +1560,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 		u32 param);
 void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 33cee0089609..61de693461da 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -293,7 +293,10 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 			continue;
 
 		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
-		dwc3_stop_active_transfer(dwc3_ep, true, true);
+		if (dwc->connected)
+			dwc3_stop_active_transfer(dwc3_ep, true, true);
+		else
+			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
 	}
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d6c0cb79ace3..6f2491fc109e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -965,12 +965,16 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	return 0;
 }
 
-static void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
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
