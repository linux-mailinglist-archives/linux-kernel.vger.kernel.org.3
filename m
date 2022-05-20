Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D9D52EE42
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350361AbiETOdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350340AbiETOdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FA65AA54
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5B3D61BCB
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504E3C385A9;
        Fri, 20 May 2022 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653057190;
        bh=xJNXh2L3rhARnW4HOSx7Ck64EwuTyP9shWfeA3uLLf4=;
        h=From:To:Cc:Subject:Date:From;
        b=kP6bsj5OTovkjjK6+uU+oD9+4mpwRrmOKnMqiW10s29gBpYuU5+jyRFHLFFdIa8AP
         ws737mj0IUGr56xcfRcPO7wm4vY5WNwTshUduMabaUfCR9S5zBVKPoloQFiSiaCxVK
         wxKLkjDbzi1GNDmOUxY3XhEd4Buc5tQLyZfdQKkCxkE0AkmIEj4J8l+lMJTvabvWjD
         LWKx9dSI1KHkE69HjGJqnTBjYpWRIloyomGckw/ikmYp6KU66o+NO2zqGWjtSMPECS
         ZG+vWulrx5AgW/4R1hLuwEjPZDi4MFHFeIHiM14eQbKAMsyhdMNHyugLXOYeZWkU5i
         u/VtJBJsjexcA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 1/5] habanalabs: order memory manager messages
Date:   Fri, 20 May 2022 17:33:00 +0300
Message-Id: <20220520143304.1906895-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

Changing format of memory manager messages to make it more readable. In
addition, reducing the priority of a warning on missing handle during
put. This scenario is not an indication of a problem and may happen in
a legal flow, when handle is put from multiple flows. For example, in
timeout and completion.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory_mgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
index 0ddfebe3a9ef..3dbe388d592d 100644
--- a/drivers/misc/habanalabs/common/memory_mgr.c
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -26,7 +26,7 @@ struct hl_mmap_mem_buf *hl_mmap_mem_buf_get(struct hl_mem_mgr *mmg, u64 handle)
 	if (!buf) {
 		spin_unlock(&mmg->lock);
 		dev_warn(mmg->dev,
-			 "Buff get failed, no match to handle %llu\n", handle);
+			 "Buff get failed, no match to handle %#llx\n", handle);
 		return NULL;
 	}
 	kref_get(&buf->refcount);
@@ -119,8 +119,8 @@ int hl_mmap_mem_buf_put_handle(struct hl_mem_mgr *mmg, u64 handle)
 	buf = idr_find(&mmg->handles, lower_32_bits(handle >> PAGE_SHIFT));
 	if (!buf) {
 		spin_unlock(&mmg->lock);
-		dev_warn(mmg->dev,
-			 "Buff put failed, no match to handle %llu\n", handle);
+		dev_dbg(mmg->dev,
+			 "Buff put failed, no match to handle %#llx\n", handle);
 		return -EINVAL;
 	}
 
@@ -246,7 +246,7 @@ int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
 	buf = hl_mmap_mem_buf_get(mmg, handle);
 	if (!buf) {
 		dev_err(mmg->dev,
-			"Memory mmap failed, no match to handle %llu\n", handle);
+			"Memory mmap failed, no match to handle %#llx\n", handle);
 		return -EINVAL;
 	}
 
-- 
2.25.1

