Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EDF55D6B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbiF0LmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbiF0LjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:39:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC21BCBD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:35:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7D3DB8111C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75649C3411D;
        Mon, 27 Jun 2022 11:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656329704;
        bh=JruKqWNa7Jx8Gi53R/brhvsiUInoiMypkjDYQeWYHjY=;
        h=From:To:Cc:Subject:Date:From;
        b=CPgUTny4PtJ9IC7WBEt2ajpVaRGA6bUKsoCpBriRwULl1yOSwPbVBBKCHstRg1N0A
         VIfdszWYSq3AMGk/H0nEYeu19AWAS2i/MY/iGmZZtvOBqT3BiQ8opiRidcautQo/wU
         5vWzVISpBQ2yfE4LeSCIm54z2ET8CLhPxB01mRzAOa4f3NLLsePW+OhDXtVNUQpjfq
         /yFWv/ZpMVFaf0MJVnVF6e1lFvBa8lAaeASml2dlcOxAGWGcWxABCO0eoBNr37TiBR
         gX30CwaDgw6eFOPZnDDTtmrgt7bhKR6FO3EC1+DZk464v+ovBU7RiayTsQ/x8DORwj
         cco89Y6BSo1rg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] habanalabs/gaudi: replace hl_poll_timeout with while loop
Date:   Mon, 27 Jun 2022 14:34:58 +0300
Message-Id: <20220627113459.590125-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

in gaudi_scrub_device_mem, replace call to hl_poll_timeout
with a while loop to avoid using dummy variables.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 584feac7ee83..05d9817985d9 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4827,23 +4827,22 @@ static int gaudi_scrub_device_dram(struct hl_device *hdev, u64 val)
 static int gaudi_scrub_device_mem(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 addr, size, dummy_val;
+	u64 wait_to_idle_time = hdev->pdev ? HBM_SCRUBBING_TIMEOUT_US :
+			min_t(u64, HBM_SCRUBBING_TIMEOUT_US * 10, HL_SIM_MAX_TIMEOUT_US);
+	u64 addr, size, val = hdev->memory_scrub_val;
+	ktime_t timeout;
 	int rc = 0;
-	u64 val = hdev->memory_scrub_val;
 
 	if (!hdev->memory_scrub)
 		return 0;
 
-	/* Wait till device is idle */
-	rc = hl_poll_timeout(hdev,
-			mmDMA0_CORE_STS0 /* dummy */,
-			dummy_val /* dummy */,
-			(hdev->asic_funcs->is_device_idle(hdev, NULL, 0, NULL)),
-			1000,
-			HBM_SCRUBBING_TIMEOUT_US);
-	if (rc) {
-		dev_err(hdev->dev, "waiting for idle timeout\n");
-		return -EIO;
+	timeout = ktime_add_us(ktime_get(), wait_to_idle_time);
+	while (!hdev->asic_funcs->is_device_idle(hdev, NULL, 0, NULL)) {
+		if (ktime_compare(ktime_get(), timeout) > 0) {
+			dev_err(hdev->dev, "waiting for idle timeout\n");
+			return -ETIMEDOUT;
+		}
+		usleep_range((1000 >> 2) + 1, 1000);
 	}
 
 	/* Scrub SRAM */
-- 
2.25.1

