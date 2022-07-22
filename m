Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5BA57D8F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 05:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiGVDRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 23:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiGVDRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 23:17:35 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5A987F70;
        Thu, 21 Jul 2022 20:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658459854; x=1689995854;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=gEDWsiz11GhB4pUHw7t4kAgF8/TF7yajo/DSLMNkb3Y=;
  b=Kh1wqlnBescfCivTjqIgDmSRvPi7HDS2XotxTmAfpMzRYwGEqRR2V3JY
   BnagGAOjPF7AWubTNOMQbxPxh/TcbO1ThJX6bjJDlxmx+UWYUJsLF3Ybk
   Ffk7u9Epd2qFXDrZiP+UEPwhDalGkBjvBkaOWhpjvyws4C3IIxqVl4yyg
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Jul 2022 20:17:33 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 20:17:33 -0700
Received: from cbsp-sh-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Jul 2022 20:17:31 -0700
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     <mani@kernel.org>, <quic_hemantk@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_jhugo@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v3 1/1] bus: mhi: host: Fix up null pointer access in mhi_irq_handler
Date:   Fri, 22 Jul 2022 11:17:18 +0800
Message-ID: <1658459838-30802-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
v2->v3: add comments
v1->v2: change dev_err to dev_dbg

 drivers/bus/mhi/host/main.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index f3aef77a..df0fbfe 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -430,12 +430,25 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
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
 
+	/*
+	 * If CONFIG_DEBUG_SHIRQ is set, the IRQ handler will get invoked during __free_irq()
+	 * and by that time mhi_ctxt() would've freed. So check for the existence of mhi_ctxt
+	 * before handling the IRQs.
+	 */
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

