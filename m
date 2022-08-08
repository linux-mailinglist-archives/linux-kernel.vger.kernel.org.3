Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D424F58C1BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244065AbiHHCmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242235AbiHHClk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7E125D8
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sneZ41lYORveEGJd86wLRINVdrJyNjdlMYzBcdpxZVM=; b=gHsZmUmooiEPQn2wHoC+85cXvp
        uUArEgvwkwTMO/rXNRp0gPoodsCYZIIJnFcz75pPW3q8m5am8CL0NhvgxKYYAWrSAUeC73Z/lPkPs
        h4I44dOOHdLqJhxSlBifUdptWyIeU2ZxgB6iQ2w6KaPpsCDck6HhMij6kmyazjOnSEUnr6L1jLqJ9
        IQSY+w7Z78SL/f6kcz8Ncq7NPw6uus03Nhyd2oLnPCkQSrsFXKNAC18OUfix8lDia35iIoLoqh1t/
        JQiFlo2Gw4YnT2v+AqHVv7w/+hdDHKX68rLMTNh95mc/ottWiYhO/BKQnzFBRUz3aJd0fiK6fsWFS
        QQ+9YZWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshy-00DVSQ-CB; Mon, 08 Aug 2022 02:41:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v5 22/32] mm/memcontrol.c: Convert to printbuf
Date:   Mon,  8 Aug 2022 03:41:18 +0100
Message-Id: <20220808024128.3219082-23-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808024128.3219082-1-willy@infradead.org>
References: <20220808024128.3219082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

This converts memory_stat_format() from seq_buf to printbuf. Printbuf is
simalar to seq_buf except that it heap allocates the string buffer:
here, we were already heap allocating the buffer with kmalloc() so the
conversion is trivial.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol.c | 54 ++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c9ced5..54897e4ac4ef 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -62,7 +62,7 @@
 #include <linux/file.h>
 #include <linux/resume_user_mode.h>
 #include <linux/psi.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -1490,13 +1490,10 @@ static const unsigned int memcg_vm_event_stat[] = {
 #endif
 };
 
-static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
+static void memory_stat_format(struct printbuf *out, struct mem_cgroup *memcg)
 {
-	struct seq_buf s;
 	int i;
 
-	seq_buf_init(&s, buf, bufsize);
-
 	/*
 	 * Provide statistics on the state of the memory subsystem as
 	 * well as cumulative event counters that show past behavior.
@@ -1513,30 +1510,30 @@ static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
 		u64 size;
 
 		size = memcg_page_state_output(memcg, memory_stats[i].idx);
-		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
+		prt_printf(out, "%s %llu\n", memory_stats[i].name, size);
 
 		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
 			size += memcg_page_state_output(memcg,
 							NR_SLAB_RECLAIMABLE_B);
-			seq_buf_printf(&s, "slab %llu\n", size);
+			prt_printf(out, "slab %llu\n", size);
 		}
 	}
 
 	/* Accumulated memory events */
-	seq_buf_printf(&s, "pgscan %lu\n",
-		       memcg_events(memcg, PGSCAN_KSWAPD) +
-		       memcg_events(memcg, PGSCAN_DIRECT));
-	seq_buf_printf(&s, "pgsteal %lu\n",
-		       memcg_events(memcg, PGSTEAL_KSWAPD) +
-		       memcg_events(memcg, PGSTEAL_DIRECT));
+	prt_printf(out, "pgscan %lu\n",
+		   memcg_events(memcg, PGSCAN_KSWAPD) +
+		   memcg_events(memcg, PGSCAN_DIRECT));
+	prt_printf(out, "pgsteal %lu\n",
+		   memcg_events(memcg, PGSTEAL_KSWAPD) +
+		   memcg_events(memcg, PGSTEAL_DIRECT));
 
 	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++)
-		seq_buf_printf(&s, "%s %lu\n",
-			       vm_event_name(memcg_vm_event_stat[i]),
-			       memcg_events(memcg, memcg_vm_event_stat[i]));
+		prt_printf(out, "%s %lu\n",
+			   vm_event_name(memcg_vm_event_stat[i]),
+			   memcg_events(memcg, memcg_vm_event_stat[i]));
 
 	/* The above should easily fit into one page */
-	WARN_ON_ONCE(seq_buf_has_overflowed(&s));
+	WARN_ON_ONCE(!printbuf_remaining(out));
 }
 
 #define K(x) ((x) << (PAGE_SHIFT-10))
@@ -1573,7 +1570,8 @@ void mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *
 void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 	/* Use static buffer, for the caller is holding oom_lock. */
-	static char buf[PAGE_SIZE];
+	static char _buf[PAGE_SIZE];
+	struct printbuf buf = PRINTBUF_EXTERN(_buf, sizeof(_buf));
 
 	lockdep_assert_held(&oom_lock);
 
@@ -1596,8 +1594,8 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 	pr_info("Memory cgroup stats for ");
 	pr_cont_cgroup_path(memcg->css.cgroup);
 	pr_cont(":");
-	memory_stat_format(memcg, buf, sizeof(buf));
-	pr_info("%s", buf);
+	memory_stat_format(&buf, memcg);
+	pr_info("%s", buf.buf);
 }
 
 /*
@@ -6401,14 +6399,16 @@ static int memory_events_local_show(struct seq_file *m, void *v)
 static int memory_stat_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
-	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	struct printbuf buf = PRINTBUF;
+	int ret;
 
-	if (!buf)
-		return -ENOMEM;
-	memory_stat_format(memcg, buf, PAGE_SIZE);
-	seq_puts(m, buf);
-	kfree(buf);
-	return 0;
+	memory_stat_format(&buf, memcg);
+	ret = buf.allocation_failure ? -ENOMEM : 0;
+	if (!ret)
+		seq_puts(m, buf.buf);
+
+	printbuf_exit(&buf);
+	return ret;
 }
 
 #ifdef CONFIG_NUMA
-- 
2.35.1

