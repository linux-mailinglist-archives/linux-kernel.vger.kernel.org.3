Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4C449E34D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241986AbiA0NXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241809AbiA0NXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:23:01 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6C9C06175A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:59 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e9so4317564ljq.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1q+vnglpO2PDv2QmjtSXkjrsf77H3g2pU/xh3PtXsQ=;
        b=dBoiU1gV4FcN5h0v1+Ht5FHOoXQeAL25AFLxoz/HhI1aTyz+dzrdmjyM7KgAfIU5Kx
         +Oh+BJYNSfMgfqiBCxlizwUauGa9t1H5FoBokNBdRNGJTcPuBEYEb+1cM2wYoy++6f1b
         m64NXmz+zWb9MT8KE86VJUuJZLnCuetMwLTfXD/z6Ubfa+uEQFGUx1YFJN19tSuVzK6s
         IXIAT5iYtQbpXAseRn9OR7Hw/ktnnNS5UdBBZeZd1r9myqhRsu+DxZ0FP89/q855f8+c
         66yZY6kGbao2rU8l6Kt4Ek2OMeIWkEggjjZhcri0DbF9a68H26pKvlIFqHfx6wb/ZFL9
         xgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1q+vnglpO2PDv2QmjtSXkjrsf77H3g2pU/xh3PtXsQ=;
        b=kiaIv8Fo65pO+cvXCsYo1bMOj4C2Qgn4OLbv4XSnmoaohSmQ1A+Dt+9AJeS6amwUCS
         10StlCvxs3SQXd0av4nNvE5haZ8MtEgSP/HbMhD4qEfutIgeLxaGjJOmyngy/lJMKBg/
         pGwZxz3AfYN8e2S/LlgygMWf/swprnjhiPlRXren06vWI9ptA1ep8P1WQmc0AnqSDhCA
         vJeeFxmSM8UGufVYNwiUE9LffjMjKv38PmYSQHjuek8Cuyli/N7ZqQeA0AJ5l32D3yDw
         X6JeefwJSoXKBJuJQuSL4n70gMU7UT5t6DbeUKcpJkJxV9/pEC90liU9ezqA85nSriCE
         Ynsw==
X-Gm-Message-State: AOAM532xbYOrPOzsszEx/wjiUFfO1Z80oEnCSawiJhdrtYB8eb9sNj5S
        oQkxBZXyu98GEld88GI3ATw=
X-Google-Smtp-Source: ABdhPJyW21GLrmtKSmGHnLJmdJ5DP3VKdlko5bJTSPTxdviTYdSWzSMpaEY/E2uPRqOTTYtWphLnWg==
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr2842965ljk.19.1643289777871;
        Thu, 27 Jan 2022 05:22:57 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:22:57 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 12/16] memblock tests: Add memblock_add tests
Date:   Thu, 27 Jan 2022 14:21:30 +0100
Message-Id: <13745fec282f5c96d39faea7cac8e034abbbfd5c.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add checks for adding a new region in different scenarios:
 - The region does not overlap with existing entries
 - The region overlaps with one of the previous entries: from the top
  (its end address is bigger than the base of the existing region) or
  from the bottom (its base address is smaller than the end address of
  one of the regions)
 - The region is within an already defined region
 - The same region is added twice to the collection of available memory
   regions

Add checks for memblock initialization to verify it sets memblock data
structures to expected values.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 215 +++++++++++++++++++++++
 1 file changed, 215 insertions(+)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 7f2597b3dd4d..6c047b7b31ab 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <string.h>
 #include <linux/memblock.h>
+#include <linux/sizes.h>
 #include "basic_api.h"
 
 #define EXPECTED_MEMBLOCK_REGIONS			128
@@ -25,8 +26,222 @@ static int memblock_initialization_check(void)
 	return 0;
 }
 
+/*
+ * A simple test that adds a memory block of a specified base address
+ * and size to the collection of available memory regions (memblock.memory).
+ * It checks if a new entry was created and if region counter and total memory
+ * were correctly updated.
+ */
+static int memblock_add_simple_check(void)
+{
+	struct memblock_region *rgn;
+
+	rgn = &memblock.memory.regions[0];
+
+	struct region r = {
+		.base = SZ_1G,
+		.size = SZ_4M
+	};
+
+	reset_memblock();
+	memblock_add(r.base, r.size);
+
+	assert(rgn->base == r.base);
+	assert(rgn->size == r.size);
+
+	assert(memblock.memory.cnt == 1);
+	assert(memblock.memory.total_size == r.size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to add two memory blocks that don't overlap with one another.
+ * It checks if two correctly initialized entries were added to the collection
+ * of available memory regions (memblock.memory) and if this change was reflected
+ * in memblock.memory's total size and region counter.
+ */
+static int memblock_add_disjoint_check(void)
+{
+	struct memblock_region *rgn1, *rgn2;
+
+	rgn1 = &memblock.memory.regions[0];
+	rgn2 = &memblock.memory.regions[1];
+
+	struct region r1 = {
+		.base = SZ_1G,
+		.size = SZ_8K
+	};
+	struct region r2 = {
+		.base = SZ_1G + SZ_16K,
+		.size = SZ_8K
+	};
+
+	reset_memblock();
+	memblock_add(r1.base, r1.size);
+	memblock_add(r2.base, r2.size);
+
+	assert(rgn1->base == r1.base);
+	assert(rgn1->size == r1.size);
+
+	assert(rgn2->base == r2.base);
+	assert(rgn2->size == r2.size);
+
+	assert(memblock.memory.cnt == 2);
+	assert(memblock.memory.total_size == r1.size + r2.size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to add two memory blocks, where the second one overlaps
+ * with the beginning of the first entry (that is r1.base < r2.base + r2.size).
+ * After this, it checks if two entries are merged into one region that starts
+ * at r2.base and has size of two regions minus their intersection. It also
+ * verifies the reported total size of the available memory and region counter.
+ */
+static int memblock_add_overlap_top_check(void)
+{
+	struct memblock_region *rgn;
+	phys_addr_t total_size;
+
+	rgn = &memblock.memory.regions[0];
+
+	struct region r1 = {
+		.base = SZ_512M,
+		.size = SZ_1G
+	};
+	struct region r2 = {
+		.base = SZ_256M,
+		.size = SZ_512M
+	};
+
+	total_size = (r1.base - r2.base) + r1.size;
+
+	reset_memblock();
+	memblock_add(r1.base, r1.size);
+	memblock_add(r2.base, r2.size);
+
+	assert(rgn->base == r2.base);
+	assert(rgn->size == total_size);
+
+	assert(memblock.memory.cnt == 1);
+	assert(memblock.memory.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to add two memory blocks, where the second one overlaps
+ * with the end of the first entry (that is r2.base < r1.base + r1.size).
+ * After this, it checks if two entries are merged into one region that starts
+ * at r1.base and has size of two regions minus their intersection. It verifies
+ * that memblock can still see only one entry and has a correct total size of
+ * the available memory.
+ */
+static int memblock_add_overlap_bottom_check(void)
+{
+	struct memblock_region *rgn;
+	phys_addr_t total_size;
+
+	rgn = &memblock.memory.regions[0];
+
+	struct region r1 = {
+		.base = SZ_128M,
+		.size = SZ_512M
+	};
+	struct region r2 = {
+		.base = SZ_256M,
+		.size = SZ_1G
+	};
+
+	total_size = (r2.base - r1.base) + r2.size;
+
+	reset_memblock();
+	memblock_add(r1.base, r1.size);
+	memblock_add(r2.base, r2.size);
+
+	assert(rgn->base == r1.base);
+	assert(rgn->size == total_size);
+
+	assert(memblock.memory.cnt == 1);
+	assert(memblock.memory.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to add two memory blocks, where the second one is
+ * within the range of the first entry (that is r1.base < r2.base &&
+ * r2.base + r2.size < r1.base + r1.size). It checks if two entries are merged
+ * into one region that stays the same. The counter and total size of available
+ * memory are expected to not be updated.
+ */
+static int memblock_add_within_check(void)
+{
+	struct memblock_region *rgn;
+
+	rgn = &memblock.memory.regions[0];
+
+	struct region r1 = {
+		.base = SZ_8M,
+		.size = SZ_32M
+	};
+	struct region r2 = {
+		.base = SZ_16M,
+		.size = SZ_1M
+	};
+
+	reset_memblock();
+	memblock_add(r1.base, r1.size);
+	memblock_add(r2.base, r2.size);
+
+	assert(rgn->base == r1.base);
+	assert(rgn->size == r1.size);
+
+	assert(memblock.memory.cnt == 1);
+	assert(memblock.memory.total_size == r1.size);
+
+	return 0;
+}
+
+/*
+ * A simple test that tries to add the same memory block twice. The counter
+ * and total size of available memory are expected to not be updated.
+ */
+static int memblock_add_twice_check(void)
+{
+	struct region r = {
+		.base = SZ_16K,
+		.size = SZ_2M
+	};
+
+	reset_memblock();
+
+	memblock_add(r.base, r.size);
+	memblock_add(r.base, r.size);
+
+	assert(memblock.memory.cnt == 1);
+	assert(memblock.memory.total_size == r.size);
+
+	return 0;
+}
+
+static int memblock_add_checks(void)
+{
+	memblock_add_simple_check();
+	memblock_add_disjoint_check();
+	memblock_add_overlap_top_check();
+	memblock_add_overlap_bottom_check();
+	memblock_add_within_check();
+	memblock_add_twice_check();
+
+	return 0;
+}
+
 int memblock_basic_checks(void)
 {
 	memblock_initialization_check();
+	memblock_add_checks();
 	return 0;
 }
-- 
2.30.2

