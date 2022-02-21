Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62274BDEC9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbiBUItq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:49:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344733AbiBUItp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:49:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA25F64
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:49:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8255FB80EA4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D18C340E9;
        Mon, 21 Feb 2022 08:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645433360;
        bh=Ivw0NsQskNBHf+264YMprTGyWc6YAjXP78iaL0XFMEc=;
        h=From:To:Cc:Subject:Date:From;
        b=B+ml5vB+/PlOLSyHpP+rn7YZ+DOmm6OpSN7qTOYIVswUIZ90RtA5VUqgfj9A85+HB
         RmO2u1BAswFfDo8vjij1KsRIim/f6TTufTZVRpUTYh7wWeJQ5sh36E/ul+/I1wOwWT
         yP+wRe7EDb2H8PR9qLMqxIMvNdyvGang09Q/nHCUMzDJA5f6gdqh4hL/9LyWPcs3i6
         A5sJXHx1z2VCJdZpErOigHdlL+h947H/MJynbTCo3m4AynTZqYRArnlaXmfgr8PDJI
         EI+Z6N0tu/SJJSVmiul9rSqWUuxxN44qgqX+iCNHnvsWNCNXQ6NtlInJ40lO/KgtOK
         fYMVqQ5v19ntw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/2] habanalabs: make sure device mem alloc is page aligned
Date:   Mon, 21 Feb 2022 10:49:13 +0200
Message-Id: <20220221084914.493784-1-ogabbay@kernel.org>
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

Working with MMU that supports multiple page sizes requires that mapping
of a page of a certain size will be aligned to the same size (e.g. the
physical address of 32MB page shall be aligned to 32MB).

To achieve this the gen_poll allocation is now using the "align" variant
to comply with the alignment requirements.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 385bf3448c73..0b76f40e9930 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -90,8 +90,8 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
 	u64 paddr = 0, total_size, num_pgs, i;
 	u32 num_curr_pgs, page_size;
-	int handle, rc;
 	bool contiguous;
+	int handle, rc;
 
 	num_curr_pgs = 0;
 
@@ -110,7 +110,11 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 	contiguous = args->flags & HL_MEM_CONTIGUOUS;
 
 	if (contiguous) {
-		paddr = (u64) gen_pool_alloc(vm->dram_pg_pool, total_size);
+		if (is_power_of_2(page_size))
+			paddr = (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool, total_size, NULL,
+							page_size);
+		else
+			paddr = (u64) gen_pool_alloc(vm->dram_pg_pool, total_size);
 		if (!paddr) {
 			dev_err(hdev->dev,
 				"failed to allocate %llu contiguous pages with total size of %llu\n",
@@ -144,9 +148,14 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 			phys_pg_pack->pages[i] = paddr + i * page_size;
 	} else {
 		for (i = 0 ; i < num_pgs ; i++) {
-			phys_pg_pack->pages[i] = (u64) gen_pool_alloc(
-							vm->dram_pg_pool,
-							page_size);
+			if (is_power_of_2(page_size))
+				phys_pg_pack->pages[i] =
+						(u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
+										page_size, NULL,
+										page_size);
+			else
+				phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
+										page_size);
 			if (!phys_pg_pack->pages[i]) {
 				dev_err(hdev->dev,
 					"Failed to allocate device memory (out of memory)\n");
-- 
2.25.1

