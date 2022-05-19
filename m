Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCB252DB3E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbiESR2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242748AbiESRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33ADC1EC8;
        Thu, 19 May 2022 10:25:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so6418786pjb.1;
        Thu, 19 May 2022 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7B0kqteeN1eyAor+oWwIzsi+4oWzLA5TO8L9iLe1/34=;
        b=nPqtZm7p2v7hAPXvOp5FvLWPKwjOUfVcVl7nNXUblqG3FYpYJbXYQvFLWKJ+8w5j31
         1IJZZ3qknsRGl55pNTfXFgIY9oUbAfTmWFE/0OWuKQAw2Eoxj9PyaiXFDFPkDOpGMmlM
         MqNM5pGOia/fB48No3VSI9urtCFGC10feuW4/a83Ureud/jN2ukq2kHwSpxzg6Whu1PZ
         leIdKVqjV37XYm3FYpkMrR6Gp6fNidApn4YH8CemucGJ2jgfORIXGEwuKeEneYgvnQn2
         h33A+2n6Zg1/VxTfEtNPQaBuBRObTh+LTk0RK3JzC88+0it8dFakz9u+iNlGyF1y3zFN
         pxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7B0kqteeN1eyAor+oWwIzsi+4oWzLA5TO8L9iLe1/34=;
        b=h0bYX4D3DWlGebEAW3+sTCWODRYx/nGl1Otu6DM0sNFEpyuD+3rG+MdtOLNSXdh/JG
         hJpuXQYQglXhWsDUg0AuhUcN5gbWHPU3qUaMChLaKk2SsuyLNgCHiLCCiejI/XokOqjh
         6bdeOXhonAakV/KCXt5hmNAR4enfESdcBaVX99E0mexfLQv7P3Qmf5yKvZiB20GVZBwT
         YTxCmOhvfi7K9MEjxvB7dfTZXLg5ddmvyPVI7hZJGlsLgwHSoK9d/f73Gzu4Rixyx3xJ
         c46zaZjWaOkjZrNMCAXSD8ZjKdT8GxzgtFRa+2tdiRINV5eY4dgVtsBjO2EA2fbckRU3
         gQPA==
X-Gm-Message-State: AOAM531u5S65K6cjp7mrW15729S0MHLENGcS5g+lzehA3SVwQH50s6SI
        A+AbHZELg8Wwv1ohw4q9tvRIlNqtlLQm
X-Google-Smtp-Source: ABdhPJyk4ae2VWBS31RHITrOF+FdzGDA2lzJY8LITE45Phy9kfhfqDOAHepVXVuBLVNeymEnXEq8Qg==
X-Received: by 2002:a17:903:2609:b0:161:58c6:77e7 with SMTP id jd9-20020a170903260900b0016158c677e7mr5532119plb.36.1652981129665;
        Thu, 19 May 2022 10:25:29 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:28 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 23/28] mm/memcontrol.c: Convert to printbuf
Date:   Thu, 19 May 2022 13:24:16 -0400
Message-Id: <20220519172421.162394-24-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220519172421.162394-1-kent.overstreet@gmail.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
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
index 36e9f38c91..4cb0b7bc1c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -61,7 +61,7 @@
 #include <linux/file.h>
 #include <linux/tracehook.h>
 #include <linux/psi.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -1436,13 +1436,9 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
 
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
@@ -1459,49 +1455,51 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		u64 size;
 
 		size = memcg_page_state_output(memcg, memory_stats[i].idx);
-		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
+		pr_buf(&buf, "%s %llu\n", memory_stats[i].name, size);
 
 		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
 			size += memcg_page_state_output(memcg,
 							NR_SLAB_RECLAIMABLE_B);
-			seq_buf_printf(&s, "slab %llu\n", size);
+			pr_buf(&buf, "slab %llu\n", size);
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
+	pr_buf(&buf, "%s %lu\n", vm_event_name(PGFAULT),
+	       memcg_events(memcg, PGFAULT));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(PGMAJFAULT),
+	       memcg_events(memcg, PGMAJFAULT));
+	pr_buf(&buf, "%s %lu\n",  vm_event_name(PGREFILL),
+	       memcg_events(memcg, PGREFILL));
+	pr_buf(&buf, "pgscan %lu\n",
+	       memcg_events(memcg, PGSCAN_KSWAPD) +
+	       memcg_events(memcg, PGSCAN_DIRECT));
+	pr_buf(&buf, "pgsteal %lu\n",
+	       memcg_events(memcg, PGSTEAL_KSWAPD) +
+	       memcg_events(memcg, PGSTEAL_DIRECT));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(PGACTIVATE),
+	       memcg_events(memcg, PGACTIVATE));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(PGDEACTIVATE),
+	       memcg_events(memcg, PGDEACTIVATE));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(PGLAZYFREE),
+	       memcg_events(memcg, PGLAZYFREE));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(PGLAZYFREED),
+	       memcg_events(memcg, PGLAZYFREED));
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
-		       memcg_events(memcg, THP_FAULT_ALLOC));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_COLLAPSE_ALLOC),
-		       memcg_events(memcg, THP_COLLAPSE_ALLOC));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
+	       memcg_events(memcg, THP_FAULT_ALLOC));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(THP_COLLAPSE_ALLOC),
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
2.36.0

