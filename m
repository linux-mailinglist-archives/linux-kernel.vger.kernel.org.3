Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09494FFB8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbiDMQod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiDMQob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:44:31 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197456542C;
        Wed, 13 Apr 2022 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649868130; x=1681404130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gOJsbaOCa8KxicoNnh0loPS6xmr5k28s00irC47bW6o=;
  b=mL1snkSGZGOlXPPJwCXhc2JRSfN0jv8g0B1gfN87giKNCdB7GDgAaeKu
   jfr19BSSyr+3yQJqI4I97gN8OzSgM2RhEa1gmw/D+f8eA+hr76zcvmqA5
   /cq4zfCGFmK8laGm+l74Y6Oq6vCICLofO5Cr171clfCHZFeIICJbgSwGW
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Apr 2022 09:42:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:42:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 09:42:09 -0700
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 09:42:08 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <mani@kernel.org>, <quic_hemantk@quicinc.com>,
        <quic_bbhatt@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH v3] bus: mhi: host: Use cached values for calculating the shared write pointer
Date:   Wed, 13 Apr 2022 10:41:53 -0600
Message-ID: <1649868113-18826-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mhi_recycle_ev_ring() computes the shared write pointer for the ring
(ctxt_wp) using a read/modify/write pattern where the ctxt_wp value in the
shared memory is read, incremented, and written back.  There are no checks
on the read value, it is assumed that it is kept in sync with the locally
cached value.  Per the MHI spec, this is correct.  The device should only
read ctxt_wp, never write it.

However, there are devices in the wild that violate the spec, and can
update the ctxt_wp in a specific scenario.  This can cause corruption, and
violate the above assumption that the ctxt_wp is in sync with the cached
value.

This can occur when the device has loaded firmware from the host, and is
transitioning from the SBL EE to the AMSS EE.  As part of shutting down
SBL, the SBL flushes it's local MHI context to the shared memory since
the local context will not persist across an EE change.  In the case of
the event ring, SBL will flush its entire context, not just the parts that
it is allowed to update.  This means SBL will write to ctxt_wp, and
possibly corrupt it.

An example:

Host				Device
----				---
Update ctxt_wp to 0x1f0
				SBL observes 0x1f0
Update ctxt_wp to 0x0
				Starts transition to AMSS EE
				Context flush, writes 0x1f0 to ctxt_wp
Update ctxt_wp to 0x200
Update ctxt_wp to 0x210
				AMSS observes 0x210
				0x210 exceeds ring size
				AMSS signals syserr

The reason the ctxt_wp goes off the end of the ring is that the rollover
check is only performed on the cached wp, which is out of sync with
ctxt_wp.

Since the host is the authority of the value of ctxt_wp per the MHI spec,
we can fix this issue by not reading ctxt_wp from the shared memory, and
instead compute it based on the cached value.  If SBL corrupts ctxt_wp,
the host won't observe it, and will correct the value at some point later.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---

v3:
Rebase to -next

v2:
Fix typo on the ring base

 drivers/bus/mhi/host/main.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 142eea1..f3aef77a 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -534,18 +534,13 @@ irqreturn_t mhi_intvec_handler(int irq_number, void *dev)
 static void mhi_recycle_ev_ring_element(struct mhi_controller *mhi_cntrl,
 					struct mhi_ring *ring)
 {
-	dma_addr_t ctxt_wp;
-
 	/* Update the WP */
 	ring->wp += ring->el_size;
-	ctxt_wp = le64_to_cpu(*ring->ctxt_wp) + ring->el_size;
 
-	if (ring->wp >= (ring->base + ring->len)) {
+	if (ring->wp >= (ring->base + ring->len))
 		ring->wp = ring->base;
-		ctxt_wp = ring->iommu_base;
-	}
 
-	*ring->ctxt_wp = cpu_to_le64(ctxt_wp);
+	*ring->ctxt_wp = cpu_to_le64(ring->iommu_base + (ring->wp - ring->base));
 
 	/* Update the RP */
 	ring->rp += ring->el_size;
-- 
2.7.4

