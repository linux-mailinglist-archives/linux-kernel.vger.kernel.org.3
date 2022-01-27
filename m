Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9650549E34E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbiA0NXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241836AbiA0NXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:23:04 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF971C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:23:01 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z4so5329058lft.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wo9oDoTr9+opMofUsU18MLG30yml/POvjUCw9DWmUTs=;
        b=jP/+ihSr4g51rsEx0q+yw/44YG9CAcNNZB3nCAL6BfNzapzprh4l5M+lKCVLrDbYmb
         E4hBP5y6i9thwDqyUm40qQ99PtTsUQcuhuenOZujAhVV78ruxXA6D4vTQhbftnQTaZp0
         lzmu4Y4gQHAdTlY6IXE616VAFkNk3PimSmI+Ew1T4ahiNsOAEd4HVgeKyo9qw5iDyWCY
         lQKyRY3kAPEh4uD8wQPgYYgr5NvCxbICgR/AnGK/MuCsvKKsontQOCWWW29UatoO6BpD
         raZES3d/+P+f8IuFCoEc1k18WzbBDZADts+aDwXu5MZUiUVr0Vie3USGi4wPj5yPMZJB
         MN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wo9oDoTr9+opMofUsU18MLG30yml/POvjUCw9DWmUTs=;
        b=fmJJeRqZzsJkOZMh8VqStoIkizOCeqYwWZU0zPg9vMRaRGHGOoLK4ev/qYNH0ZiWuQ
         gr5a639Squ0VUeTIx3a3R9RKoPk5TUxjILqb5EU+YkHdD8DyFvJOnY/5lQQnV+p5C3hV
         //wFpg9j2h1mJEgKgcSsxYflAlP1IGQ+PfVdX1h17cJ4W+Po+xtsHmxWvdCmmeamQU33
         sbLuuuS88xZDbBLsJSE5b0zyKawXjGUI1e3uIIdto/Bl0gtD5pW0IISH9OdgMat4PhCu
         V2B77ziYwiyx7USELeGmYIu1HNtdsDFFIFrKtPOzBXVAk+95immjtMNyOziXvb3+u1q+
         UWIg==
X-Gm-Message-State: AOAM531JXwZXGAR01MDeHtWrVMbpRq9ly7W9XuK5h+AtvlO708R1A9PR
        a+xRMK31SggAl4YmvU+QPs4=
X-Google-Smtp-Source: ABdhPJynVFbj7l9tFBplnLU9W06Hzj8764UyQPBLqnquPB33OyA2o7mk1idQQTMT4nn0O1PyggxmUw==
X-Received: by 2002:a19:5f58:: with SMTP id a24mr2785650lfj.46.1643289780152;
        Thu, 27 Jan 2022 05:23:00 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:22:59 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 13/16] memblock tests: Add memblock_reserve tests
Date:   Thu, 27 Jan 2022 14:21:31 +0100
Message-Id: <4603629b76f8caf68b4487b7a040461dc18e9723.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add checks for marking a region as reserved in different scenarios:
 - The region does not overlap with existing entries
 - The region overlaps with one of the previous entries: from the top
   (its end address is bigger than the base of the existing region) or
   from the bottom (its base address is smaller than the end address of
   one of the regions)
 - The region is within an already defined region
 - The same region is marked as reserved twice

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 213 +++++++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 6c047b7b31ab..b055ff262d23 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -239,9 +239,222 @@ static int memblock_add_checks(void)
 	return 0;
 }
 
+ /*
+  * A simple test that marks a memory block of a specified base address
+  * and size as reserved and to the collection of reserved memory regions
+  * (memblock.reserved). It checks if a new entry was created and if region
+  * counter and total memory size were correctly updated.
+  */
+static int memblock_reserve_simple_check(void)
+{
+	struct memblock_region *rgn;
+
+	rgn =  &memblock.reserved.regions[0];
+
+	struct region r = {
+		.base = SZ_2G,
+		.size = SZ_128M
+	};
+
+	reset_memblock();
+	memblock_reserve(r.base, r.size);
+
+	assert(rgn->base == r.base);
+	assert(rgn->size == r.size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to mark two memory blocks that don't overlap as reserved
+ * and checks if two entries were correctly added to the collection of reserved
+ * memory regions (memblock.reserved) and if this change was reflected in
+ * memblock.reserved's total size and region counter.
+ */
+static int memblock_reserve_disjoint_check(void)
+{
+	struct memblock_region *rgn1, *rgn2;
+
+	rgn1 = &memblock.reserved.regions[0];
+	rgn2 = &memblock.reserved.regions[1];
+
+	struct region r1 = {
+		.base = SZ_256M,
+		.size = SZ_16M
+	};
+	struct region r2 = {
+		.base = SZ_512M,
+		.size = SZ_512M
+	};
+
+	reset_memblock();
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	assert(rgn1->base == r1.base);
+	assert(rgn1->size == r1.size);
+
+	assert(rgn2->base == r2.base);
+	assert(rgn2->size == r2.size);
+
+	assert(memblock.reserved.cnt == 2);
+	assert(memblock.reserved.total_size == r1.size + r2.size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to mark two memory blocks as reserved, where the second one
+ * overlaps with the beginning of the first (that is r1.base < r2.base + r2.size).
+ * It checks if two entries are merged into one region that starts at r2.base
+ * and has size of two regions minus their intersection. The test also verifies
+ * that memblock can still see only one entry and has a correct total size of
+ * the reserved memory.
+ */
+static int memblock_reserve_overlap_top_check(void)
+{
+	struct memblock_region *rgn;
+	phys_addr_t total_size;
+
+	rgn = &memblock.reserved.regions[0];
+
+	struct region r1 = {
+		.base = SZ_1G,
+		.size = SZ_1G
+	};
+	struct region r2 = {
+		.base = SZ_128M,
+		.size = SZ_1G
+	};
+
+	total_size = (r1.base - r2.base) + r1.size;
+
+	reset_memblock();
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	assert(rgn->base == r2.base);
+	assert(rgn->size == total_size);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to mark two memory blocks as reserved, where the second
+ * one overlaps with the end of the first entry (that is r2.base < r1.base + r1.size).
+ * It checks if two entries are merged into one region that starts at r1.base
+ * and has size of two regions minus their intersection. It verifies that memblock
+ * can still see only one entry and has a correct total size of the reserved memory.
+ */
+static int memblock_reserve_overlap_bottom_check(void)
+{
+	struct memblock_region *rgn;
+	phys_addr_t total_size;
+
+	rgn = &memblock.reserved.regions[0];
+
+	struct region r1 = {
+		.base = SZ_2K,
+		.size = SZ_128K
+	};
+	struct region r2 = {
+		.base = SZ_128K,
+		.size = SZ_128K
+	};
+
+	total_size = (r2.base - r1.base) + r2.size;
+
+	reset_memblock();
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
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
+ * A test that tries to mark two memory blocks as reserved, where the second one
+ * is within the range of the first entry (that is (r1.base < r2.base) &&
+ * (r2.base + r2.size < r1.base + r1.size)). It checks if two entries are merged
+ * into one region that stays the same. The counter and total size of available
+ * memory are expected to not be updated.
+ */
+static int memblock_reserve_within_check(void)
+{
+	struct memblock_region *rgn;
+
+	rgn = &memblock.reserved.regions[0];
+
+	struct region r1 = {
+		.base = SZ_1M,
+		.size = SZ_8M
+	};
+	struct region r2 = {
+		.base = SZ_2M,
+		.size = SZ_64K
+	};
+
+	reset_memblock();
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
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
+ * A simple test that tries to reserve the same memory block twice.
+ * The region counter and total size of reserved memory are expected to not
+ * be updated.
+ */
+static int memblock_reserve_twice_check(void)
+{
+	struct region r = {
+		.base = SZ_16K,
+		.size = SZ_2M
+	};
+
+	reset_memblock();
+
+	memblock_reserve(r.base, r.size);
+	memblock_reserve(r.base, r.size);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == r.size);
+
+	return 0;
+}
+
+static int memblock_reserve_checks(void)
+{
+	memblock_reserve_simple_check();
+	memblock_reserve_disjoint_check();
+	memblock_reserve_overlap_top_check();
+	memblock_reserve_overlap_bottom_check();
+	memblock_reserve_within_check();
+	memblock_reserve_twice_check();
+
+	return 0;
+}
+
 int memblock_basic_checks(void)
 {
 	memblock_initialization_check();
 	memblock_add_checks();
+	memblock_reserve_checks();
+
 	return 0;
 }
-- 
2.30.2

