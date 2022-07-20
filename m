Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0D357B44C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiGTKL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiGTKL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:11:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434AF545E8;
        Wed, 20 Jul 2022 03:11:27 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K9ZqdV001592;
        Wed, 20 Jul 2022 10:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=inuNwO9IAY/YiQFJpWcW6TKvVQbP3ppg5xl2X/Ep4L0=;
 b=j1shwSoGZEIUPnG7y8RA5bBtboeup4zu2s1a0av3uZ7gO6Yc4ZnY2n2kfsC+QkL23A/d
 CK1F1FbTapqWWHx9S8JIQUTvS3DMULnZv2cxUTYrLNxPM/ZUIjTEW/Mm5PEXAg67AUv1
 38Bd93y9KXnBb5JnFmG2R+4gEd2psd3ooxtTx7seh1POECDH1ljdE10sJtPdf5ecuy7T
 Tap0Rgc+vF6IGRIaRTbthA/4qq6jGKQcWS4AT3u5M1yTVZ1PhehYV7rkB7FExuYw985A
 2CXJnDkrGjy7o3R4MWjKNBzkYJ8VdF/YQvMgZI+3Nnj3E2/XtVattLS5nW8XgKw6uJJG gQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hef6sr4rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 10:11:12 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26KA6Brq005422
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 10:06:11 GMT
Received: from cbsp-sh-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 03:06:09 -0700
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     <mani@kernel.org>, <quic_hemantk@quicinc.com>,
        <loic.poulain@linaro.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v1 1/1] bus: mhi: host: Fix up null pointer access in mhi_irq_handler
Date:   Wed, 20 Jul 2022 18:04:14 +0800
Message-ID: <1658311454-4707-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MaXNWA5xlqv5daTUFl-XB6iVKZMYOumi
X-Proofpoint-GUID: MaXNWA5xlqv5daTUFl-XB6iVKZMYOumi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_05,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1011
 adultscore=0 impostorscore=0 mlxlogscore=939 suspectscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200042
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/bus/mhi/host/main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index f3aef77a..7959457 100644
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
+		dev_err(&mhi_cntrl->mhi_dev->dev,
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

