Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DB04E9A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244152AbiC1PAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244146AbiC1O76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:59:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2307CB84
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:58:16 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648479494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SOuuvst+UUNcj8L4Pzp1TF8twONkUaE7vZdYgdMuLVo=;
        b=HgHOi4bJEj3U+SyFteDlU1LoxRHx0XUwJUo5/Krx3azavcESGbVbGBAE/dBrN+TNhfoi1c
        hlVxi9KlPTd6r5UZLSIjAl9jy607KP1HeZ7ahddP+Vbr3a2Bj+C8wQJOF9ySxfMzDOav/k
        fzbLG/NF3wwy6OppYP8RKHR0kQu0A5tqF4AnmIbl80/94GaoHphXUhpZWxWKVqlanDGbmf
        ihhAfqCGMYO+FvBAblg0vABkV0XyfvcNCx32/qaWeO75kL1Bk+ZD0wsovvYLG6jWnAFZ5H
        AhL6VR9815NgZDhX1J3feMmJjqT6nshKdroiq/wSnYV6f9jzinJBNz2Up12x2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648479494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SOuuvst+UUNcj8L4Pzp1TF8twONkUaE7vZdYgdMuLVo=;
        b=2aCABIvcnUJpmvSC8UGLXtseBPVnJlnqfN1q1go6xtgFvzsm+iRVJNNKc6wIkd3IrnvyoO
        f3f+oZc0RjR82VCQ==
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        boqun.feng@gmail.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH v2 1/3] x86/percpu: Remove volatile from arch_raw_cpu_ptr().
Date:   Mon, 28 Mar 2022 16:58:08 +0200
Message-Id: <20220328145810.86783-2-bigeasy@linutronix.de>
In-Reply-To: <20220328145810.86783-1-bigeasy@linutronix.de>
References: <CAHk-=wgcM9vUjGTdoCbX4DuBM+53FFmHFqYZdF8mNzATwj8z0A@mail.gmail.com>
 <20220328145810.86783-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/include/asm/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index a3c33b79fb865..5d572a19a389c 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -38,7 +38,7 @@
 #define arch_raw_cpu_ptr(ptr)				\
 ({							\
 	unsigned long tcp_ptr__;			\
-	asm volatile("add " __percpu_arg(1) ", %0"	\
+	asm ("add " __percpu_arg(1) ", %0"	\
 		     : "=3Dr" (tcp_ptr__)			\
 		     : "m" (this_cpu_off), "0" (ptr));	\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;	\
--=20
2.35.1

