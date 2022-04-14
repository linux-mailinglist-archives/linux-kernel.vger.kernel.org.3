Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F3E500E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243652AbiDNNAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiDNNAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:00:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530E891AC2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7385B82943
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9008FC385A5;
        Thu, 14 Apr 2022 12:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649941069;
        bh=/73mar6yXG41mELYNx1Ct+uRxOy054yFiSndeMEgqOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=rEYbcBXKym+8hemNkNynl05P7tEbvG0pcxS5PgFG/K0BqmK9K1cqQqsXZXyc0A+nA
         0UpTeT/+4Vg5wTLzqiPLItcUN5+ND3voji/YHKaLAlKMAWc4qwAQD2iMGAPI/NXAl0
         vWk8F9Cec7oog4pqxYwSz5gypWUH1fV2OS7nwvgcSj92kXlThBQZQZvKvdUi9WJriJ
         AYpn4RZIzJpJLsS3zhJMLMrSrMyfth4+M2gqVO4SmofG91MTcFVQHqQ9jhgMucPT08
         I/c9EbVXx+hAqCgV6EWWbaLDGUHzE7VpXVjdMsax77QVMEzwpFNaqsj9wa2gQqNBDM
         7z6IpqQndekaw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/2] habanalabs: add prefetch flag to the MAP operation
Date:   Thu, 14 Apr 2022 15:57:43 +0300
Message-Id: <20220414125744.1928306-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: Ohad Sharabi <osharabi@habana.ai>

This patch let the user decide whether the translations done in the
page tables will be fetched directly to the STLB right after the map.

We want to let the user control whether to perform prefetch upon map
operation.

To do so a memory flag was added, to be used in the MAP ioctl, called
HL_MEM_PREFETCH and if set- the mappings will be fetched directly to
the STLB after map operation.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 11 ++++++-----
 include/uapi/misc/habanalabs.h          |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 326c2179628f..6face45c57e3 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1250,11 +1250,12 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	if (rc)
 		goto map_err;
 
-	/* already prefetch the relevant translations to the cache */
-	rc = hl_mmu_prefetch_cache_range(hdev, *vm_type, ctx->asid, ret_vaddr,
-						phys_pg_pack->total_size);
-	if (rc)
-		goto map_err;
+	if (args->flags & HL_MEM_PREFETCH) {
+		rc = hl_mmu_prefetch_cache_range(hdev, *vm_type, ctx->asid, ret_vaddr,
+							phys_pg_pack->total_size);
+		if (rc)
+			goto map_err;
+	}
 
 	mutex_unlock(&ctx->mmu_lock);
 
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index ca2af5f98056..3576bf2b4841 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1134,6 +1134,7 @@ union hl_wait_cs_args {
 #define HL_MEM_SHARED		0x2
 #define HL_MEM_USERPTR		0x4
 #define HL_MEM_FORCE_HINT	0x8
+#define HL_MEM_PREFETCH		0x40
 
 /**
  * structure hl_mem_in - structure that handle input args for memory IOCTL
-- 
2.25.1

