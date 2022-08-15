Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569EB594E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242974AbiHPBjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiHPBio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:38:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3723BEEF13;
        Mon, 15 Aug 2022 14:31:59 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FL2XV7021614;
        Mon, 15 Aug 2022 21:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=N/oewzN8fFPqyjguolIEbeLa7qRllQSiTpU1m+vIORM=;
 b=IxF9wEInw3oJkg2V/MfuOxotqq/LyD2Ey7Bg19CWH8UJlckO+EMtMjq6hZJcRyHMwltN
 rYxA5RqSekIrMmcnmlboG6r8moFPcQx0ljEKwbBzh/x2TgaPJGTGlFJrkdbtARcad3pO
 SVg/IBjzjUo4qyprbeDNjeSQ2AQNQry6lp+rE4+awvMhH3QD6AS/OHQbnyF1FisTtD9H
 JbYK+dwRE+ZJFyxasL57S7MypLzJ7V3ZJzfxp1j3ygH1T5NPT13Zwro4jihOSr8mKgvM
 yttui+SAJAJOsmEF0WSryYPsTx1N/VtZEkOl3a4rJa8mLNtJ/hR4rNnlXWynz3H7E42g XA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx3j6egm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 21:31:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27FLVrLR004389
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 21:31:53 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 15 Aug 2022 14:31:53 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v3 2/8] usb: dwc3: gadget: Force sending delayed status during soft disconnect
Date:   Mon, 15 Aug 2022 14:31:28 -0700
Message-ID: <20220815213134.23783-3-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: EvhDVu3lWX59ZJpr_XUOIDD1PdlPorMf
X-Proofpoint-ORIG-GUID: EvhDVu3lWX59ZJpr_XUOIDD1PdlPorMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=631 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If any function drivers request for a delayed status phase, this leads to a
SETUP transfer timeout error, since the function may take longer to process
the DATA stage.  This eventually results in end transfer timeouts, as there
is a pending SETUP transaction.

In addition, allow the DWC3_EP_DELAY_STOP to be set for if there is a
delayed status requested.  Ocasionally, a host may abort the current SETUP
transaction, by issuing a subsequent SETUP token.  In those situations, it
would result in an endxfer timeout as well.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2818e3317064..391e40c35747 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2501,6 +2501,9 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	if (dwc->ep0state != EP0_SETUP_PHASE) {
 		int ret;
 
+		if (dwc->delayed_status)
+			dwc3_ep0_send_delayed_status(dwc);
+
 		reinit_completion(&dwc->ep0_in_setup);
 
 		spin_unlock_irqrestore(&dwc->lock, flags);
@@ -3693,7 +3696,7 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	 * timeout. Delay issuing the End Transfer command until the Setup TRB is
 	 * prepared.
 	 */
-	if (dwc->ep0state != EP0_SETUP_PHASE && !dwc->delayed_status) {
+	if (dwc->ep0state != EP0_SETUP_PHASE) {
 		dep->flags |= DWC3_EP_DELAY_STOP;
 		return;
 	}
