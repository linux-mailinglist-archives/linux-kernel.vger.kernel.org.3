Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DD049532D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiATR2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:28:17 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:38887 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346829AbiATR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642699615; x=1674235615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WKv6tCtQgSCkfw+0HJkKanv62ISYhKm0cbdrYhfgvT0=;
  b=xutkIUzWDwKZOkA7ynExj+Yx6XnT9kLFC8OJDxiyqCktOhVg5trAPp9e
   ThlwgSBkNQAJXNjvyOlms6NVUGUh5gT3mt9t51SeJf+Y2rRI7mt9tTmXM
   ukEg/hI9IxnVtdCzsoHyNgSyPS5yu9WhcGEAiK5PfvjzC7Of6Opz1FLhc
   A=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 20 Jan 2022 09:26:55 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Jan 2022 09:26:53 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 20 Jan 2022 22:56:41 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 786FB538E; Thu, 20 Jan 2022 22:56:39 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, quic_asutoshd@quicinc.com,
        ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stummala@codeaurora.org, vbadigan@codeaurora.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        sartgarg@codeaurora.org, nitirawa@codeaurora.org,
        sayalil@codeaurora.org,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Liangliang Lu <luliang@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
Subject: [PATCH V3 4/4] mmc: cqhci: Capture eMMC and SD card errors
Date:   Thu, 20 Jan 2022 22:56:22 +0530
Message-Id: <1642699582-14785-5-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642699582-14785-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1642699582-14785-1-git-send-email-quic_c_sbhanu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add changes to capture eMMC and SD card errors.
This is useful for debug and testing.

Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Signed-off-by: Liangliang Lu <luliang@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
---
 drivers/mmc/host/cqhci-core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b0d30c3..2908d30 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -822,8 +822,15 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
 	pr_debug("%s: cqhci: IRQ status: 0x%08x\n", mmc_hostname(mmc), status);
 
 	if ((status & (CQHCI_IS_RED | CQHCI_IS_GCE | CQHCI_IS_ICCE)) ||
-	    cmd_error || data_error)
+	    cmd_error || data_error) {
+		if ((status & CQHCI_IS_RED) && mmc->err_stats_enabled)
+			mmc_debugfs_err_stats_inc(mmc, MMC_ERR_CMDQ_RED);
+		if ((status & CQHCI_IS_GCE) && (mmc->err_stats_enabled))
+			mmc_debugfs_err_stats_inc(mmc, MMC_ERR_CMDQ_GCE);
+		if ((status & CQHCI_IS_ICCE) && mmc->err_stats_enabled)
+			mmc_debugfs_err_stats_inc(mmc, MMC_ERR_CMDQ_ICCE);
 		cqhci_error_irq(mmc, status, cmd_error, data_error);
+	}
 
 	if (status & CQHCI_IS_TCC) {
 		/* read TCN and complete the request */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

