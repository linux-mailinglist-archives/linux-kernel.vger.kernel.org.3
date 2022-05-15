Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ADB527932
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 20:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbiEOSml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 14:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiEOSmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 14:42:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2288ADF15
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 11:42:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y21so15769983edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 11:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kf1qyJ7WcrGbAyk0+4ZCl1Hcx0Pw2x4ceEltokIn6Ec=;
        b=V+OE4PXTIHs3eExpcvYxcCgVE0v7IGBJuh3YlE13WPevogBZZfxhg1Igl7Y4+nH4mk
         4sHrazj3HNHHianDRyfEucO/fVJIXTwxsXFDBVQ2XKrYV1rClmK6oXsB8C5uwi0Xhz4m
         GgeCnq0QQ9LneuNTbbgzd3aQCNSW9k/t8Nk1egm9jPQttvqvB7ByZlpU4D0K2VGY0noj
         cF7hWYP6DsFj8ntI426bXgGM/f3GKJLCrz0t0avo7qD5Gmsj/x41aE1E/cLosqRojKPh
         EhKuk1SWUt+FHkMmayhJP5rvcKGykKeh7Beoim1Pf2n8AoB7e0p3cd3VwAehCc4WJbul
         Ax/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kf1qyJ7WcrGbAyk0+4ZCl1Hcx0Pw2x4ceEltokIn6Ec=;
        b=qmVQkPYfXPS/E9WHnsTeffjtP0YvJ1bjQ51KQxHQ0uAgmaAfkOGbCon7bz/Qai9aSB
         /NipMYKvVkEeVE1LEAFr8sAr0nGm1pJHzT9seTAtq1sm48khJLJE718pX3JoAIqxlac3
         wgFRBGqM5d38IBtZDviVSpqz7mkc7KVRtmkQy+p5GfTmaAwkZcqJpQs3y7i9Ev+pSWys
         +VrNu6YxcQVnSUFzFWUmjTephgUd7PSsrq5K9IOwMxMWxjrN1yIh+z/twMFOBV1hcNTh
         VWtdw/Kmkuae25qZ8JN8DthShC781ft38SkIhoDDu4lmHm/veNl5iJlzMazTLAGyUl/Y
         R4rA==
X-Gm-Message-State: AOAM530Nu2wEzZkJY6gKaC/BJquC1UMFT/PRTTruSThpDM6Raxf0S72R
        /Wh82kcbGWSS3kKFnA8BQnw=
X-Google-Smtp-Source: ABdhPJy/R817RklJo9xBiaf3PVrccBMZmQvjIt08J7GAbWoKofO7M0ET9r2V7/mrtYjbDRwn69ypGw==
X-Received: by 2002:a05:6402:296:b0:427:e497:29ef with SMTP id l22-20020a056402029600b00427e49729efmr9372588edv.399.1652640149715;
        Sun, 15 May 2022 11:42:29 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id hv7-20020a17090760c700b006f3ef214e62sm2861898ejc.200.2022.05.15.11.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 11:42:29 -0700 (PDT)
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
Subject: [PATCH v3 2/2] locking/atomic/x86: Introduce arch_try_cmpxchg64
Date:   Sun, 15 May 2022 20:42:04 +0200
Message-Id: <20220515184205.103089-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220515184205.103089-1-ubizjak@gmail.com>
References: <20220515184205.103089-1-ubizjak@gmail.com>
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
index 0a7fe0321613..215f5a65790f 100644
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

