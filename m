Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CB6526628
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382099AbiEMPbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382052AbiEMPbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:31:25 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B23D887A4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:31:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g23so10337274edy.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FyEVkw0keNZPZ0CrsntkdDzRqQxoY6siytBBtxmPcFY=;
        b=l/MU78YHN6EV+CLSopMUXdmhfLtEY8/kC7dPg5bnMUl6OkVQ1sGIR3JewU6G4oYr/N
         BaZIiY/xYy14mNR8EyDdbzl7COT1jCIYdW3X8t8Zbo/fUrje/pJPe/18b6YO8cAEh3D/
         YHbwxa+KBmUrKf5dClwvwQZ2s6bMiUFqgcwVJcgRhfWR35/b/n3nFViB/gYfoPMrFIUx
         7McYaFrl5nB4QDkkPoO3nvJAQ7Of3auW0Cw90XJRN4SDm1zvSVUuUtdJMy6OMo7xrfn9
         HZ/giFLN7ZMKZpHssJa8QF9r0YuG6GaoEC9v/l5K5SONIJXdNcBklwqQBrTAzDJ9EcKy
         VtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FyEVkw0keNZPZ0CrsntkdDzRqQxoY6siytBBtxmPcFY=;
        b=WkShX0OCSDibUQvLrrXzGGFjy8cbqTRKazYCuXwS76HACeG4V+JzYV7HHR7TMI8eyL
         gDikfeykasfl3EjWU4lYyIWF9+MLZ8R9QiDdRwN+14/nIlpypARj0i5nWLg0oMoRI2HE
         BfERbxSWj6V7LccXQU60w1dSdmwIHl30aovF4y/Y4TrM6TpnhIBQHc3+XgdP6QHIDAWJ
         gComNREYKJflZTLv+rlPQIaneH0SI645Nrd6ynUVZkVfRdm/bA1woDK03ZVc+y83k1Oo
         34Z8kDyLvJD/eqZdMbYWU/Nn3HDHcZBaTY7PfRyJg9dQcOd5fZhF+/7XB8o8Tr3yPgfa
         nzkA==
X-Gm-Message-State: AOAM531TEuGiEzCD07+tONA/OsFun3jwqgwX5Fy/VHzushp3oUdjzXGw
        +yIenyUs+bOzB9PNg/LKItU=
X-Google-Smtp-Source: ABdhPJyOSgegB1CN8ntV9JWIhiZbe4Pa14PPgrWNg35FGTH9M6c3NM+zjYpf82znFB7KswVzz1uhRA==
X-Received: by 2002:a05:6402:12cd:b0:426:16f:c135 with SMTP id k13-20020a05640212cd00b00426016fc135mr40702733edx.297.1652455882596;
        Fri, 13 May 2022 08:31:22 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id h9-20020a50cdc9000000b0042617ba63d5sm1075706edj.95.2022.05.13.08.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:31:22 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>
Subject: [PATCH v2 2/2] locking/atomic/x86: Introduce arch_try_cmpxchg64
Date:   Fri, 13 May 2022 17:30:09 +0200
Message-Id: <20220513153009.228282-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513153009.228282-1-ubizjak@gmail.com>
References: <20220513153009.228282-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>
---
 arch/x86/include/asm/cmpxchg_32.h | 21 +++++++++++++++++++++
 arch/x86/include/asm/cmpxchg_64.h |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 0a7fe0321613..16a604cf24d4 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -42,6 +42,9 @@ static inline void set_64bit(volatile u64 *ptr, u64 value)
 #define arch_cmpxchg64_local(ptr, o, n)					\
 	((__typeof__(*(ptr)))__cmpxchg64_local((ptr), (unsigned long long)(o), \
 					       (unsigned long long)(n)))
+#define arch_try_cmpxchg64(ptr, po, n)					\
+	((__typeof__(*(ptr)))__try_cmpxchg64((ptr), (unsigned long long *)(po), \
+					     (unsigned long long)(n)))
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
index 072e5459fe2f..250187ac8248 100644
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
-- 
2.35.1

