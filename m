Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55C55A3233
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbiHZWsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345358AbiHZWs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:48:28 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C215DE97E8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 15:48:27 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s8-20020a170902ea0800b00172e456031eso1841126plg.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 15:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=l6N8I12ejNlrTpzE1zHpjpuxPcjHnjsqdBCs4VzChgw=;
        b=jLHbx3G5CZLgmkuGkmwbz4/eihPdIy9DXuNsrnhR4RibF75i1m93fFS+WFI+/vCg5i
         BLZGkvEypm6VguvN/xCoLfW3mWJxNv/i+70ODLaLwHjX47Vt6GrHUyg2KGuJLmtk5py5
         tZHVegWijweFwPlUcQ2ssKtSZHtUPmJE8Nc8MUWrPBpPQYe1bbiFosqTkkJcIa9cGZc8
         paoG+gXYdHZVvcM2peaslwjglAm9M2XuyYXwUqVAGWeJNNxcL2HcVdwP4hhoh0b9i5Hb
         Sj+gOlzwHvbsoRB75wN4tI8/UlCdam4RUqYbbWpKflCaCnZS44y0txm/Sxh4mndbVN0U
         9wDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=l6N8I12ejNlrTpzE1zHpjpuxPcjHnjsqdBCs4VzChgw=;
        b=Vfe0FHj7nOfMW3FQDE/FY3dNUI0ZjlIRgI34YBcd+rkqrdDpmXBb+8CdZipyUu/i20
         RtH90hJ1VtaAL0ptZuLMT7nDJAVv8RSWj0EbhKDH+Tp8zoWzO+Hve3H7JOGfsGX4ygQm
         7/VtpPlAk8p92E9P/GiIEvApiqCX9UuoGXDVobG4ATSzAalP84Rn/b50telHIVfR1w2C
         7LCyC2Smu9huM4X3M7LEmElMLcA09/PUfo9IurILzwYJzOvpnEI1GYe9f9rygvY9wa3y
         Ckfp7GJelDhdn1+r8qyC3XnAecSwMmjm+GiWnoPgLUjkINuN9LSw6w3P4JfvMkT1JWKH
         0ouA==
X-Gm-Message-State: ACgBeo0g88nxAyXzlpHlVX0K88Mtk118OdJAGOJDf1vxdC5ov2AdvUNf
        utGO/MJZijfMHcQHgBr4ZZVH7IB+V4GphA==
X-Google-Smtp-Source: AA6agR41a3o8U9TaaCiHdPrFfzHtW5YsUptLs9UjrmBRqMbl0pNX2tOFfCzIJKiou/78YOv3jXspeUqzmdvCdA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a00:1a8d:b0:52f:433:e499 with SMTP
 id e13-20020a056a001a8d00b0052f0433e499mr5931967pfv.70.1661554107298; Fri, 26
 Aug 2022 15:48:27 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:48:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826224812.550793-1-shakeelb@google.com>
Subject: [PATCH] mm: deduplicate cacheline padding code
From:   Shakeel Butt <shakeelb@google.com>
To:     Michal Hocko <mhocko@kernel.org>, Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three users (mmzone.h, memcontrol.h, page_counter.h) using
similar code for forcing cacheline padding between fields of different
structures. Dedup that code.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Suggested-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/cache.h        | 13 +++++++++++++
 include/linux/memcontrol.h   | 13 ++-----------
 include/linux/mmzone.h       | 24 +++++-------------------
 include/linux/page_counter.h | 13 ++-----------
 4 files changed, 22 insertions(+), 41 deletions(-)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index d742c57eaee5..5da1bbd96154 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -85,4 +85,17 @@
 #define cache_line_size()	L1_CACHE_BYTES
 #endif
 
+/*
+ * Helper to add padding within a struct to ensure data fall into separate
+ * cachelines.
+ */
+#if defined(CONFIG_SMP)
+struct cacheline_padding {
+	char x[0];
+} ____cacheline_internodealigned_in_smp;
+#define CACHELINE_PADDING(name)		struct cacheline_padding name
+#else
+#define CACHELINE_PADDING(name)
+#endif
+
 #endif /* __LINUX_CACHE_H */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 344022f102c2..60545e4a1c03 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -185,15 +185,6 @@ struct mem_cgroup_thresholds {
 	struct mem_cgroup_threshold_ary *spare;
 };
 
-#if defined(CONFIG_SMP)
-struct memcg_padding {
-	char x[0];
-} ____cacheline_internodealigned_in_smp;
-#define MEMCG_PADDING(name)      struct memcg_padding name
-#else
-#define MEMCG_PADDING(name)
-#endif
-
 /*
  * Remember four most recent foreign writebacks with dirty pages in this
  * cgroup.  Inode sharing is expected to be uncommon and, even if we miss
@@ -304,7 +295,7 @@ struct mem_cgroup {
 	spinlock_t		move_lock;
 	unsigned long		move_lock_flags;
 
-	MEMCG_PADDING(_pad1_);
+	CACHELINE_PADDING(_pad1_);
 
 	/* memory.stat */
 	struct memcg_vmstats	vmstats;
@@ -326,7 +317,7 @@ struct mem_cgroup {
 	struct list_head objcg_list;
 #endif
 
-	MEMCG_PADDING(_pad2_);
+	CACHELINE_PADDING(_pad2_);
 
 	/*
 	 * set > 0 if pages under this cgroup are moving to other cgroup.
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 14919b2fb5f5..084f47dc0fad 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -121,20 +121,6 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
 
 struct pglist_data;
 
-/*
- * Add a wild amount of padding here to ensure data fall into separate
- * cachelines.  There are very few zone structures in the machine, so space
- * consumption is not a concern here.
- */
-#if defined(CONFIG_SMP)
-struct zone_padding {
-	char x[0];
-} ____cacheline_internodealigned_in_smp;
-#define ZONE_PADDING(name)	struct zone_padding name;
-#else
-#define ZONE_PADDING(name)
-#endif
-
 #ifdef CONFIG_NUMA
 enum numa_stat_item {
 	NUMA_HIT,		/* allocated in intended node */
@@ -837,7 +823,7 @@ struct zone {
 	int initialized;
 
 	/* Write-intensive fields used from the page allocator */
-	ZONE_PADDING(_pad1_)
+	CACHELINE_PADDING(_pad1_)
 
 	/* free areas of different sizes */
 	struct free_area	free_area[MAX_ORDER];
@@ -849,7 +835,7 @@ struct zone {
 	spinlock_t		lock;
 
 	/* Write-intensive fields used by compaction and vmstats. */
-	ZONE_PADDING(_pad2_)
+	CACHELINE_PADDING(_pad2_)
 
 	/*
 	 * When free pages are below this point, additional steps are taken
@@ -886,7 +872,7 @@ struct zone {
 
 	bool			contiguous;
 
-	ZONE_PADDING(_pad3_)
+	CACHELINE_PADDING(_pad3_)
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
@@ -1194,7 +1180,7 @@ typedef struct pglist_data {
 #endif /* CONFIG_NUMA */
 
 	/* Write-intensive fields used by page reclaim */
-	ZONE_PADDING(_pad1_)
+	CACHELINE_PADDING(_pad1_)
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 	/*
@@ -1239,7 +1225,7 @@ typedef struct pglist_data {
 	struct lru_gen_mm_walk	mm_walk;
 #endif
 
-	ZONE_PADDING(_pad2_)
+	CACHELINE_PADDING(_pad2_)
 
 	/* Per-node vmstats */
 	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 78a1c934e416..c141ea9a95ef 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -7,22 +7,13 @@
 #include <linux/kernel.h>
 #include <asm/page.h>
 
-#if defined(CONFIG_SMP)
-struct pc_padding {
-	char x[0];
-} ____cacheline_internodealigned_in_smp;
-#define PC_PADDING(name)	struct pc_padding name
-#else
-#define PC_PADDING(name)
-#endif
-
 struct page_counter {
 	/*
 	 * Make sure 'usage' does not share cacheline with any other field. The
 	 * memcg->memory.usage is a hot member of struct mem_cgroup.
 	 */
 	atomic_long_t usage;
-	PC_PADDING(_pad1_);
+	CACHELINE_PADDING(_pad1_);
 
 	/* effective memory.min and memory.min usage tracking */
 	unsigned long emin;
@@ -38,7 +29,7 @@ struct page_counter {
 	unsigned long failcnt;
 
 	/* Keep all the read most fields in a separete cacheline. */
-	PC_PADDING(_pad2_);
+	CACHELINE_PADDING(_pad2_);
 
 	unsigned long min;
 	unsigned long low;
-- 
2.37.2.672.g94769d06f0-goog

