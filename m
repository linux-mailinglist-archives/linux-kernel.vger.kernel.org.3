Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200DA4A6F7F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343864AbiBBLEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343856AbiBBLEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:04:16 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23584C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:04:07 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id a28so39785765lfl.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wo9oDoTr9+opMofUsU18MLG30yml/POvjUCw9DWmUTs=;
        b=o1rU8PIpltWepZP+5N7r9V3PtFLNLH6wMPx4DvttXOwgoPXYQwal3K/obrXKLZKnei
         xomAfrBY+phjcjzRAb5SNwF7M4SiVFifEGk8CxBQOi0pjuHLIVm4eznqRwc5/ffNpPDa
         k7aDs693+btHlT7VO8DXe/MbvK/VaSx9lrkknyPlzOtFgNIXIb30ZSFiOiEQHl1Sukj0
         OhGrRKQKrObo9gH+6LWd3Zg0t1IsDoDy4fbv5VSaaE0OFLW3l10ZmDgTvm1H5jsG/bzi
         8UURER61P1arBEEAGlNX/aMMp0DcJsvjwMDXkPf/PumUehl+ig8rK/tLGogD7jG67dZn
         4Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wo9oDoTr9+opMofUsU18MLG30yml/POvjUCw9DWmUTs=;
        b=W4ZNrMH5iqPrZQGTwpiK1JwFgQIrBQZJOx1hnddSYTbFonLkztqayCaQ4O+BlNwVPp
         NzNY5CN/cYdvVMAH+zHwkcgHf1DcibK/WBiJaJzvMNQEmFgozG0Ifq1M1dHtwJ+k2yDV
         5QtQmgD2byT8PF2saCak/Xhleto+1f56YGNaGDoYe1LK6tLy//SIeiEkpJfuth8XS0qe
         aqyzV84NukhLP0ZyMA0RJ9oTO4L4AIi/IWcaQteK98Gl4go8o3Qe2821kPcIzBBNd3Lg
         o9y1/u5xRAUGQdLYBDnxEkRbrRMvYB2+H0ack6GqrSQyZZs9xVYJDcWvP85rCKz5EMjo
         F2Vw==
X-Gm-Message-State: AOAM532DrxIyZs2pc4PayI5F+cfbgu2L3NFmLioNomEa7VT5mdOKNXmD
        b6jAwyIAOESKV9f65GPFkhM=
X-Google-Smtp-Source: ABdhPJzBr1HreI0HQmXg87ltcy+WXra0I0o3KQK3FcN0ytPZkFQs4PFCGIqH7poEXFJckzhnH7oZ4Q==
X-Received: by 2002:a05:6512:2295:: with SMTP id f21mr22525606lfu.435.1643799845442;
        Wed, 02 Feb 2022 03:04:05 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:04:05 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 13/16] memblock tests: Add memblock_reserve tests
Date:   Wed,  2 Feb 2022 12:03:12 +0100
Message-Id: <cac867d2b6c17e53d9e977b5d6cd88cc4e9453b6.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
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

