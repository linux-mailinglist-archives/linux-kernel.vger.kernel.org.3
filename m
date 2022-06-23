Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27189558A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiFWUmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiFWUmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A07762721
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D05361DEB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFE1C341C0;
        Thu, 23 Jun 2022 20:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656016942;
        bh=hviTkDyW4rPf0CUIsQ7Dbtey/q7pCJk5kLDjCODH/Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=umYU+QcZR8MqlCob5dtRthobk5fZOJQJEJVeKq+RZFv4IFy7cQrL/g2GZfU283PR0
         h5VHB54z38oyxE8vt7om76oADHAht3t/unf1ZG3ceZUrHAwVgFElLL5SyNnBLqX51r
         nzQO3SjImEK6wa/FbpMNMo3mg/ASGQtVuHAsW1HwsEmR2pldmFkDmWmzqQM0JpOR/Q
         2zKzUESXyUizPm4uBpS2007mahBRQvoj0KXaOlvq6PCmMQrV8X3O47e6TIBhBw2qAE
         x1u16WrNnMtD66lIqxsVQ/zgvAO6eGZvQAiKMTXXvxcFwgRgP/CPblCfqQOz0GmVAe
         rwhL710LG/7GA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 5/9] habanalabs: don't do memory scrubbing when unmapping
Date:   Thu, 23 Jun 2022 23:42:08 +0300
Message-Id: <20220623204212.1628709-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623204212.1628709-1-ogabbay@kernel.org>
References: <20220623204212.1628709-1-ogabbay@kernel.org>
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

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

There is no need to do memory scrub when unmapping anymore as it is
an overhead as long as we have a single user at any given time.

Remove that code and change return value of free_phys_pg_pack to void

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 36 +++++--------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index d5e6500f8a1f..039fd87021ab 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -305,33 +305,20 @@ static void dram_pg_pool_do_release(struct kref *ref)
  *
  * This function does the following:
  * - For DRAM memory only
- *   - iterate over the pack, scrub and free each physical block structure by
+ *   - iterate over the pack, free each physical block structure by
  *     returning it to the general pool.
- *     In case of error during scrubbing, initiate hard reset.
- *     Once hard reset is triggered, scrubbing is bypassed while freeing the
- *     memory continues.
  * - Free the hl_vm_phys_pg_pack structure.
  */
-static int free_phys_pg_pack(struct hl_device *hdev,
+static void free_phys_pg_pack(struct hl_device *hdev,
 				struct hl_vm_phys_pg_pack *phys_pg_pack)
 {
 	struct hl_vm *vm = &hdev->vm;
 	u64 i;
-	int rc = 0;
 
 	if (phys_pg_pack->created_from_userptr)
 		goto end;
 
 	if (phys_pg_pack->contiguous) {
-		if (hdev->memory_scrub && !hdev->disabled) {
-			rc = hdev->asic_funcs->scrub_device_mem(hdev,
-					phys_pg_pack->pages[0],
-					phys_pg_pack->total_size);
-			if (rc)
-				dev_err(hdev->dev,
-					"Failed to scrub contiguous device memory\n");
-		}
-
 		gen_pool_free(vm->dram_pg_pool, phys_pg_pack->pages[0],
 			phys_pg_pack->total_size);
 
@@ -340,15 +327,6 @@ static int free_phys_pg_pack(struct hl_device *hdev,
 				dram_pg_pool_do_release);
 	} else {
 		for (i = 0 ; i < phys_pg_pack->npages ; i++) {
-			if (hdev->memory_scrub && !hdev->disabled && rc == 0) {
-				rc = hdev->asic_funcs->scrub_device_mem(
-						hdev,
-						phys_pg_pack->pages[i],
-						phys_pg_pack->page_size);
-				if (rc)
-					dev_err(hdev->dev,
-						"Failed to scrub device memory\n");
-			}
 			gen_pool_free(vm->dram_pg_pool,
 				phys_pg_pack->pages[i],
 				phys_pg_pack->page_size);
@@ -357,14 +335,11 @@ static int free_phys_pg_pack(struct hl_device *hdev,
 		}
 	}
 
-	if (rc && !hdev->disabled)
-		hl_device_reset(hdev, HL_DRV_RESET_HARD);
-
 end:
 	kvfree(phys_pg_pack->pages);
 	kfree(phys_pg_pack);
 
-	return rc;
+	return;
 }
 
 /**
@@ -409,7 +384,8 @@ static int free_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args)
 		atomic64_sub(phys_pg_pack->total_size, &ctx->dram_phys_mem);
 		atomic64_sub(phys_pg_pack->total_size, &hdev->dram_used_mem);
 
-		return free_phys_pg_pack(hdev, phys_pg_pack);
+		free_phys_pg_pack(hdev, phys_pg_pack);
+		return 0;
 	} else {
 		spin_unlock(&vm->idr_lock);
 		dev_err(hdev->dev,
@@ -1278,7 +1254,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args, u64 *device
 	*device_addr = ret_vaddr;
 
 	if (is_userptr)
-		rc = free_phys_pg_pack(hdev, phys_pg_pack);
+		free_phys_pg_pack(hdev, phys_pg_pack);
 
 	return rc;
 
-- 
2.25.1

