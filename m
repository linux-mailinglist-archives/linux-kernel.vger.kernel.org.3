Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4945A3256
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 01:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiHZXGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 19:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345190AbiHZXGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:06:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4039E9A82
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 16:06:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33d9f6f4656so47338767b3.21
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 16:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=AErA6r+S0T2+MIHy6k4+EgHRpVoazsJhQoBwdMNs6OQ=;
        b=rQ2yqilamgWFxD5OxWxgwRd3ZenVlKBZDKCtoZMBtHyXDycAdbTNWiEQHDPPndoANt
         LwY9Mg1z2RiY3386JkyJR7WT7DpwsI4P+BZcka6KIByvHSOta6ou1A6gWtDUdzLPCOPF
         SI6m5D9rOnOrAbDWL+zxlYC2x2uWNZYc8i3xwOZxKGmqUCcX6CYOwHjp2hxp3Nae2Kwu
         GuWdgKVb0raU3DhmOwE4lzqZLulzNQU+XeaQgCIGpTQfXnNluBS5aclifoklvZHElqFX
         vWBKb4w1xMXEYteERS9hJrB4eVnct4iR/Ggw7iQH7IxzAdMPnsLOgzxzouCOWlboIvTv
         1o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=AErA6r+S0T2+MIHy6k4+EgHRpVoazsJhQoBwdMNs6OQ=;
        b=KMQ+OK6mcycxqSjMrVi61RKATy8P/dURERVPhOr7CJvGMD3u7EalVZISOBlryONNcv
         2tcBF9nRjXgJ6U0bZ5/+/xKxnOZwS5o8JlbMt6jmatjlbJCS8TIRFn2SFdCF08FieK4g
         kIpLXVI4i9S5X/l1J5xFeW+/ICWa2rgGEWoAVzzRVSmx5CDqQaO4EbNBqDtwZ8bjgA0T
         vcG8IcTRVrAB9vJin/C3xc1q0RKxPm78B8GcCgmqeLAw0We9e0rCHW+zWRY0S3tEN/zb
         Orkmhu84Bld4L59832M4pdmoqYOZZAEFXA17E7d7F/h7ACd5JAmCEMJcSLUE4y7jxilI
         ps6Q==
X-Gm-Message-State: ACgBeo3dmZRpba4NcJ1naR8tz0WkrHsE+OReKYtAZ1DuTTlIDM5mJ2Cr
        wd+OMBuTUlW7snnTDwLQvg1u2wTuOkAAdw==
X-Google-Smtp-Source: AA6agR6q5EJP/GkNg/PNBka+3A3ihvPAbli2Ztt0HU+f7NUyjnHeTeAKy9bBjR/3gpFsR9Z44fIBCV6ivqlklQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:2493:0:b0:695:839:3a5a with SMTP id
 k141-20020a252493000000b0069508393a5amr1776831ybk.468.1661555208691; Fri, 26
 Aug 2022 16:06:48 -0700 (PDT)
Date:   Fri, 26 Aug 2022 23:06:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826230642.566725-1-shakeelb@google.com>
Subject: [PATCH v2] mm: deduplicate cacheline padding code
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
Changes since v1:
- add semicolons in mmzone.h

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
index 14919b2fb5f5..b30f5f0dd13f 100644
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
+	CACHELINE_PADDING(_pad1_);
 
 	/* free areas of different sizes */
 	struct free_area	free_area[MAX_ORDER];
@@ -849,7 +835,7 @@ struct zone {
 	spinlock_t		lock;
 
 	/* Write-intensive fields used by compaction and vmstats. */
-	ZONE_PADDING(_pad2_)
+	CACHELINE_PADDING(_pad2_);
 
 	/*
 	 * When free pages are below this point, additional steps are taken
@@ -886,7 +872,7 @@ struct zone {
 
 	bool			contiguous;
 
-	ZONE_PADDING(_pad3_)
+	CACHELINE_PADDING(_pad3_);
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
@@ -1194,7 +1180,7 @@ typedef struct pglist_data {
 #endif /* CONFIG_NUMA */
 
 	/* Write-intensive fields used by page reclaim */
-	ZONE_PADDING(_pad1_)
+	CACHELINE_PADDING(_pad1_);
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 	/*
@@ -1239,7 +1225,7 @@ typedef struct pglist_data {
 	struct lru_gen_mm_walk	mm_walk;
 #endif
 
-	ZONE_PADDING(_pad2_)
+	CACHELINE_PADDING(_pad2_);
 
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

