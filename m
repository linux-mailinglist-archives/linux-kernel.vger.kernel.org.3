Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7A55B12C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 12:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiFZKdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 06:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiFZKdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 06:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9659FB7D3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 319FE6113D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 10:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A58C34114;
        Sun, 26 Jun 2022 10:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656239589;
        bh=c6LZLm52pCtskTA/Y5nwIytWtE5KrVyZEG65ZFoKBXw=;
        h=From:To:Cc:Subject:Date:From;
        b=h7gtElTkspFbUOhC1ZxTd4nVkqCbokzC2cqMe0B6uL0LPIpfK3EXCieZu8OPlp1k6
         COJAdl7OQeWyn6h3B+Wn3fR3lr3fA3N9IWWcrwcqg4vEjXPfhBmJkIPIgpIi4NqZLU
         JIW/CcIeRCTgUHMvi+SnroSq+LdlhVkNVUrrcA6PLQuJJmpiVnamMpN1KvmuuUj133
         5lEFWuEaxs2mAEWKxNQngfjU17u+GedfRj8pI1MchdSkUqNGSIML2VqPnvmRZM5hl2
         VIS6QPztJDUiDCKoajTBv4UTrltFIRascSh6MKPd9LMMb/wq7gkUrDYscR9GsLumXz
         A8J+cwRLVccfA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 1/2] habanalabs: remove dead code from free_device_memory()
Date:   Sun, 26 Jun 2022 13:33:03 +0300
Message-Id: <20220626103304.46126-1-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

free_device_memory() ends with if and else, each has a return statement,
followed by another return statement that can never be reached.
Restructure the function and remove this dead code.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 50 +++++++++++--------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 4f35a5668fcb..bc921f32716a 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -359,41 +359,35 @@ static int free_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args)
 
 	spin_lock(&vm->idr_lock);
 	phys_pg_pack = idr_find(&vm->phys_pg_pack_handles, handle);
-	if (phys_pg_pack) {
-		if (atomic_read(&phys_pg_pack->mapping_cnt) > 0) {
-			dev_err(hdev->dev, "handle %u is mapped, cannot free\n",
-				handle);
-			spin_unlock(&vm->idr_lock);
-			return -EINVAL;
-		}
-
-		if (phys_pg_pack->exporting_cnt) {
-			dev_dbg(hdev->dev, "handle %u is exported, cannot free\n", handle);
-			spin_unlock(&vm->idr_lock);
-			return -EINVAL;
-		}
-
-		/*
-		 * must remove from idr before the freeing of the physical
-		 * pages as the refcount of the pool is also the trigger of the
-		 * idr destroy
-		 */
-		idr_remove(&vm->phys_pg_pack_handles, handle);
+	if (!phys_pg_pack) {
 		spin_unlock(&vm->idr_lock);
+		dev_err(hdev->dev, "free device memory failed, no match for handle %u\n", handle);
+		return -EINVAL;
+	}
 
-		atomic64_sub(phys_pg_pack->total_size, &ctx->dram_phys_mem);
-		atomic64_sub(phys_pg_pack->total_size, &hdev->dram_used_mem);
+	if (atomic_read(&phys_pg_pack->mapping_cnt) > 0) {
+		spin_unlock(&vm->idr_lock);
+		dev_err(hdev->dev, "handle %u is mapped, cannot free\n", handle);
+		return -EINVAL;
+	}
 
-		free_phys_pg_pack(hdev, phys_pg_pack);
-		return 0;
-	} else {
+	if (phys_pg_pack->exporting_cnt) {
 		spin_unlock(&vm->idr_lock);
-		dev_err(hdev->dev,
-			"free device memory failed, no match for handle %u\n",
-			handle);
+		dev_dbg(hdev->dev, "handle %u is exported, cannot free\n", handle);
 		return -EINVAL;
 	}
 
+	/* must remove from idr before the freeing of the physical pages as the refcount of the pool
+	 * is also the trigger of the idr destroy
+	 */
+	idr_remove(&vm->phys_pg_pack_handles, handle);
+	spin_unlock(&vm->idr_lock);
+
+	atomic64_sub(phys_pg_pack->total_size, &ctx->dram_phys_mem);
+	atomic64_sub(phys_pg_pack->total_size, &hdev->dram_used_mem);
+
+	free_phys_pg_pack(hdev, phys_pg_pack);
+
 	return 0;
 }
 
-- 
2.25.1

