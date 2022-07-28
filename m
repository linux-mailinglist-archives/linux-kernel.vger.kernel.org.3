Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FCD584730
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiG1Upt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiG1Upj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:45:39 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8196C110
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:33 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e132so2436638pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=o9jWwsLlYZnS171yrNbtFKKGeaY8IhQRPNlofd9rtnc=;
        b=PC9ISe/Tv2ntpg8FscV4ebolxpt+AhXtqalCdJ/HM/qaDIdf1rxD2vBYVhSyfRLxvQ
         GHNNXjMEXEikSN1uQJEUc4Zhe57ufRlQnqw9TudVYtELg/+5ehUxd4ndJQJ5R6PRGeeT
         r+ufm10YR1mOAqOW40t42Qr6bFNcdDvwRbzl9OkfnTCh+iEnGxt/DT6muqSIGo96CuOf
         et+sFqcvlWWFb9bXbnS+xT11zv2W1sj53OfXveVBtRe+8b7qrKDj27Z/dZd3xwMT1a5G
         exxkBIZstIbrCsALmdrvZOuGiqwEUnFgdG1pJx0C5F7hTIdLNEc4O30Ottfvj3r5Ihoq
         Gx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=o9jWwsLlYZnS171yrNbtFKKGeaY8IhQRPNlofd9rtnc=;
        b=MrlQwgAmALJonkpvHpWC/Jug+K7irc3YKLAyH9ulLX/VfYujHvw+4eEEqMOaaTBlgr
         7FUrWGaVlDLRayHPfJatWgr3HOpSub8fJP+SeJKVS7ZctRPHArH1alAlDky2Kyg3HYbw
         l71/AHex4awtqIMZFtr8E5fJLJp9gLnvdxJZR5kkpr0clF7zCWaMs1h8LPgPPd+M0abE
         SlqjBR/Zr4uehYa2OzMW+0FdjXEAQZrMa1Rm8NHWSPttIwtW1gL/fubwxJTBWHlSTrmh
         MMOd6SULoUuPWF5PTKpjLHGbV9r7UAtcxaagpjL+s8DSQY5AkzMII8gY9fE7xbggmCJc
         aWPg==
X-Gm-Message-State: AJIora8/Xpkn4+zIUCsvuo5LtcdDa2RrZwFoFaB4dH6nIiXthSFsnArV
        +EB61X1YWFlXgUts8Mtvwbg=
X-Google-Smtp-Source: AGRyM1vsVwYmFD3XfCQrIG8QN1BCM3jR8q0DPVN7U5JQfZ3X2kYLzuo6hZlQfhMP+vyClpJD2IEHiw==
X-Received: by 2002:a05:6a00:1d26:b0:52b:f8ab:6265 with SMTP id a38-20020a056a001d2600b0052bf8ab6265mr340380pfx.54.1659041131938;
        Thu, 28 Jul 2022 13:45:31 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([114.254.3.190])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c40f8cb58sm1787304pli.81.2022.07.28.13.45.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Jul 2022 13:45:31 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 6/7] mm: introduce CONFIG_ARCH_PCP_RSS_USE_CPUMASK
Date:   Fri, 29 Jul 2022 04:45:10 +0800
Message-Id: <20220728204511.56348-7-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220728204511.56348-1-ryncsn@gmail.com>
References: <20220728204511.56348-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

If the arch related code can provide helpers to bind the RSS cache to
mm_cpumask, then the syncing code can just rely on that instead of doing
full CPU synchronization. This speed up the reading/mm_exit by a lot.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 arch/Kconfig        |  3 ++
 kernel/sched/core.c |  3 +-
 mm/memory.c         | 94 ++++++++++++++++++++++++++++-----------------
 3 files changed, 64 insertions(+), 36 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 71b9272acb28..8df45b6346ae 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1403,6 +1403,9 @@ config ARCH_HAS_ELFCORE_COMPAT
 config ARCH_HAS_PARANOID_L1D_FLUSH
 	bool
 
+config ARCH_PCP_RSS_USE_CPUMASK
+	bool
+
 config DYNAMIC_SIGFRAME
 	bool
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 11df67bb52ee..6f7991caf24b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5143,7 +5143,8 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	prepare_lock_switch(rq, next, rf);
 
 	/* Cache new active_mm */
-	switch_pcp_rss_cache_no_irq(next->active_mm);
+	if (!IS_ENABLED(CONFIG_ARCH_PCP_RSS_USE_CPUMASK))
+		switch_pcp_rss_cache_no_irq(next->active_mm);
 
 	/* Here we just switch the register state and the stack. */
 	switch_to(prev, next, prev);
diff --git a/mm/memory.c b/mm/memory.c
index 09d7d193da51..a819009aa3e0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -188,9 +188,16 @@ unsigned long get_mm_counter(struct mm_struct *mm, int member)
 {
 	int cpu;
 	long ret, update, sync_count;
+	const struct cpumask *mm_mask;
 
 	ret = atomic_long_read(&mm->rss_stat.count[member]);
-	for_each_possible_cpu(cpu) {
+
+	if (IS_ENABLED(CONFIG_ARCH_PCP_RSS_USE_CPUMASK))
+		mm_mask = mm_cpumask(mm);
+	else
+		mm_mask = cpu_possible_mask;
+
+	for_each_cpu(cpu, mm_mask) {
 		if (READ_ONCE(per_cpu(cpu_rss_cache.mm, cpu)) != mm)
 			continue;
 		sync_count = READ_ONCE(per_cpu(cpu_rss_cache.sync_count, cpu));
@@ -217,12 +224,18 @@ unsigned long get_mm_rss(struct mm_struct *mm)
 {
 	int cpu;
 	long ret, update, sync_count;
+	const struct cpumask *mm_mask;
 
 	ret = atomic_long_read(&mm->rss_stat.count[MM_FILEPAGES]),
 	    + atomic_long_read(&mm->rss_stat.count[MM_ANONPAGES]),
 	    + atomic_long_read(&mm->rss_stat.count[MM_SHMEMPAGES]);
 
-	for_each_possible_cpu(cpu) {
+	if (IS_ENABLED(CONFIG_ARCH_PCP_RSS_USE_CPUMASK))
+		mm_mask = mm_cpumask(mm);
+	else
+		mm_mask = cpu_possible_mask;
+
+	for_each_cpu(cpu, mm_mask) {
 		if (READ_ONCE(per_cpu(cpu_rss_cache.mm, cpu)) != mm)
 			continue;
 		sync_count = READ_ONCE(per_cpu(cpu_rss_cache.sync_count, cpu));
@@ -266,10 +279,13 @@ void switch_pcp_rss_cache_no_irq(struct mm_struct *next_mm)
 	if (cpu_mm == NULL)
 		goto commit_done;
 
-	/* Race with check_discard_rss_cache */
-	if (cpu_mm != cmpxchg(this_cpu_ptr(&cpu_rss_cache.mm), cpu_mm,
-			      __pcp_rss_mm_mark(cpu_mm)))
-		goto commit_done;
+	/* Arch will take care of cache invalidation */
+	if (!IS_ENABLED(CONFIG_ARCH_PCP_RSS_USE_CPUMASK)) {
+		/* Race with check_discard_rss_cache */
+		if (cpu_mm != cmpxchg(this_cpu_ptr(&cpu_rss_cache.mm), cpu_mm,
+				      __pcp_rss_mm_mark(cpu_mm)))
+			goto commit_done;
+	}
 
 	for (int i = 0; i < NR_MM_COUNTERS; i++) {
 		count = this_cpu_read(cpu_rss_cache.count[i]);
@@ -328,46 +344,54 @@ static void check_discard_rss_cache(struct mm_struct *mm)
 	long cached_count[NR_MM_COUNTERS] = { 0 };
 	struct mm_struct *cpu_mm;
 
-	/* Invalidate the RSS cache on every CPU */
-	for_each_possible_cpu(cpu) {
-		cpu_mm = READ_ONCE(per_cpu(cpu_rss_cache.mm, cpu));
-		if (__pcp_rss_mm_unmark(cpu_mm) != mm)
-			continue;
-
-		/*
-		 * If not being flusehd, try read-in the counter and mark it NULL,
-		 * once cache's mm is set NULL, counter are considered invalided
-		 */
-		if (cpu_mm != __pcp_rss_mm_mark(cpu_mm)) {
-			long count[NR_MM_COUNTERS];
-
-			for (int i = 0; i < NR_MM_COUNTERS; i++)
-				count[i] = READ_ONCE(per_cpu(cpu_rss_cache.count[i], cpu));
+	/* Arch will take care of cache invalidation */
+	if (!IS_ENABLED(CONFIG_ARCH_PCP_RSS_USE_CPUMASK)) {
+		/* Invalidate the RSS cache on every CPU */
+		for_each_possible_cpu(cpu) {
+			cpu_mm = READ_ONCE(per_cpu(cpu_rss_cache.mm, cpu));
+			if (__pcp_rss_mm_unmark(cpu_mm) != mm)
+				continue;
 
 			/*
-			 * If successfully set to NULL, the owner CPU is not flushing it, counters
-			 * are uncommiteed and untouched during this period, since a dying mm won't
-			 * be accouted anymore
+			 * If not being flusehd, try read-in the counter and mark it NULL,
+			 * once cache's mm is set NULL, counter are considered invalided.
 			 */
-			cpu_mm = cmpxchg(&per_cpu(cpu_rss_cache.mm, cpu), mm, NULL);
-			if (cpu_mm == mm) {
+			if (cpu_mm != __pcp_rss_mm_mark(cpu_mm)) {
+				long count[NR_MM_COUNTERS];
+
 				for (int i = 0; i < NR_MM_COUNTERS; i++)
-					cached_count[i] += count[i];
-				continue;
+					count[i] = READ_ONCE(per_cpu(cpu_rss_cache.count[i], cpu));
+
+				/*
+				 * If successfully set to NULL, the owner CPU is not flushing it,
+				 * counters are uncommitted and untouched during this period, since
+				 * a dying mm won't be accouted anymore.
+				 */
+				cpu_mm = cmpxchg(&per_cpu(cpu_rss_cache.mm, cpu), mm, NULL);
+				if (cpu_mm == mm) {
+					for (int i = 0; i < NR_MM_COUNTERS; i++)
+						cached_count[i] += count[i];
+					continue;
+				}
 			}
-		}
 
-		/* It's being flushed, just busy wait as the critial section is really short */
-		do {
-			cpu_relax();
-			cpu_mm = READ_ONCE(per_cpu(cpu_rss_cache.mm, cpu));
-		} while (cpu_mm == __pcp_rss_mm_mark(mm));
+			/*
+			 * It's being flushed, just busy wait as the critial section
+			 * is really short.
+			 */
+			do {
+				cpu_relax();
+				cpu_mm = READ_ONCE(per_cpu(cpu_rss_cache.mm, cpu));
+			} while (cpu_mm == __pcp_rss_mm_mark(mm));
+		}
 	}
 
 	for (int i = 0; i < NR_MM_COUNTERS; i++) {
 		long val = atomic_long_read(&mm->rss_stat.count[i]);
 
-		val += cached_count[i];
+		if (!IS_ENABLED(CONFIG_ARCH_PCP_RSS_USE_CPUMASK)) {
+			val += cached_count[i];
+		}
 
 		if (unlikely(val)) {
 			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
-- 
2.35.2

