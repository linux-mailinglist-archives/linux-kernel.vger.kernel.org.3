Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E1E4AF570
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiBIPgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiBIPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:35:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60A01C0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:35:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25BAC1FB;
        Wed,  9 Feb 2022 07:35:56 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D1BD33F73B;
        Wed,  9 Feb 2022 07:35:53 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ardb@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, valentin.schneider@arm.com, will@kernel.org
Subject: [PATCH v3 4/7] sched/preempt: decouple HAVE_PREEMPT_DYNAMIC from GENERIC_ENTRY
Date:   Wed,  9 Feb 2022 15:35:32 +0000
Message-Id: <20220209153535.818830-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209153535.818830-1-mark.rutland@arm.com>
References: <20220209153535.818830-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

