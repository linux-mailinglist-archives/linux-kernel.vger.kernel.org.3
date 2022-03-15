Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D2E4D9696
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346131AbiCOIpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346114AbiCOIpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62424D252
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t11so27780901wrm.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wzh6PPn3BYYLSOV3r4esv3lBm2eIZKvXqrp9GqW+JaE=;
        b=dG4RWZdVbBfki25LNw8BUMmcRFIGmE63SNCOVbHa4hmBaTBq5+UI2aRaCvGm7Na9bK
         V0d4wxWABZgUntQ4psJ4prwm1OmsKJbMC6ZC1po2mciFf3LNp0GwunxtdCAg2lAb1SnG
         rohx9TGGkTdpcPi1lWYARuL8L6cOHM97UoFCS3X637/l2eK92u8At9AIeQ/vP4uAzItv
         bc5LN8kaL89rxeNuln09H4SQsoKjmV70BKGf1jImYGne+NzJ4RGlDXG+BEdgYPpmJObV
         ujn1Lcu5tntbR9jmtrHlBKqhgFbyqTaBXoUyos4GCC7WCLwKnftspDRYgVnll3zbJfX2
         I5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wzh6PPn3BYYLSOV3r4esv3lBm2eIZKvXqrp9GqW+JaE=;
        b=Ae2LR6TrjIdRHjzY9njEQRc/7esQLY33hEUO+EO1CH5z2cZe60Va2XbP5PJ+YFTty+
         brVScmF+XWeyYQjh9NnyqAcWFjqBxBEg9Zxbm3hXbvxUzM2DsdAjquSVH+u7yLAx6jX8
         z7xK2IPz26c3c3XIbMnSsEeNdh084C2207xFHCwf8YFHCOi+pMrpbTSksZV0MKotUTxW
         eL5R1YCdoCREOtSlY87E93z8qYCYPte61R3v/37qHJ3G6ZU1WrKV6q36X4t72MfeYUtm
         QQZFxsGfRwnqWKOXe/5d/A410kqq9Y5go4KcVPyYnt0oQrCjX2YuWZjvHyCasmkx0usu
         U1Ew==
X-Gm-Message-State: AOAM533hXrcZIm9J15VyJPve6Pon0DGknTI86rWYqy7qaT/z4AIiai7X
        hVWm0K+CNPBwDqfDY1PNDcR841fvJrc=
X-Google-Smtp-Source: ABdhPJwFo0JopTRwVFWvzEs02cO2cyz7od1Cg81UWCAawetrgpAG9fn3JgwoDebFQck5wQg1DP02Yg==
X-Received: by 2002:a5d:4dc5:0:b0:1f0:73e4:2cd9 with SMTP id f5-20020a5d4dc5000000b001f073e42cd9mr19693320wru.212.1647333834026;
        Tue, 15 Mar 2022 01:43:54 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:43:53 -0700 (PDT)
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
Subject: [PATCH 05/15] sched/headers: Add initial new headers as identity mappings
Date:   Tue, 15 Mar 2022 09:42:37 +0100
Message-Id: <20220315084247.40783-6-mingo@kernel.org>
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

This allows code sharing between fast-headers tree and the vanilla
scheduler tree.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/arm64/include/asm/paravirt_api_clock.h | 1 +
 arch/x86/include/asm/paravirt_api_clock.h   | 1 +
 include/linux/cgroup_api.h                  | 1 +
 include/linux/cpumask_api.h                 | 1 +
 include/linux/fs_api.h                      | 1 +
 include/linux/gfp_api.h                     | 1 +
 include/linux/hashtable_api.h               | 1 +
 include/linux/hrtimer_api.h                 | 1 +
 include/linux/kobject_api.h                 | 1 +
 include/linux/kref_api.h                    | 1 +
 include/linux/ktime_api.h                   | 1 +
 include/linux/llist_api.h                   | 1 +
 include/linux/lockdep_api.h                 | 1 +
 include/linux/mm_api.h                      | 1 +
 include/linux/mutex_api.h                   | 1 +
 include/linux/perf_event_api.h              | 1 +
 include/linux/pgtable_api.h                 | 1 +
 include/linux/ptrace_api.h                  | 1 +
 include/linux/rcuwait_api.h                 | 1 +
 include/linux/refcount_api.h                | 1 +
 include/linux/sched/affinity.h              | 1 +
 include/linux/sched/cond_resched.h          | 1 +
 include/linux/sched/posix-timers.h          | 1 +
 include/linux/sched/rseq_api.h              | 1 +
 include/linux/sched/task_flags.h            | 1 +
 include/linux/sched/thread_info_api.h       | 1 +
 include/linux/seqlock_api.h                 | 1 +
 include/linux/softirq.h                     | 1 +
 include/linux/spinlock_api.h                | 1 +
 include/linux/swait_api.h                   | 1 +
 include/linux/syscalls_api.h                | 1 +
 include/linux/u64_stats_sync_api.h          | 1 +
 include/linux/wait_api.h                    | 1 +
 include/linux/workqueue_api.h               | 1 +
 34 files changed, 34 insertions(+)

diff --git a/arch/arm64/include/asm/paravirt_api_clock.h b/arch/arm64/include/asm/paravirt_api_clock.h
new file mode 100644
index 000000000000..65ac7cee0dad
--- /dev/null
+++ b/arch/arm64/include/asm/paravirt_api_clock.h
@@ -0,0 +1 @@
+#include <asm/paravirt.h>
diff --git a/arch/x86/include/asm/paravirt_api_clock.h b/arch/x86/include/asm/paravirt_api_clock.h
new file mode 100644
index 000000000000..65ac7cee0dad
--- /dev/null
+++ b/arch/x86/include/asm/paravirt_api_clock.h
@@ -0,0 +1 @@
+#include <asm/paravirt.h>
diff --git a/include/linux/cgroup_api.h b/include/linux/cgroup_api.h
new file mode 100644
index 000000000000..d0cfe8025111
--- /dev/null
+++ b/include/linux/cgroup_api.h
@@ -0,0 +1 @@
+#include <linux/cgroup.h>
diff --git a/include/linux/cpumask_api.h b/include/linux/cpumask_api.h
new file mode 100644
index 000000000000..83bd3ebe82b0
--- /dev/null
+++ b/include/linux/cpumask_api.h
@@ -0,0 +1 @@
+#include <linux/cpumask.h>
diff --git a/include/linux/fs_api.h b/include/linux/fs_api.h
new file mode 100644
index 000000000000..83be38d6d413
--- /dev/null
+++ b/include/linux/fs_api.h
@@ -0,0 +1 @@
+#include <linux/fs.h>
diff --git a/include/linux/gfp_api.h b/include/linux/gfp_api.h
new file mode 100644
index 000000000000..5a05a2764a86
--- /dev/null
+++ b/include/linux/gfp_api.h
@@ -0,0 +1 @@
+#include <linux/gfp.h>
diff --git a/include/linux/hashtable_api.h b/include/linux/hashtable_api.h
new file mode 100644
index 000000000000..c268ac2c5c0e
--- /dev/null
+++ b/include/linux/hashtable_api.h
@@ -0,0 +1 @@
+#include <linux/hashtable.h>
diff --git a/include/linux/hrtimer_api.h b/include/linux/hrtimer_api.h
new file mode 100644
index 000000000000..8d9700894468
--- /dev/null
+++ b/include/linux/hrtimer_api.h
@@ -0,0 +1 @@
+#include <linux/hrtimer.h>
diff --git a/include/linux/kobject_api.h b/include/linux/kobject_api.h
new file mode 100644
index 000000000000..6e36a054c2d6
--- /dev/null
+++ b/include/linux/kobject_api.h
@@ -0,0 +1 @@
+#include <linux/kobject.h>
diff --git a/include/linux/kref_api.h b/include/linux/kref_api.h
new file mode 100644
index 000000000000..d67e554721d2
--- /dev/null
+++ b/include/linux/kref_api.h
@@ -0,0 +1 @@
+#include <linux/kref.h>
diff --git a/include/linux/ktime_api.h b/include/linux/ktime_api.h
new file mode 100644
index 000000000000..f697d493960f
--- /dev/null
+++ b/include/linux/ktime_api.h
@@ -0,0 +1 @@
+#include <linux/ktime.h>
diff --git a/include/linux/llist_api.h b/include/linux/llist_api.h
new file mode 100644
index 000000000000..625bec0393a1
--- /dev/null
+++ b/include/linux/llist_api.h
@@ -0,0 +1 @@
+#include <linux/llist.h>
diff --git a/include/linux/lockdep_api.h b/include/linux/lockdep_api.h
new file mode 100644
index 000000000000..907e66979ab2
--- /dev/null
+++ b/include/linux/lockdep_api.h
@@ -0,0 +1 @@
+#include <linux/lockdep.h>
diff --git a/include/linux/mm_api.h b/include/linux/mm_api.h
new file mode 100644
index 000000000000..a5ace2b198b8
--- /dev/null
+++ b/include/linux/mm_api.h
@@ -0,0 +1 @@
+#include <linux/mm.h>
diff --git a/include/linux/mutex_api.h b/include/linux/mutex_api.h
new file mode 100644
index 000000000000..85ab9491e13e
--- /dev/null
+++ b/include/linux/mutex_api.h
@@ -0,0 +1 @@
+#include <linux/mutex.h>
diff --git a/include/linux/perf_event_api.h b/include/linux/perf_event_api.h
new file mode 100644
index 000000000000..c2fd6048b790
--- /dev/null
+++ b/include/linux/perf_event_api.h
@@ -0,0 +1 @@
+#include <linux/perf_event.h>
diff --git a/include/linux/pgtable_api.h b/include/linux/pgtable_api.h
new file mode 100644
index 000000000000..ff367a4ba8c4
--- /dev/null
+++ b/include/linux/pgtable_api.h
@@ -0,0 +1 @@
+#include <linux/pgtable.h>
diff --git a/include/linux/ptrace_api.h b/include/linux/ptrace_api.h
new file mode 100644
index 000000000000..26e7d275ad8d
--- /dev/null
+++ b/include/linux/ptrace_api.h
@@ -0,0 +1 @@
+#include <linux/ptrace.h>
diff --git a/include/linux/rcuwait_api.h b/include/linux/rcuwait_api.h
new file mode 100644
index 000000000000..f962e28544dd
--- /dev/null
+++ b/include/linux/rcuwait_api.h
@@ -0,0 +1 @@
+#include <linux/rcuwait.h>
diff --git a/include/linux/refcount_api.h b/include/linux/refcount_api.h
new file mode 100644
index 000000000000..5f032589f568
--- /dev/null
+++ b/include/linux/refcount_api.h
@@ -0,0 +1 @@
+#include <linux/refcount.h>
diff --git a/include/linux/sched/affinity.h b/include/linux/sched/affinity.h
new file mode 100644
index 000000000000..227f5be81bcd
--- /dev/null
+++ b/include/linux/sched/affinity.h
@@ -0,0 +1 @@
+#include <linux/sched.h>
diff --git a/include/linux/sched/cond_resched.h b/include/linux/sched/cond_resched.h
new file mode 100644
index 000000000000..227f5be81bcd
--- /dev/null
+++ b/include/linux/sched/cond_resched.h
@@ -0,0 +1 @@
+#include <linux/sched.h>
diff --git a/include/linux/sched/posix-timers.h b/include/linux/sched/posix-timers.h
new file mode 100644
index 000000000000..523a381d6c88
--- /dev/null
+++ b/include/linux/sched/posix-timers.h
@@ -0,0 +1 @@
+#include <linux/posix-timers.h>
diff --git a/include/linux/sched/rseq_api.h b/include/linux/sched/rseq_api.h
new file mode 100644
index 000000000000..cf2af72693e1
--- /dev/null
+++ b/include/linux/sched/rseq_api.h
@@ -0,0 +1 @@
+#include <linux/rseq.h>
diff --git a/include/linux/sched/task_flags.h b/include/linux/sched/task_flags.h
new file mode 100644
index 000000000000..227f5be81bcd
--- /dev/null
+++ b/include/linux/sched/task_flags.h
@@ -0,0 +1 @@
+#include <linux/sched.h>
diff --git a/include/linux/sched/thread_info_api.h b/include/linux/sched/thread_info_api.h
new file mode 100644
index 000000000000..2c60fbc16c08
--- /dev/null
+++ b/include/linux/sched/thread_info_api.h
@@ -0,0 +1 @@
+#include <linux/thread_info.h>
diff --git a/include/linux/seqlock_api.h b/include/linux/seqlock_api.h
new file mode 100644
index 000000000000..be91e7d3b826
--- /dev/null
+++ b/include/linux/seqlock_api.h
@@ -0,0 +1 @@
+#include <linux/seqlock.h>
diff --git a/include/linux/softirq.h b/include/linux/softirq.h
new file mode 100644
index 000000000000..c73d7dcb4cb5
--- /dev/null
+++ b/include/linux/softirq.h
@@ -0,0 +1 @@
+#include <linux/interrupt.h>
diff --git a/include/linux/spinlock_api.h b/include/linux/spinlock_api.h
new file mode 100644
index 000000000000..6338b27f98df
--- /dev/null
+++ b/include/linux/spinlock_api.h
@@ -0,0 +1 @@
+#include <linux/spinlock.h>
diff --git a/include/linux/swait_api.h b/include/linux/swait_api.h
new file mode 100644
index 000000000000..1eeaaaaa5ea7
--- /dev/null
+++ b/include/linux/swait_api.h
@@ -0,0 +1 @@
+#include <linux/swait.h>
diff --git a/include/linux/syscalls_api.h b/include/linux/syscalls_api.h
new file mode 100644
index 000000000000..23e012b04db4
--- /dev/null
+++ b/include/linux/syscalls_api.h
@@ -0,0 +1 @@
+#include <linux/syscalls.h>
diff --git a/include/linux/u64_stats_sync_api.h b/include/linux/u64_stats_sync_api.h
new file mode 100644
index 000000000000..c72ca63da44b
--- /dev/null
+++ b/include/linux/u64_stats_sync_api.h
@@ -0,0 +1 @@
+#include <linux/u64_stats_sync.h>
diff --git a/include/linux/wait_api.h b/include/linux/wait_api.h
new file mode 100644
index 000000000000..4e930548935a
--- /dev/null
+++ b/include/linux/wait_api.h
@@ -0,0 +1 @@
+#include <linux/wait.h>
diff --git a/include/linux/workqueue_api.h b/include/linux/workqueue_api.h
new file mode 100644
index 000000000000..77debb5d2760
--- /dev/null
+++ b/include/linux/workqueue_api.h
@@ -0,0 +1 @@
+#include <linux/workqueue.h>
-- 
2.32.0

