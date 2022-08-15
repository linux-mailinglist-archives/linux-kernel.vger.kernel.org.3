Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF218594E40
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiHPBjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiHPBil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:38:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F95EEF08;
        Mon, 15 Aug 2022 14:31:58 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FKmGtw028291;
        Mon, 15 Aug 2022 21:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=bPl1ixCE3L9W0j/Y/JC8KtD4/nvB3ebPmz0uiK4zZrI=;
 b=PnZ+d44EGSn1MRYrqyZ9ewrojfQ4antoVbiBNDuH33tZG29E7gKTZhfd5bj41EpxJXO4
 yczB7AcaSiLsLgh3aEFUCnby6wNQjM3Zi+4UHYrkG8YNqDY8WBWs8hYz5YkGmTgIz9HI
 HD9fmFcFTHRBPV8rxOM9JSwM4XtsAMTigL7ckoOK2byO68a+XzfJ2wDOHX4NKGELDMGU
 6J/vxSh9tAOavZpNuGed0G/aefhoUQldVYFXAiSgiUNUwwwU2GeR50w+EyQ/FKk4x1vq
 AZLtKi/lZbwm4kabjzIhwK5aPwXUA4eU7oTFxL17RKMBL3EFOsjVOJw8d5hw08CjsseH iA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx467ekhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 21:31:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27FLVrx7014768
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
Subject: [PATCH v3 3/8] usb: dwc3: gadget: Synchronize IRQ between soft connect/disconnect
Date:   Mon, 15 Aug 2022 14:31:29 -0700
Message-ID: <20220815213134.23783-4-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 9rJL7U0CYAP_E87SO9vMRnU01kGWH44v
X-Proofpoint-GUID: 9rJL7U0CYAP_E87SO9vMRnU01kGWH44v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=679
 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208150082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that there are no pending events being handled in between soft
connect/disconnect transitions.  As we are keeping interrupts enabled,
and EP0 events are still being serviced, this avoids any stale events from
being serviced.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 391e40c35747..3b83e3c4b932 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2569,6 +2569,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		return 0;
 	}
 
+	synchronize_irq(dwc->irq_gadget);
+
 	if (!is_on) {
 		ret = dwc3_gadget_soft_disconnect(dwc);
 	} else {
