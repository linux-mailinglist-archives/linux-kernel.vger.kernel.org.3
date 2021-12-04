Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACB94684A8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 13:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384886AbhLDMOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 07:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbhLDMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 07:13:59 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F11C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 04:10:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u17so4268169wrt.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 04:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=bVVV3uEtfiYj88cCYd+MCtwH/YItJDy9WxebFmCU/7w=;
        b=OsY4t9p8LrFFBl8yk56eU9qzL57nnbKuaqzNrR/0NnbjBJRMqld+YXEYl1eLLKPcg4
         ehT6unbVBhZxyueBoYjmTsIT7DkMQrGCYlJ6VRYgb05+XC5uJUox6znNaVnW6jlVyFTV
         6XN3nTyQmsXE7+/K9EJKTjROZ1MlNAfzIpAnKuGJGWTpjz7QVMP3os2WmRwIdBGgqKeG
         7P5EAsDV6JqBPPACXJzI5/HrHs/aO2Rv3o4Z+nyyZtaTjJnxG7fHD3zneeEN9vPHraOY
         9/YhfbOvFEpA33mTaEvaQRodvTTcCquOlQk5i4oDh+/b23TZwQoh9H4TpjtgfGu5fwrk
         53NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bVVV3uEtfiYj88cCYd+MCtwH/YItJDy9WxebFmCU/7w=;
        b=Stq7t9VJ30KKSdcryt2SCgnestux8MDDcxwjL1Mbhn8Tq1UkSux9ROSFXrO2JQg5iD
         USAGl1u+y7bCVzAoxz+I4bdsuV38xY7p19Aj35eJpGjQryrCEk7k/SO3Y7wlS2/7fsDP
         yuqY6z6WMoHUlz1RNexMWQbV95F8ffhQx5FSHeIBZWofiT+NTkP+6S72nHf8uebAhR2S
         c3EpSH7scYISzU39rQYlD7rTUr8s23Dn+vUIsOKXPY5AOnw/H5xDt/OssIF1gQMK/uyS
         6ERBwTilGM5as+39pny0pdKslgsfPBD/knZj0nIml2EnDQU62QUf7xaMZ7Uy/vMuwI8+
         fljA==
X-Gm-Message-State: AOAM5311OuvTLZjIPp67pLVamxPzvAXrRj3ukkTJhhPvAlet/8I+98ns
        7lylWgifTRw2DvTQSZzmBoI=
X-Google-Smtp-Source: ABdhPJxNiYyPQzRRXLr+fDR3CKcI4exMAVM56SAftbu9ysjlo8h+YEk1aRHm7OSEn6JZ8yQofVL/YA==
X-Received: by 2002:adf:d0d0:: with SMTP id z16mr29135384wrh.601.1638619831400;
        Sat, 04 Dec 2021 04:10:31 -0800 (PST)
Received: from localhost.localdomain ([45.67.146.70])
        by smtp.gmail.com with ESMTPSA id g198sm5709024wme.23.2021.12.04.04.10.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Dec 2021 04:10:31 -0800 (PST)
From:   yongw.pur@gmail.com
X-Google-Original-From: wang.yong12@zte.com.cn
To:     bsingharora@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.yang29@zte.com.cn, wang.yong12@zte.com.cn
Subject: [PATCH v2 linux-next] delayacct: track delays from memory compact
Date:   Sat,  4 Dec 2021 04:09:55 -0800
Message-Id: <1638619795-71451-1-git-send-email-wang.yong12@zte.com.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangyong <wang.yong12@zte.com.cn>

Delay accounting does not track the delay of memory compact.
When there is not enough free memory, tasks can spend
a amount of their time waiting for compact.

To get the impact of tasks in direct memory compact, measure
the delay when allocating memory through memory compact.

Also update tools/accounting/getdelays.c:
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
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: wangyong <wang.yong12@zte.com.cn>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Reviewed-by: Zhang Wenya <zhang.wenya1@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---

Changes since v1:
-fixed duplicate member freepages_start.

 include/linux/delayacct.h      | 28 ++++++++++++++++++++++++++++
 include/uapi/linux/taskstats.h |  6 +++++-
 kernel/delayacct.c             | 15 +++++++++++++++
 mm/page_alloc.c                |  3 +++
 tools/accounting/getdelays.c   |  8 +++++++-
 5 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 435c365..3e03d01 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -42,8 +42,12 @@ struct task_delay_info {
 	u64 thrashing_start;
 	u64 thrashing_delay;	/* wait for thrashing page */
 
+	u64 compact_start;
+	u64 compact_delay;	/* wait for memory compact */
+
 	u32 freepages_count;	/* total count of memory reclaim */
 	u32 thrashing_count;	/* total count of thrash waits */
+	u32 compact_count;	/* total count of memory compact */
 };
 #endif
 
@@ -72,6 +76,8 @@ extern void __delayacct_thrashing_start(void);
 extern void __delayacct_thrashing_end(void);
 extern void __delayacct_swapin_start(void);
 extern void __delayacct_swapin_end(void);
+extern void __delayacct_compact_start(void);
+extern void __delayacct_compact_end(void);
 
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
@@ -170,6 +176,24 @@ static inline void delayacct_swapin_end(void)
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
@@ -200,6 +224,10 @@ static inline void delayacct_swapin_start(void)
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

