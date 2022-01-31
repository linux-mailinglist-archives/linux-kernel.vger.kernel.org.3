Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2914A4B30
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379983AbiAaQDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:03:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55936 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379977AbiAaQDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:03:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB79A61463
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B388C340EC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643645012;
        bh=W+EhUhcqdUxgVfhu8IN7oh339ILnyfOGkAmVM9xL+Xw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bzEaXdK57kelJQqetef5JpCfanRoaVV5HUbs6UUjithmeNh7e9XT5Gqy5Gw2yL7JL
         RPZISOP60W5LFX64lw1u1LfWDHqgPUl/NWcWVXYXqex7WxBRuisXlLoHd5AyjUUFDk
         hf0xF73Wnp0jsHNzatDLPyqdpljD+DrGwDEKblrYERHwozd3j8MiYy/NtBphNTgnVg
         GSkR+WAStrkQ+BpzufqJ7OYQBW/BAcPxp7iVVNXd7XAfrmqZ2vsJTVnHACgJL+Notx
         4+neB1DTajhq+E1WGKpjVRtuObp4VOD6B8LXTWxo+RVVSQWQZOLiG8HnjdDpbcz5tj
         7RJAup36TXHUg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] habanalabs: fix use-after-free bug
Date:   Mon, 31 Jan 2022 18:03:27 +0200
Message-Id: <20220131160327.3060127-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220131160327.3060127-1-ogabbay@kernel.org>
References: <20220131160327.3060127-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the code iterates over the free list of physical pages nodes, it
deletes the physical page node which is used as the iterator.

Therefore, we need to use the safe version of the iteration to prevent
use-after-free.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 4778f23d8098..348daac621ee 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -2860,7 +2860,7 @@ int hl_vm_ctx_init(struct hl_ctx *ctx)
  */
 void hl_vm_ctx_fini(struct hl_ctx *ctx)
 {
-	struct hl_vm_phys_pg_pack *phys_pg_list;
+	struct hl_vm_phys_pg_pack *phys_pg_list, *tmp_phys_node;
 	struct hl_device *hdev = ctx->hdev;
 	struct hl_vm_hash_node *hnode;
 	struct hl_vm *vm = &hdev->vm;
@@ -2913,7 +2913,7 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 		}
 	spin_unlock(&vm->idr_lock);
 
-	list_for_each_entry(phys_pg_list, &free_list, node)
+	list_for_each_entry_safe(phys_pg_list, tmp_phys_node, &free_list, node)
 		free_phys_pg_pack(hdev, phys_pg_list);
 
 	va_range_fini(hdev, ctx->va_range[HL_VA_RANGE_TYPE_DRAM]);
-- 
2.25.1

