Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9DA53D861
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbiFDTdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240532AbiFDTbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:44 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20A95005F
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:28 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id l1so7812454qvh.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uTBJQxxOq1+B+oEKPtyj8xG9RwTxPKpWggt48cPFUTs=;
        b=qF8hvl7FRdivZqjRtJV3KC4IjPjSaOkQ//qhUAMMund+hkAvcmgC8hOVy9dqOmOhHE
         SnAvDDqrFCTK2834+EwTE5QW2BvZ1djniF6FLRndwBhml8CZKkNNipJHa2t/3sKTg9Z/
         CArej/tQ/ZK2Mni6YKXY6SwGB0SzCRgPID+7Oqd010mBCTipJZ3nG02+u3nulBzqjDEo
         hm2Vw4CVdR40mQG4ycSi5J3BVJN0GfEInoz2uFU7nYhs9BpqvVy0k6nPucgq51DTa+rk
         XrNeRFuHL15ytdaiRkSvvNKggJ+CA86Z605rPC3azKAb5pyMWZgBX8/WudQ5B78kNqXX
         2h1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uTBJQxxOq1+B+oEKPtyj8xG9RwTxPKpWggt48cPFUTs=;
        b=LGP7lbwoaQjOTtBPbe0wCr8sIrBCSBrCwabcb0Cov7PMlFWaI6OnP+dMGRES82Gjuy
         9TXJ9E3V+4R4l9KcH8LwiRy7BWz7coVmZUDFWfdN+0HmWjLbCCIpZnrRWl+bUbK4ed5T
         uoG0UFadIvVdpkw3FHf1843DlffhXyR1f79v5xXHDhuCkpTyChC2iWVu1MPNS+iEPA3c
         lp4Np/amABKupa94BUJRtQu1VGdrVYH2UIS4JB6rZXAtRhLnIzp5LY3Pr5Rsc+IDKZwJ
         opFzGDDE4iD/cpP5N9nzvRhPAbh+CtKDazVaceahNPmmGMUneI+4MIVNM6OAs7hHuivn
         BqFA==
X-Gm-Message-State: AOAM530fDyk9H9YaIB/iwksZDOh0ftsrSVJDfxcOoISazld2CMnzzalH
        WOgZlyxVTcd+uRcVDR5rA1joJioFeHoe
X-Google-Smtp-Source: ABdhPJyup4DVXawsaJXGhDU1HMeqJkb2a5r+HIeWjsqJ7vBBtcWqrYj0+HHTr/GSS/jvqIzsiZu2jQ==
X-Received: by 2002:a05:6214:5097:b0:466:c160:e585 with SMTP id kk23-20020a056214509700b00466c160e585mr12929848qvb.54.1654371086393;
        Sat, 04 Jun 2022 12:31:26 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:25 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 24/33] mm/memcontrol.c: Convert to printbuf
Date:   Sat,  4 Jun 2022 15:30:33 -0400
Message-Id: <20220604193042.1674951-25-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220604193042.1674951-1-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
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
2.36.0

