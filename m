Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7935997E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbiHSIkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346618AbiHSIjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:39:37 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F05952FED
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:39:36 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e28so2865914qts.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZVAH52wX+Vt0VKFbPcXrR0NQYeosP7RaFGxexdtx2/k=;
        b=RBvhEylwETKO3LQxwWSeaQIT8zFQsVcb2ac4fQv65r4ZaKJOIxncaj3jU95FlpRq1C
         miI4Mo+in6YwX1eXdwPiPt2Mf/MuUKer/ORZsLwibFNz2IYhiR261oGgJFHi/wofDzUl
         6SvY+GbnuYbT23bJp2HASErvNrB5tVY7rlMIM1KFKh5v86IthHVkwds+7aErsgGTePLH
         GvK7SijEyufalcqph/NO0rUf+Af2ZQw7X7P4sbIXHELV8ijwWDn0BM2Jt0MRIqCmK4tG
         tA4v+A7Oro3k3VWl14IWMrKgTMrNwIZ8FMO/j2LhzneVE1FstWD0gvhVVXd3vrngiHlR
         PzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZVAH52wX+Vt0VKFbPcXrR0NQYeosP7RaFGxexdtx2/k=;
        b=GdG3Doedhh/4bJ66QigzS8ylByujHgEEPs089ycCMWB+3QBl4qVirHLatKMg/NIacv
         M/4v/HpKr3CCw6w2QiSeiWBsA/GtbojIafkvkpw1hxWmaLZKwdWBhLwc5RhVlhBMpK5v
         nuNw1wB/AJKOfUiWs4KqaUsQseWQK2WMrvpabBUuGgAeo9BPuuMIaE0lzt1hxoni8Lq/
         DEEslsk0jCof8/9dodz39LehSzF3620UR+pS65R3fQ6YcAxsaNLAhqUjzdXfFyqqY+P9
         HEHU6d385pdF0vYVwyTvLZ+uiiS9BsYDxBsE0l1a4QeGdF0YstmMr/YbKP88QQUZS/Ab
         0w9w==
X-Gm-Message-State: ACgBeo0xBowivm1wpxhvX2KTj34kwnS8B/q4GT9GPhgk0aGnsKM5mlqZ
        0AREZcFIum56K80ad6/3lfk=
X-Google-Smtp-Source: AA6agR63GuJ9BaRkAT1HJfWOqq0Tozm0ITWs+Ffdd9lihkVdVI6HsKLlY1QYEJeOEWwacxzbNVZz4w==
X-Received: by 2002:a05:622a:1185:b0:343:7de8:c0f2 with SMTP id m5-20020a05622a118500b003437de8c0f2mr5509076qtk.256.1660898375533;
        Fri, 19 Aug 2022 01:39:35 -0700 (PDT)
Received: from sophie ([89.46.62.64])
        by smtp.gmail.com with ESMTPSA id az41-20020a05620a172900b006bb8b5b79efsm3265212qkb.129.2022.08.19.01.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:39:35 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>
Subject: [PATCH v2 1/8] memblock tests: update tests to check if memblock_alloc zeroed memory
Date:   Fri, 19 Aug 2022 01:34:49 -0700
Message-Id: <669782f4f508c3dd60c5efd6d130d12a77573448.1660897732.git.remckee0@gmail.com>
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

Add an assert in memblock_alloc() tests where allocation is expected to
occur. The assert checks whether the entire chunk of allocated memory is
cleared.

The current memblock_alloc() tests do not check whether the allocated
memory was zeroed. memblock_alloc() should zero the allocated memory since
it is a wrapper for memblock_alloc_try_nid().

Reviewed-by: Shaoqin Huang <shaoqin.huang@intel.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_api.c | 23 +++++++++++++++++++++++
 tools/testing/memblock/tests/common.c    |  7 +++++++
 tools/testing/memblock/tests/common.h    | 12 ++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
index a14f38eb8a89..aefb67557de9 100644
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
 
@@ -472,6 +486,8 @@ static int alloc_bottom_up_simple_check(void)
 	allocated_ptr = memblock_alloc(SZ_2, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, SZ_2);
+
 	ASSERT_EQ(rgn->size, SZ_2);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
@@ -528,6 +544,7 @@ static int alloc_bottom_up_disjoint_check(void)
 	allocated_ptr = memblock_alloc(r2_size, alignment);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
@@ -571,6 +588,8 @@ static int alloc_bottom_up_before_check(void)
 	allocated_ptr = memblock_alloc(r1_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r1_size);
+
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
@@ -618,6 +637,8 @@ static int alloc_bottom_up_after_check(void)
 	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base);
 
@@ -669,6 +690,8 @@ static int alloc_bottom_up_second_fit_check(void)
 	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+
 	ASSERT_EQ(rgn->size, r2.size + r3_size);
 	ASSERT_EQ(rgn->base, r2.base);
 
diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index 76a8ad818f3a..eec6901081af 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -60,16 +60,23 @@ void reset_memblock_attributes(void)
 	memblock.current_limit	= MEMBLOCK_ALLOC_ANYWHERE;
 }
 
+static inline void fill_memblock(void)
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
index d396e5423a8e..29756e652e3e 100644
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
-- 
2.25.1

