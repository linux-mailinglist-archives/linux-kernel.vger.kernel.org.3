Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBFA594E23
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242705AbiHPBjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiHPBim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:38:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C37CEEF0F;
        Mon, 15 Aug 2022 14:31:59 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FKVpV9010972;
        Mon, 15 Aug 2022 21:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=S5QaPvrNLvBnPtkKA+lsmOspIvOgN7nDWdMPUhoUl6U=;
 b=aSYL/n09FKAEH1YKqxF1ZxVT5mJSYBmDmYoeHwegLdTjLBnhfyLfQTwpRKjdbtqZ1/O8
 wcIzN+Xy3eRjqDNcAmAOUtZghxT5SSEDZkfjn8Tq9gxcLa+cyerl+aMRmgDfZxLmbAXp
 DNuxO3dcRHnAjIGTG77JWlCcWC+7w1UNZEWU8nhQMdVrcWuwOt+rOnojxiR+Ix5fDmag
 c7TwurjKZ3/FG0xJ6JZpZQCryh1yUXYCvHoo4O32dupkTZ7xB4YBdPeUsnzPfcJ9GyZN
 6Q3u8MX4LIpsk1fN17nyBPKbHP0K3qpri8Xmm8NGlWUS5VE722XGMP1N/v0m9fLKRZVV CQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx58f6ecd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 21:31:55 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27FLVsKm021070
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 21:31:54 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 15 Aug 2022 14:31:54 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v3 7/8] usb: dwc3: gadget: Skip waiting for CMDACT cleared during endxfer
Date:   Mon, 15 Aug 2022 14:31:33 -0700
Message-ID: <20220815213134.23783-8-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: V7aHEBpskFYhmmdJfYUdmAIh8ATr5EiX
X-Proofpoint-GUID: V7aHEBpskFYhmmdJfYUdmAIh8ATr5EiX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=419 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

For endxfer commands that do not require an endpoint complete interrupt,
avoid having to wait for the command active bit to clear.  This allows for
EP0 events to continue to be handled, which allows for the controller to
complete it.  Otherwise, it is known that the endxfer command will fail if
there is a pending SETUP token that needs to be read.

Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b2668a83cc29..5e8d3f02f99c 100644
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
