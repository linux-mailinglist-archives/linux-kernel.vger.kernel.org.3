Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9CB57C228
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 04:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiGUCQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 22:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGUCQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:16:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E355A6BC0F;
        Wed, 20 Jul 2022 19:16:23 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26L1ROW0004847;
        Thu, 21 Jul 2022 02:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=M2M6I18ySNIp/h+Xnf4yxDrn7dqGutjGEaAxUEh70IA=;
 b=beuqUz3Nt82I3GVAflSX8ZcRUU6rIOlvaAVLUORkI7eAl4qicvBep2xrNgJE0JM+8MIN
 TJ6z5LgePeCUon7y8DbUZHg/TnHlRn47GmS6Bf9o3JYs76nXmDmMDNFegH2iC/nh3Guw
 yF0LkORlD6dNOPl+vYzvUTbL0OOS6L+9RDgdgxEgO20XTCe1VR2BzQXsCaQ4zY28wHWZ
 BXWXhUEfq/sbqI20TUeoocpRSQiLCV7cfrJuE6EUzehH1RuSk8aD4Ya5Jo26vPDuILK3
 yHbOqEwRtstLOYPNMdVhHJLrzAjoVy+aa81GOlsasnUB1Fc6JpfDVhtpodThSSyzJoL4 yw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3heb3x2q3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 02:16:13 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26L2GC6W028633
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 02:16:12 GMT
Received: from cbsp-sh-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 19:16:10 -0700
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     <mani@kernel.org>, <quic_hemantk@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_jhugo@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v2 1/1] bus: mhi: host: Fix up null pointer access in mhi_irq_handler
Date:   Thu, 21 Jul 2022 10:15:54 +0800
Message-ID: <1658369754-87005-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WEODm89xukhm_cKTR4Rwb_ojT38sPDa_
X-Proofpoint-ORIG-GUID: WEODm89xukhm_cKTR4Rwb_ojT38sPDa_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=954 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq handler for a shared IRQ ought to be prepared for running
even now it's being freed. So let's check the pointer used by
mhi_irq_handler to avoid null pointer access since it is probably
released before freeing IRQ.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
v1->v2: change dev_err to dev_dbg

 drivers/bus/mhi/host/main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index f3aef77a..25ea1f8 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -430,12 +430,20 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
 {
 	struct mhi_event *mhi_event = dev;
 	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
-	struct mhi_event_ctxt *er_ctxt =
-		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	struct mhi_event_ctxt *er_ctxt;
 	struct mhi_ring *ev_ring = &mhi_event->ring;
-	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
+	dma_addr_t ptr;
 	void *dev_rp;
 
+	if (!mhi_cntrl->mhi_ctxt) {
+		dev_dbg(&mhi_cntrl->mhi_dev->dev,
+			"mhi_ctxt has been freed\n");
+		return IRQ_HANDLED;
+	}
+
+	er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	ptr = le64_to_cpu(er_ctxt->rp);
+
 	if (!is_valid_ring_ptr(ev_ring, ptr)) {
 		dev_err(&mhi_cntrl->mhi_dev->dev,
 			"Event ring rp points outside of the event ring\n");
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

