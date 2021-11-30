Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E5D4641FC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345101AbhK3XMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbhK3XMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:12:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9F3C061574;
        Tue, 30 Nov 2021 15:08:41 -0800 (PST)
Date:   Tue, 30 Nov 2021 23:08:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638313719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o8ejOcFPPEQeF3hX1gm6j+vPKDt6RbdDClf/4MPPq24=;
        b=w3YsTDurIT04QYOZSo7/rmDPHzExcYxfjqEHl1s90pFtVnEnEbl3edb+rtVdAQocNligFs
        VPSy2YoM3AwMRQTpKmmFs0mgXUJIKcvjgfm9euANs5dnUWcUcxx02DiuWT3g1rTTSF1+Ka
        LnbqDb+ILPsPTUkMFhtnCiyVCNoJp0RdYeEThg16c3u3a0EQ+bzlf/9AQVRZMYDSTF1q9o
        asVrV2UDNB3SQru0KerFykCWakQVh8IiHyttGqPpZTuhoDCHHCvl0c+t1zNZT5l8j/1gkL
        f8XGOat4Q9pIwNtcnuWziZK9qSGeCLJr7DMZZZ+ci4zq9gnp/7hSs6HBxvCNsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638313719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o8ejOcFPPEQeF3hX1gm6j+vPKDt6RbdDClf/4MPPq24=;
        b=8VZ/yG4qPW1GlokZn5J/QgpkHgIR5A6PC0i09L+krKHarNrVRI97Ezlj4nRViSQA9+vmrr
        0mXXUwSWAOkN5DBA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] powerpc: Avoid discarding flags in system_call_exception()
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eirik Fuller <efuller@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129130653.2037928-10-mark.rutland@arm.com>
References: <20211129130653.2037928-10-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163831371859.11128.15029023034131367563.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     08b0af5b2affbe7419853e8dd1330e4b3fe27125
Gitweb:        https://git.kernel.org/tip/08b0af5b2affbe7419853e8dd1330e4b3fe27125
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 29 Nov 2021 13:06:51 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Dec 2021 00:06:44 +01:00

powerpc: Avoid discarding flags in system_call_exception()

Some thread flags can be set remotely, and so even when IRQs are disabled,
the flags can change under our feet. Thus, when setting flags we must use
an atomic operation rather than a plain read-modify-write sequence, as a
plain read-modify-write may discard flags which are concurrently set by a
remote thread, e.g.

	// task A			// task B
	tmp = A->thread_info.flags;
					set_tsk_thread_flag(A, NEWFLAG_B);
	tmp |= NEWFLAG_A;
	A->thread_info.flags = tmp;

arch/powerpc/kernel/interrupt.c's system_call_exception() sets
_TIF_RESTOREALL in the thread info flags with a read-modify-write, which
may result in other flags being discarded.

Elsewhere in the file it uses clear_bits() to atomically remove flag bits,
so use set_bits() here for consistency with those.

There may be reasons (e.g. instrumentation) that prevent the use of
set_thread_flag() and clear_thread_flag() here, which would otherwise be
preferable.

Fixes: ae7aaecc3f2f78b7 ("powerpc/64s: system call rfscv workaround for TM bugs")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Eirik Fuller <efuller@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Link: https://lore.kernel.org/r/20211129130653.2037928-10-mark.rutland@arm.com

---
 arch/powerpc/kernel/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 835b626..df048e3 100644
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
