Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130B7533CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiEYM3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbiEYM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:28:50 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8D46D3B5;
        Wed, 25 May 2022 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653481730; x=1685017730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=FwtFR9xmp2GlSe86mLIUtQ+27qGOvB2x+BZIKUG5EzM=;
  b=VfyN7CTC7Lk2ZCl0y5wo6WqF8ZeAOgTZlwaDQcJ4AxrgYRPgVG/SUyXM
   Nwv0Qba0ESukRI33hjsJS2RRuDBm2itn94sROsQE9L9eTr8+tN+0pEptT
   UPWu1CO70V2ZTSNZN+dp/6q5f0rvFcSupKaLIXWZiJQt+C/f26Cg7HWzy
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 May 2022 05:28:50 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 May 2022 05:28:48 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 25 May 2022 17:58:30 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id C837116F8; Wed, 25 May 2022 17:58:28 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        chris@printf.net, venkatg@codeaurora.org, gdjakov@mm-sol.com,
        quic_asutoshd@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
Subject: [PATCH V7 4/4] mmc: debugfs: Add debug fs error state entry for mmc driver
Date:   Wed, 25 May 2022 17:58:21 +0530
Message-Id: <1653481701-19642-5-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653481701-19642-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1653481701-19642-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debug fs entry error state to query eMMC and SD card errors statistics.
If any errors occurred in eMMC and SD card driver level then
err_state value will be set to 1.

Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/debugfs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index f9fb51f..d8ff66f 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -234,6 +234,27 @@ static int mmc_clock_opt_set(void *data, u64 val)
 DEFINE_SIMPLE_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
 	"%llu\n");
 
+static int mmc_err_state_get(void *data, u64 *val)
+{
+	struct mmc_host *host = data;
+	int i;
+
+	if (!host)
+		return -EINVAL;
+
+	*val = 0;
+	for (i = 0; i < MMC_ERR_MAX; i++) {
+		if (host->err_stats[i]) {
+			*val = 1;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(mmc_err_state, mmc_err_state_get, NULL, "%llu\n");
+
 static int mmc_err_stats_show(struct seq_file *file, void *data)
 {
 	struct mmc_host *host = (struct mmc_host *)file->private;
@@ -309,6 +330,10 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 			&mmc_clock_fops))
 		goto err_node;
 
+	if (!debugfs_create_file_unsafe("err_state", 0600, root, host,
+			&mmc_err_state))
+		goto err_node;
+
 	if (!debugfs_create_file("err_stats", 0600, root, host,
 			&mmc_err_stats_fops))
 		goto err_node;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

