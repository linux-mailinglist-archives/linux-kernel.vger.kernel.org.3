Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5864F4D9699
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346153AbiCOIp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346139AbiCOIpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE7D4D275
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:44:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r10so27820450wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCdjHXVX+BAOQ2yVcrI7SyvzKpdkdL/11OuCDg14XLo=;
        b=pIoE/HpKDdHiDncMIJAbB18zsxa2+6s5W62t4oa1Y3KZPU1hnm3RlyVbVFTafXOiFi
         9uMb9qYgjpDw0JoGpR/Bvmu6DOK8h45ntkOUgnksb63A26Z4bfTPnvW7IbFGwXRUfegE
         Jq1inoXxj5oFK7e4YRXs9Q46XfSoI+R3/tPl+v5mwGklXKn+17+msaWm9cZLSigUs3jz
         mdJ5uFQ+IQWdsrFovLn5Z7G/1xIr2dmsqqauhcIJEm0keuqGn6d93f1WbkbAdnXZMLYN
         VISi88HThFwyPNMekw2oxz7u7PaF5xUw5lCJaH34H99c7XWCaVC7G7sGZ8mBe1sWqLNy
         1JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fCdjHXVX+BAOQ2yVcrI7SyvzKpdkdL/11OuCDg14XLo=;
        b=Hd8rBZH++XQdZq6pEmsWraMZWsPU4NLK3gOIYL+1uJOVKAiRsPs8+7T08Utqm+OeN9
         e4OTYRiE9Fhg9ewYBt1ayDnrPu4Z8NJMPEAqfL5Al/4Xxf1Nf2ozZxUBuylGH6F/gcdc
         mtYxrdIVGXftJBWLOX+GaRswi+qtPoLSwajp743iJvKJwYTLDyyW7xfi9rUho9BmTrt4
         qZO00j+I0UT1PJtIEMY2oFF+F2KJUYurgyKgDAd0VOdCvbHx9jRzravYGhNRxwhs3JVw
         XZ81nnu25ltlJxSPbnu1ynx46TyzJ8reQljTIWvYd1UMB/BtyeIUhZ6snyd708b9ElHh
         xysA==
X-Gm-Message-State: AOAM533pQ+Qt6uSox8VgzoaeS+UTGB9P6UL8b9yWvrEhNMbOvC1UJ1nt
        SJhaThFyyeZXCBZNemWShICvGnbfiWo=
X-Google-Smtp-Source: ABdhPJyemeY0/o2nSnMGQ5BDTo0VP4OpLZAfb/wOMSpDMHfsSXqvpvYlGzRedJ6ux92PFPJDYOPQtw==
X-Received: by 2002:a5d:6d8a:0:b0:203:6efe:7961 with SMTP id l10-20020a5d6d8a000000b002036efe7961mr19866602wrs.367.1647333840864;
        Tue, 15 Mar 2022 01:44:00 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:44:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 11/15] sched/headers: Reorganize, clean up and optimize kernel/sched/core.c dependencies
Date:   Tue, 15 Mar 2022 09:42:43 +0100
Message-Id: <20220315084247.40783-12-mingo@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220315084247.40783-1-mingo@kernel.org>
References: <20220315084247.40783-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use all generic headers from kernel/sched/sched.h that are required
for it to build.

Sort the sections alphabetically.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 22de53710ee9..5eaa4211d93c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6,7 +6,73 @@
  *
  *  Copyright (C) 1991-2002  Linus Torvalds
  */
+#include <linux/highmem.h>
+#include <linux/hrtimer_api.h>
+#include <linux/ktime_api.h>
+#include <linux/sched/signal.h>
+#include <linux/syscalls_api.h>
+#include <linux/debug_locks.h>
+#include <linux/prefetch.h>
+#include <linux/capability.h>
+#include <linux/pgtable_api.h>
+#include <linux/wait_bit.h>
+#include <linux/jiffies.h>
+#include <linux/spinlock_api.h>
+#include <linux/cpumask_api.h>
+#include <linux/lockdep_api.h>
+#include <linux/hardirq.h>
+#include <linux/softirq.h>
+#include <linux/refcount_api.h>
+#include <linux/topology.h>
+#include <linux/sched/clock.h>
+#include <linux/sched/cond_resched.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/isolation.h>
+#include <linux/sched/loadavg.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/nohz.h>
+#include <linux/sched/rseq_api.h>
+#include <linux/sched/rt.h>
+
+#include <linux/blkdev.h>
+#include <linux/context_tracking.h>
+#include <linux/cpuset.h>
+#include <linux/delayacct.h>
+#include <linux/init_task.h>
+#include <linux/interrupt.h>
+#include <linux/ioprio.h>
+#include <linux/kallsyms.h>
+#include <linux/kcov.h>
+#include <linux/kprobes.h>
+#include <linux/llist_api.h>
+#include <linux/mmu_context.h>
+#include <linux/mmzone.h>
+#include <linux/mutex_api.h>
+#include <linux/nmi.h>
+#include <linux/nospec.h>
+#include <linux/perf_event_api.h>
+#include <linux/profile.h>
+#include <linux/psi.h>
+#include <linux/rcuwait_api.h>
+#include <linux/sched/wake_q.h>
+#include <linux/scs.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/vtime.h>
+#include <linux/wait_api.h>
+#include <linux/workqueue_api.h>
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+# include <linux/entry-common.h>
+#endif
+
+#include <uapi/linux/sched/types.h>
+
+#include <asm/switch_to.h>
+#include <asm/tlb.h>
+
 #define CREATE_TRACE_POINTS
+#include <linux/sched/rseq_api.h>
 #include <trace/events/sched.h>
 #undef CREATE_TRACE_POINTS
 
@@ -14,22 +80,15 @@
 #include "stats.h"
 #include "autogroup.h"
 
-#include <linux/nospec.h>
-#include <linux/blkdev.h>
-#include <linux/jump_label.h>
-#include <linux/kcov.h>
-#include <linux/scs.h>
-
-#include <asm/switch_to.h>
-#include <asm/tlb.h>
+#include "autogroup.h"
+#include "pelt.h"
+#include "smp.h"
+#include "stats.h"
 
 #include "../workqueue_internal.h"
 #include "../../fs/io-wq.h"
 #include "../smpboot.h"
 
-#include "pelt.h"
-#include "smp.h"
-
 /*
  * Export tracepoints that act as a bare tracehook (ie: have no trace event
  * associated with them) to allow external modules to probe them.
-- 
2.32.0

