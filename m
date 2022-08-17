Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852E3597CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242747AbiHRERM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiHRERI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:17:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333798034D;
        Wed, 17 Aug 2022 21:17:06 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I1iPbk011490;
        Thu, 18 Aug 2022 04:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=eqYpVJ6N4NBU7S7zi0Mp88Isgr0jnXWVH+SUvfxnzDY=;
 b=MUAZrB8+S192F92Vl3qL0TQufVl/RqEMbOd8HL7gKGIwSeXBMDl4xoH2jHPeMqzqKW87
 PEXXD0OfzsGG/jtLIkSStFnP5FQfe+nCuvtRhOTP32J6bwuwQhVNthTa2LHAEPoYhXOa
 3dAFDie1E1o0gRjMd69o49gNny7A1v5YdCLgnHvHud+S46jle9GVlI6w5wSv0dGdvx+n
 dkVN7u/P23ti8j1ORjgMaBHjuXlVJu7n0+cqpf85+ifBtQafvLtKZyCc/4VvWXdeI1Hz
 3wLbmgHT5Dhd6R+EJLsLriKlXEMtA49QIW38GgxKM6RLhJw+WN927N9DBPjPbwbKPDbp lQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j127jan8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:17:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27I4H2Nv009088
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:17:02 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 19:24:15 -0700
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 11:24:12 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v4 6/9] usb: dwc3: Remove DWC3 locking during gadget suspend/resume
Date:   Wed, 17 Aug 2022 11:23:56 -0700
Message-ID: <20220817182359.13550-7-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: hs-V4js2dn2GdEDHc72vVOj2fks7oCoN
X-Proofpoint-ORIG-GUID: hs-V4js2dn2GdEDHc72vVOj2fks7oCoN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=660
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

Remove the need for making dwc3_gadget_suspend() and dwc3_gadget_resume()
to be called in a spinlock, as dwc3_gadget_run_stop() could potentially
take some time to complete.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/core.c   | 4 ----
 drivers/usb/dwc3/gadget.c | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c5c238ab3083..23e123a1ab5f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1976,9 +1976,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
 			break;
-		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_suspend(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
 		synchronize_irq(dwc->irq_gadget);
 		dwc3_core_exit(dwc);
 		break;
@@ -2039,9 +2037,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			return ret;
 
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
-		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_resume(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
 		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 7b66a54250a0..57d83b3b4967 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4520,12 +4520,17 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
+	unsigned long flags;
+
 	if (!dwc->gadget_driver)
 		return 0;
 
 	dwc3_gadget_run_stop(dwc, false, false);
+
+	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
 }
