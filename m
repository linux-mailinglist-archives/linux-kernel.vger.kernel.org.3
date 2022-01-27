Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C2549E34F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbiA0NX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241843AbiA0NXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:23:04 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD55C061748
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:23:03 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a25so4268620lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hy7Dd2f91UDJKml61GqO51OOP6//JtRGeIoiva3Pj4s=;
        b=eOBmJmDHfkuFeep90OvjOekwFn22R9eJ6NpFaGtjUtD5B8ra+NXr2/L42EZ/tIGqr1
         Os+Xfz7s2sqwWFzFFEBHdWgxxVLc3GN8+kFNFiPHzsva5t0Evujp/h19Sk1V2I2/LBAN
         vp5NtiB9x6RHstR/aDYucdeSTWlQeT+fpPdOMg0iFxa3WEv21kWHzKrEuGAqXn436R/L
         y7HkgeDFwCiZXOd0iefHLlZ67/zUrVnJEe0FQlhVX7d+X+Nd/4d3D4a9CJun/QYqiRIR
         qQ1Wl8ZkUAr3ZEOCVSqskAwdz4/i0mFDzUpwBnGf2vCZ1Jd5iRsCdL/OrMR3PohB6ZkM
         JukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hy7Dd2f91UDJKml61GqO51OOP6//JtRGeIoiva3Pj4s=;
        b=ooP5X27+TRTle19LJ1fZRLOitZrsxRjYqikHEKL+0D6E6lhOEx7SqPwsnhnsUi+kkB
         Zq0tPd312umlddvIbb83UZyxXmFCffpiQqb+7cpnNNHqQPJz3qLa1RgoRvQWSdpLCdur
         e5VEzg2+ZD+1uff1qqfKcmQcBrAnnpIekqVbc3rtZ1YFNyvK2/xR8HB3xJ3u1nhTfdlm
         yhegovybc1D6GTwdn3GtiKpLGhJJCf094XEbkpUKafSQO7jlRklTqOWeD0Ermq9VlRzr
         POy3VTuNUj9aUXdrtBBSHXR4ssnvQb114OHk9GeIYKnbBM/fBEEqonXfmxSB+4W/lWyl
         bolA==
X-Gm-Message-State: AOAM533D6mEeo76GkoR8bFUg06gxxxg6ZmPB7HMF7BWVg/IYLRkyWjlF
        kGpQpC6aoYt0OrWAz6/8sDI=
X-Google-Smtp-Source: ABdhPJylTzrNTw+ZvMPlNBQsGkLRQ2IxoY6wQKgiAfi4DWnoRMz0SCd4bbx9GZyc/0LHkhu8H9Ociw==
X-Received: by 2002:a2e:a41a:: with SMTP id p26mr2927925ljn.176.1643289782157;
        Thu, 27 Jan 2022 05:23:02 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:23:01 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 14/16] memblock tests: Add memblock_remove tests
Date:   Thu, 27 Jan 2022 14:21:32 +0100
Message-Id: <680e9f43b98cae24f6c6364052be14f2bcefa694.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
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

