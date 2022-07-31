Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97576585E84
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiGaKvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbiGaKut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:50:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B5A11820
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45F9E60C02
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 10:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF105C433B5;
        Sun, 31 Jul 2022 10:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659264647;
        bh=iTu5p4YKZ4xAm4s5F+BSXv8uXDKAOfaBoiaPJlN3I8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9aLD7xH7frXpHNKF9/yO0HaCdDnByqaUL2byadK8QdPjTIxss8xDANPxHHIDH2fw
         0igTYbSDEv/gPPH+FohtxmTWSP1pQoVcDzKb8EPOeV8wMuV/8AjAph9sdlmT0pvu6R
         l4qjCRrmr90nynQx41TvhA9Zx25hvDK2W41uOyBFKwlRfhwC23BuE3Gw/aCeopgYdM
         TaH7U//PAFLA0cjQl3EYBAnEJjxi1vf3/fCokDUskJk+QHXsLiUGZUOVUhqXGTFNuC
         oFmIXPpWlmC2oV1221gjCUNoMEy1oBZD4rPN0aGzrEEnEIFlIqtmc2Hjayz7laupIU
         PvsnILWZbsIQw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 5/8] habanalabs: fix vma fields assignments order in hl_hw_block_mmap()
Date:   Sun, 31 Jul 2022 13:50:34 +0300
Message-Id: <20220731105037.545106-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220731105037.545106-1-ogabbay@kernel.org>
References: <20220731105037.545106-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

In hl_hw_block_mmap(), the vma's 'vm_private_data' and 'vm_ops' fields
are assigned before filling the content of the private data.
In between there is a call to the ASIC hw_block_mmap() function, and if
it fails, the vma close function will be called with a bad private data
value.
Fix the order of assignments to avoid this issue.

In hl_hw_block_mmap() the vma's 'vm_private_data and vm_ops are assigned
before setting the

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 0698c3c363bd..a027fa88889b 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1492,23 +1492,22 @@ int hl_hw_block_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 	if (!lnode)
 		return -ENOMEM;
 
-	vma->vm_ops = &hw_block_vm_ops;
-	vma->vm_private_data = lnode;
-
-	hl_ctx_get(ctx);
-
 	rc = hdev->asic_funcs->hw_block_mmap(hdev, vma, block_id, block_size);
 	if (rc) {
-		hl_ctx_put(ctx);
 		kfree(lnode);
 		return rc;
 	}
 
+	hl_ctx_get(ctx);
+
 	lnode->ctx = ctx;
 	lnode->vaddr = vma->vm_start;
 	lnode->size = block_size;
 	lnode->id = block_id;
 
+	vma->vm_private_data = lnode;
+	vma->vm_ops = &hw_block_vm_ops;
+
 	mutex_lock(&ctx->hw_block_list_lock);
 	list_add_tail(&lnode->node, &ctx->hw_block_mem_list);
 	mutex_unlock(&ctx->hw_block_list_lock);
-- 
2.25.1

