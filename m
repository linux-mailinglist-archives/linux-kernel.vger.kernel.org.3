Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D65366B8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353577AbiE0RyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349832AbiE0RyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:54:22 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6323A88A8;
        Fri, 27 May 2022 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653674062; x=1685210062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=l3rjmybN1CpswS9ijer3aRVunkWPQ59t8L40dSpAj00=;
  b=ErgiRQNDFTaiCQ/8iCgddNtko6dopHQnRcl3ocEwMzkruLP5TsSFE4b5
   awsoftjap3mtPcLw6tvYXvd4aY5OgQDdB7fFtq4/fb1lx+JxyqRmCDQBY
   S8AaSB+tcexquforeONn+gfdEeuAv2TerYuyWJOI6A8S9xFhvy4u3UGja
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 27 May 2022 10:54:21 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 May 2022 10:54:19 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 27 May 2022 23:24:04 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 6DE9A1846; Fri, 27 May 2022 23:24:03 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        wsa+renesas@sang-engineering.com, shawn.lin@rock-chips.com,
        yoshihiro.shimoda.uh@renesas.com, digetx@gmail.com,
        quic_asutoshd@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
Subject: [PATCH V8 4/5] mmc: debugfs: Add debug fs error state entry for mmc driver
Date:   Fri, 27 May 2022 23:23:55 +0530
Message-Id: <1653674036-21829-5-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653674036-21829-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1653674036-21829-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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
 drivers/mmc/core/debugfs.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 6aa5a60..75e98ec 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -223,6 +223,27 @@ static int mmc_clock_opt_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
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
@@ -289,6 +310,8 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
 				   &mmc_clock_fops);
 
+	debugfs_create_file_unsafe("err_state", 0600, root, host,
+			    &mmc_err_state);
 	debugfs_create_file("err_stats", 0600, root, host,
 			    &mmc_err_stats_fops);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

