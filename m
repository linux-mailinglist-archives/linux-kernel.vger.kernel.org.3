Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37865A45FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiH2JXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiH2JXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:23:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA0C5AA13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B458560BD4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40671C433C1;
        Mon, 29 Aug 2022 09:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661764981;
        bh=yP1OlOYlPsS4R7HoRks70kLjMnq7xl7j94ZgEpioAS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2cdKIUO8LwjHfJvp39iphnr7WcoAu2Iv6RmKUyp9rMYA28dYGrTWyOpy+fOEr7IM
         ooLVPeNDC6VQybHYHWS6bKv3TLt5e+eO96r7dHzGIOF2U7hG4u1s5JDUxAQ3ITHQ7t
         TvFLRHKIiMkZPv4C/HUzEIKBTtoq+WGmpMFsPTwNWwXjboyTpYKDl89vYV9Ado/aJr
         9/fOQgrkL4xaJrKMm5oiQh1XzF7kELHTSTZYgWZVRyrsr+ui1fGll8btQNbIqc5dVR
         dj3jFUILGdM1cfGbKl9N9tNofOfRyBpQJGhEzPaqqzkD/8egjVP36ksLl5tKcb07Uq
         EVf5yARugTGkA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/7] habanalabs: perform context switch flow only if needed
Date:   Mon, 29 Aug 2022 12:22:49 +0300
Message-Id: <20220829092254.930753-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829092254.930753-1-ogabbay@kernel.org>
References: <20220829092254.930753-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Except Goya, none of our ASICs require context switch flow, hence we
enable this flow only where it is needed.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 10 ++++++----
 drivers/misc/habanalabs/common/habanalabs.h         |  2 ++
 drivers/misc/habanalabs/goya/goya.c                 |  1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index cf4118515678..746b688d34cf 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1590,13 +1590,14 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_ctx *ctx = hpriv->ctx;
 	bool need_soft_reset = false;
-	int rc = 0, do_ctx_switch;
+	int rc = 0, do_ctx_switch = 0;
 	void __user *chunks;
 	u32 num_chunks, tmp;
 	u16 sob_count;
 	int ret;
 
-	do_ctx_switch = atomic_cmpxchg(&ctx->thread_ctx_switch_token, 1, 0);
+	if (hdev->supports_ctx_switch)
+		do_ctx_switch = atomic_cmpxchg(&ctx->thread_ctx_switch_token, 1, 0);
 
 	if (do_ctx_switch || (args->in.cs_flags & HL_CS_FLAGS_FORCE_RESTORE)) {
 		mutex_lock(&hpriv->restore_phase_mutex);
@@ -1667,9 +1668,10 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 			}
 		}
 
-		ctx->thread_ctx_switch_wait_token = 1;
+		if (hdev->supports_ctx_switch)
+			ctx->thread_ctx_switch_wait_token = 1;
 
-	} else if (!ctx->thread_ctx_switch_wait_token) {
+	} else if (hdev->supports_ctx_switch && !ctx->thread_ctx_switch_wait_token) {
 		rc = hl_poll_timeout_memory(hdev,
 			&ctx->thread_ctx_switch_wait_token, tmp, (tmp == 1),
 			100, jiffies_to_usecs(hdev->timeout_jiffies), false);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index d7fd4f57abf3..33c6476b60a9 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3199,6 +3199,7 @@ struct hl_reset_info {
  *                         Used only for testing.
  * @heartbeat: Controls if we want to enable the heartbeat mechanism vs. the f/w, which verifies
  *             that the f/w is always alive. Used only for testing.
+ * @supports_ctx_switch: true if a ctx switch is required upon first submission.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -3335,6 +3336,7 @@ struct hl_device {
 	u8				compute_ctx_in_release;
 	u8				supports_mmu_prefetch;
 	u8				reset_upon_device_release;
+	u8				supports_ctx_switch;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 87465a28af0d..d8fb91d257b9 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -1025,6 +1025,7 @@ static int goya_sw_init(struct hl_device *hdev)
 	hdev->asic_prop.supports_compute_reset = true;
 	hdev->asic_prop.allow_inference_soft_reset = true;
 	hdev->supports_wait_for_multi_cs = false;
+	hdev->supports_ctx_switch = true;
 
 	hdev->asic_funcs->set_pci_memory_regions(hdev);
 
-- 
2.25.1

