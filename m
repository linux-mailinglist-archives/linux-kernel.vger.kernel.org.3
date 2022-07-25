Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE61580516
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbiGYUL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGYULz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:11:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1ED21261;
        Mon, 25 Jul 2022 13:11:54 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PDoV24011837;
        Mon, 25 Jul 2022 20:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=JRUjPEurBMiGerl4lNxBbOJ00uBxrV76UTHGFIC2iqE=;
 b=U+4FbFd5d7fCj49TIIHI4LF4LmcIEiNH8rn8zRHJ5pidDzjEA1uyuAfgNqgUVQcSOY18
 yDx1cSQ4b4sDJy4VXmkTzIN3ZDjw1oSUSvU5Su8i8/ieaRyUXcz/Y9SxMsoY/9bXAkxd
 y3rA/DcNY+9kh+IH67PafmYZDU6umzKHYB0T7upDXS0UnttKEDzIrYJyD3h4WMz4oqY1
 XY5nhi90oSWd388gwqmq2voCuhM32CSO0Dm2zWhM0lLDBUXTUUX2yaD/nqFx/n+v9ooQ
 EEUIQiaZS3q7sjKm4ViC+KIGZeuCCffGjkL6z1imToxOeogXXjf9dw3cSApBcfVzyrdf oA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hg7xyntdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 20:11:49 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26PKBmtt000509
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 20:11:49 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Jul 2022 13:11:48 -0700
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Jul 2022 13:11:47 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <quic_mrana@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH] usb: dwc3: gadget: Avoid duplicate requests to enable Run/Stop
Date:   Mon, 25 Jul 2022 13:11:36 -0700
Message-ID: <20220725201136.7989-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f1xwcrjx0dq8n-Nojnd00x63yqHG1why
X-Proofpoint-GUID: f1xwcrjx0dq8n-Nojnd00x63yqHG1why
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_12,2022-07-25_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=820 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207250083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocate the pullups_connected check until after it is ensured that there
are no runtime PM transitions.  If another context triggered the DWC3
core's runtime resume, it may have already enabled the Run/Stop.  Do not
re-run the entire pullup sequence again, as it may issue a core soft
reset while Run/Stop is already set.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index aeeec751c53c..67b1039c664c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2539,9 +2539,6 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	is_on = !!is_on;
 
-	if (dwc->pullups_connected == is_on)
-		return 0;
-
 	dwc->softconnect = is_on;
 
 	/*
@@ -2566,6 +2563,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		return 0;
 	}
 
+	if (dwc->pullups_connected == is_on)
+		return 0;
+
 	if (!is_on) {
 		ret = dwc3_gadget_soft_disconnect(dwc);
 	} else {
