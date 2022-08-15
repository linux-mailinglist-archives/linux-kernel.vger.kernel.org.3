Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0995933FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiHOR03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHOR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:26:26 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF62EE0D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:26:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660584382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ATDYH/fzJGrRFCJwgQnJvJlavn2n3Y9MC4NIhEqVrQ=;
        b=QSKJpbzucIobo/9f1eN92mvg54vCoczIXlY7xGAIjfLik0h9iBO16nz3Qe3i1jt40YRUGo
        74Fkuk92RVkjP9Y7pzqAsGfGWellQnXBWz/53+bi5tdzUxRM/d3suvxLftDy4wn5dYHq6v
        BMSfjZKJRRtfOtg7pNU5pFR9I75V4kA=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 01/11] mm/memcontrol.c: Convert to printbuf
Date:   Mon, 15 Aug 2022 13:26:03 -0400
Message-Id: <20220815172613.621627-2-kent.overstreet@linux.dev>
In-Reply-To: <20220815172613.621627-1-kent.overstreet@linux.dev>
References: <20220815172613.621627-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 54 ++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c9ce..54897e4ac4 100644
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
2.36.1

