Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4453246798C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381525AbhLCOl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbhLCOlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:41:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509A2C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:38:31 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r11so12242178edd.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 06:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=chR4af+IfDfsqhZAZrVwI4X+Xf3XgUyZz2Vg1zAzeOg=;
        b=dG/zr4OMWjdCv4D9eRkLA1feaHOnLbntdIJK2LNVEjjYrTPJGsWrM9kMz44OFt7DIp
         dSbJAdP74PXYYA5/FGBcQKFUGIbThxKDnch4tF8w49YHI1nDUz0l8KRtcai2ZL4EnviT
         4dI5B7CJxd7wCYmXMQAduDE7JVPT+ozEPijNGUNBF00Ajz6C0ulLd1FUknF/IeModOMl
         ouJl4dhLiRU2+0grflX+k7n6wxF3GHvOwmqyivb4C3BTgdeTiAZF4Tjc92lEHUyyhkWw
         dp4MrWdcfJ7OKzpXaBj5tnh8scP0+ME3aS6NMKeVY5Ah2fSSPL6slafaRUKoIhDu7hfE
         sjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=chR4af+IfDfsqhZAZrVwI4X+Xf3XgUyZz2Vg1zAzeOg=;
        b=CeaF0M5mAsT4fN4Tk4Hk+Tz2DPhkLajbgPoB9F4MZrXzCEz3tkmfTeJitXFjTHXq6V
         /+h54Uy10EEru3hA2iJhrFLUHsGa4UbGEFbNvSqME+JaDoEvDPDScRs6DBIjHxNekS+s
         2VyNxHc2yFRaTkW8dsCHYWnSc+01oi+8RbxNAlEXW8JgYgkERf9W+T8M7UPc0Qh5le7j
         Ef/cizk8qYLyFQtSN+6n1rbnTrD3/TBuvsPCHlB+SK1xAEa09kh+OP/7ENTXAX9HxHSj
         qnreVWgnNgMe08/WNRYWPmzNlQnm1U6yFzrBQJEEvjbTvRa4LwgDtcYqRsPVktuilfV6
         +KyQ==
X-Gm-Message-State: AOAM532LzV1FIwgj5I8/4IjiuC/kuHYR7TRGr1JHSAPgN/1FJvRLEpbV
        NQZ3dz69B5tH7kkUqub4Qeo=
X-Google-Smtp-Source: ABdhPJzBzYWq2KE1lU6oGOG/JTf8ir2ecNJUBHmySZ5nPckx08Vtv+J3PYlzDMHkI8u+jInk2oKYCQ==
X-Received: by 2002:a17:907:97d2:: with SMTP id js18mr18806079ejc.179.1638542309621;
        Fri, 03 Dec 2021 06:38:29 -0800 (PST)
Received: from localhost.localdomain ([146.70.33.61])
        by smtp.gmail.com with ESMTPSA id hb36sm2132179ejc.73.2021.12.03.06.38.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Dec 2021 06:38:28 -0800 (PST)
From:   yongw.pur@gmail.com
X-Google-Original-From: wang.yong12@zte.com.cn
To:     bsingharora@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.yang29@zte.com.cn, wang.yong12@zte.com.cn
Subject: [PATCH linux-next] delayacct: track delays from memory compact
Date:   Fri,  3 Dec 2021 06:37:52 -0800
Message-Id: <1638542272-15187-1-git-send-email-wang.yong12@zte.com.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangyong <wang.yong12@zte.com.cn>

Delay accounting does not track the delay of memory compact.
When there is not enough free memory, tasks can spend
a amount of their time waiting for memory compact.

To get the impact of tasks in direct memory compact, measure
the delay when allocating memory through memory compact.

Update tools/accounting/getdelays.c:
/ # ./getdelays_next  -di -p 304
print delayacct stats ON
printing IO accounting
PID     304

CPU             count     real total  virtual total    delay total  delay average
                  277      780000000      849039485       18877296          0.068ms
IO              count    delay total  delay average
                    0              0              0ms
SWAP            count    delay total  delay average
                    0              0              0ms
RECLAIM         count    delay total  delay average
                    5    11088812685           2217ms
THRASHING       count    delay total  delay average
                    0              0              0ms
COMPACT         count    delay total  delay average
                    3          72758              0ms
watch: read=0, write=0, cancelled_write=0

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: wangyong <wang.yong12@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---
 include/linux/delayacct.h      | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/taskstats.h |  6 +++++-
 kernel/delayacct.c             | 15 +++++++++++++++
 mm/page_alloc.c                |  3 +++
 tools/accounting/getdelays.c   |  8 +++++++-
 5 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 435c365..547cba9 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -42,8 +42,13 @@ struct task_delay_info {
 	u64 thrashing_start;
 	u64 thrashing_delay;	/* wait for thrashing page */
 
+	u64 compact_start;
+	u64 compact_delay;	/* wait for memory compact */
+
+	u64 freepages_start;
 	u32 freepages_count;	/* total count of memory reclaim */
 	u32 thrashing_count;	/* total count of thrash waits */
+	u32 compact_count;	/* total count of memory compact */
 };
 #endif
 
@@ -72,6 +77,8 @@ extern void __delayacct_thrashing_start(void);
 extern void __delayacct_thrashing_end(void);
 extern void __delayacct_swapin_start(void);
 extern void __delayacct_swapin_end(void);
+extern void __delayacct_compact_start(void);
+extern void __delayacct_compact_end(void);
 
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
@@ -170,6 +177,24 @@ static inline void delayacct_swapin_end(void)
 		__delayacct_swapin_end();
 }
 
+static inline void delayacct_compact_start(void)
+{
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
+	if (current->delays)
+		__delayacct_compact_start();
+}
+
+static inline void delayacct_compact_end(void)
+{
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
+	if (current->delays)
+		__delayacct_compact_end();
+}
+
 #else
 static inline void delayacct_init(void)
 {}
@@ -200,6 +225,10 @@ static inline void delayacct_swapin_start(void)
 {}
 static inline void delayacct_swapin_end(void)
 {}
+static inline void delayacct_compact_start(void)
+{}
+static inline void delayacct_compact_end(void)
+{}
 
 #endif /* CONFIG_TASK_DELAY_ACCT */
 
diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index ccbd087..12327d3 100644
--- a/include/uapi/linux/taskstats.h
+++ b/include/uapi/linux/taskstats.h
@@ -34,7 +34,7 @@
  */
 
 
-#define TASKSTATS_VERSION	10
+#define TASKSTATS_VERSION	11
 #define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
 					 * in linux/sched.h */
 
@@ -172,6 +172,10 @@ struct taskstats {
 
 	/* v10: 64-bit btime to avoid overflow */
 	__u64	ac_btime64;		/* 64-bit begin time */
+
+	/* Delay waiting for memory compact */
+	__u64	compact_count;
+	__u64	compact_delay_total;
 };
 
 
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 11f3cd8..c5e8cea 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -155,10 +155,13 @@ int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	d->freepages_delay_total = (tmp < d->freepages_delay_total) ? 0 : tmp;
 	tmp = d->thrashing_delay_total + tsk->delays->thrashing_delay;
 	d->thrashing_delay_total = (tmp < d->thrashing_delay_total) ? 0 : tmp;
+	tmp = d->compact_delay_total + tsk->delays->compact_delay;
+	d->compact_delay_total = (tmp < d->compact_delay_total) ? 0 : tmp;
 	d->blkio_count += tsk->delays->blkio_count;
 	d->swapin_count += tsk->delays->swapin_count;
 	d->freepages_count += tsk->delays->freepages_count;
 	d->thrashing_count += tsk->delays->thrashing_count;
+	d->compact_count += tsk->delays->compact_count;
 	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 
 	return 0;
@@ -214,3 +217,15 @@ void __delayacct_swapin_end(void)
 		      &current->delays->swapin_count);
 }
 
+void __delayacct_compact_start(void)
+{
+	current->delays->compact_start = local_clock();
+}
+
+void __delayacct_compact_end(void)
+{
+	delayacct_end(&current->delays->lock,
+		      &current->delays->compact_start,
+		      &current->delays->compact_delay,
+		      &current->delays->compact_count);
+}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index edfd6c8..6430226 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -74,6 +74,7 @@
 #include <linux/padata.h>
 #include <linux/khugepaged.h>
 #include <linux/buffer_head.h>
+#include <linux/delayacct.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -4363,6 +4364,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 		return NULL;
 
 	psi_memstall_enter(&pflags);
+	delayacct_compact_start();
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	*compact_result = try_to_compact_pages(gfp_mask, order, alloc_flags, ac,
@@ -4370,6 +4372,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 	psi_memstall_leave(&pflags);
+	delayacct_compact_end();
 
 	if (*compact_result == COMPACT_SKIPPED)
 		return NULL;
diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
index 5ef1c15..11e8673 100644
--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -205,6 +205,8 @@ static void print_delayacct(struct taskstats *t)
 	       "RECLAIM  %12s%15s%15s\n"
 	       "      %15llu%15llu%15llums\n"
 	       "THRASHING%12s%15s%15s\n"
+	       "      %15llu%15llu%15llums\n"
+	       "COMPACT  %12s%15s%15s\n"
 	       "      %15llu%15llu%15llums\n",
 	       "count", "real total", "virtual total",
 	       "delay total", "delay average",
@@ -228,7 +230,11 @@ static void print_delayacct(struct taskstats *t)
 	       "count", "delay total", "delay average",
 	       (unsigned long long)t->thrashing_count,
 	       (unsigned long long)t->thrashing_delay_total,
-	       average_ms(t->thrashing_delay_total, t->thrashing_count));
+	       average_ms(t->thrashing_delay_total, t->thrashing_count),
+	       "count", "delay total", "delay average",
+	       (unsigned long long)t->compact_count,
+	       (unsigned long long)t->compact_delay_total,
+	       average_ms(t->compact_delay_total, t->compact_count));
 }
 
 static void task_context_switch_counts(struct taskstats *t)
-- 
2.7.4

