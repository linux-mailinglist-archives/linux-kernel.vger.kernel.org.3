Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B21C52ADFD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiEQWV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiEQWV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:21:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DFD28E18;
        Tue, 17 May 2022 15:21:25 -0700 (PDT)
Date:   Tue, 17 May 2022 22:21:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652826082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JvThGW9rVy0Y7k8i4EwpLIQqeX5s0xfJpDrQQUJOyDU=;
        b=IXSwyGFSHO4ns+FEmYrkmWjTHXnLOcStFOStsyc0d5XjgPj2KVCMWvALHptEL+U36enodN
        wD/m+URpVwkJI520Th1vposIfKH7jeNKKOBnw3fx6NbHBiLd3I33NDuHes9aDtJIFik9Ee
        LY60Y6vNG+1bOT48PXqH3xkyeLzmfiMyiGOKnb3p2wWCGHP4TvHDRz5fZ9IJjmu19XtZGS
        conlonApUyuBaIwXsWmAhekaQmASArMntB3jmqRo2LKMiXzELcF1sTlCYAAXyBlVjIlXZY
        6YlsfqWtsiA3HWq6U6fZXCJjqotpuSD6ofMGJLLw5pqk/iEz10d5tl3Bsov59g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652826082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JvThGW9rVy0Y7k8i4EwpLIQqeX5s0xfJpDrQQUJOyDU=;
        b=+E8ZB2hhEGZhHVeI0xdvszJaknwjE4bg4ceHvZcpCkHMx7xbvzsFXh3YobJ1asvPCCTnYA
        Obsk5BXw4MqlRtCA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic/x86: Introduce arch_try_cmpxchg64
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220515184205.103089-3-ubizjak@gmail.com>
References: <20220515184205.103089-3-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <165282608130.4207.11491865757790296043.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c2df0a6af177b6c06a859806a876f92b072dc624
Gitweb:        https://git.kernel.org/tip/c2df0a6af177b6c06a859806a876f92b072dc624
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 15 May 2022 20:42:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 18 May 2022 00:08:28 +02:00

locking/atomic/x86: Introduce arch_try_cmpxchg64

Introduce arch_try_cmpxchg64 for 64-bit and 32-bit targets to improve
code using cmpxchg64.  On 64-bit targets, the generated assembly improves
from:

  ab:	89 c8                	mov    %ecx,%eax
  ad:	48 89 4c 24 60       	mov    %rcx,0x60(%rsp)
  b2:	83 e0 fd             	and    $0xfffffffd,%eax
  b5:	89 54 24 64          	mov    %edx,0x64(%rsp)
  b9:	88 44 24 60          	mov    %al,0x60(%rsp)
  bd:	48 89 c8             	mov    %rcx,%rax
  c0:	c6 44 24 62 f2       	movb   $0xf2,0x62(%rsp)
  c5:	48 8b 74 24 60       	mov    0x60(%rsp),%rsi
  ca:	f0 49 0f b1 34 24    	lock cmpxchg %rsi,(%r12)
  d0:	48 39 c1             	cmp    %rax,%rcx
  d3:	75 cf                	jne    a4 <t+0xa4>

to:

  b3:	89 c2                	mov    %eax,%edx
  b5:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  ba:	83 e2 fd             	and    $0xfffffffd,%edx
  bd:	89 4c 24 64          	mov    %ecx,0x64(%rsp)
  c1:	88 54 24 60          	mov    %dl,0x60(%rsp)
  c5:	c6 44 24 62 f2       	movb   $0xf2,0x62(%rsp)
  ca:	48 8b 54 24 60       	mov    0x60(%rsp),%rdx
  cf:	f0 48 0f b1 13       	lock cmpxchg %rdx,(%rbx)
  d4:	75 d5                	jne    ab <t+0xab>

where a move and a compare after cmpxchg is saved.  The improvements
for 32-bit targets are even more noticeable, because dual-word compare
after cmpxchg8b gets eliminated.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220515184205.103089-3-ubizjak@gmail.com
---
 arch/x86/include/asm/cmpxchg_32.h | 21 +++++++++++++++++++++
 arch/x86/include/asm/cmpxchg_64.h |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 0a7fe03..215f5a6 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -42,6 +42,9 @@ static inline void set_64bit(volatile u64 *ptr, u64 value)
 #define arch_cmpxchg64_local(ptr, o, n)					\
 	((__typeof__(*(ptr)))__cmpxchg64_local((ptr), (unsigned long long)(o), \
 					       (unsigned long long)(n)))
+#define arch_try_cmpxchg64(ptr, po, n)					\
+	__try_cmpxchg64((ptr), (unsigned long long *)(po), \
+			(unsigned long long)(n))
 #endif
 
 static inline u64 __cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
@@ -70,6 +73,24 @@ static inline u64 __cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new)
 	return prev;
 }
 
+static inline bool __try_cmpxchg64(volatile u64 *ptr, u64 *pold, u64 new)
+{
+	bool success;
+	u64 old = *pold;
+	asm volatile(LOCK_PREFIX "cmpxchg8b %[ptr]"
+		     CC_SET(z)
+		     : CC_OUT(z) (success),
+		       [ptr] "+m" (*ptr),
+		       "+A" (old)
+		     : "b" ((u32)new),
+		       "c" ((u32)(new >> 32))
+		     : "memory");
+
+	if (unlikely(!success))
+		*pold = old;
+	return success;
+}
+
 #ifndef CONFIG_X86_CMPXCHG64
 /*
  * Building a kernel capable running on 80386 and 80486. It may be necessary
diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index 072e545..250187a 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -19,6 +19,12 @@ static inline void set_64bit(volatile u64 *ptr, u64 val)
 	arch_cmpxchg_local((ptr), (o), (n));				\
 })
 
+#define arch_try_cmpxchg64(ptr, po, n)					\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	arch_try_cmpxchg((ptr), (po), (n));				\
+})
+
 #define system_has_cmpxchg_double() boot_cpu_has(X86_FEATURE_CX16)
 
 #endif /* _ASM_X86_CMPXCHG_64_H */
