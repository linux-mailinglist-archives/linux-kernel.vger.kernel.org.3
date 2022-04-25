Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BFB50E511
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243205AbiDYQEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243168AbiDYQEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:04:23 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E02FFD05;
        Mon, 25 Apr 2022 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650902479; x=1682438479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=SfwU9RRrwUbs8J2J4RuaSBSxyXtRxCmuowf1qerOqMc=;
  b=JcN/5DGbLQMIY6ptRHL/iEwedTDt5sgwAfogUjcXmen92aMCyWOiD3NT
   HCXGEwotW8Alpb15HMr6XrRBNNeLjzYt+4dUzG/5VC2YQWVr7YRa4fPxg
   e/x4/Gk6AcMjDAX4pSCHpVM9RkohyooIK33wypE0Ww1tacJMKre/MauF6
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Apr 2022 09:01:18 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Apr 2022 09:01:16 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 25 Apr 2022 21:30:55 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 27EEAB77; Mon, 25 Apr 2022 21:30:54 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        wsa+renesas@sang-engineering.com, yoshihiro.shimoda.uh@renesas.com,
        linus.walleij@linaro.org, digetx@gmail.com,
        briannorris@chromium.org, quic_riteshh@quicinc.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
Subject: [PATCH V5 5/5] mmc: cqhci: Capture eMMC and SD card errors
Date:   Mon, 25 Apr 2022 21:30:43 +0530
Message-Id: <1650902443-26357-6-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650902443-26357-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1650902443-26357-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add changes to capture eMMC and SD card errors.
This is useful for debug and testing.

Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 drivers/mmc/host/cqhci-core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b0d30c3..b3d7d6d 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -822,8 +822,15 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
 	pr_debug("%s: cqhci: IRQ status: 0x%08x\n", mmc_hostname(mmc), status);
 
 	if ((status & (CQHCI_IS_RED | CQHCI_IS_GCE | CQHCI_IS_ICCE)) ||
-	    cmd_error || data_error)
+	    cmd_error || data_error) {
+		if (status & CQHCI_IS_RED)
+			mmc_debugfs_err_stats_inc(mmc, MMC_ERR_CMDQ_RED);
+		if (status & CQHCI_IS_GCE)
+			mmc_debugfs_err_stats_inc(mmc, MMC_ERR_CMDQ_GCE);
+		if (status & CQHCI_IS_ICCE)
+			mmc_debugfs_err_stats_inc(mmc, MMC_ERR_CMDQ_ICCE);
 		cqhci_error_irq(mmc, status, cmd_error, data_error);
+	}
 
 	if (status & CQHCI_IS_TCC) {
 		/* read TCN and complete the request */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

