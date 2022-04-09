Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5991B4FA163
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbiDIBrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiDIBra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:47:30 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C602CE08;
        Fri,  8 Apr 2022 18:45:24 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id o18so4880180qtk.7;
        Fri, 08 Apr 2022 18:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L5ahqKEOWsqICx2dcXP1L2JHpg9KAd1o8Zg/n5Citp4=;
        b=KT2A5Z+TYl+/GZpwdIKFvp8vv5T126qkDv1SgL1VbnMoJI4b+ile+T69BJuWL3g1tg
         2btEF0r1JnMSnPZ6psxbdGidz+SGvwEQTLeQkFRb17CgHk30rvW/Qi6XY8ZX8+8vjZ0b
         +ooDhT5EGlGxRTtDwGvbIZAZ3GucIwDwAw4VuHWZZxcr8Dlsh//ADL3DuzkcgpMzZJuF
         /4/TDpr/w8jPhEmWlIg7RSWbn++pUMVuTsqoGQpd6TvtoLHee0NN0vDyHeF/kE3Kl6VD
         jmkmpqQvCC5K+sfmkXlTPrwV3zIDpHfs8Vy72HJW4LOyY+MAizFbLh8Sbpny+HysQ/7P
         tKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L5ahqKEOWsqICx2dcXP1L2JHpg9KAd1o8Zg/n5Citp4=;
        b=tghyUEcqosuhRyd46OHsgr3tXjyLI61D4cK9igqjUKE7cgCzlUurAQTmYSfJDw5LrY
         5jfXcNGnQ7RtQ07tp3dswG4BPWnONG57PYEuFxIB9IX6IZb3OhoPRejd0BZ4yPaATDpA
         tDiVaJBL1M2JTi0vOkEVB6hO9OQQD5TXxz6OqGKDVy5TxZiP3Bn8+GpmEfJYKi3h0l7l
         cKIAYgp9vNoCraSRDOPrYQkEhYIToHtbpCdJ+aZREPrMEjfRKxdFxnknXmv6Wafh6wk/
         19SHRzfY7RxkgxzbsRh3P60bQt1GZbbV6TeXWDIx9DOoUvW+C5amRXKjmWwsgOiNaPV4
         n9/A==
X-Gm-Message-State: AOAM530B4zxWF8TZ7rpPr2VQXK2qmSTXjoGckZwrBL7LZx5/IzlGw/RB
        ZhJGCJ2vIj6vKsX3+STnkIY=
X-Google-Smtp-Source: ABdhPJwcbo1es3g4yEmMzYMkHF4ygEWw3WuJtUVkrMjx8LZXba6s9BXuBLTipi1TT7eQC1eew4RQNg==
X-Received: by 2002:a05:622a:120d:b0:2e1:c9f5:c13 with SMTP id y13-20020a05622a120d00b002e1c9f50c13mr18134238qtx.599.1649468723650;
        Fri, 08 Apr 2022 18:45:23 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d11-20020a37680b000000b0069ab73d9981sm2669333qkc.38.2022.04.08.18.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 18:45:22 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     corbet@lwn.net, bsingharora@gmail.com, mike.kravetz@oracle.com,
        yang.yang29@zte.com.cn, peterz@infradead.org,
        wang.yong12@zte.com.cn, ran.xiaokai@zte.com.cn,
        jiang.xuexin@zte.com.cn, thomas.orgis@uni-hamburg.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, sfr@canb.auug.org.au
Subject: [PATCH v2] delayacct: track delays from write-protect copy
Date:   Sat,  9 Apr 2022 01:43:44 +0000
Message-Id: <20220409014342.2505532-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Delay accounting does not track the delay of write-protect copy. When
tasks trigger many write-protect copys(include COW and unsharing of
anonymous pages[1]), it may spend a amount of time waiting for them.
To get the delay of tasks in write-protect copy, could help users to
evaluate the impact of using KSM or fork() or GUP.

Also update tools/accounting/getdelays.c:

    / # ./getdelays -dl -p 231
    print delayacct stats ON
    listen forever
    PID     231

    CPU             count     real total  virtual total    delay total  delay average
                     6247     1859000000     2154070021     1674255063          0.268ms
    IO              count    delay total  delay average
                        0              0              0ms
    SWAP            count    delay total  delay average
                        0              0              0ms
    RECLAIM         count    delay total  delay average
                        0              0              0ms
    THRASHING       count    delay total  delay average
                        0              0              0ms
    COMPACT         count    delay total  delay average
                        3          72758              0ms
    WPCOPY          count    delay total  delay average
                     3635      271567604              0ms

[1] commit 31cc5bc4af70("mm: support GUP-triggered unsharing of anonymous pages")

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: wangyong <wang.yong12@zte.com.cn>
---
v2:
- fix compile error of implicit declaration of function.
---
 Documentation/accounting/delay-accounting.rst |  5 +++-
 include/linux/delayacct.h                     | 28 +++++++++++++++++++
 include/uapi/linux/taskstats.h                |  6 +++-
 kernel/delayacct.c                            | 16 +++++++++++
 mm/hugetlb.c                                  |  8 ++++++
 mm/memory.c                                   |  8 ++++++
 tools/accounting/getdelays.c                  |  8 +++++-
 7 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/Documentation/accounting/delay-accounting.rst b/Documentation/accounting/delay-accounting.rst
index 197fe319cbec..241d1a87f2cd 100644
--- a/Documentation/accounting/delay-accounting.rst
+++ b/Documentation/accounting/delay-accounting.rst
@@ -15,6 +15,7 @@ c) swapping in pages
 d) memory reclaim
 e) thrashing page cache
 f) direct compact
+g) write-protect copy
 
 and makes these statistics available to userspace through
 the taskstats interface.
@@ -48,7 +49,7 @@ this structure. See
 for a description of the fields pertaining to delay accounting.
 It will generally be in the form of counters returning the cumulative
 delay seen for cpu, sync block I/O, swapin, memory reclaim, thrash page
-cache, direct compact etc.
+cache, direct compact, write-protect copy etc.
 
 Taking the difference of two successive readings of a given
 counter (say cpu_delay_total) for a task will give the delay
@@ -117,6 +118,8 @@ Get sum of delays, since system boot, for all pids with tgid 5::
 	                    0              0              0ms
 	COMPACT         count    delay total  delay average
 	                    0              0              0ms
+        WPCOPY          count    delay total  delay average
+                            0              0              0ms
 
 Get IO accounting for pid 1, it works only with -p::
 
diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 6b16a6930a19..58aea2d7385c 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -45,9 +45,13 @@ struct task_delay_info {
 	u64 compact_start;
 	u64 compact_delay;	/* wait for memory compact */
 
+	u64 wpcopy_start;
+	u64 wpcopy_delay;	/* wait for write-protect copy */
+
 	u32 freepages_count;	/* total count of memory reclaim */
 	u32 thrashing_count;	/* total count of thrash waits */
 	u32 compact_count;	/* total count of memory compact */
+	u32 wpcopy_count;	/* total count of write-protect copy */
 };
 #endif
 
@@ -75,6 +79,8 @@ extern void __delayacct_swapin_start(void);
 extern void __delayacct_swapin_end(void);
 extern void __delayacct_compact_start(void);
 extern void __delayacct_compact_end(void);
+extern void __delayacct_wpcopy_start(void);
+extern void __delayacct_wpcopy_end(void);
 
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
@@ -191,6 +197,24 @@ static inline void delayacct_compact_end(void)
 		__delayacct_compact_end();
 }
 
+static inline void delayacct_wpcopy_start(void)
+{
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
+	if (current->delays)
+		__delayacct_wpcopy_start();
+}
+
+static inline void delayacct_wpcopy_end(void)
+{
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
+	if (current->delays)
+		__delayacct_wpcopy_end();
+}
+
 #else
 static inline void delayacct_init(void)
 {}
@@ -225,6 +249,10 @@ static inline void delayacct_compact_start(void)
 {}
 static inline void delayacct_compact_end(void)
 {}
+static inline void delayacct_wpcopy_start(void)
+{}
+static inline void delayacct_wpcopy_end(void)
+{}
 
 #endif /* CONFIG_TASK_DELAY_ACCT */
 
diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index 736154171489..a7f5b11a8f1b 100644
--- a/include/uapi/linux/taskstats.h
+++ b/include/uapi/linux/taskstats.h
@@ -34,7 +34,7 @@
  */
 
 
-#define TASKSTATS_VERSION	12
+#define TASKSTATS_VERSION	13
 #define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
 					 * in linux/sched.h */
 
@@ -194,6 +194,10 @@ struct taskstats {
 	__u64   ac_exe_dev;     /* program binary device ID */
 	__u64   ac_exe_inode;   /* program binary inode number */
 	/* v12 end */
+
+	/* v13: Delay waiting for write-protect copy */
+	__u64    wpcopy_count;
+	__u64    wpcopy_delay_total;
 };
 
 
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 2c1e18f7c5cf..164ed9ef77a3 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -177,11 +177,14 @@ int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	d->thrashing_delay_total = (tmp < d->thrashing_delay_total) ? 0 : tmp;
 	tmp = d->compact_delay_total + tsk->delays->compact_delay;
 	d->compact_delay_total = (tmp < d->compact_delay_total) ? 0 : tmp;
+	tmp = d->wpcopy_delay_total + tsk->delays->wpcopy_delay;
+	d->wpcopy_delay_total = (tmp < d->wpcopy_delay_total) ? 0 : tmp;
 	d->blkio_count += tsk->delays->blkio_count;
 	d->swapin_count += tsk->delays->swapin_count;
 	d->freepages_count += tsk->delays->freepages_count;
 	d->thrashing_count += tsk->delays->thrashing_count;
 	d->compact_count += tsk->delays->compact_count;
+	d->wpcopy_count += tsk->delays->wpcopy_count;
 	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 
 	return 0;
@@ -249,3 +252,16 @@ void __delayacct_compact_end(void)
 		      &current->delays->compact_delay,
 		      &current->delays->compact_count);
 }
+
+void __delayacct_wpcopy_start(void)
+{
+	current->delays->wpcopy_start = local_clock();
+}
+
+void __delayacct_wpcopy_end(void)
+{
+	delayacct_end(&current->delays->lock,
+		      &current->delays->wpcopy_start,
+		      &current->delays->wpcopy_delay,
+		      &current->delays->wpcopy_count);
+}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fb5a549169ce..0d2fe8c020c9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -32,6 +32,7 @@
 #include <linux/cma.h>
 #include <linux/migrate.h>
 #include <linux/nospec.h>
+#include <linux/delayacct.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -5173,6 +5174,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	pte = huge_ptep_get(ptep);
 	old_page = pte_page(pte);
 
+	delayacct_wpcopy_start();
+
 retry_avoidcopy:
 	/*
 	 * If no-one else is actually using this page, we're the exclusive
@@ -5183,6 +5186,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			page_move_anon_rmap(old_page, vma);
 		if (likely(!unshare))
 			set_huge_ptep_writable(vma, haddr, ptep);
+
+		delayacct_wpcopy_end();
 		return 0;
 	}
 	VM_BUG_ON_PAGE(PageAnon(old_page) && PageAnonExclusive(old_page),
@@ -5252,6 +5257,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * race occurs while re-acquiring page table
 			 * lock, and our job is done.
 			 */
+			delayacct_wpcopy_end();
 			return 0;
 		}
 
@@ -5310,6 +5316,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	put_page(old_page);
 
 	spin_lock(ptl); /* Caller expects lock to be held */
+
+	delayacct_wpcopy_end();
 	return ret;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index a82bf21be5e3..aad64c51c175 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3008,6 +3008,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	int page_copied = 0;
 	struct mmu_notifier_range range;
 
+	delayacct_wpcopy_start();
+
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
 
@@ -3032,6 +3034,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			put_page(new_page);
 			if (old_page)
 				put_page(old_page);
+
+			delayacct_wpcopy_end();
 			return 0;
 		}
 	}
@@ -3138,12 +3142,16 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			free_swap_cache(old_page);
 		put_page(old_page);
 	}
+
+	delayacct_wpcopy_end();
 	return page_copied && !unshare ? VM_FAULT_WRITE : 0;
 oom_free_new:
 	put_page(new_page);
 oom:
 	if (old_page)
 		put_page(old_page);
+
+	delayacct_wpcopy_end();
 	return VM_FAULT_OOM;
 }
 
diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
index 11e86739456d..e83e6e47a21e 100644
--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -207,6 +207,8 @@ static void print_delayacct(struct taskstats *t)
 	       "THRASHING%12s%15s%15s\n"
 	       "      %15llu%15llu%15llums\n"
 	       "COMPACT  %12s%15s%15s\n"
+	       "      %15llu%15llu%15llums\n"
+	       "WPCOPY   %12s%15s%15s\n"
 	       "      %15llu%15llu%15llums\n",
 	       "count", "real total", "virtual total",
 	       "delay total", "delay average",
@@ -234,7 +236,11 @@ static void print_delayacct(struct taskstats *t)
 	       "count", "delay total", "delay average",
 	       (unsigned long long)t->compact_count,
 	       (unsigned long long)t->compact_delay_total,
-	       average_ms(t->compact_delay_total, t->compact_count));
+	       average_ms(t->compact_delay_total, t->compact_count),
+	       "count", "delay total", "delay average",
+	       (unsigned long long)t->wpcopy_count,
+	       (unsigned long long)t->wpcopy_delay_total,
+	       average_ms(t->wpcopy_delay_total, t->wpcopy_count));
 }
 
 static void task_context_switch_counts(struct taskstats *t)
-- 
2.25.1

