Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE8B5A34E5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiH0FnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH0FnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:43:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D280F9568E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h11-20020a17090a470b00b001fbc5ba5224so3841143pjg.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CbttiqUzc3kX4sqeN/EvVpgeeOdCTiCyPO9VnXUsAnE=;
        b=GDvONdxe41IqiptU7RtamIlPaVGdXhKtiHgSczs9fojJ3/NLrzt+QRnq6g4xUarFhF
         nfaNCDdnyHDlTJwCOXOraNeSmV1LedGYSYakBPwJ83e/nySdzij6+M/0HDQVNMlGwkOZ
         i6VCwXfuKQv1sK0AaEji8UM1QwJioy4/mOVpD3nlpcrqWxAgD4EruAx468FbhDWvyvdK
         nBvu/smGvG1kBcQuwBBXfCn/aBYq84rsCxfZgIdbuIx78zq3D5Jf9iSRXZbNKZcJwPW0
         ymPoYdNTM68on/zs1IWfJzYn8F4v/pE3GKWUMZlovmzA00JLawgV71a1lrU/DHXTJlCS
         9s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CbttiqUzc3kX4sqeN/EvVpgeeOdCTiCyPO9VnXUsAnE=;
        b=bw6Wm8oIFuCWkAwVS25pRElvIof+FDiuIWfajpjJAnolhsX+giBdykIDhlShmbzzs3
         zFDbBQ9EGmQICe7m2ZoO6XAsmAzUcARHe+4/rRNijKXW3u+a0z31t57ZcoRarinbbTW5
         Cx116H3uOnk7/OECcgY1Y8Sy2EAv/IbNv132xNRX9sS/t1GpjsmmTcRdmrKB2LM/kDBH
         vkLO+qN7cUkf4NyEPJN2kKAc8iZ65p/09/gFR1Bg10zS+RInuLYGPbXS5EdUgDfzP1yy
         nPFz6H1LNzvZPcMvSBBPCYyjHDTdXm58vGOahwUPA/DMYmQ5VYdBalRZQb5IyEgGeeBx
         dFOg==
X-Gm-Message-State: ACgBeo19zt9A+j+BwmhKULm9leLjBeAhnx/Bb8vyy+eMabRszov2s0Bx
        LpStMUVIdlNS6KxSrfu1bNs=
X-Google-Smtp-Source: AA6agR53dWSlgvRtlrbUzSd/iQ8GLUn4cYWvDJOzW45R04DHUjLWKFDTZ3AU+qNHZirGqnJ2dyosUQ==
X-Received: by 2002:a17:903:22c1:b0:16f:3d1:f5c with SMTP id y1-20020a17090322c100b0016f03d10f5cmr6837753plg.155.1661578985079;
        Fri, 26 Aug 2022 22:43:05 -0700 (PDT)
Received: from sophie ([89.46.114.37])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090341c100b0016b81679c1fsm2641722ple.216.2022.08.26.22.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 22:43:04 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>
Subject: [PATCH v3 1/8] memblock tests: update tests to check if memblock_alloc zeroed memory
Date:   Sat, 27 Aug 2022 00:42:43 -0500
Message-Id: <83ffb941b65074f40eb14552f8bfe5b71fe50abd.1661578349.git.remckee0@gmail.com>
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

Add an assert in memblock_alloc() tests where allocation is expected to
occur. The assert checks whether the entire chunk of allocated memory is
cleared.

The current memblock_alloc() tests do not check whether the allocated
memory was zeroed. memblock_alloc() should zero the allocated memory since
it is a wrapper for memblock_alloc_try_nid().

Reviewed-by: Shaoqin Huang <shaoqin.huang@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_api.c | 23 +++++++++++++++++++++++
 tools/testing/memblock/tests/common.c    |  7 +++++++
 tools/testing/memblock/tests/common.h    | 12 ++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
index a14f38eb8a89..c97da91a98d6 100644
--- a/tools/testing/memblock/tests/alloc_api.c
+++ b/tools/testing/memblock/tests/alloc_api.c
@@ -22,6 +22,8 @@ static int alloc_top_down_simple_check(void)
 	allocated_ptr = memblock_alloc(size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ(allocated_ptr, 0, size);
+
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, expected_start);
 
@@ -80,6 +82,8 @@ static int alloc_top_down_disjoint_check(void)
 	allocated_ptr = memblock_alloc(r2_size, alignment);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ(allocated_ptr, 0, r2_size);
+
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
 
@@ -125,6 +129,8 @@ static int alloc_top_down_before_check(void)
 	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ(allocated_ptr, 0, r2_size);
+
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - total_size);
 
@@ -173,6 +179,8 @@ static int alloc_top_down_after_check(void)
 	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ(allocated_ptr, 0, r2_size);
+
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base - r2_size);
 
@@ -223,6 +231,8 @@ static int alloc_top_down_second_fit_check(void)
 	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
+
 	ASSERT_EQ(rgn->size, r2.size + r3_size);
 	ASSERT_EQ(rgn->base, r2.base - r3_size);
 
@@ -277,6 +287,8 @@ static int alloc_in_between_generic_check(void)
 	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
+
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base - r2.size - r3_size);
 
@@ -418,6 +430,8 @@ static int alloc_limited_space_generic_check(void)
 	allocated_ptr = memblock_alloc(available_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ(allocated_ptr, 0, available_size);
+
 	ASSERT_EQ(rgn->size, MEM_SIZE);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
@@ -472,6 +486,8 @@ static int alloc_bottom_up_simple_check(void)
 	allocated_ptr = memblock_alloc(SZ_2, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ(allocated_ptr, 0, SZ_2);
+
 	ASSERT_EQ(rgn->size, SZ_2);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
@@ -528,6 +544,7 @@ static int alloc_bottom_up_disjoint_check(void)
 	allocated_ptr = memblock_alloc(r2_size, alignment);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ(allocated_ptr, 0, r2_size);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
@@ -571,6 +588,8 @@ static int alloc_bottom_up_before_check(void)
 	allocated_ptr = memblock_alloc(r1_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ(allocated_ptr, 0, r1_size);
+
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
@@ -618,6 +637,8 @@ static int alloc_bottom_up_after_check(void)
 	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ(allocated_ptr, 0, r2_size);
+
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base);
 
@@ -669,6 +690,8 @@ static int alloc_bottom_up_second_fit_check(void)
 	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
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
index d396e5423a8e..93e559780890 100644
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
+		ASSERT_EQ(((char *)_seen)[_i], (_expected)); \
+	} \
+} while (0)
+
 #define PREFIX_PUSH() prefix_push(__func__)
 
 /*
-- 
2.25.1

