Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194ED4C6FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbiB1OsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiB1OsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:48:05 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDA11274A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:25 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j15so21733221lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XkoCnBAa1JQTAcVmjm2BwcgOzEHkTWH89xocRiPiPBg=;
        b=LBgcJev33Ch2AEoI2UMdD5pREGd2zs6uuwnvr6zMARc7EMkwD9thjxbpOuo4EGFs0J
         9IXjHzWYVF2QefyoTy8bBvxJKKF2Dt3xIhrEf5DenGVQpiWp/AVuYA7QxR/TMXRhH9jN
         vKDWhqgThxWzbJYOCwXsMTN9xUi8Q0z3rIPZTY7NCZutlxh65VKDzwdfWJojebJavxBh
         EsSRlz59rgY5hw/gVXvhsSG94BnQjHUUCb1As2WV95+0+fk66HPOLGvjcu8vsZQ6IAhF
         x0RoGBiGmhY9r0p/R2p7A1Z3k29zAW5qH9RyS4pJqy8YFaFJc38nUUY59mfIDxq5B/mi
         qifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XkoCnBAa1JQTAcVmjm2BwcgOzEHkTWH89xocRiPiPBg=;
        b=Xa6/XnHC1AoDKJVqCDX4Kl09YCKBi8yXWeG9SoLtRqTuCHTmiivdVRu0noi31cglhq
         gm6c8JiLD5kb6bMUtYONxAWzL6uiKBfaRsbTKle8kjgj5z3fp22Es5OhoIKWcsVIDMHl
         LFo3FkJ/gcFOYbUnuZZvdnDOoVahV6Gx1XYfvnYVskF7hYibxBgE5ijK6L/NK+lUaDVf
         zMU/dE+1PYuOqlj6Tc2t9itw5Gas8luvC6Mr4oYz990JHR9uDdpnDItHk9gKycIM+rOU
         1DiKrlQblEKuouVn/qeaNBPpRtqLv8w4Gnom8lKG8jLFY+pnNbwjQuIuKsIxm+CUIPqE
         mFwQ==
X-Gm-Message-State: AOAM533HOxkCHkI7GCXnL/glHvhWg4y4nT86toNWJAQOW7RNCKg9khaL
        L0aJfLKPxYBiwwRkdCo8n40=
X-Google-Smtp-Source: ABdhPJz7hQFnuMCEY4QgmJAVggE8tnUUqMH8h47VTQ24mhLVyCDoGjP2dP5SiJSEys0cBw4BMySiUw==
X-Received: by 2002:a05:6512:3a95:b0:443:1624:3be1 with SMTP id q21-20020a0565123a9500b0044316243be1mr12829384lfu.355.1646059643992;
        Mon, 28 Feb 2022 06:47:23 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-165-244.toya.net.pl. [31.183.165.244])
        by smtp.gmail.com with ESMTPSA id r14-20020ac252ae000000b00443f3cbc03asm993996lfm.6.2022.02.28.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:47:23 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     rppt@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 5/9] memblock tests: Add memblock_alloc_from tests for top down
Date:   Mon, 28 Feb 2022 15:46:47 +0100
Message-Id: <3dd645f437975fd393010b95b8faa85d2b86490a.1646055639.git.karolinadrobnik@gmail.com>
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

Add checks for memblock_alloc_from for default allocation direction.
The tested scenarios are:
  - Not enough space to allocate memory at the minimal address
  - Minimal address parameter is smaller than the start address
    of the available memory
  - Minimal address is too close to the available memory

Add simple memblock_alloc_from test that can be used to test both
allocation directions (minimal address is aligned or misaligned).

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/testing/memblock/Makefile               |   3 +-
 tools/testing/memblock/main.c                 |   2 +
 .../memblock/tests/alloc_helpers_api.c        | 226 ++++++++++++++++++
 .../memblock/tests/alloc_helpers_api.h        |   9 +
 4 files changed, 239 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/memblock/tests/alloc_helpers_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_helpers_api.h

diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
index 5b01cfd808d0..89e374470009 100644
--- a/tools/testing/memblock/Makefile
+++ b/tools/testing/memblock/Makefile
@@ -6,7 +6,8 @@ CFLAGS += -I. -I../../include -Wall -O2 -fsanitize=address \
 	  -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT
 LDFLAGS += -fsanitize=address -fsanitize=undefined
 TARGETS = main
-TEST_OFILES = tests/alloc_api.o tests/basic_api.o tests/common.o
+TEST_OFILES = tests/alloc_helpers_api.o tests/alloc_api.o tests/basic_api.o \
+	      tests/common.o
 DEP_OFILES = memblock.o lib/slab.o mmzone.o slab.o
 OFILES = main.o $(DEP_OFILES) $(TEST_OFILES)
 EXTR_SRC = ../../../mm/memblock.c
diff --git a/tools/testing/memblock/main.c b/tools/testing/memblock/main.c
index e7cc45dc06d4..b63150ee554f 100644
--- a/tools/testing/memblock/main.c
+++ b/tools/testing/memblock/main.c
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include "tests/basic_api.h"
 #include "tests/alloc_api.h"
+#include "tests/alloc_helpers_api.h"
 
 int main(int argc, char **argv)
 {
 	memblock_basic_checks();
 	memblock_alloc_checks();
+	memblock_alloc_helpers_checks();
 
 	return 0;
 }
diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
new file mode 100644
index 000000000000..dc5152adcc5b
--- /dev/null
+++ b/tools/testing/memblock/tests/alloc_helpers_api.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "alloc_helpers_api.h"
+
+/*
+ * A simple test that tries to allocate a memory region above a specified,
+ * aligned address:
+ *
+ *             +
+ *  |          +-----------+         |
+ *  |          |    rgn    |         |
+ *  +----------+-----------+---------+
+ *             ^
+ *             |
+ *             Aligned min_addr
+ *
+ * Expect to allocate a cleared region at the minimal memory address.
+ */
+static int alloc_from_simple_generic_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	char *b;
+
+	phys_addr_t size = SZ_16;
+	phys_addr_t min_addr;
+
+	setup_memblock();
+
+	min_addr = memblock_end_of_DRAM() - SMP_CACHE_BYTES;
+
+	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
+	b = (char *)allocated_ptr;
+
+	assert(allocated_ptr);
+	assert(*b == 0);
+
+	assert(rgn->size == size);
+	assert(rgn->base == min_addr);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region above a certain address.
+ * The minimal address here is not aligned:
+ *
+ *         +      +
+ *  |      +      +---------+            |
+ *  |      |      |   rgn   |            |
+ *  +------+------+---------+------------+
+ *         ^      ^------.
+ *         |             |
+ *       min_addr        Aligned address
+ *                       boundary
+ *
+ * Expect to allocate a cleared region at the closest aligned memory address.
+ */
+static int alloc_from_misaligned_generic_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	char *b;
+
+	phys_addr_t size = SZ_32;
+	phys_addr_t min_addr;
+
+	setup_memblock();
+
+	/* A misaligned address */
+	min_addr = memblock_end_of_DRAM() - (SMP_CACHE_BYTES * 2 - 1);
+
+	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
+	b = (char *)allocated_ptr;
+
+	assert(allocated_ptr);
+	assert(*b == 0);
+
+	assert(rgn->size == size);
+	assert(rgn->base == memblock_end_of_DRAM() - SMP_CACHE_BYTES);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region above an address that is too
+ * close to the end of the memory:
+ *
+ *              +        +
+ *  |           +--------+---+      |
+ *  |           |   rgn  +   |      |
+ *  +-----------+--------+---+------+
+ *              ^        ^
+ *              |        |
+ *              |        min_addr
+ *              |
+ *              Aligned address
+ *              boundary
+ *
+ * Expect to prioritize granting memory over satisfying the minimal address
+ * requirement.
+ */
+static int alloc_from_top_down_high_addr_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+
+	phys_addr_t size = SZ_32;
+	phys_addr_t min_addr;
+
+	setup_memblock();
+
+	/* The address is too close to the end of the memory */
+	min_addr = memblock_end_of_DRAM() - SZ_16;
+
+	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
+
+	assert(allocated_ptr);
+	assert(rgn->size == size);
+	assert(rgn->base == memblock_end_of_DRAM() - SMP_CACHE_BYTES);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region when there is no space
+ * available above the minimal address above a certain address:
+ *
+ *                     +
+ *  |        +---------+-------------|
+ *  |        |   rgn   |             |
+ *  +--------+---------+-------------+
+ *                     ^
+ *                     |
+ *                     min_addr
+ *
+ * Expect to prioritize granting memory over satisfying the minimal address
+ * requirement and to allocate next to the previously reserved region. The
+ * regions get merged into one.
+ */
+static int alloc_from_top_down_no_space_above_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+
+	phys_addr_t r1_size = SZ_64;
+	phys_addr_t r2_size = SZ_2;
+	phys_addr_t total_size = r1_size + r2_size;
+	phys_addr_t min_addr;
+
+	setup_memblock();
+
+	min_addr = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
+
+	/* No space above this address */
+	memblock_reserve(min_addr, r2_size);
+
+	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
+
+	assert(allocated_ptr);
+	assert(rgn->base == min_addr - r1_size);
+	assert(rgn->size == total_size);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region with a minimal address below
+ * the start address of the available memory. As the allocation is top-down,
+ * first reserve a region that will force allocation near the start.
+ * Expect successful allocation and merge of both regions.
+ */
+static int alloc_from_top_down_min_addr_cap_check(void)
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
+	memblock_reserve(start_addr + r1_size, MEM_SIZE - r1_size);
+
+	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
+
+	assert(allocated_ptr);
+	assert(rgn->base == start_addr);
+	assert(rgn->size == MEM_SIZE);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == MEM_SIZE);
+
+	return 0;
+}
+
+int memblock_alloc_helpers_checks(void)
+{
+	reset_memblock_attributes();
+	dummy_physical_memory_init();
+
+	alloc_from_simple_generic_check();
+	alloc_from_misaligned_generic_check();
+	alloc_from_top_down_high_addr_check();
+	alloc_from_top_down_min_addr_cap_check();
+	alloc_from_top_down_no_space_above_check();
+
+	dummy_physical_memory_cleanup();
+
+	return 0;
+}
diff --git a/tools/testing/memblock/tests/alloc_helpers_api.h b/tools/testing/memblock/tests/alloc_helpers_api.h
new file mode 100644
index 000000000000..c9e4827b1623
--- /dev/null
+++ b/tools/testing/memblock/tests/alloc_helpers_api.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _MEMBLOCK_ALLOC_HELPERS_H
+#define _MEMBLOCK_ALLOC_HELPERS_H
+
+#include "common.h"
+
+int memblock_alloc_helpers_checks(void);
+
+#endif
-- 
2.30.2

