Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F804C6FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiB1Osf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbiB1OsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:48:07 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF5BFC3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:27 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id r20so17760815ljj.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dODaVYwjD7geqFx/VYp9W8G2RuqYSXTNScA1eN7itG0=;
        b=LZaAe03qJIgVLKW0ROcUF5NtBYIHelCM2LrCq5VA5D5lRnAEbYXzNSRTOTJo2qQT4s
         I/JDuliC/5lLGARf5qXerJN94Fzlhycn7DfMGj02lslArMjroM8pgQqhwPF+7fxPMyyX
         SxjeJXuWbWneu83tRzDRi6vvT0Ao6MQ0Bu0H8jviuPVMswymwSAV/56jUNJMRMskVNi8
         Vd5R2NgXMKDo8W1b2RzoTpcmzN8j7CWzWXIh9GcDRZqJ8EvXRwchvWYVnYsZMZ7xH5Kt
         cq+9OgOWhVBbttHtUGT5clurr92m4ch4lNgaGqN9oQWZ+149WJdDIWha7kQ63s17EvBB
         MhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dODaVYwjD7geqFx/VYp9W8G2RuqYSXTNScA1eN7itG0=;
        b=xZN16GGJbdMkEBui2cveFvoId/Yk0IF19Y3PrWH7T0trSEIwoLw+RSidtOm0tdAYNt
         iMilZwHphA35TiLS5dRLmhWQcwXVX8BHGm+8G4cY4nUVSRL8GpYHTQGqWKeVVonNlyFa
         etGq7vUcdPHyj1cAPR8qaKZG0bXIpPvjVyjmo0Fa5qHbVS1aUc50204iVW2OZUCNBtnO
         pOYWSmdyX6hIenPvz7a0wTlVnNAMf5ssjJGgVt0Ab5T8QWKQOFUrkoPWdgE5jnROdt1x
         2NgHsKNJOAZc8XogtSI6euawsykCNV2FP00S7FVOe4ZqldaLqU2e7Yq2vU4v3RxgrPjU
         IOlQ==
X-Gm-Message-State: AOAM530Nf1bdE0e3PSicve0wlTqoJB2erxwy4ltuHJYGKAlngvotBfV6
        czfpU+I3qV+brVJu/bmCcUE=
X-Google-Smtp-Source: ABdhPJzvP0DsMR+uBiVybsUZ/9RqLjAPnDO5Uwmg2UTv5N8cZp0XtxXxyIrbL5MaQ4F5xC+2mT0uDg==
X-Received: by 2002:a2e:954:0:b0:241:73c:cb5e with SMTP id 81-20020a2e0954000000b00241073ccb5emr14833424ljj.86.1646059645459;
        Mon, 28 Feb 2022 06:47:25 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-165-244.toya.net.pl. [31.183.165.244])
        by smtp.gmail.com with ESMTPSA id r14-20020ac252ae000000b00443f3cbc03asm993996lfm.6.2022.02.28.06.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:47:25 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     rppt@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 6/9] memblock tests: Add memblock_alloc_from tests for bottom up
Date:   Mon, 28 Feb 2022 15:46:48 +0100
Message-Id: <506cf5293c8a21c012b7ea87b14af07754d3e656.1646055639.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1646055639.git.karolinadrobnik@gmail.com>
References: <cover.1646055639.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add checks for memblock_alloc_from for bottom up allocation direction.
The tested scenarios are:
  - Not enough space to allocate memory at the minimal address
  - Minimal address parameter is smaller than the start address
    of the available memory
  - Minimal address parameter is too close to the end of the available
    memory

Add test case wrappers to test both directions in the same context.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 .../memblock/tests/alloc_helpers_api.c        | 175 +++++++++++++++++-
 1 file changed, 171 insertions(+), 4 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
index dc5152adcc5b..963a966db461 100644
--- a/tools/testing/memblock/tests/alloc_helpers_api.c
+++ b/tools/testing/memblock/tests/alloc_helpers_api.c
@@ -209,16 +209,183 @@ static int alloc_from_top_down_min_addr_cap_check(void)
 	return 0;
 }

-int memblock_alloc_helpers_checks(void)
+/*
+ * A test that tries to allocate a memory region above an address that is too
+ * close to the end of the memory:
+ *
+ *                             +
+ *  |-----------+              +     |
+ *  |    rgn    |              |     |
+ *  +-----------+--------------+-----+
+ *  ^                          ^
+ *  |                          |
+ *  Aligned address            min_addr
+ *  boundary
+ *
+ * Expect to prioritize granting memory over satisfying the minimal address
+ * requirement. Allocation happens at beginning of the available memory.
+ */
+static int alloc_from_bottom_up_high_addr_check(void)
 {
-	reset_memblock_attributes();
-	dummy_physical_memory_init();
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+
+	phys_addr_t size = SZ_32;
+	phys_addr_t min_addr;
+
+	setup_memblock();
+
+	/* The address is too close to the end of the memory */
+	min_addr = memblock_end_of_DRAM() - SZ_8;
+
+	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
+
+	assert(allocated_ptr);
+	assert(rgn->size == size);
+	assert(rgn->base == memblock_start_of_DRAM());
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}

+/*
+ * A test that tries to allocate a memory region when there is no space
+ * available above the minimal address above a certain address:
+ *
+ *                   +
+ *  |-----------+    +-------------------|
+ *  |    rgn    |    |                   |
+ *  +-----------+----+-------------------+
+ *                   ^
+ *                   |
+ *                   min_addr
+ *
+ * Expect to prioritize granting memory over satisfying the minimal address
+ * requirement and to allocate at the beginning of the available memory.
+ */
+static int alloc_from_bottom_up_no_space_above_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+
+	phys_addr_t r1_size = SZ_64;
+	phys_addr_t min_addr;
+	phys_addr_t r2_size;
+
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() + SZ_128;
+	r2_size = memblock_end_of_DRAM() - min_addr;
+
+	/* No space above this address */
+	memblock_reserve(min_addr - SMP_CACHE_BYTES, r2_size);
+
+	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
+
+	assert(allocated_ptr);
+	assert(rgn->base == memblock_start_of_DRAM());
+	assert(rgn->size == r1_size);
+
+	assert(memblock.reserved.cnt == 2);
+	assert(memblock.reserved.total_size == r1_size + r2_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region with a minimal address below
+ * the start address of the available memory. Expect to allocate a region
+ * at the beginning of the available memory.
+ */
+static int alloc_from_bottom_up_min_addr_cap_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+
+	phys_addr_t r1_size = SZ_64;
+	phys_addr_t min_addr;
+	phys_addr_t start_addr;
+
+	setup_memblock();
+
+	start_addr = (phys_addr_t)memblock_start_of_DRAM();
+	min_addr = start_addr - SMP_CACHE_BYTES * 3;
+
+	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
+
+	assert(allocated_ptr);
+	assert(rgn->base == start_addr);
+	assert(rgn->size == r1_size);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == r1_size);
+
+	return 0;
+}
+
+/* Test case wrappers */
+static int alloc_from_simple_check(void)
+{
+	memblock_set_bottom_up(false);
+	alloc_from_simple_generic_check();
+	memblock_set_bottom_up(true);
 	alloc_from_simple_generic_check();
+
+	return 0;
+}
+
+static int alloc_from_misaligned_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_from_misaligned_generic_check();
+	memblock_set_bottom_up(true);
+	alloc_from_misaligned_generic_check();
+
+	return 0;
+}
+
+static int alloc_from_high_addr_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_from_top_down_high_addr_check();
-	alloc_from_top_down_min_addr_cap_check();
+	memblock_set_bottom_up(true);
+	alloc_from_bottom_up_high_addr_check();
+
+	return 0;
+}
+
+static int alloc_from_no_space_above_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_from_top_down_no_space_above_check();
+	memblock_set_bottom_up(true);
+	alloc_from_bottom_up_no_space_above_check();
+
+	return 0;
+}
+
+static int alloc_from_min_addr_cap_check(void)
+{
+	memblock_set_bottom_up(false);
+	alloc_from_top_down_min_addr_cap_check();
+	memblock_set_bottom_up(true);
+	alloc_from_bottom_up_min_addr_cap_check();
+
+	return 0;
+}
+
+int memblock_alloc_helpers_checks(void)
+{
+	reset_memblock_attributes();
+	dummy_physical_memory_init();
+
+	alloc_from_simple_check();
+	alloc_from_misaligned_check();
+	alloc_from_high_addr_check();
+	alloc_from_no_space_above_check();
+	alloc_from_min_addr_cap_check();

 	dummy_physical_memory_cleanup();

--
2.30.2

