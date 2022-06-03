Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F0753C418
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbiFCFQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240238AbiFCFQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:16:01 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F5E1DA7A;
        Thu,  2 Jun 2022 22:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654233360; x=1685769360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=PhL0Jx26bW8fPzRbWM63sB+vZMdeYCJTu8TFvCSjIsU=;
  b=lWoACLs2YAJEGWcPqGC+5A5HTNKnJ3ui0E+ijfRWaTF5kJqXWHb6kBse
   60RphcKqjaoaAWnnKmFp3B3SDxzShfCvk5/FVIEPZEQwIQGO4wcLnjwAu
   oNtIVxMjEjd1BCCG/V4hx7s7KyrJyzA1XiaBt916Lw5WSHOTl2SbzPweZ
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 Jun 2022 22:16:00 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 Jun 2022 22:15:59 -0700
X-QCInternal: smtphost
Received: from hu-sartgarg-hyd.qualcomm.com (HELO hu-maiyas-hyd.qualcomm.com) ([10.213.105.147])
  by ironmsg01-blr.qualcomm.com with ESMTP; 03 Jun 2022 10:45:50 +0530
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id 7A40A5001CD; Fri,  3 Jun 2022 10:45:49 +0530 (+0530)
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_kamasali@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, Sarthak Garg <quic_sartgarg@quicinc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Avri Altman <Avri.Altman@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        =?UTF-8?q?Christian=20L=C3=B6hle?= <CLoehle@hyperstone.com>,
        Bean Huo <beanhuo@micron.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH V1 1/2] mmc: core: Introduce new flag to force hardware reset
Date:   Fri,  3 Jun 2022 10:45:32 +0530
Message-Id: <20220603051534.22672-2-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603051534.22672-1-quic_sartgarg@quicinc.com>
References: <20220603051534.22672-1-quic_sartgarg@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new flag cqe_recovery_reset_always to allow vendors to force
hardware reset during cqe recovery.

Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
---
 drivers/mmc/core/block.c | 2 +-
 include/linux/mmc/host.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1259ca22d625..496cdd8a2999 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1497,7 +1497,7 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq)
 	pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
 
 	err = mmc_cqe_recovery(host);
-	if (err)
+	if (err || host->cqe_recovery_reset_always)
 		mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
 	else
 		mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c193c50ccd78..3e2fe950b4ec 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -492,6 +492,7 @@ struct mmc_host {
 	int			cqe_qdepth;
 	bool			cqe_enabled;
 	bool			cqe_on;
+	bool			cqe_recovery_reset_always;
 
 	/* Inline encryption support */
 #ifdef CONFIG_MMC_CRYPTO
-- 
2.17.1

