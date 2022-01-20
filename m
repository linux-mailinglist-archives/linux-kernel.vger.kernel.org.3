Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8149532E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiATR2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:28:18 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:48739 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiATR05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642699617; x=1674235617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4daRwd6XUkVJ25mEal3fAjXhPYFJ0f4AY8G1bpkWBSM=;
  b=KcAeSXflC1LpyjzOcOILgOH6jl0AVU1UBrI5Oo7usXh+XtA4U4MnCD2K
   njEa1/ApIsoXhvG6dieJ+PRdMZWOPP0HeeVgj5jAjaq/0ZmTMqljvMBVo
   owdX9jAUC8N2r+OYfdVZ7QTSsT/laF8Ws96f5xZP8CowQxav0TkLhU8Wt
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 20 Jan 2022 09:26:57 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Jan 2022 09:26:55 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 20 Jan 2022 22:56:39 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id A7018538E; Thu, 20 Jan 2022 22:56:37 +0530 (IST)
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
Subject: [PATCH V3 3/4] mmc: core: Capture eMMC and SD card errors
Date:   Thu, 20 Jan 2022 22:56:21 +0530
Message-Id: <1642699582-14785-4-git-send-email-quic_c_sbhanu@quicinc.com>
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
 drivers/mmc/core/core.c  | 8 ++++++++
 drivers/mmc/core/queue.c | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 368f104..c586d69 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2242,6 +2242,14 @@ void mmc_rescan(struct work_struct *work)
 		if (freqs[i] <= host->f_min)
 			break;
 	}
+
+	/*
+	 * Ignore the command timeout errors observed during
+	 * the card init as those are excepted.
+	 */
+
+	if (host && host->err_stats_enabled)
+		host->err_stats[MMC_ERR_CMD_TIMEOUT] = 0;
 	mmc_release_host(host);
 
  out:
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index c69b2d9..7dc9dfb 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -100,6 +100,9 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
 	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
 	bool recovery_needed = false;
 
+	if (host->err_stats_enabled)
+		mmc_debugfs_err_stats_inc(host, MMC_ERR_CMDQ_REQ_TIMEOUT);
+
 	switch (issue_type) {
 	case MMC_ISSUE_ASYNC:
 	case MMC_ISSUE_DCMD:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

