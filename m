Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70564A6F81
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbiBBLEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343699AbiBBLEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:04:06 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AB4C061756
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:04:05 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o12so39786145lfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1q+vnglpO2PDv2QmjtSXkjrsf77H3g2pU/xh3PtXsQ=;
        b=Y+DAZbn7eBikKhOJb2t9zhFEsRzaD/h+bqx/Rt2MsDKzuKW0hfWPa/iUULVUEg5/9Y
         vayvDgZsNytsm/a4RYCcGjgx6D2Ki+NxDyLZqHqHkD6NLji62qaHhU2IsovYrlTNTZwf
         ah3Na4V51uQhxKaDgrpet+o/CbIf6Vy8Lvrf2Sb689tp8f4nrGar8tMcgA/f7GrKRg+O
         7Wh07HNSJNbIvSQifSN8mGTCwWFkSUKFPPUgpUjo9gsmdR4JFJVnuh1guvOe9wgOlrYk
         Vq5ZuOF4JZ2qKIPuwgDWbVDcTLTTWIALK2SnkyLuGcFheUP0jGY9pMNc4V7pZ5vF74/K
         anig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1q+vnglpO2PDv2QmjtSXkjrsf77H3g2pU/xh3PtXsQ=;
        b=3+vFGOI/4qZoTENadkHGYLvKLV0/zHRbJ83IIYMWDyrknGTeV8Qo9M9FT+WnkirH5f
         l5j702eZTAMKc/j44SIOWyNGLVDu3EmBrKFVV2lY2FlS14PzeSYnQNg+YuwjpVkP+P9d
         Qy08E24q/yYa0q1iP5Sr6x8e5k/jMO5Fq5rC/vRNbfQCR9ZfxNXRofAVk15DiB55Hzmg
         PdtPUSJW8P6W0QZ78i699J537XvmA7i0/PCpztaq7qssTjKeTxar1RTXL7bVR+/hzwf8
         MZRH1DvRufxtD3VdWUG8tZpKrHIyhQNw8qMzwk/KqE97cg14A+58NdYfSBh5znLLGPqb
         aFgA==
X-Gm-Message-State: AOAM532kLIczpFadiu3hgVh6Bj3qCfLHLD8Rra+FC8tedZS53YzbM0rR
        +xtJ6aV6/a8ke447ni+qz5mJXwa78Xk=
X-Google-Smtp-Source: ABdhPJzi0lUvtnDJD5AmL/bTe3Q4E9I6wrM8gyW0zCmvqqg+iKWlNqrCmdOtXcEnFhBybVQl3/IIbw==
X-Received: by 2002:ac2:4e0c:: with SMTP id e12mr22803927lfr.437.1643799844101;
        Wed, 02 Feb 2022 03:04:04 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:04:03 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 12/16] memblock tests: Add memblock_add tests
Date:   Wed,  2 Feb 2022 12:03:11 +0100
Message-Id: <b6c26525025bccec0bf7419473d4d1293eb82b3b.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
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

