Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937DE51F785
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbiEII64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiEII1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:27:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18741DA643
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 01:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E05F7B80EA2
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABA9C385AC;
        Mon,  9 May 2022 08:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652084545;
        bh=NANQp7QofUo34mrnijGjquxDhvq3koZzFJ1Pl4SUt7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjF1Oe/yMsZC/GLxhVBM5iR+ydt4nG+AWfiqgmNmcbZgrMiFAV2L9IR+9Hbawkd5r
         xr11NeHhJnKB6XNzLj2Xp/Q+J6izR3ZEV+cL8ujy+Ip5mAYn7bPrmG8KPwcD8wRPeW
         PQ2f1KpChKEgfNBWUbmCfqHgwIL3kCIEBoG/7fdBFbAgbpu3+7i1+NAd0r3Cfz1hPd
         6VZicyG3LwsBocvwfoQnE2TgFhmafZCjbC+2Y54VSZb7ezeWyDIszEvckKVfjZq9cI
         fQ38Epym3mGrZvI5noU9UBngF9J+2MXQ5f+XALDDLhsDQ5UneyoQCqr/P4aZaWo9fL
         FZlH3/dchVZrA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 2/3] habanalabs: add topic to memory manager buffer
Date:   Mon,  9 May 2022 11:22:17 +0300
Message-Id: <20220509082218.956916-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509082218.956916-1-ogabbay@kernel.org>
References: <20220509082218.956916-1-ogabbay@kernel.org>
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

From: Yuri Nudelman <ynudelman@habana.ai>

Currently, buffers from multiple flows pass through the same infra.
This way, in logs, we are unable to distinguish between buffers that
came from separate flows.
To address this problem, add a "topic" to buffer behavior
descriptor - a string identifier that will be used to identify in logs
the flow this buffer relates to.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   |  1 +
 drivers/misc/habanalabs/common/habanalabs.h   |  2 ++
 drivers/misc/habanalabs/common/memory.c       |  1 +
 drivers/misc/habanalabs/common/memory_mgr.c   | 23 +++++++++++--------
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index fd9ef32ea6a0..1fac72c38c87 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -319,6 +319,7 @@ static int hl_cb_mmap(struct hl_mmap_mem_buf *buf,
 }
 
 static struct hl_mmap_mem_buf_behavior cb_behavior = {
+	.topic = "CB",
 	.mem_id = HL_MMAP_TYPE_CB,
 	.alloc = hl_cb_mmap_mem_alloc,
 	.release = hl_cb_mmap_mem_release,
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 59150caa98a2..918e8a04acab 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -731,6 +731,7 @@ struct hl_mem_mgr {
 
 /**
  * struct hl_mmap_mem_buf_behavior - describes unified memory manager buffer behavior
+ * @topic: string identifier used for logging
  * @mem_id: memory type identifier, embedded in the handle and used to identify
  *          the memory type by handle.
  * @alloc: callback executed on buffer allocation, shall allocate the memory,
@@ -739,6 +740,7 @@ struct hl_mem_mgr {
  * @release: callback executed on release, must free the resources used by the buffer
  */
 struct hl_mmap_mem_buf_behavior {
+	const char *topic;
 	u64 mem_id;
 
 	int (*alloc)(struct hl_mmap_mem_buf *buf, gfp_t gfp, void *args);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index e7a0c44c487d..ecf3c094242a 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -2141,6 +2141,7 @@ static int hl_ts_alloc_buf(struct hl_mmap_mem_buf *buf, gfp_t gfp, void *args)
 }
 
 static struct hl_mmap_mem_buf_behavior hl_ts_behavior = {
+	.topic = "TS",
 	.mem_id = HL_MMAP_TYPE_TS_BUFF,
 	.mmap = hl_ts_mmap,
 	.alloc = hl_ts_alloc_buf,
diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
index 9f3ab6cf25d3..0ddfebe3a9ef 100644
--- a/drivers/misc/habanalabs/common/memory_mgr.c
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -162,7 +162,8 @@ hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
 	spin_unlock(&mmg->lock);
 	if (rc < 0) {
 		dev_err(mmg->dev,
-			"Failed to allocate IDR for a new buffer, rc=%d\n", rc);
+			"%s: Failed to allocate IDR for a new buffer, rc=%d\n",
+			behavior->topic, rc);
 		goto free_buf;
 	}
 
@@ -173,8 +174,8 @@ hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
 
 	rc = buf->behavior->alloc(buf, gfp, args);
 	if (rc) {
-		dev_err(mmg->dev, "Failure in buffer alloc callback %d\n",
-			rc);
+		dev_err(mmg->dev, "%s: Failure in buffer alloc callback %d\n",
+			behavior->topic, rc);
 		goto remove_idr;
 	}
 
@@ -253,8 +254,8 @@ int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
 	user_mem_size = vma->vm_end - vma->vm_start;
 	if (user_mem_size != ALIGN(buf->mappable_size, PAGE_SIZE)) {
 		dev_err(mmg->dev,
-			"Memory mmap failed, mmap VM size 0x%llx != 0x%llx allocated physical mem size\n",
-			user_mem_size, buf->mappable_size);
+			"%s: Memory mmap failed, mmap VM size 0x%llx != 0x%llx allocated physical mem size\n",
+			buf->behavior->topic, user_mem_size, buf->mappable_size);
 		rc = -EINVAL;
 		goto put_mem;
 	}
@@ -266,8 +267,8 @@ int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
 	if (!access_ok((void __user *)(uintptr_t)vma->vm_start,
 		       user_mem_size)) {
 #endif
-		dev_err(mmg->dev, "user pointer is invalid - 0x%lx\n",
-			vma->vm_start);
+		dev_err(mmg->dev, "%s: User pointer is invalid - 0x%lx\n",
+			buf->behavior->topic, vma->vm_start);
 
 		rc = -EINVAL;
 		goto put_mem;
@@ -275,7 +276,8 @@ int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
 
 	if (atomic_cmpxchg(&buf->mmap, 0, 1)) {
 		dev_err(mmg->dev,
-			"Memory mmap failed, already mmaped to user\n");
+			"%s, Memory mmap failed, already mmaped to user\n",
+			buf->behavior->topic);
 		rc = -EINVAL;
 		goto put_mem;
 	}
@@ -328,14 +330,17 @@ void hl_mem_mgr_fini(struct hl_mem_mgr *mmg)
 {
 	struct hl_mmap_mem_buf *buf;
 	struct idr *idp;
+	const char *topic;
 	u32 id;
 
 	idp = &mmg->handles;
 
 	idr_for_each_entry(idp, buf, id) {
+		topic = buf->behavior->topic;
 		if (hl_mmap_mem_buf_put(buf) != 1)
 			dev_err(mmg->dev,
-				"Buff handle %u for CTX is still alive\n", id);
+				"%s: Buff handle %u for CTX is still alive\n",
+				topic, id);
 	}
 
 	/* TODO: can it happen that some buffer is still in use at this point? */
-- 
2.25.1

