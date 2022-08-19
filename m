Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2070F599819
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347769AbiHSIzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347892AbiHSIzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:55:18 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D7FD4764
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:55:06 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y18so2875546qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QFgB1gsSAoG+hS58IncwUozrISMMlQtds/WbFB87YTI=;
        b=AbdL85n3lmzPtDCe/0JF9M2e5jB3Q0mtzxFL6dD/0wie8bJw6MV6jGErrfhBedZKy+
         KlhLOqMTHjkU/+J3wkmvZyChrRLEcr1+Y2MC4CoAmnNOoW0q/XnAjrk0JZ49UgvJKjS/
         kvIiitERotZ2K1lQI6W3FzdXzI9ZuLiqpvtG/3azfIJFkOFArd/FuNmUJNqLaPZORz+W
         MzD+VDnBMfsGPMfh43Yw5UC12IBHDHhO09rAH/dTJrToff6YXZX8HLRlTTbVW1lsyE/b
         8OlMT0FSItyIPXS6EUcHrM1EEzHgb1EB61IAwsgfK5Nb/Inq584oiRqQ1h/UnxPPYjAK
         6uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QFgB1gsSAoG+hS58IncwUozrISMMlQtds/WbFB87YTI=;
        b=LwBQ5a/ETStNnRAoihCThV7GQk1ChBJsufLsym2mczs4ayyUNLanmLuJ8BLAzEidq1
         GA1InxzP0Z83lLhDHJfesJrJZ6/LsGKXVbWkh5SCXQQj9H1/r3Uyf4G6aR5rNH3D0qHl
         +U9LdGXxcdyxZ+EMdoMOXZTd4HIJY7LaAVss5mdiSpT7uwe8IYQq29HX0Pulh5rh7yDi
         EI7//HVieYzmPwHT9xKgw01czOk971u50XWx2yfQ6tPBBgO7i/EIcs1iL9niqxl6u25J
         1C3ckOHzWfsx9xxWXWkGSyXCYUINTrYcQWbhG/1lPJueTSxpqsBGQVMJAaAA31lPCgTi
         bcQw==
X-Gm-Message-State: ACgBeo0VJx7YMgRvu+KJYTbuQybHqxyEXJYvR1RntO2ngRKnGOZno+1y
        DDEYChVdLin2okINqe4Ul4I=
X-Google-Smtp-Source: AA6agR7jlnvccUlV1fMt3CaIEGX7wpp5Q3lwM6x8ijuDU20Fd7DPGrCK+t9G8cEyNsbsIHibjjZaCw==
X-Received: by 2002:a05:622a:1492:b0:344:5130:4094 with SMTP id t18-20020a05622a149200b0034451304094mr5687369qtx.3.1660899305200;
        Fri, 19 Aug 2022 01:55:05 -0700 (PDT)
Received: from sophie ([89.46.62.64])
        by smtp.gmail.com with ESMTPSA id t201-20020a37aad2000000b006bacf4703c5sm3495354qke.111.2022.08.19.01.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:55:04 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 8/8] memblock tests: add tests for memblock_trim_memory
Date:   Fri, 19 Aug 2022 01:34:56 -0700
Message-Id: <4157021eecdd3abb503d4b1d1449844baac2d7b9.1660897732.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660897732.git.remckee0@gmail.com>
References: <cover.1660897732.git.remckee0@gmail.com>
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
index c7490291c485..7048319bb096 100644
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
+ * Expect that r1 will not be trimmed and r2 will be trimmed at the base.
+ * Expect the counter to not be updated.
+ */
+static int memblock_trim_memory_unaligned_end_check(void)
+{
+	struct memblock_region *rgn1, *rgn2;
+	phys_addr_t alignment = SMP_CACHE_BYTES;
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

