Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1203A50F67B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347091AbiDZIvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345801AbiDZIjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:39:32 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AF8996A1;
        Tue, 26 Apr 2022 01:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650961881; x=1682497881;
  h=from:to:cc:subject:date:message-id;
  bh=ey2DEjx+AwyO6kemYE9A9R1iln2K570othjBxqTPYqY=;
  b=YMmPAOq6g3ITUqKsSgvvDdhuQfYVjeyHV9yzYYsnrQjMX2MbZaOZmsCV
   7fVJhUr+CK4cR0fppYGMSyQS4vks+438FIodfukQxCbE1wtoW8CHXS+P8
   U6GZUFgDnchYP7ERpEpG0rGwhpe5O69FBkhQW6KqDei6tk6LguPYSDYIj
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 Apr 2022 01:31:20 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Apr 2022 01:31:18 -0700
X-QCInternal: smtphost
Received: from hu-c-spathi-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.108.59])
  by ironmsg01-blr.qualcomm.com with ESMTP; 26 Apr 2022 14:00:59 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
        id 3A599DD9; Tue, 26 Apr 2022 14:00:58 +0530 (+0530)
From:   Srinivasarao Pathipati <quic_spathi@quicinc.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        riteshh@codeaurora.org, asutoshd@codeaurora.org, axboe@kernel.dk,
        avri.altman@wdc.com, kch@nvidia.com, CLoehle@hyperstone.com,
        swboyd@chromium.org, digetx@gmail.com, bigeasy@linutronix.de,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kamasali <quic_kamasali@quicinc.com>,
        Srinivasarao Pathipati <quic_spathi@quicinc.com>
Subject: [PATCH V1] mmc: core: Enable force hw reset
Date:   Tue, 26 Apr 2022 14:00:18 +0530
Message-Id: <1650961818-13452-1-git-send-email-quic_spathi@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaik Sajida Bhanu <sbhanu@codeaurora.org>

During error recovery set need hw reset to handle
ICE error where cqe reset is must.

Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Signed-off-by: kamasali <quic_kamasali@quicinc.com>
Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
---
 drivers/mmc/core/block.c      | 8 +++++---
 drivers/mmc/host/cqhci-core.c | 7 +++++--
 include/linux/mmc/host.h      | 1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b35e7a9..f63bf33 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1482,10 +1482,12 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq)
 	pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
 
 	err = mmc_cqe_recovery(host);
-	if (err)
+	if (err || host->need_hw_reset) {
 		mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
-	else
-		mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
+		if (host->need_hw_reset)
+			host->need_hw_reset = false;
+	}
+	mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
 
 	pr_debug("%s: CQE recovery done\n", mmc_hostname(host));
 }
diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b0d30c3..311b510 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -812,18 +812,21 @@ static void cqhci_finish_mrq(struct mmc_host *mmc, unsigned int tag)
 irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
 		      int data_error)
 {
-	u32 status;
+	u32 status, ice_err;
 	unsigned long tag = 0, comp_status;
 	struct cqhci_host *cq_host = mmc->cqe_private;
 
 	status = cqhci_readl(cq_host, CQHCI_IS);
 	cqhci_writel(cq_host, status, CQHCI_IS);
+	ice_err = status & (CQHCI_IS_GCE | CQHCI_IS_ICCE);
 
 	pr_debug("%s: cqhci: IRQ status: 0x%08x\n", mmc_hostname(mmc), status);
 
 	if ((status & (CQHCI_IS_RED | CQHCI_IS_GCE | CQHCI_IS_ICCE)) ||
-	    cmd_error || data_error)
+	    cmd_error || data_error || ice_err){
+		mmc->need_hw_reset = true;
 		cqhci_error_irq(mmc, status, cmd_error, data_error);
+	}
 
 	if (status & CQHCI_IS_TCC) {
 		/* read TCN and complete the request */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c193c50..3d00bcf 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -492,6 +492,7 @@ struct mmc_host {
 	int			cqe_qdepth;
 	bool			cqe_enabled;
 	bool			cqe_on;
+	bool                    need_hw_reset;
 
 	/* Inline encryption support */
 #ifdef CONFIG_MMC_CRYPTO
-- 
2.7.4

