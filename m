Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215984F2E58
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 14:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354289AbiDEKNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241159AbiDEIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F222167C7;
        Tue,  5 Apr 2022 01:28:59 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:28:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aRspjOD+sp4wLkw4s0WLBmG5G07DJy71EvKofdBLPA4=;
        b=gok3LcuSKj4zHHuSDoKXqImYIYgLzOiqWQmeaO0TT7se7k1AS6iHAf0DLX7gCwbSZ8So9o
        3PSKYhQa+td4Dz5gi2y6hCbTg8mbMDjVO39IQfj4fU1lR6Teav0I6/Jo5cVpzz3pvHQ/f1
        otDThHBB5ChCpFRrCZuOzlTHh2uz6tsKh8mE7BypSn4GgsDZoEe6yT9BrflLOL5zBmQRb8
        Y4UGPw9EGMyHIKD3PD8fsK5LTe4/FngmAuofjAzR6hdlY8hsVtQfkt8ezHnR6cYENWz1Uy
        0iLeDoF0pPk8kqrltGxJI3I3nSjwr0YR90BPow/iSpki8FEkybVBAU5SXqlvdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aRspjOD+sp4wLkw4s0WLBmG5G07DJy71EvKofdBLPA4=;
        b=VxaaUtbIbDRsVByCzaPodikw8WVDkI1rGgzMxON0+tAuOIy8nh02YGsBmagANhYfrPGO0J
        oo2+TPEhpRMsjrDA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] x86/percpu: Remove volatile from arch_raw_cpu_ptr().
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220328145810.86783-2-bigeasy@linutronix.de>
References: <20220328145810.86783-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164914733657.389.13602692959226451396.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     1c1e7e3c23dd25f938302428eeb22c3dda2c3427
Gitweb:        https://git.kernel.org/tip/1c1e7e3c23dd25f938302428eeb22c3dda2c3427
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 28 Mar 2022 16:58:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:38 +02:00

x86/percpu: Remove volatile from arch_raw_cpu_ptr().

The volatile attribute in the inline assembly of arch_raw_cpu_ptr()
forces the compiler to always generate the code, even if the compiler
can decide upfront that its result is not needed.

For instance invoking __intel_pmu_disable_all(false) (like
intel_pmu_snapshot_arch_branch_stack() does) leads to loading the
address of &cpu_hw_events into the register while compiler knows that it
has no need for it. This ends up with code like:

|	movq	$cpu_hw_events, %rax			#, tcp_ptr__
|	add	%gs:this_cpu_off(%rip), %rax		# this_cpu_off, tcp_ptr__
|	xorl	%eax, %eax				# tmp93

It also creates additional code within local_lock() with !RT &&
!LOCKDEP which is not desired.

By removing the volatile attribute the compiler can place the
function freely and avoid it if it is not needed in the end.
By using the function twice the compiler properly caches only the
variable offset and always loads the CPU-offset.

this_cpu_ptr() also remains properly placed within a preempt_disable()
sections because
- arch_raw_cpu_ptr() assembly has a memory input ("m" (this_cpu_off))
- prempt_{dis,en}able() fundamentally has a 'barrier()' in it

Therefore this_cpu_ptr() is already properly serialized and does not
rely on the 'volatile' attribute.

Remove volatile from arch_raw_cpu_ptr().

[ bigeasy: Added Linus' explanation why this_cpu_ptr() is not moved out
  of a preempt_disable() section without the 'volatile' attribute. ]

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220328145810.86783-2-bigeasy@linutronix.de
---
 arch/x86/include/asm/percpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index a3c33b7..13c0d63 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -38,9 +38,9 @@
 #define arch_raw_cpu_ptr(ptr)				\
 ({							\
 	unsigned long tcp_ptr__;			\
-	asm volatile("add " __percpu_arg(1) ", %0"	\
-		     : "=r" (tcp_ptr__)			\
-		     : "m" (this_cpu_off), "0" (ptr));	\
+	asm ("add " __percpu_arg(1) ", %0"		\
+	     : "=r" (tcp_ptr__)				\
+	     : "m" (this_cpu_off), "0" (ptr));		\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;	\
 })
 #else
