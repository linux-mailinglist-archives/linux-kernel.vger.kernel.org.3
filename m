Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359AF5A34E4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbiH0Fn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345265AbiH0Fnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:43:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FA4B07F3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r22so3191720pgm.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=EKxkqxcBr4W8oMXrdMYE0sRW7t58efVXfDHxSfd0qfM=;
        b=BiCRueY9agN8Kh4+haI1G9+IPGIT3yl/sRuiex13gdm6SrYEZxelKfkALuSlGfYLj4
         FK1WlYyYXBrED6Fn3kdDjmwzV9QsW2PeJR/hnE+PL1NHH/q7Gt95q7KqNhBF7rd5M6jo
         pJuTKWrnBqNxhOsisKWwmrijgj6zpOb8AFmj6N3qoiBt6P57LZ3PX7fgfbcK/fwKUTjE
         /TO1roYHNlWdx4vjYFXb25XbVOjYPErpR5abbBeBN0au8XqzkZP+Np5NZ53JH5/FK0ml
         Epnf5A8JfD7JrCdU2EFAPXVBCxz81vauHKLaVDZFP3BrisidGA8lHVxiE0R98ohai/XZ
         Mv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EKxkqxcBr4W8oMXrdMYE0sRW7t58efVXfDHxSfd0qfM=;
        b=dKMHKkhyiGalSRNQDor1l76BBX6EIzzC+0SKrim6ax69breLDA09jJH3QuFS272+Zt
         XejD0dxcrUbirAjMngTGr/r1deR/bGTNPvB3xV6oKh9aVfJXztdiLDreoivgSu+og5HM
         BTRfs+eX/1cXxUawgiE/NOf6zYjC9G5nZ1UV1o1fhPWk1GBVoJ3TakDi8ABt4ATNRznT
         PDKCzU5Rl0OisT89vuOZ/VMwoYj0P8Ff/LqyFHYulH7MJNUW3zbb7naTerq6pBogSE1G
         IddmtjHO/dqCmyhxTzZDvOl6ij26cnMDgMXq+SI+g6j7g6qz5dFaHltGdLmkmjFQdNL1
         EfKg==
X-Gm-Message-State: ACgBeo2b0fn4hb/pImSdpNnl04RLUux7g5vzviReZC2reGVyq5xwkdhi
        w/C6o6MGR23Ta9nkAN2jMx4=
X-Google-Smtp-Source: AA6agR407S5k5TyUhxyjMUWkdny3xkqUuGe/sW+HKlq+rHqlCH7wp7aErCfg6ZkWnxVPjqS5hEGn1w==
X-Received: by 2002:a65:6d13:0:b0:41d:7380:e9cc with SMTP id bf19-20020a656d13000000b0041d7380e9ccmr5964711pgb.153.1661579006964;
        Fri, 26 Aug 2022 22:43:26 -0700 (PDT)
Received: from sophie ([89.46.114.37])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902784600b00168dadc7354sm2624702pln.78.2022.08.26.22.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 22:43:26 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 8/8] memblock tests: add tests for memblock_trim_memory
Date:   Sat, 27 Aug 2022 00:42:50 -0500
Message-Id: <0e5f55154a3b66581e04ba3717978795cbc08a5b.1661578349.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661578349.git.remckee0@gmail.com>
References: <cover.1661578349.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for memblock_trim_memory() for the following scenarios:
- all regions aligned
- one unaligned region that is smaller than the alignment
- one unaligned region that is unaligned at the base
- one unaligned region that is unaligned at the end

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 223 +++++++++++++++++++++++
 1 file changed, 223 insertions(+)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index c7490291c485..a13a57ba0815 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -8,6 +8,7 @@
 #define FUNC_RESERVE					"memblock_reserve"
 #define FUNC_REMOVE					"memblock_remove"
 #define FUNC_FREE					"memblock_free"
+#define FUNC_TRIM					"memblock_trim_memory"
 
 static int memblock_initialization_check(void)
 {
@@ -1723,6 +1724,227 @@ static int memblock_bottom_up_checks(void)
 	return 0;
 }
 
+/*
+ * A test that tries to trim memory when both ends of the memory region are
+ * aligned. Expect that the memory will not be trimmed. Expect the counter to
+ * not be updated.
+ */
+static int memblock_trim_memory_aligned_check(void)
+{
+	struct memblock_region *rgn;
+	const phys_addr_t alignment = SMP_CACHE_BYTES;
+
+	rgn = &memblock.memory.regions[0];
+
+	struct region r = {
+		.base = alignment,
+		.size = alignment * 4
+	};
+
+	PREFIX_PUSH();
+
+	reset_memblock_regions();
+	memblock_add(r.base, r.size);
+	memblock_trim_memory(alignment);
+
+	ASSERT_EQ(rgn->base, r.base);
+	ASSERT_EQ(rgn->size, r.size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to trim memory when there are two available regions, r1 and
+ * r2. Region r1 is aligned on both ends and region r2 is unaligned on one end
+ * and smaller than the alignment:
+ *
+ *                                     alignment
+ *                                     |--------|
+ * |        +-----------------+        +------+   |
+ * |        |        r1       |        |  r2  |   |
+ * +--------+-----------------+--------+------+---+
+ *          ^        ^        ^        ^      ^
+ *          |________|________|________|      |
+ *                            |               Unaligned address
+ *                Aligned addresses
+ *
+ * Expect that r1 will not be trimmed and r2 will be removed. Expect the
+ * counter to be updated.
+ */
+static int memblock_trim_memory_too_small_check(void)
+{
+	struct memblock_region *rgn;
+	const phys_addr_t alignment = SMP_CACHE_BYTES;
+
+	rgn = &memblock.memory.regions[0];
+
+	struct region r1 = {
+		.base = alignment,
+		.size = alignment * 2
+	};
+	struct region r2 = {
+		.base = alignment * 4,
+		.size = alignment - SZ_2
+	};
+
+	PREFIX_PUSH();
+
+	reset_memblock_regions();
+	memblock_add(r1.base, r1.size);
+	memblock_add(r2.base, r2.size);
+	memblock_trim_memory(alignment);
+
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, r1.size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to trim memory when there are two available regions, r1 and
+ * r2. Region r1 is aligned on both ends and region r2 is unaligned at the base
+ * and aligned at the end:
+ *
+ *                               Unaligned address
+ *                                       |
+ *                                       v
+ * |        +-----------------+          +---------------+   |
+ * |        |        r1       |          |      r2       |   |
+ * +--------+-----------------+----------+---------------+---+
+ *          ^        ^        ^        ^        ^        ^
+ *          |________|________|________|________|________|
+ *                            |
+ *                    Aligned addresses
+ *
+ * Expect that r1 will not be trimmed and r2 will be trimmed at the base.
+ * Expect the counter to not be updated.
+ */
+static int memblock_trim_memory_unaligned_base_check(void)
+{
+	struct memblock_region *rgn1, *rgn2;
+	const phys_addr_t alignment = SMP_CACHE_BYTES;
+	phys_addr_t offset = SZ_2;
+	phys_addr_t new_r2_base, new_r2_size;
+
+	rgn1 = &memblock.memory.regions[0];
+	rgn2 = &memblock.memory.regions[1];
+
+	struct region r1 = {
+		.base = alignment,
+		.size = alignment * 2
+	};
+	struct region r2 = {
+		.base = alignment * 4 + offset,
+		.size = alignment * 2 - offset
+	};
+
+	PREFIX_PUSH();
+
+	new_r2_base = r2.base + (alignment - offset);
+	new_r2_size = r2.size - (alignment - offset);
+
+	reset_memblock_regions();
+	memblock_add(r1.base, r1.size);
+	memblock_add(r2.base, r2.size);
+	memblock_trim_memory(alignment);
+
+	ASSERT_EQ(rgn1->base, r1.base);
+	ASSERT_EQ(rgn1->size, r1.size);
+
+	ASSERT_EQ(rgn2->base, new_r2_base);
+	ASSERT_EQ(rgn2->size, new_r2_size);
+
+	ASSERT_EQ(memblock.memory.cnt, 2);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to trim memory when there are two available regions, r1 and
+ * r2. Region r1 is aligned on both ends and region r2 is aligned at the base
+ * and unaligned at the end:
+ *
+ *                                             Unaligned address
+ *                                                     |
+ *                                                     v
+ * |        +-----------------+        +---------------+   |
+ * |        |        r1       |        |      r2       |   |
+ * +--------+-----------------+--------+---------------+---+
+ *          ^        ^        ^        ^        ^        ^
+ *          |________|________|________|________|________|
+ *                            |
+ *                    Aligned addresses
+ *
+ * Expect that r1 will not be trimmed and r2 will be trimmed at the end.
+ * Expect the counter to not be updated.
+ */
+static int memblock_trim_memory_unaligned_end_check(void)
+{
+	struct memblock_region *rgn1, *rgn2;
+	const phys_addr_t alignment = SMP_CACHE_BYTES;
+	phys_addr_t offset = SZ_2;
+	phys_addr_t new_r2_size;
+
+	rgn1 = &memblock.memory.regions[0];
+	rgn2 = &memblock.memory.regions[1];
+
+	struct region r1 = {
+		.base = alignment,
+		.size = alignment * 2
+	};
+	struct region r2 = {
+		.base = alignment * 4,
+		.size = alignment * 2 - offset
+	};
+
+	PREFIX_PUSH();
+
+	new_r2_size = r2.size - (alignment - offset);
+
+	reset_memblock_regions();
+	memblock_add(r1.base, r1.size);
+	memblock_add(r2.base, r2.size);
+	memblock_trim_memory(alignment);
+
+	ASSERT_EQ(rgn1->base, r1.base);
+	ASSERT_EQ(rgn1->size, r1.size);
+
+	ASSERT_EQ(rgn2->base, r2.base);
+	ASSERT_EQ(rgn2->size, new_r2_size);
+
+	ASSERT_EQ(memblock.memory.cnt, 2);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+static int memblock_trim_memory_checks(void)
+{
+	prefix_reset();
+	prefix_push(FUNC_TRIM);
+	test_print("Running %s tests...\n", FUNC_TRIM);
+
+	memblock_trim_memory_aligned_check();
+	memblock_trim_memory_too_small_check();
+	memblock_trim_memory_unaligned_base_check();
+	memblock_trim_memory_unaligned_end_check();
+
+	prefix_pop();
+
+	return 0;
+}
+
 int memblock_basic_checks(void)
 {
 	memblock_initialization_check();
@@ -1731,6 +1953,7 @@ int memblock_basic_checks(void)
 	memblock_remove_checks();
 	memblock_free_checks();
 	memblock_bottom_up_checks();
+	memblock_trim_memory_checks();
 
 	return 0;
 }
-- 
2.25.1

