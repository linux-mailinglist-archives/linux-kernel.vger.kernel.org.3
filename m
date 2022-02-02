Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB544A6F84
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343771AbiBBLEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343861AbiBBLEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:04:16 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4661C06173E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:04:08 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id q127so28363582ljq.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hy7Dd2f91UDJKml61GqO51OOP6//JtRGeIoiva3Pj4s=;
        b=hWkfIui+gxpbLh2BPaL2aGtfyYaKHcp4xjQS9FMtAU1ZXoSx+pdqXlsqHxAs5rrJdu
         r8C7jF0edJt/ShpCP8A1AuMeTmyNJhmVa8LL9cFNgLAp/ri/V7lkoxUVSHu4wWVNY3eD
         lLNXhT2J8d9LwVxAVONMrDjhZSaVgJMQiD04c/lksq1dSAJP5wXqRlowohzXwLvP2OTj
         A7BV1qMkx35bg0z1/pQxZ1HeS7y9QqL5ksSIXBKs+T2n/SJqGZNnGQLlhT429S7aPAgt
         R+2EXzl5P2DKWkDtt9sVw3X02V8ixNDpOv31RaeBa/98c2CM0d6mlnlXYS1tyzp1/ODv
         /K+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hy7Dd2f91UDJKml61GqO51OOP6//JtRGeIoiva3Pj4s=;
        b=2fu/fTL4MKr08Xs0v2loL+qORT66aO08PLrG5W3Mw/3gkIhYKoLmoKr90WJXCKZ+V2
         vq6rJcGon25zPfQqVXtoaYrFJsR4tSLBBtjA8juLdIpt+HgyqtTDZPDLx8o1yoHV7Ams
         Py2M7f4wZ5dnu+7hKP6qYI+r4uVg7DBEJTUZ4uAqODH4BeRK5aMA8CbprE1hKNj3kKQy
         ps7MSDui6F3m6gLO4Gdf03GO8V91lOiY38qFbO+WTr0jYrfWlYajeaXK78bhCc1WYvKu
         DuoN/7/WWVolGIeTLUESQk0P+8yRN5fuxlZoGkHCHTQReojZ6YHQvr+0B5lhFJgonyJU
         efHQ==
X-Gm-Message-State: AOAM531dfBAUugZSEu4lfeE+UP/lXZKlG9FfQGPv0dfXvucxBrbpDuaG
        mzDjKLLqhW3szVYi7JEtwEI=
X-Google-Smtp-Source: ABdhPJy4ZUVUTqMEwlvM7qv5wc/wjd51q7EKuO8jIaWMRcUtjk+QKhtOa2tW0JXo/LWxTBbiOmZxFA==
X-Received: by 2002:a2e:a4a9:: with SMTP id g9mr20061973ljm.289.1643799847040;
        Wed, 02 Feb 2022 03:04:07 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:04:06 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 14/16] memblock tests: Add memblock_remove tests
Date:   Wed,  2 Feb 2022 12:03:13 +0100
Message-Id: <8e6aa005407bbe1a75b75e85ac04ebb51318a52a.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add checks for removing a region from available memory in different
scenarios:
 - The requested region matches one in the collection of available
   memory regions
 - The requested region does not exist in memblock.memory
 - The region overlaps with one of the entries: from the top (its end
   address is bigger than the base of the existing region) or from the
   bottom (its base address is smaller than the end address of one of
   the regions)
 - The region is within an already defined region

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 203 +++++++++++++++++++++++
 1 file changed, 203 insertions(+)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index b055ff262d23..96af80bf9df9 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -450,11 +450,214 @@ static int memblock_reserve_checks(void)
 	return 0;
 }
 
+ /*
+  * A simple test that tries to remove the first entry of the array of available
+  * memory regions. By "removing" a region we mean overwriting it with the next
+  * region in memblock.memory. To check this is the case, the test adds two memory
+  * blocks and verifies that the value of the latter was used to erase r1 region.
+  * It also checks if the region counter and total size were updated to expected
+  * values.
+  */
+static int memblock_remove_simple_check(void)
+{
+	struct memblock_region *rgn;
+
+	rgn = &memblock.memory.regions[0];
+
+	struct region r1 = {
+		.base = SZ_2K,
+		.size = SZ_4K
+	};
+	struct region r2 = {
+		.base = SZ_128K,
+		.size = SZ_4M
+	};
+
+	reset_memblock();
+	memblock_add(r1.base, r1.size);
+	memblock_add(r2.base, r2.size);
+	memblock_remove(r1.base, r1.size);
+
+	assert(rgn->base == r2.base);
+	assert(rgn->size == r2.size);
+
+	assert(memblock.memory.cnt == 1);
+	assert(memblock.memory.total_size == r2.size);
+
+	return 0;
+}
+
+ /*
+  * A test that tries to remove a region that was not registered as available
+  * memory (i.e. has no corresponding entry in memblock.memory). It verifies
+  * that array, regions counter and total size were not modified.
+  */
+static int memblock_remove_absent_check(void)
+{
+	struct memblock_region *rgn;
+
+	rgn = &memblock.memory.regions[0];
+
+	struct region r1 = {
+		.base = SZ_512K,
+		.size = SZ_4M
+	};
+	struct region r2 = {
+		.base = SZ_64M,
+		.size = SZ_1G
+	};
+
+	reset_memblock();
+	memblock_add(r1.base, r1.size);
+	memblock_remove(r2.base, r2.size);
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
+ * A test that tries to remove a region which overlaps with the beginning of
+ * the already existing entry r1 (that is r1.base < r2.base + r2.size). It
+ * checks if only the intersection of both regions is removed from the available
+ * memory pool. The test also checks if the regions counter and total size are
+ * updated to expected values.
+ */
+static int memblock_remove_overlap_top_check(void)
+{
+	struct memblock_region *rgn;
+	phys_addr_t r1_end, r2_end, total_size;
+
+	rgn = &memblock.memory.regions[0];
+
+	struct region r1 = {
+		.base = SZ_32M,
+		.size = SZ_32M
+	};
+	struct region r2 = {
+		.base = SZ_16M,
+		.size = SZ_32M
+	};
+
+	r1_end = r1.base + r1.size;
+	r2_end = r2.base + r2.size;
+	total_size = r1_end - r2_end;
+
+	reset_memblock();
+	memblock_add(r1.base, r1.size);
+	memblock_remove(r2.base, r2.size);
+
+	assert(rgn->base == r1.base + r2.base);
+	assert(rgn->size == total_size);
+
+	assert(memblock.memory.cnt == 1);
+	assert(memblock.memory.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to remove a region which overlaps with the end of the
+ * first entry (that is r2.base < r1.base + r1.size). It checks if only the
+ * intersection of both regions is removed from the available memory pool.
+ * The test also checks if the regions counter and total size are updated to
+ * expected values.
+ */
+static int memblock_remove_overlap_bottom_check(void)
+{
+	struct memblock_region *rgn;
+	phys_addr_t total_size;
+
+	rgn = &memblock.memory.regions[0];
+
+	struct region r1 = {
+		.base = SZ_2M,
+		.size = SZ_64M
+	};
+	struct region r2 = {
+		.base = SZ_32M,
+		.size = SZ_256M
+	};
+
+	total_size = r2.base - r1.base;
+
+	reset_memblock();
+	memblock_add(r1.base, r1.size);
+	memblock_remove(r2.base, r2.size);
+
+	assert(rgn->base == r1.base);
+	assert(rgn->size == total_size);
+
+	assert(memblock.memory.cnt == 1);
+	assert(memblock.memory.total_size == total_size);
+	return 0;
+}
+
+/*
+ * A test that tries to remove a region which is within the range of the already
+ * existing entry (that is (r1.base < r2.base) && (r2.base + r2.size < r1.base + r1.size)).
+ * It checks if the region is split into two - one that ends at r2.base and second
+ * that starts at r2.base + size, with appropriate sizes. The test also checks if
+ * the region counter and total size were updated to expected values.
+ */
+static int memblock_remove_within_check(void)
+{
+	struct memblock_region *rgn1, *rgn2;
+	phys_addr_t r1_size, r2_size, total_size;
+
+	rgn1 = &memblock.memory.regions[0];
+	rgn2 = &memblock.memory.regions[1];
+
+	struct region r1 = {
+		.base = SZ_1M,
+		.size = SZ_32M
+	};
+	struct region r2 = {
+		.base = SZ_16M,
+		.size = SZ_1M
+	};
+
+	r1_size = r2.base - r1.base;
+	r2_size = (r1.base + r1.size) - (r2.base + r2.size);
+	total_size = r1_size + r2_size;
+
+	reset_memblock();
+	memblock_add(r1.base, r1.size);
+	memblock_remove(r2.base, r2.size);
+
+	assert(rgn1->base == r1.base);
+	assert(rgn1->size == r1_size);
+
+	assert(rgn2->base == r2.base + r2.size);
+	assert(rgn2->size == r2_size);
+
+	assert(memblock.memory.cnt == 2);
+	assert(memblock.memory.total_size == total_size);
+
+	return 0;
+}
+
+static int memblock_remove_checks(void)
+{
+	memblock_remove_simple_check();
+	memblock_remove_absent_check();
+	memblock_remove_overlap_top_check();
+	memblock_remove_overlap_bottom_check();
+	memblock_remove_within_check();
+
+	return 0;
+}
+
 int memblock_basic_checks(void)
 {
 	memblock_initialization_check();
 	memblock_add_checks();
 	memblock_reserve_checks();
+	memblock_remove_checks();
 
 	return 0;
 }
-- 
2.30.2

