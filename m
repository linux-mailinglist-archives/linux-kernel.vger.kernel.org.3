Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979BB4A9B9D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiBDPGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:06:23 -0500
Received: from foss.arm.com ([217.140.110.172]:50264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359535AbiBDPGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:06:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CA6C1476;
        Fri,  4 Feb 2022 07:06:20 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79DC03F774;
        Fri,  4 Feb 2022 07:06:18 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ardb@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, valentin.schneider@arm.com, will@kernel.org
Subject: [PATCH v2 4/7] sched/preempt: decouple HAVE_PREEMPT_DYNAMIC from GENERIC_ENTRY
Date:   Fri,  4 Feb 2022 15:05:54 +0000
Message-Id: <20220204150557.434610-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220204150557.434610-1-mark.rutland@arm.com>
References: <20220204150557.434610-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the enabled/disabled states for the preemption functions are
declared alongside their definitions, the core PREEMPT_DYNAMIC logic is
no longer tied to GENERIC_ENTRY, and can safely be selected so long as
an architecture provides enabled/disabled states for
irqentry_exit_cond_resched().

Make it possible to select HAVE_PREEMPT_DYNAMIC without GENERIC_ENTRY.

For existing users of HAVE_PREEMPT_DYNAMIC there should be no functional
change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/Kconfig        | 1 -
 kernel/sched/core.c | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 678a80713b21..601691f1570f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1279,7 +1279,6 @@ config HAVE_STATIC_CALL_INLINE
 config HAVE_PREEMPT_DYNAMIC
 	bool
 	depends on HAVE_STATIC_CALL
-	depends on GENERIC_ENTRY
 	help
 	   Select this if the architecture support boot time preempt setting
 	   on top of static calls. It is strongly advised to support inline
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 414165c430f4..3bf7f90d0ef7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8141,7 +8141,9 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
+#ifdef CONFIG_GENERIC_ENTRY
 #include <linux/entry-common.h>
+#endif
 
 /*
  * SC:cond_resched
-- 
2.30.2

