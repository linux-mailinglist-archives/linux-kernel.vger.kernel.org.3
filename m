Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EEB4B576A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbiBNQwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:52:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbiBNQwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:52:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8518365142
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:52:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E35213D5;
        Mon, 14 Feb 2022 08:52:25 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C1C03F70D;
        Mon, 14 Feb 2022 08:52:23 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ardb@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, valentin.schneider@arm.com, will@kernel.org
Subject: [PATCH v4 0/7] arm64 / sched/preempt: support PREEMPT_DYNAMIC with static keys
Date:   Mon, 14 Feb 2022 16:52:09 +0000
Message-Id: <20220214165216.2231574-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
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

This series enables PREEMPT_DYNAMIC on arm64. To do so, it adds a new
mechanism allowing the preemption functions to be enabled/disabled using
static keys rather than static calls, with architectures selecting
whether they use static calls or static keys.

With non-inline static calls, each function call results in a call to
the (out-of-line) trampoline which either tail-calls its associated
callee or performs an early return.

The key idea is that where we're only enabling/disabling a single
callee, we can inline this trampoline into the start of the callee,
using a static key to decide whether to return early, and leaving the
remaining codegen to the compiler. The overhead should be similar to
(and likely lower than) using a static call trampoline. Since most
codegen is up to the compiler, we sidestep a number of implementation
pain-points (e.g. things like CFI should "just work" as well as they do
for any other functions).

The bulk of the diffstat for kernel/sched/core.c is shuffling the
PREEMPT_DYNAMIC code later in the file, and the actual additions are
fairly trivial.

I've given this very light build+boot testing so far.

Since v1 [1]:
* Rework Kconfig text to be clearer
* Rework arm64 entry code
* Clarify commit messages.

Since v2 [2]:
* Add missing includes
* Always provide prototype for preempt_schedule()
* Always provide prototype for preempt_schedule_notrace()
* Fix __cond_resched() to default to disabled
* Fix might_resched() to default to disabled
* Clarify example in commit message

Since v3 [3]:
* Add acks (including those missing from v3)
* Fix Kconfig dependencies for jump labels
* Don't default-enable PREEMPT_DYNAMIC when using static keys
* Clarify generated assembly examples

[1] https://lore.kernel.org/r/20211109172408.49641-1-mark.rutland@arm.com/
[2] https://lore.kernel.org/r/20220204150557.434610-1-mark.rutland@arm.com/
[3] https://lore.kernel.org/r/20220209153535.818830-1-mark.rutland@arm.com/

Thanks,
Mark.

Mark Rutland (7):
  sched/preempt: move PREEMPT_DYNAMIC logic later
  sched/preempt: refactor sched_dynamic_update()
  sched/preempt: simplify irqentry_exit_cond_resched() callers
  sched/preempt: decouple HAVE_PREEMPT_DYNAMIC from GENERIC_ENTRY
  sched/preempt: add PREEMPT_DYNAMIC using static keys
  arm64: entry: centralize preemption decision
  arm64: support PREEMPT_DYNAMIC

 arch/Kconfig                     |  37 +++-
 arch/arm64/Kconfig               |   1 +
 arch/arm64/include/asm/preempt.h |  19 +-
 arch/arm64/kernel/entry-common.c |  28 ++-
 arch/x86/Kconfig                 |   2 +-
 arch/x86/include/asm/preempt.h   |  10 +-
 include/linux/entry-common.h     |  15 +-
 include/linux/kernel.h           |   7 +-
 include/linux/sched.h            |  10 +-
 kernel/Kconfig.preempt           |   3 +-
 kernel/entry/common.c            |  23 +-
 kernel/sched/core.c              | 347 ++++++++++++++++++-------------
 12 files changed, 329 insertions(+), 173 deletions(-)

-- 
2.30.2

