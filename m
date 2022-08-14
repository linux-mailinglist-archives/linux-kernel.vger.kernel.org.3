Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C7A591E8C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbiHNFyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239721AbiHNFyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:54:25 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993755C356
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:23 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id d4so2483548ilc.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=57rgW1sYbO78tij7BVX5WYr55Vq5FbqyewxGMYBSZtk=;
        b=B/fgMudF1KCEFCKV6FWg8Gz3rGGiLl0m7TNOf0gfhZZp6Wrgxs92Z4hAbQ+aQjouFu
         X1OEhXaQUMv8zDIRSMsxneJhLVHEOzJrVtY5K5bCqT8vInwovKktKyBO+cfLYVHy9Aj1
         9X2hRFjnuKLsoPh+WDybApb5+vLU2URzvWqvDUny2XJetlHCIEFJrgNaHJZTLpofWny0
         +OgdAxLv45Bb5QQCWLQxMB3Ji++3isUtoslT8mnlSQWYA1BGe/FApjhKJuhSlCBNGGow
         0gqtnCh97tSHuFJ/lKsADY3kBBv14SjhH0sqmEQMJLbuA/BonAIPynG6Y8rUyqSM6zhE
         RQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=57rgW1sYbO78tij7BVX5WYr55Vq5FbqyewxGMYBSZtk=;
        b=PdQptkyXGtsO0EjaLgGlcMpdZTNiBoU0kPJNZi/sE/CH7o2poBeKqJpRNGvvaXT+kh
         GTgC5dlFN/7Rn9gw994v4LjmmN80J0B2+zwJStCbYWsUae4kCwR6lKkJOANC7yM4GKE2
         r8nau8NLJeiIYuH0BcIRWUmwkMj0fYlWKx0X1m0OZ/ZnFYHMJ611xIjt4XP76/I+nKNZ
         TbRpbRsi4msO2xUkhq43hHbgFFVg8yxRjmdXmdrmGffq9EmdPKS5Z9/VGlU3cQquLIEH
         EYQWZWkBhfQ25XfBkJ2kpjIhcNWcnFb3Lt+9raK7QozmYc+UYVnnirQaNmvjHPYk6Y52
         KoHg==
X-Gm-Message-State: ACgBeo07ArBv8dt+rVf1x1a99d8+4NSGLefCwq+dJrBVgabiYdGyNhYF
        2ko4zhHGpI8sRpBCS9Pedcc=
X-Google-Smtp-Source: AA6agR406vu4PkQdRHCd5fMLZ7RIpgMg5EM1fsk2ivjCdmJ3HsNQd0botplZ5UriMbe3vmUfiBL3QA==
X-Received: by 2002:a05:6e02:2185:b0:2de:9a5a:4993 with SMTP id j5-20020a056e02218500b002de9a5a4993mr4535302ila.182.1660456462573;
        Sat, 13 Aug 2022 22:54:22 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id b6-20020a05660214c600b0067b7a057ee8sm3144563iow.25.2022.08.13.22.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 22:54:22 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 8/8] memblock tests: add tests for memblock_trim_memory
Date:   Sun, 14 Aug 2022 00:54:00 -0500
Message-Id: <ebbd1fd2c2a3d223a744adf24b4293a559a7003a.1660454730.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660454730.git.remckee0@gmail.com>
References: <cover.1660454730.git.remckee0@gmail.com>
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
- one region unalign that is smaller than the alignment
- one region unaligned at the base
- one region unaligned at the end

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 223 +++++++++++++++++++++++
 1 file changed, 223 insertions(+)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index d7f008e7a12a..c8bb44f20846 100644
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
+	phys_addr_t alignment = SMP_CACHE_BYTES;
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
+	phys_addr_t alignment = SMP_CACHE_BYTES;
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
+	phys_addr_t alignment = SMP_CACHE_BYTES;
+	phys_addr_t offset = SZ_2;
+	phys_addr_t r2_base, r2_size;
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
+	r2_base = r2.base + (alignment - offset);
+	r2_size = r2.size - (alignment - offset);
+
+	reset_memblock_regions();
+	memblock_add(r1.base, r1.size);
+	memblock_add(r2.base, r2.size);
+	memblock_trim_memory(alignment);
+
+	ASSERT_EQ(rgn1->base, r1.base);
+	ASSERT_EQ(rgn1->size, r1.size);
+
+	ASSERT_EQ(rgn2->base, r2_base);
+	ASSERT_EQ(rgn2->size, r2_size);
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
+ * Expect that r1 will not be trimmed and r2 will be trimmed at the base.
+ * Expect the counter to not be updated.
+ */
+static int memblock_trim_memory_unaligned_end_check(void)
+{
+	struct memblock_region *rgn1, *rgn2;
+	phys_addr_t alignment = SMP_CACHE_BYTES;
+	phys_addr_t offset = SZ_2;
+	phys_addr_t r2_size;
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
+	r2_size = r2.size - (alignment - offset);
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
+	ASSERT_EQ(rgn2->size, r2_size);
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

