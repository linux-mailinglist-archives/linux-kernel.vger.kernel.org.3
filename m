Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083A25A9F52
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiIASod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiIASnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:43:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC65B564EA;
        Thu,  1 Sep 2022 11:43:39 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281G5F4m013101;
        Thu, 1 Sep 2022 18:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=DLf1K/HcpOUvHnFmWoIjVBH+QrBr/nv3FmUwEoUfmcs=;
 b=FeMI4hx0wniwyXRWyGVWQVjBG2a3sRqxu8WlT5bIP11uc7SYsH0mSzdr05UYhI2c3YFK
 PccqMz9dGRJ/da1PTmKqFJxRyeFVcVREP9ZqAgQW9l+jzJEzYqU15dApuRopElrqAcVb
 2/rN/Y+qs5IcGLGCG7LekbtuNsqzEl3raZxIcP1/EhRRzg+suDmQ4RZaDoVL/NhPEpNP
 lIRwi1/vVlfx9Iklx87e608E/24IDEb8Uce5WscIduPCBI3l5zrBtVLRwMI4b62ZGcaG
 9l4hhm3sGiYQEHPk7xq08F51x72CbsyxPa+J2+Z3mBC9o38urIBwe75mIUy+PMdZP7tf fQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jaeb4uva0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 18:43:27 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 281IhRnA019935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 18:43:27 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 1 Sep 2022 11:43:26 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v6 3/5] usb: dwc3: Increase DWC3 controller halt timeout
Date:   Thu, 1 Sep 2022 11:43:12 -0700
Message-ID: <20220901184314.30481-4-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220901184314.30481-1-quic_wcheng@quicinc.com>
References: <20220901184314.30481-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F_dOmDDhb9pXOlQd1UDfBvMUzVUP_7dl
X-Proofpoint-ORIG-GUID: F_dOmDDhb9pXOlQd1UDfBvMUzVUP_7dl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=589
 impostorscore=0 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since EP0 transactions need to be completed before the controller halt
sequence is finished, this may take some time depending on the host and the
enabled functions.  Increase the controller halt timeout, so that we give
the controller sufficient time to handle EP0 transfers.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 08281c4f47e6..c9310645701d 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2444,7 +2444,7 @@ static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
 static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 {
 	u32			reg;
-	u32			timeout = 500;
+	u32			timeout = 2000;
 
 	if (pm_runtime_suspended(dwc->dev))
 		return 0;
@@ -2477,6 +2477,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	do {
+		usleep_range(1000, 2000);
 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 		reg &= DWC3_DSTS_DEVCTRLHLT;
 	} while (--timeout && !(!is_on ^ !reg));
