Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B048591E89
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiHNFyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiHNFyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:54:10 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CC752E76
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:08 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p9so2471794ilq.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=TqLTKUmEk/mKGbJa80nE77aaCeS2f2PhLCxbPuooWhk=;
        b=Q+70lCxo0EOr6ZjULQtULwXoQfFqFrhzmgqGnXuME+BrsXkSjYP3hTsUbnpp1qw43m
         1F6K2i2CQKCycUqiGC5ObC9j1BnKh/dxeOxl1qRdJeeFl756TIYVq0Cdz4Yy6uJaEccb
         T7cm9eYHf//UuNx/gSF5Vgw7Q66vQXTEPwIqZ9kIUu3it4V3EJHPx5/OIeDIxS+tbSm2
         O0k9O+veuWtYGdsCjrYkCfd/o5yukBIAFTTWsKBhY/70a0oH2j5KFx6aixZWydOagUfp
         xCv/B2tiT8441toWEth7/JWx5Y30oN/FMiwPJJtZXMu7AmJgdfR529IUWeaCzuME630I
         9KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=TqLTKUmEk/mKGbJa80nE77aaCeS2f2PhLCxbPuooWhk=;
        b=mdBfXLapSoT1E1CMBdSqJygXLaKEpPr0VKD/57CT3fKPIKDftCht0mY0H3SdZC4VuL
         BoOfeHzLwGBG9H1dlcAd+dCmdEV9f2r9bZajuWyTI6ZZs58l8tbOezGURR/aGzohGrfv
         Ab8uXSYl5+qJyrHRyRPAxBLGfa+2NsTlcqj+cLdknm0Vrw3CDiUTvMMZXuwiERke3zsE
         bdojtjTXhDsbq0MHMkd8JKNLKaSw+2+P0mbkOphy9H81nT5WcSefhOO4O+VmfhopE99P
         Nw4xAnKHjp6VZ1vh7QAuPpXMerTjqWAvW7l8xiEyvAGHb39XkmgzbBojOa7feX52UVJz
         awrA==
X-Gm-Message-State: ACgBeo1J4NSZrH+WXAlQ8GVE40INZcQYHbusqf8w4OqHx3fldYnzhYN+
        Oojy1V5YNEX6qYrma+TwzVw=
X-Google-Smtp-Source: AA6agR57m2tbZb2IQQdr4JcN2+O7/qS5xwfmQSAUfTIGFtypLP3eE76NYeUEL1dj9t1cc0w5ype3xw==
X-Received: by 2002:a92:cda9:0:b0:2df:a725:6491 with SMTP id g9-20020a92cda9000000b002dfa7256491mr4968030ild.12.1660456448133;
        Sat, 13 Aug 2022 22:54:08 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id h8-20020a05660208c800b006882a3bd03fsm432587ioz.16.2022.08.13.22.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 22:54:07 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 1/8] memblock tests: update tests to check if memblock_alloc zeroed memory
Date:   Sun, 14 Aug 2022 00:53:53 -0500
Message-Id: <02d514d86f212c79e52792b8ecd919156d7a9c20.1660454730.git.remckee0@gmail.com>
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

Add an assert in memblock_alloc() tests where allocation is expected to
occur. The assert checks whether the entire chunk of allocated memory is
cleared.

The current memblock_alloc() tests do not check whether the allocated
memory was zeroed. memblock_alloc() should zero the allocated memory since
it is a wrapper for memblock_alloc_try_nid().

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_api.c | 24 ++++++++++++++++++++++++
 tools/testing/memblock/tests/common.c    |  7 +++++++
 tools/testing/memblock/tests/common.h    | 13 +++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
index a14f38eb8a89..71c89cb9b2a8 100644
--- a/tools/testing/memblock/tests/alloc_api.c
+++ b/tools/testing/memblock/tests/alloc_api.c
@@ -22,6 +22,8 @@ static int alloc_top_down_simple_check(void)
 	allocated_ptr = memblock_alloc(size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, expected_start);
 
@@ -80,6 +82,8 @@ static int alloc_top_down_disjoint_check(void)
 	allocated_ptr = memblock_alloc(r2_size, alignment);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
 
@@ -125,6 +129,8 @@ static int alloc_top_down_before_check(void)
 	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - total_size);
 
@@ -173,6 +179,8 @@ static int alloc_top_down_after_check(void)
 	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base - r2_size);
 
@@ -223,6 +231,8 @@ static int alloc_top_down_second_fit_check(void)
 	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+
 	ASSERT_EQ(rgn->size, r2.size + r3_size);
 	ASSERT_EQ(rgn->base, r2.base - r3_size);
 
@@ -277,6 +287,8 @@ static int alloc_in_between_generic_check(void)
 	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base - r2.size - r3_size);
 
@@ -418,6 +430,8 @@ static int alloc_limited_space_generic_check(void)
 	allocated_ptr = memblock_alloc(available_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, available_size);
+
 	ASSERT_EQ(rgn->size, MEM_SIZE);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
@@ -442,6 +456,7 @@ static int alloc_no_memory_generic_check(void)
 	PREFIX_PUSH();
 
 	reset_memblock_regions();
+	fill_memblock();
 
 	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
 
@@ -472,6 +487,8 @@ static int alloc_bottom_up_simple_check(void)
 	allocated_ptr = memblock_alloc(SZ_2, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, SZ_2);
+
 	ASSERT_EQ(rgn->size, SZ_2);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
@@ -528,6 +545,7 @@ static int alloc_bottom_up_disjoint_check(void)
 	allocated_ptr = memblock_alloc(r2_size, alignment);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
@@ -571,6 +589,8 @@ static int alloc_bottom_up_before_check(void)
 	allocated_ptr = memblock_alloc(r1_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r1_size);
+
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
@@ -618,6 +638,8 @@ static int alloc_bottom_up_after_check(void)
 	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base);
 
@@ -669,6 +691,8 @@ static int alloc_bottom_up_second_fit_check(void)
 	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+
 	ASSERT_EQ(rgn->size, r2.size + r3_size);
 	ASSERT_EQ(rgn->base, r2.base);
 
diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index 76a8ad818f3a..0ca26fe12c38 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -60,16 +60,23 @@ void reset_memblock_attributes(void)
 	memblock.current_limit	= MEMBLOCK_ALLOC_ANYWHERE;
 }
 
+void fill_memblock(void)
+{
+	memset(memory_block.base, 1, MEM_SIZE);
+}
+
 void setup_memblock(void)
 {
 	reset_memblock_regions();
 	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
+	fill_memblock();
 }
 
 void dummy_physical_memory_init(void)
 {
 	memory_block.base = malloc(MEM_SIZE);
 	assert(memory_block.base);
+	fill_memblock();
 }
 
 void dummy_physical_memory_cleanup(void)
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index d396e5423a8e..7a16a7dc8f2c 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -51,6 +51,18 @@
 	assert((_expected) < (_seen)); \
 } while (0)
 
+/**
+ * ASSERT_MEM_EQ():
+ * Check that the first @_size bytes of @_seen are all equal to @_expected.
+ * If false, print failed test message (if running with --verbose) and then
+ * assert.
+ */
+#define ASSERT_MEM_EQ(_seen, _expected, _size) do { \
+	for (int _i = 0; _i < (_size); _i++) { \
+		ASSERT_EQ((_seen)[_i], (_expected)); \
+	} \
+} while (0)
+
 #define PREFIX_PUSH() prefix_push(__func__)
 
 /*
@@ -70,6 +82,7 @@ struct region {
 
 void reset_memblock_regions(void);
 void reset_memblock_attributes(void);
+void fill_memblock(void);
 void setup_memblock(void);
 void dummy_physical_memory_init(void);
 void dummy_physical_memory_cleanup(void);
-- 
2.25.1

