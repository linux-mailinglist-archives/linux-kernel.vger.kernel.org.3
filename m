Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F8F4A6F83
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343916AbiBBLEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343783AbiBBLER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:04:17 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0880DC06175E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:04:12 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b9so39808542lfq.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fXs9Z9PQYCruMdcrfaMtY0ndpO2Xn6EDlt3MZzXYgdU=;
        b=Dba5XaJ4YA9vpc0hY5gn45LFbLkG/VzuAUztdk53/XTRWBh6s761tDC/A3IF9fnCze
         /+glyw8MSR1ID6IHiJ/cnI0y/V9M7hQ9NCNTrfZPzRBvwQrtxytnB2KCDvQb6r+z2RtW
         8622a/Asuu1bjdAq6NmBzW8+bCABmCKpi6MQR4a6GEU2wmDB4ICldMvLYK6rW+8aVrMV
         U+vMKFGCV3OOQYWwqTCQs0qm3T68s0XscVj7YpEbsaA8w9YEzjNveZLPo1W/MMa7l3p6
         6Nck9ktAKT06GNvBgQlvPCzvETxBPW3zCbNi4vOYksN63nFZK57tFMrJPjJLWZF43eUF
         n4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fXs9Z9PQYCruMdcrfaMtY0ndpO2Xn6EDlt3MZzXYgdU=;
        b=Ncf91KMqpoANedy7Scbhs8b9DSX/HRimW2poI51TF9HNHUCdVOgHjLLWC7HUTd4jhA
         bwJZ3OxG8JkOyRGWS7K9QKPEck33brxBTb3UMQq5He53shTH7SjjKJ8j9grSBaLDssol
         9zpFGrCdi8CseczxM8f8mQNxpjQ2AP4mcjK2dvT9L1wZA2aiwtysp9hVfoQ70GAcj+Yn
         OwGSWTI5SgX2SLSpyCUQajmK4+4Hy5dsXpBUoikzl9tdpqRzJ1Dx0vfX92sIA3tSW7UT
         mitYSHO7wiVt4rOYwkuBkYjAMx6TZRYH6S++CU6Ruh4o/cn1EJ8x3DAW3dX4iIgvuovz
         wMzQ==
X-Gm-Message-State: AOAM530JKI7VMFv7VmV0LKBZfoxafZ+gSAQSgCyXVrIcE0AZ0CHkk0y8
        CkVmxAQeVlZdr8JtUcCtIB8=
X-Google-Smtp-Source: ABdhPJxR1zuszDMGjwGZeutMvY35G28bmpwlvPOGrKcn1rCWt6gy9RgtvgaRkVsAv3cFx97J4LRhBA==
X-Received: by 2002:a05:6512:3f99:: with SMTP id x25mr10847382lfa.235.1643799850317;
        Wed, 02 Feb 2022 03:04:10 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:04:09 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 16/16] memblock tests: Add memblock_free tests
Date:   Wed,  2 Feb 2022 12:03:15 +0100
Message-Id: <30af95c82754ad8029404c3b528a5ef1c05d1ed6.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add checks for removing a region from reserved memory in different
scenarios:
 - The requested region matches one in the collection of reserved
   memory regions
 - The requested region does not exist in memblock.reserved
 - The region overlaps with one of the entries: from the top (its
   end address is bigger than the base of the existing region) or
   from the bottom (its base address is smaller than the end address
   of one of the regions)
 - The region is within an already defined region

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 199 +++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 02eb88358a58..568b05b52883 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -686,12 +686,211 @@ static int memblock_remove_checks(void)
 	return 0;
 }
 
+/*
+ * A simple test that tries to free a memory block that was marked earlier as
+ * reserved. By "freeing" a region we mean overwriting it with the next entry
+ * in memblock.reserved. To check this is the case, the test reserves two memory
+ * regions and verifies that the value of the latter was used to erase r1 region.
+ * The test also checks if the region counter and total size were updated.
+ */
+static int memblock_free_simple_check(void)
+{
+	struct memblock_region *rgn;
+
+	rgn = &memblock.reserved.regions[0];
+
+	struct region r1 = {
+		.base = SZ_4M,
+		.size = SZ_1M
+	};
+	struct region r2 = {
+		.base = SZ_8M,
+		.size = SZ_1M
+	};
+
+	reset_memblock();
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+	memblock_free((void *)r1.base, r1.size);
+
+	assert(rgn->base == r2.base);
+	assert(rgn->size == r2.size);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == r2.size);
+
+	return 0;
+}
+
+ /*
+  * A test that tries to free a region that was not marked as reserved (i.e. has
+  * no corresponding entry in memblock.reserved). It verifies that array, regions
+  * counter and total size were not modified.
+  */
+static int memblock_free_absent_check(void)
+{
+	struct memblock_region *rgn;
+
+	rgn = &memblock.reserved.regions[0];
+
+	struct region r1 = {
+		.base = SZ_2M,
+		.size = SZ_8K
+	};
+	struct region r2 = {
+		.base = SZ_16M,
+		.size = SZ_128M
+	};
+
+	reset_memblock();
+	memblock_reserve(r1.base, r1.size);
+	memblock_free((void *)r2.base, r2.size);
+
+	assert(rgn->base == r1.base);
+	assert(rgn->size == r1.size);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == r1.size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to free a region which overlaps with the beginning of
+ * the already existing entry r1 (that is r1.base < r2.base + r2.size). It
+ * checks if only the intersection of both regions is freed. The test also
+ * checks if the regions counter and total size are updated to expected values.
+ */
+static int memblock_free_overlap_top_check(void)
+{
+	struct memblock_region *rgn;
+	phys_addr_t total_size;
+
+	rgn = &memblock.reserved.regions[0];
+
+	struct region r1 = {
+		.base = SZ_8M,
+		.size = SZ_32M
+	};
+	struct region r2 = {
+		.base = SZ_1M,
+		.size = SZ_8M
+	};
+
+	total_size = (r1.size + r1.base) - (r2.base + r2.size);
+
+	reset_memblock();
+	memblock_reserve(r1.base, r1.size);
+	memblock_free((void *)r2.base, r2.size);
+
+	assert(rgn->base == r2.base + r2.size);
+	assert(rgn->size == total_size);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to free a region which overlaps with the end of the
+ * first entry (that is r2.base < r1.base + r1.size). It checks if only the
+ * intersection of both regions is freed. The test also checks if the regions
+ * counter and total size are updated to expected values.
+ */
+static int memblock_free_overlap_bottom_check(void)
+{
+	struct memblock_region *rgn;
+	phys_addr_t total_size;
+
+	rgn = &memblock.reserved.regions[0];
+
+	struct region r1 = {
+		.base = SZ_8M,
+		.size = SZ_32M
+	};
+	struct region r2 = {
+		.base = SZ_32M,
+		.size = SZ_32M
+	};
+
+	total_size = r2.base - r1.base;
+
+	reset_memblock();
+	memblock_reserve(r1.base, r1.size);
+	memblock_free((void *)r2.base, r2.size);
+
+	assert(rgn->base == r1.base);
+	assert(rgn->size == total_size);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to free a region which is within the range of the already
+ * existing entry (that is (r1.base < r2.base) && (r2.base + r2.size < r1.base + r1.size)).
+ * It checks if the region is split into two - one that ends at r2.base and second
+ * that starts at r2.base + size, with appropriate sizes. It is expected that
+ * the region counter and total size fields were updated t reflect that change.
+ */
+static int memblock_free_within_check(void)
+{
+	struct memblock_region *rgn1, *rgn2;
+	phys_addr_t r1_size, r2_size, total_size;
+
+	rgn1 = &memblock.reserved.regions[0];
+	rgn2 = &memblock.reserved.regions[1];
+
+	struct region r1 = {
+		.base = SZ_1M,
+		.size = SZ_8M
+	};
+	struct region r2 = {
+		.base = SZ_4M,
+		.size = SZ_1M
+	};
+
+	r1_size = r2.base - r1.base;
+	r2_size = (r1.base + r1.size) - (r2.base + r2.size);
+	total_size = r1_size + r2_size;
+
+	reset_memblock();
+	memblock_reserve(r1.base, r1.size);
+	memblock_free((void *)r2.base, r2.size);
+
+	assert(rgn1->base == r1.base);
+	assert(rgn1->size == r1_size);
+
+	assert(rgn2->base == r2.base + r2.size);
+	assert(rgn2->size == r2_size);
+
+	assert(memblock.reserved.cnt == 2);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+static int memblock_free_checks(void)
+{
+	memblock_free_simple_check();
+	memblock_free_absent_check();
+	memblock_free_overlap_top_check();
+	memblock_free_overlap_bottom_check();
+	memblock_free_within_check();
+
+	return 0;
+}
+
 int memblock_basic_checks(void)
 {
 	memblock_initialization_check();
 	memblock_add_checks();
 	memblock_reserve_checks();
 	memblock_remove_checks();
+	memblock_free_checks();
 
 	return 0;
 }
-- 
2.30.2

