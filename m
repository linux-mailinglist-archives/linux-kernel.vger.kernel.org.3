Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4B2505F74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiDRVlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiDRVlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E857F2ED70;
        Mon, 18 Apr 2022 14:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ECDD60FFA;
        Mon, 18 Apr 2022 21:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDC4C385A1;
        Mon, 18 Apr 2022 21:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650317918;
        bh=imQLFb1ROjuyLNu38llWBohpiNFKzkj0uG4wNs7W0b0=;
        h=From:To:Cc:Subject:Date:From;
        b=NkePFybGgXdd77+wHs0WTVGMOxJwiUA+xvby0wqX0e8NlxKxr9xc6lU3Hea3W5/UA
         2vC+a+40RHwV6BiKhhIz5rlosvWh2MNB9sHqdKm2yR4dxTEee/PbkpLPxViwMUjCrm
         iHhNq2Sow2UGUNfENn8GduNsJWvHb9yQBE6knq1PC/MUJTF8wdBzxn1FzKSA2xUKTm
         wF1gcVkrF+POobEbntrF9N11qYK2sC4z5w/aeEvEjNfb+cw+l9x/3pFxq5Qdt5mC3y
         8mK5Xck0NGthaqdban3l0RyJy4CA+U08vFiGwqVE7GEpZfGr4yQLNdpogDbbZCLj6J
         48ZutCSbxrvBQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] platform/x86: amd-pmc: Shuffle location of amd_pmc_get_smu_version()
Date:   Mon, 18 Apr 2022 14:38:00 -0700
Message-Id: <20220418213800.21257-1-nathan@kernel.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DEBUG_FS is disabled, amd_pmc_get_smu_version() is unused:

  drivers/platform/x86/amd-pmc.c:196:12: warning: unused function 'amd_pmc_get_smu_version' [-Wunused-function]
  static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
             ^
  1 warning generated.

Eliminate the warning by moving amd_pmc_get_smu_version() to the
CONFIG_DEBUG_FS block where it is used.

Fixes: b0c07116c894 ("platform/x86: amd-pmc: Avoid reading SMU version at probe time")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/platform/x86/amd-pmc.c | 40 +++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 668a1d6c11ee..e266492d3ef7 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -193,26 +193,6 @@ struct smu_metrics {
 	u64 timecondition_notmet_totaltime[SOC_SUBSYSTEM_IP_MAX];
 } __packed;
 
-static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
-{
-	int rc;
-	u32 val;
-
-	rc = amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION, 1);
-	if (rc)
-		return rc;
-
-	dev->smu_program = (val >> 24) & GENMASK(7, 0);
-	dev->major = (val >> 16) & GENMASK(7, 0);
-	dev->minor = (val >> 8) & GENMASK(7, 0);
-	dev->rev = (val >> 0) & GENMASK(7, 0);
-
-	dev_dbg(dev->dev, "SMU program %u version is %u.%u.%u\n",
-		dev->smu_program, dev->major, dev->minor, dev->rev);
-
-	return 0;
-}
-
 static int amd_pmc_stb_debugfs_open(struct inode *inode, struct file *filp)
 {
 	struct amd_pmc_dev *dev = filp->f_inode->i_private;
@@ -417,6 +397,26 @@ static int s0ix_stats_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(s0ix_stats);
 
+static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
+{
+	int rc;
+	u32 val;
+
+	rc = amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION, 1);
+	if (rc)
+		return rc;
+
+	dev->smu_program = (val >> 24) & GENMASK(7, 0);
+	dev->major = (val >> 16) & GENMASK(7, 0);
+	dev->minor = (val >> 8) & GENMASK(7, 0);
+	dev->rev = (val >> 0) & GENMASK(7, 0);
+
+	dev_dbg(dev->dev, "SMU program %u version is %u.%u.%u\n",
+		dev->smu_program, dev->major, dev->minor, dev->rev);
+
+	return 0;
+}
+
 static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
 {
 	struct amd_pmc_dev *dev = s->private;

base-commit: b0c07116c894325d40a218f558047f925e4b3bdb
-- 
2.36.0

