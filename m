Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1BF4E67EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352332AbiCXRlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiCXRlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:41:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1D891572
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:39:43 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648143581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KQxr5oJ0K8+nt7jNJuq4MVZPPDUKGy53NQZ0DdOjis=;
        b=X00bF5WRAfgXO35kUZA7+Mynd7cc4jHPhjP4rTt4cVkOjUQ4wgfVd2xw06a+JFOWBfjjM9
        sg6g+iiJNpWCWk2lCRgeKijKX8hwpgSSNjsbCuzefHbJPTwVcHvr/2FGYtVLlmIEg0TCQT
        9C2/g5YhMj/TKiniNpwvPFKkPTNHPzvdyI74OJV/nZh03nez1IBZRXwGdXtvYKYsSWjgnf
        zboHXqwvGUc4YezjNsHRIV/U49RfYq7kBOW6u4fZvy7u6UyUWcmsUl0XkZ96t38p6XYvcJ
        fVQotLId6F67KhrCgbBf+JONquPHO1fqzeBph5rrfayhIORSamojKmlfSMBcfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648143581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KQxr5oJ0K8+nt7jNJuq4MVZPPDUKGy53NQZ0DdOjis=;
        b=yn0/gUbocPgO65/CVGQlTEPNDplx1MznixwfsgIgjHC0y1vC3GGSUc8sfHfRLfT2r3RXZh
        xbC/ZTzrsCi1teAg==
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        boqun.feng@gmail.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH 1/3] x86/percpu: Remove volatile from arch_raw_cpu_ptr().
Date:   Thu, 24 Mar 2022 18:39:25 +0100
Message-Id: <20220324173927.2230447-2-bigeasy@linutronix.de>
In-Reply-To: <20220324173927.2230447-1-bigeasy@linutronix.de>
References: <CAHk-=wh81PAKxapicYOby3WWOFJV2htR5KWCRdKNgw68mOc0Zg@mail.gmail.com>
 <20220324173927.2230447-1-bigeasy@linutronix.de>
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

Remove volatile from arch_raw_cpu_ptr().

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

