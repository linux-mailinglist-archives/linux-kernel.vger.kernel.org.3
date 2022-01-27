Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8824549EAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245157AbiA0TY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:24:59 -0500
Received: from foss.arm.com ([217.140.110.172]:51600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232674AbiA0TY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:24:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E67E0113E;
        Thu, 27 Jan 2022 11:24:56 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED4243F7D7;
        Thu, 27 Jan 2022 11:24:53 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: [PATCH v4] arm64: mm: Make arch_faults_on_old_pte() check for migratability
Date:   Thu, 27 Jan 2022 19:24:37 +0000
Message-Id: <20220127192437.1192957-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_faults_on_old_pte() relies on the calling context being
non-preemptible. CONFIG_PREEMPT_RT turns the PTE lock into a sleepable
spinlock, which doesn't disable preemption once acquired, triggering the
warning in arch_faults_on_old_pte().

It does however disable migration, ensuring the task remains on the same
CPU during the entirety of the critical section, making the read of
cpu_has_hw_af() safe and stable.

Make arch_faults_on_old_pte() check cant_migrate() instead of preemptible().

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lore.kernel.org/r/20210811201354.1976839-5-valentin.schneider@arm.com
---
v3 -> v4: Dropped migratable(), reuse cant_migrate() (Sebastian)
---
 arch/arm64/include/asm/pgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c4ba047a82d2..3caf6346ea95 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1001,7 +1001,8 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
  */
 static inline bool arch_faults_on_old_pte(void)
 {
-	WARN_ON(preemptible());
+	/* The register read below requires a stable CPU to make any sense */
+	cant_migrate();
 
 	return !cpu_has_hw_af();
 }
-- 
2.25.1

