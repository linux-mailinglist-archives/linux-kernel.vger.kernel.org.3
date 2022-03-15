Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAAD4D969D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346179AbiCOIqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346176AbiCOIpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14F84D613
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:44:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so952369wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FHw7YrqhEBArbZ7ERU7QUTduUXqoCrfJEvjtPS1rJu4=;
        b=IhqY7JQbledD2CgBRoKqX6srm+u9SvX8fwHSzDGvklTMtGf3XBZuIxUND7SLKEAm6i
         7SGtcRLr7dmxbOYc5FuKgwGqq3nYqzGd883B+513h59ZiQyPGxsxytlbKJqBlLDoLInG
         R1HardsA0QVFOfnrn7Ev2d8aJODVVXN+IZVykB4H8zRjmC07kSF8BMqvnpbYOFq8HVcb
         FWEly4AZ56OYGmBXBxiZl/F0wreErXbuIbGttv0IogRzT2lYmD0bzB5s19cFjOqpo3eS
         dZgHdQEd2GKJrePBUf20ikYmyOIZvMx0LP/lh5meaQTHNvNpJXdFQdSluwO5NxA6pU6a
         /yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FHw7YrqhEBArbZ7ERU7QUTduUXqoCrfJEvjtPS1rJu4=;
        b=f2/+/kliudK8UUZagdym8UeEs5znliqwfeCzDYfQvU1F52OKKnb5rBxUjSssFGTRyK
         esBXEROTBTAKERTeD8gs2MFrHMY1o7a8CkeNDJRw+iHIxM6lXTgNdJuZP6Pyf+Fo2Kdm
         IOxtxuenqAESemkmzStQyu62seRi86EFuUPBBXdW8R6ihHYR7miQ3YrEulxeIx/XXVtk
         HDokUfN2srmscjPFrqxiYKipynRr2mS09IUjFNjmuKZYKjojLApOvif1b37C28Rkp+3K
         uKBC6Ovzw3PHsDy67tXi3mcgyTwHHJ4FGRfIfgBTIPp2ElPThx2tQk4VxbmNxuXT9Csf
         oaKA==
X-Gm-Message-State: AOAM532kvWUyivqRaFxoG89GMGScTp1XFK7YWNK/wvVFc71AD3Ro6TKx
        eBdC8acUQ4i9v3vAm5kT0jn2sVl6H/k=
X-Google-Smtp-Source: ABdhPJytDh2neTgked42IY+RyFQq1dv0P2hyPJUYBM/8U9EBEyE/NmaceboOa1zNU5fh3lIBbQW4eg==
X-Received: by 2002:a1c:1941:0:b0:38b:4af1:49f8 with SMTP id 62-20020a1c1941000000b0038b4af149f8mr2110200wmz.156.1647333844235;
        Tue, 15 Mar 2022 01:44:04 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:44:03 -0700 (PDT)
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
Subject: [PATCH 14/15] sched/headers: Reorganize, clean up and optimize kernel/sched/build_utility.c dependencies
Date:   Tue, 15 Mar 2022 09:42:46 +0100
Message-Id: <20220315084247.40783-15-mingo@kernel.org>
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
 kernel/sched/build_utility.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index 8b2b199983bf..bc2f4d648209 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -9,14 +9,53 @@
  *   coalescing source files to amortize header inclusion
  *   cost. )
  */
+#include <linux/sched/clock.h>
+#include <linux/sched/cputime.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/isolation.h>
+#include <linux/sched/loadavg.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/rseq_api.h>
+#include <linux/sched/task_stack.h>
+
+#include <linux/cpufreq.h>
+#include <linux/cpumask_api.h>
+#include <linux/cpuset.h>
+#include <linux/ctype.h>
+#include <linux/debugfs.h>
+#include <linux/energy_model.h>
+#include <linux/hashtable_api.h>
+#include <linux/irq.h>
+#include <linux/kobject_api.h>
+#include <linux/membarrier.h>
+#include <linux/mempolicy.h>
+#include <linux/nmi.h>
+#include <linux/nospec.h>
+#include <linux/proc_fs.h>
+#include <linux/psi.h>
+#include <linux/psi.h>
+#include <linux/ptrace_api.h>
+#include <linux/sched_clock.h>
+#include <linux/security.h>
+#include <linux/spinlock_api.h>
+#include <linux/swait_api.h>
+#include <linux/timex.h>
+#include <linux/utsname.h>
+#include <linux/wait_api.h>
+#include <linux/workqueue_api.h>
+
+#ifdef CONFIG_PARAVIRT
+# include <asm/paravirt.h>
+#endif
+
+#include <uapi/linux/prctl.h>
+#include <uapi/linux/sched/types.h>
 
 #include "sched.h"
 #include "sched-pelt.h"
 #include "stats.h"
 #include "autogroup.h"
 
-#include <linux/sched_clock.h>
-
 #include "clock.c"
 
 #ifdef CONFIG_CGROUP_CPUACCT
-- 
2.32.0

