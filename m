Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD9E4F9326
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiDHKkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiDHKkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:40:51 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD96DF33;
        Fri,  8 Apr 2022 03:38:46 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 75so1594488qkk.8;
        Fri, 08 Apr 2022 03:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mG2gws1am1gOrwdE88okuwfDPFBk0cTSxDkUvHCcH/g=;
        b=foxd5QtW399Jj7DRvpiIdnOPcNUc0ehGdan1ikRC+av1rFzEov2M0nJVf9KsQ9Zuge
         X3gbDpVrBCbLGqTrEn5DxLLi+pNCx4aeM/HzH77xWMY2mEZy4aNd0sHngvLEd/kGRiPO
         6tQBYiLrBEh0sG1cZiWT7yHTkual/vwkTKpyAkb6OCU+uASBataPFtrxIgcm6mFbvKCH
         DUE/XNMyI/yWmqAK/qdsN42h/A6QbBaQpjUSMonl1m0kIP9T5Pf/sUf/az6ZJEzIhCst
         3Dg87ILFjS8ApBsywumPO0kgJ+A4uZvq8SSDeeRmC2e1a08rwUpCCf+OQpKD4P9IsUnL
         jATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mG2gws1am1gOrwdE88okuwfDPFBk0cTSxDkUvHCcH/g=;
        b=QXyYoLIbsHOBnWkgUvYufkjn0omLEX0Az0IsOk3Kk9QIIJTNm5puc010vesv8T72wv
         Lyes9nVK+1Yhmof7892Raj5LN88Y33Bxy4+E/NfZh957J2DegoZGKM//PfROOBqq1Bk8
         LefHVbe9/cKy1ZSGCK7FmVXLGWSqCIpQyjAbAwHQLuzgcpUIzCKOnRIhvn4SXnl6ggIT
         5KT4bS6dhDzgBRAZDO1PQbiBcoKL779DXhkCVfcVn+AVyDV97WZmgBFOnWTXKF1y8DZ8
         2ZTaB8bPD8AsH+dblS5bh/n9nlP9hoWrTGu0IoDdVuou/E6a97PBM/o9Kt1x3iiBwJ0i
         dXUw==
X-Gm-Message-State: AOAM533eQ+reeJZXshq82bSc6dWZQTNuS2E7xyY/T8QRciRe9LHy+AvJ
        wTrm8q58rd6fbYFjb+UN5E8=
X-Google-Smtp-Source: ABdhPJxgitZIQDwYsW4TE9GUJduhStEYlk6pviIfjVmoY6YN1+y6+ttQ/sV1fIR0zwbe6RFvOju/0g==
X-Received: by 2002:a05:620a:1916:b0:67d:69ef:6715 with SMTP id bj22-20020a05620a191600b0067d69ef6715mr12140222qkb.514.1649414325184;
        Fri, 08 Apr 2022 03:38:45 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bm1-20020a05620a198100b0047bf910892bsm14924850qkb.65.2022.04.08.03.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 03:38:44 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     corbet@lwn.net, bsingharora@gmail.com, mike.kravetz@oracle.com,
        yang.yang29@zte.com.cn, wang.yong12@zte.com.cn,
        peterz@infradead.org, jiang.xuexin@zte.com.cn,
        sfr@canb.auug.org.au, thomas.orgis@uni-hamburg.de,
        ran.xiaokai@zte.com.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] delayacct: track delays from write-protect copy
Date:   Fri,  8 Apr 2022 10:37:10 +0000
Message-Id: <20220408103708.2495882-1-yang.yang29@zte.com.cn>
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
 Documentation/accounting/delay-accounting.rst |  5 +++-
 include/linux/delayacct.h                     | 28 +++++++++++++++++++
 include/uapi/linux/taskstats.h                |  6 +++-
 kernel/delayacct.c                            | 16 +++++++++++
 mm/hugetlb.c                                  |  7 +++++
 mm/memory.c                                   |  8 ++++++
 tools/accounting/getdelays.c                  |  8 +++++-
 7 files changed, 75 insertions(+), 3 deletions(-)

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
index fb5a549169ce..b131d44741dd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5173,6 +5173,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	pte = huge_ptep_get(ptep);
 	old_page = pte_page(pte);
 
+	delayacct_wpcopy_start();
+
 retry_avoidcopy:
 	/*
 	 * If no-one else is actually using this page, we're the exclusive
@@ -5183,6 +5185,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			page_move_anon_rmap(old_page, vma);
 		if (likely(!unshare))
 			set_huge_ptep_writable(vma, haddr, ptep);
+
+		delayacct_wpcopy_end();
 		return 0;
 	}
 	VM_BUG_ON_PAGE(PageAnon(old_page) && PageAnonExclusive(old_page),
@@ -5252,6 +5256,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * race occurs while re-acquiring page table
 			 * lock, and our job is done.
 			 */
+			delayacct_wpcopy_end();
 			return 0;
 		}
 
@@ -5310,6 +5315,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
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

