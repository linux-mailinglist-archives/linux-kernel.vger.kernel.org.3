Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C368550E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbiFTAou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbiFTAnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:47 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30959B7FC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:32 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 15so6879985qki.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyLJo+KoIiEhpVGAQ2QxyVkabvxhAF2JfmbYzoDAQFQ=;
        b=ZwMhY+29YOmX0RvGbQvKKpPUJ/LqiQlfG/fgzGyHH2KruyCzuGFG7Cx9DBTnJkvwbK
         gAaCicWiyizg4Ns7w9SJIH9poWXfXv4BSJRB8E3LDl9mvltSXu+AiBCzfX/xNZFzqIjQ
         v8SpfIbUg2ZXZgRZ48WZbDJ4lNh+p6rokBEkhGJAC1sQYvtHz9gEd0+35p9o8Bt+BNE1
         pZmzrLUxry5FvQMPKjEHsa+YCN8WwrOA/Rhd1OQ5cJCvVgyG64UUWUMsgq1X6/YcQeP2
         5fmQ5xebpkhNfdNLRNu2ImCzxKO2l/tZuPB9FyaW/6ikTd+q6pzU6aFO9/E7fP4o/7/M
         tMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyLJo+KoIiEhpVGAQ2QxyVkabvxhAF2JfmbYzoDAQFQ=;
        b=W6ReSAzmCDYTFpS0wdjL1z2F5SdzOkyhWSAr/AxZ7SA9Gvr8uIWA3SNPxqzA+pBU7R
         hTrNJd2FoOBpo1SAPCFjbmWa0Xp0Wk7kRBqp9lNRkKgtSLwWs5erQ0Gr9FDMShNIA3NL
         /vpcmOYZSHMHD7sUlxWpLv7+txNFtCwtmtZoKgKfBwIa7RuZMguvIiuqsI2ZywdnaN+q
         64AOHSaUP+8/k0EP+OaK6MZWYJxeWgBnpsn0EHpWvpkTVFhRDGDFMijwfxr6tiVxtm5w
         uXQ4O0qeRdoCkW3x5KOCY7AjvSMTZTymovTCNmVR0CMqT1Ebg9eV33GWqwZ5riemdGEB
         k65Q==
X-Gm-Message-State: AJIora8WN78bhsV+fRZD0E9+iu8L/B3TBS78S8fTR/uz2FVI8QVDYudN
        DcSvjSieh4O/SdSQiht9v0PYC1sW6UG2x7Y=
X-Google-Smtp-Source: AGRyM1uaH48yIvoz9xPy//ybN6M0Bpovt4qpzmAy41Tiev9BddZLDAZCbKgQyHBrnnXmG62fhuA/aw==
X-Received: by 2002:ae9:ef47:0:b0:6a6:809a:aab5 with SMTP id d68-20020ae9ef47000000b006a6809aaab5mr14526624qkg.615.1655685810646;
        Sun, 19 Jun 2022 17:43:30 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006a791a42693sm11091058qko.133.2022.06.19.17.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:29 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 24/34] mm/memcontrol.c: Convert to printbuf
Date:   Sun, 19 Jun 2022 20:42:23 -0400
Message-Id: <20220620004233.3805-25-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
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

This converts memory_stat_format() from seq_buf to printbuf. Printbuf is
simalar to seq_buf except that it heap allocates the string buffer:
here, we were already heap allocating the buffer with kmalloc() so the
conversion is trivial.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/memcontrol.c | 68 ++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 598fece89e..57861dc9fe 100644
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
@@ -1461,13 +1461,9 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
 
 static char *memory_stat_format(struct mem_cgroup *memcg)
 {
-	struct seq_buf s;
+	struct printbuf buf = PRINTBUF;
 	int i;
 
-	seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
-	if (!s.buffer)
-		return NULL;
-
 	/*
 	 * Provide statistics on the state of the memory subsystem as
 	 * well as cumulative event counters that show past behavior.
@@ -1484,49 +1480,51 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		u64 size;
 
 		size = memcg_page_state_output(memcg, memory_stats[i].idx);
-		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
+		prt_printf(&buf, "%s %llu\n", memory_stats[i].name, size);
 
 		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
 			size += memcg_page_state_output(memcg,
 							NR_SLAB_RECLAIMABLE_B);
-			seq_buf_printf(&s, "slab %llu\n", size);
+			prt_printf(&buf, "slab %llu\n", size);
 		}
 	}
 
 	/* Accumulated memory events */
 
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGFAULT),
-		       memcg_events(memcg, PGFAULT));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGMAJFAULT),
-		       memcg_events(memcg, PGMAJFAULT));
-	seq_buf_printf(&s, "%s %lu\n",  vm_event_name(PGREFILL),
-		       memcg_events(memcg, PGREFILL));
-	seq_buf_printf(&s, "pgscan %lu\n",
-		       memcg_events(memcg, PGSCAN_KSWAPD) +
-		       memcg_events(memcg, PGSCAN_DIRECT));
-	seq_buf_printf(&s, "pgsteal %lu\n",
-		       memcg_events(memcg, PGSTEAL_KSWAPD) +
-		       memcg_events(memcg, PGSTEAL_DIRECT));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGACTIVATE),
-		       memcg_events(memcg, PGACTIVATE));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGDEACTIVATE),
-		       memcg_events(memcg, PGDEACTIVATE));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREE),
-		       memcg_events(memcg, PGLAZYFREE));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREED),
-		       memcg_events(memcg, PGLAZYFREED));
+	prt_printf(&buf, "%s %lu\n", vm_event_name(PGFAULT),
+	       memcg_events(memcg, PGFAULT));
+	prt_printf(&buf, "%s %lu\n", vm_event_name(PGMAJFAULT),
+	       memcg_events(memcg, PGMAJFAULT));
+	prt_printf(&buf, "%s %lu\n",  vm_event_name(PGREFILL),
+	       memcg_events(memcg, PGREFILL));
+	prt_printf(&buf, "pgscan %lu\n",
+	       memcg_events(memcg, PGSCAN_KSWAPD) +
+	       memcg_events(memcg, PGSCAN_DIRECT));
+	prt_printf(&buf, "pgsteal %lu\n",
+	       memcg_events(memcg, PGSTEAL_KSWAPD) +
+	       memcg_events(memcg, PGSTEAL_DIRECT));
+	prt_printf(&buf, "%s %lu\n", vm_event_name(PGACTIVATE),
+	       memcg_events(memcg, PGACTIVATE));
+	prt_printf(&buf, "%s %lu\n", vm_event_name(PGDEACTIVATE),
+	       memcg_events(memcg, PGDEACTIVATE));
+	prt_printf(&buf, "%s %lu\n", vm_event_name(PGLAZYFREE),
+	       memcg_events(memcg, PGLAZYFREE));
+	prt_printf(&buf, "%s %lu\n", vm_event_name(PGLAZYFREED),
+	       memcg_events(memcg, PGLAZYFREED));
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
-		       memcg_events(memcg, THP_FAULT_ALLOC));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_COLLAPSE_ALLOC),
-		       memcg_events(memcg, THP_COLLAPSE_ALLOC));
+	prt_printf(&buf, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
+	       memcg_events(memcg, THP_FAULT_ALLOC));
+	prt_printf(&buf, "%s %lu\n", vm_event_name(THP_COLLAPSE_ALLOC),
+	       memcg_events(memcg, THP_COLLAPSE_ALLOC));
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-	/* The above should easily fit into one page */
-	WARN_ON_ONCE(seq_buf_has_overflowed(&s));
+	if (buf.allocation_failure) {
+		printbuf_exit(&buf);
+		return NULL;
+	}
 
-	return s.buffer;
+	return buf.buf;
 }
 
 #define K(x) ((x) << (PAGE_SHIFT-10))
-- 
2.36.1

