Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A75E4DAF07
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355433AbiCPLnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355436AbiCPLm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:42:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5859527F4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D2AEB81AAE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFF3C340E9;
        Wed, 16 Mar 2022 11:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647430903;
        bh=sBpwkv13ToRoimPPQihi4/xZkbS8Ru5zFJZuvMZV19I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q4kyb8Tvv2YeRK2rTPscj07UyE+7LjaVANW8uFeOyHCouk6p50iu7wz2DI573o7Vv
         2WoSTt9oPM2LSVIQzT/RRL/LU9udZ22YTuspCgaYFEqgsbCYoi0PCI6ZhDSBSwhzmw
         MMliXZwxD5QfvIVUXSnguq5Aptr+iIe094tWfS66jblixY2jQzl2+fBEdvSCwl4jK7
         n7kUHjBszWNMKo9vmzhDY9oqCU9UFwhJ1MRpZB4Y5ZlyDLtWc/oVk5FTKn4tNB7ThI
         4pCvCFgzrvmur/bof8UXp/gwYqLp5M8+4swXBLhG4Wnohi9latpdJzp5/TV8BMSXAF
         JJjNVCJE+D86Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 07/11] habanalabs: expose compute ctx status through info ioctl
Date:   Wed, 16 Mar 2022 13:41:25 +0200
Message-Id: <20220316114129.2520107-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316114129.2520107-1-ogabbay@kernel.org>
References: <20220316114129.2520107-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order for the user to know if he can try and open device, we
expose the compute ctx state. The user can now know if the context
is used by another process or whether the device is still ongoing
through cleanup or reset and will be available soon.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 2 ++
 include/uapi/misc/habanalabs.h                    | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index c6fe35ae1238..bfb5cfe68110 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -498,6 +498,8 @@ static int open_stats_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	open_stats_info.last_open_period_ms = jiffies64_to_msecs(
 		hdev->last_open_session_duration_jif);
 	open_stats_info.open_counter = hdev->open_counter;
+	open_stats_info.is_compute_ctx_active = hdev->is_compute_ctx_active;
+	open_stats_info.compute_ctx_in_release = hdev->compute_ctx_in_release;
 
 	return copy_to_user(out, &open_stats_info,
 		min((size_t) max_size, sizeof(open_stats_info))) ? -EFAULT : 0;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index f474e7fb018d..ca2af5f98056 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -543,10 +543,15 @@ struct hl_pll_frequency_info {
  * struct hl_open_stats_info - device open statistics information
  * @open_counter: ever growing counter, increased on each successful dev open
  * @last_open_period_ms: duration (ms) device was open last time
+ * @is_compute_ctx_active: Whether there is an active compute context executing
+ * @compute_ctx_in_release: true if the current compute context is being released
  */
 struct hl_open_stats_info {
 	__u64 open_counter;
 	__u64 last_open_period_ms;
+	__u8 is_compute_ctx_active;
+	__u8 compute_ctx_in_release;
+	__u8 pad[6];
 };
 
 /**
-- 
2.25.1

