Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E065A85CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiHaShc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiHaShB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:37:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6752F47EB;
        Wed, 31 Aug 2022 11:33:10 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VGmvo1023034;
        Wed, 31 Aug 2022 18:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=eUyzNrUe7h8wrZuH7Gy5duX/6zvORw6oWfUVvm+hwKw=;
 b=jhkyU3rvE0gJ3+EH1Ca04eyfqr2Rd2VjXFLIXOTGUNIGaNM4OLCm1daBPHcdGphWznM2
 GFZD/keWeBfgcb9UDQUAAIRknl/z1kLNA3s0wleo2aeyEJLcgfrB3b5tgQphIXKAhVSh
 MMIEs1aY3TOfvqMSqYb3P71dEU7FKYRZqdbsBphv1CS82pPWkLO1MLRrETPHvRuudEWE
 wCwYPK/8HPMGmVw64u8KuNSWb5hw/SBb3/ZAmRzQavG0RnR7I0HRUVvgbpwqOYU6Emyn
 rXVN0V8BGfUuxx5BsCQWvFbqy+NLOotZft1h7ZLJCv13v9ataJ7vftHYTpKU7n4OmITm LQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jabgcrev6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 18:33:00 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27VIWxEV001727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 18:33:00 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 31 Aug 2022 11:32:59 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v5 4/5] usb: dwc3: gadget: Skip waiting for CMDACT cleared during endxfer
Date:   Wed, 31 Aug 2022 11:32:41 -0700
Message-ID: <20220831183242.27826-5-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220831183242.27826-1-quic_wcheng@quicinc.com>
References: <20220831183242.27826-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XHzRTnJEOh68sH2Qhl2ZEyouAz3p57hp
X-Proofpoint-GUID: XHzRTnJEOh68sH2Qhl2ZEyouAz3p57hp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_11,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=458 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For endxfer commands that do not require an endpoint complete interrupt,
avoid having to wait for the command active bit to clear.  This allows for
EP0 events to continue to be handled, which allows for the controller to
complete it.  Otherwise, it is known that the endxfer command will fail if
there is a pending SETUP token that needs to be read.

Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c9310645701d..4721561e4ba5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -366,7 +366,9 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 
 	dwc3_writel(dep->regs, DWC3_DEPCMD, cmd);
 
-	if (!(cmd & DWC3_DEPCMD_CMDACT)) {
+	if (!(cmd & DWC3_DEPCMD_CMDACT) ||
+		(DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER &&
+		!(cmd & DWC3_DEPCMD_CMDIOC))) {
 		ret = 0;
 		goto skip_status;
 	}
