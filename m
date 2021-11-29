Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF1A4615E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377335AbhK2NO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:14:28 -0500
Received: from foss.arm.com ([217.140.110.172]:38942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377353AbhK2NMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:12:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F9F8147A;
        Mon, 29 Nov 2021 05:07:41 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4541A3F766;
        Mon, 29 Nov 2021 05:07:38 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, efuller@redhat.com,
        elver@google.com, ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mark.rutland@arm.com, mattst88@gmail.com, michal.simek@xilinx.com,
        mingo@redhat.com, mpe@ellerman.id.au, npiggin@gmail.com,
        paulmck@kernel.org, paulus@samba.org, peterz@infradead.org,
        rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        vincent.guittot@linaro.org, will@kernel.org
Subject: [PATCH v8 09/11] powerpc: avoid discarding flags in system_call_exception()
Date:   Mon, 29 Nov 2021 13:06:51 +0000
Message-Id: <20211129130653.2037928-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129130653.2037928-1-mark.rutland@arm.com>
References: <20211129130653.2037928-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Thus, when setting flags
we must use an atomic operation rather than a plain read-modify-write
sequence, as a plain read-modify-write may discard flags which are
concurrently set by a remote thread, e.g.

	// task A			// task B
	tmp = A->thread_info.flags;
					set_tsk_thread_flag(A, NEWFLAG_B);
	tmp |= NEWFLAG_A;
	A->thread_info.flags = tmp;

In arch/powerpc/kernel/interrupt.c's system_call_exception(), we set
_TIF_RESTOREALL in the thread info flags with a read-modify-write, which
may result in other flags being discarded.

Elsewhere in the file we use clear_bits() to atomically remove flag
bits, so let's use set_bits() here for consistency with those.

I presume there may be reasons (e.g. instrumentation) that prevent the
use of set_thread_flag() and clear_thread_flag() here, which would
otherwise be preferable.

Fixes: ae7aaecc3f2f78b7 ("powerpc/64s: system call rfscv workaround for TM bugs")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Eirik Fuller <efuller@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 835b626cd476..df048e331cbf 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -148,7 +148,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 	 */
 	if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
 			unlikely(MSR_TM_TRANSACTIONAL(regs->msr)))
-		current_thread_info()->flags |= _TIF_RESTOREALL;
+		set_bits(_TIF_RESTOREALL, &current_thread_info()->flags);
 
 	/*
 	 * If the system call was made with a transaction active, doom it and
-- 
2.30.2

