Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0091D49E352
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbiA0NXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241830AbiA0NXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:23:07 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569D8C061753
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:23:07 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id t14so4259970ljh.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fXs9Z9PQYCruMdcrfaMtY0ndpO2Xn6EDlt3MZzXYgdU=;
        b=oDkwc2cjqtYnHMagaCWEJVr/CeYLDMdA1chFEf6kE7nkifGc77Mt5cEDZltehARWEn
         j7BaXrgNgOyBzYbSKKk2HzC0yJ/5JAy469XULMHCDqpG5RLCQEQHUab0vk3E8/4+K1Li
         F1uCKCdxUZ0o57qHw5jM0tV8u89yzygJ4ZKmzAXhuSdsPTVewsMyX691jknDJfHzElxX
         eI2B58VIW/JmU04rLHF8uedgvN4MAtJrNnzUOkSON0ColNaV6zEh/UyGO0YzV/DEd/fQ
         eE0L4riN1rQfekOlss9DqJed1nIY04qbPezdvCAsz4gpB6FCyj/r4fm/BHkAeye93CTv
         twLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fXs9Z9PQYCruMdcrfaMtY0ndpO2Xn6EDlt3MZzXYgdU=;
        b=exJfpHg5XumvrKljbzVXKpdOEhuR6lNkCXmhlkhIQH8sRrrFbrFyzbHBFmfnnO90+0
         AuwtBpKSFEHhzKM59t5xjTPhLzW/QgggneXvVqnwZ2TzTP7gh2DLknoOb9+dQ1Bz17sy
         UNH4Eyf+CxHqzX7yDODAsbMh3k1WVi8nhgXdUNTMHBwrZ50LLOjUung9mSwHjFgjniZz
         Qg2qD1UNz31ER7+kGtpy+ULIq5xgDQwurHkiOpqC30spsx4k5BtTEbC9f1PYKrAum6UM
         1vmPS9pHKjV9HiJz4+Dg3yKBsNutt7B9hLsqJQX98GU5eYTkWvDTExqGI8nO8tmK2djO
         au5g==
X-Gm-Message-State: AOAM533DnKD7WHb9N1WwU3qOjE9P2NUpbOnB/Fsyrc5qZUEb6eLY4rlC
        jxpBm7gnQwisfj9RVC6DXWo=
X-Google-Smtp-Source: ABdhPJz8UMyjQwIGDZ8QCO9YdTY8bJGm0PMsj9ZFWONj4sBJqZLF/ujqUdzMv5WSCxRhTIMleLZP8w==
X-Received: by 2002:a2e:9003:: with SMTP id h3mr2796586ljg.111.1643289785683;
        Thu, 27 Jan 2022 05:23:05 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:23:05 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 16/16] memblock tests: Add memblock_free tests
Date:   Thu, 27 Jan 2022 14:21:34 +0100
Message-Id: <586cd930a449bc2192ebee592c3a043cc0c1828f.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
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

