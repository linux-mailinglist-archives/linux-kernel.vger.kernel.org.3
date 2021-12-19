Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E54947A144
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbhLSQMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:12:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42174 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbhLSQMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:12:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43514B80C99
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 16:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF36C36AE7;
        Sun, 19 Dec 2021 16:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639930355;
        bh=UMovWI4dCc2XVcWwE0TxAIku7SlyPjncbxMxOuEyBPo=;
        h=From:To:Cc:Subject:Date:From;
        b=BbrSpgRiNHXTIbf6KXVMKe58TV0q3Qvt6kgy2ORfH2neGNDmb3WdJu05R+HBac710
         5rF5nezX4urITaWIyUxZupMLEshpHwxAYfUxcJTYBdQeuvbf6x5BOZSwrLR1TUQXrI
         KlfliHtLiPVNJqcIgOfrQi6e/fxRL8GRsWURKbLJyCzJi/mNNNPmPAQIDddoQeUp3p
         V8pivWrqwIsqCsNT/crgb1zjb3tWHu8rnKLfrM05r1tfjW6SurVmeR8zGmsgdn5XkK
         XBDXQNTLACtR/J6BcaMnvWm3QxUgy9WSa3zQC8vI8JGA0f+FRNOjEFVukY4mbpYvU/
         UMPhGx1D7WxDA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs: fix comments according to kernel-doc
Date:   Sun, 19 Dec 2021 18:12:29 +0200
Message-Id: <20211219161230.2674012-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Fix missing fields, descriptions not according to kernel-doc style.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 315594e96dcd..e5f7b23cbf94 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -518,7 +518,7 @@ static int add_va_block_locked(struct hl_device *hdev,
 /**
  * add_va_block() - wrapper for add_va_block_locked.
  * @hdev: pointer to the habanalabs device structure.
- * @va_list: pointer to the virtual addresses block list.
+ * @va_range: pointer to the virtual addresses range object.
  * @start: start virtual address.
  * @end: end virtual address.
  *
@@ -538,8 +538,11 @@ static inline int add_va_block(struct hl_device *hdev,
 }
 
 /**
- * is_hint_crossing_range() - check if hint address crossing specified reserved
- * range.
+ * is_hint_crossing_range() - check if hint address crossing specified reserved.
+ * @range_type: virtual space range type.
+ * @start_addr: start virtual address.
+ * @size: block size.
+ * @prop: asic properties structure to retrieve reserved ranges from.
  */
 static inline bool is_hint_crossing_range(enum hl_va_range_type range_type,
 		u64 start_addr, u32 size, struct asic_fixed_properties *prop) {
@@ -749,6 +752,7 @@ u64 hl_reserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
 
 /**
  * hl_get_va_range_type() - get va_range type for the given address and size.
+ * @ctx: context to fetch va_range from.
  * @address: the start address of the area we want to validate.
  * @size: the size in bytes of the area we want to validate.
  * @type: returned va_range type.
@@ -776,8 +780,8 @@ static int hl_get_va_range_type(struct hl_ctx *ctx, u64 address, u64 size,
  * hl_unreserve_va_block() - wrapper for add_va_block to unreserve a va block.
  * @hdev: pointer to the habanalabs device structure
  * @ctx: pointer to the context structure.
- * @start: start virtual address.
- * @end: end virtual address.
+ * @start_addr: start virtual address.
+ * @size: number of bytes to unreserve.
  *
  * This function does the following:
  * - Takes the list lock and calls add_va_block_locked.
@@ -2329,6 +2333,8 @@ void hl_userptr_delete_list(struct hl_device *hdev,
 /**
  * hl_userptr_is_pinned() - returns whether the given userptr is pinned.
  * @hdev: pointer to the habanalabs device structure.
+ * @addr: user address to check.
+ * @size: user block size to check.
  * @userptr_list: pointer to the list to clear.
  * @userptr: pointer to userptr to check.
  *
@@ -2351,9 +2357,10 @@ bool hl_userptr_is_pinned(struct hl_device *hdev, u64 addr,
 /**
  * va_range_init() - initialize virtual addresses range.
  * @hdev: pointer to the habanalabs device structure.
- * @va_range: pointer to the range to initialize.
+ * @va_ranges: pointer to va_ranges array.
  * @start: range start address.
  * @end: range end address.
+ * @page_size: page size for this va_range.
  *
  * This function does the following:
  * - Initializes the virtual addresses list of the given range with the given
@@ -2410,7 +2417,7 @@ static int va_range_init(struct hl_device *hdev, struct hl_va_range *va_range,
 /**
  * va_range_fini() - clear a virtual addresses range.
  * @hdev: pointer to the habanalabs structure.
- * va_range: pointer to virtual addresses rang.e
+ * @va_range: pointer to virtual addresses range.
  *
  * This function does the following:
  * - Frees the virtual addresses block list and its lock.
@@ -2430,12 +2437,15 @@ static void va_range_fini(struct hl_device *hdev, struct hl_va_range *va_range)
  * @ctx: pointer to the habanalabs context structure.
  * @host_range_start: host virtual addresses range start.
  * @host_range_end: host virtual addresses range end.
+ * @host_page_size: host page size.
  * @host_huge_range_start: host virtual addresses range start for memory
  *                         allocated with huge pages.
  * @host_huge_range_end: host virtual addresses range end for memory allocated
  *                        with huge pages.
+ * @host_huge_page_size: host huge page size.
  * @dram_range_start: dram virtual addresses range start.
  * @dram_range_end: dram virtual addresses range end.
+ * @dram_page_size: dram page size.
  *
  * This function initializes the following:
  * - MMU for context.
-- 
2.25.1

