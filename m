Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09904533F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243416AbiEYOkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiEYOke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:40:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2624C32EFF
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:40:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t26so2217417edt.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WGRkHo13klUcDKk1KqH40m6REBnbbm7RxrmwOgaIy6M=;
        b=LtBLbMi9JKvOZMUSCfZdrY+fZA6DYkhA2b98GUXIMdkIVbHThmh2Rnl8mdD1oGUAg2
         QqbLF/L+mw7FeVB2giyVlbrmzhCOSz6Fki/OwVfZ3TjO6OH2/NYPJeWrRceBg8WwA5BO
         YmKzPhfJIk8Ez8vbhAEPO5TD6+SUdjej8MxCZ2hSyLsJGCuVX9a3ztvDk49kC1YJQ9Dq
         /HMe+7mTxxLE4CS8DFEzeSHBXnVQgKYnBmUatmUosY/8sk9g59NXGwwrk0WE/obMuo2j
         1EhY48pkOTV661H+B821KMC0RpaIrdN0YqSJQbf1WfRG2nbDeVrlxWbawLH3XNkO0PF9
         1Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WGRkHo13klUcDKk1KqH40m6REBnbbm7RxrmwOgaIy6M=;
        b=abJiTiF9xOdWe3N14cGzhl7pkgvAM5i9sSQERRJ0bqoJaB/zT9Q28HB3al/+p2WNwY
         Lma7DA1YLuwjGcO+gfvHH6+qk5ToI8fZzZh8+9xItpJ+bTzY0EOVsED4FSluU4+L7cuA
         fMDREUt3rhMIbMMTkc6ygIUKkjZSq1tnhCTsutiG4jt4stQP8LFUuLjZWUKXmr7GF6BH
         X9vaNshsrQ6P0UfptUGv5mg75wHrX/R7CILN8JXrqayqyQpabfoeaF3DeEFImvV1R8A0
         h0ZExWhvHbD6J35hvJleDuYb6ddwCWpD/nQRQDEj/9ERmMP1sD3qCbzCRLBV8TGSJdl9
         OzFA==
X-Gm-Message-State: AOAM531G2T3cGMzo3nVl2bXGXmNZMxdBCCCFXIcVHSJKkKqfZBEc63G+
        qRtdjxFRChGOhXKhLvqAo4s=
X-Google-Smtp-Source: ABdhPJyz6d3QgFAMa7osg5LGOwJFbHcbyLDyfJGbY6zdbRkJzXiPXZ2Def+pmp2a0fBWm9VAVLW46A==
X-Received: by 2002:a05:6402:520e:b0:42b:360b:78e1 with SMTP id s14-20020a056402520e00b0042b360b78e1mr25258520edd.186.1653489629653;
        Wed, 25 May 2022 07:40:29 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906224400b006f3ef214da7sm8288262ejr.13.2022.05.25.07.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 07:40:29 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Waiman.Long@hp.com,
        paulmck@linux.vnet.ibm.com
Subject: [PATCH 1/2] locking/lockref: Use try_cmpxchg64 in CMPXCHG_LOOP macro
Date:   Wed, 25 May 2022 16:40:12 +0200
Message-Id: <20220525144013.6481-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525144013.6481-1-ubizjak@gmail.com>
References: <20220525144013.6481-1-ubizjak@gmail.com>
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

Use try_cmpxchg64 instead of cmpxchg64 in CMPXCHG_LOOP macro.
x86 CMPXCHG instruction returns success in ZF flag, so this
change saves a compare after cmpxchg (and related move instruction
in front of cmpxchg). The main loop of lockref_get improves from:

  13:	48 89 c1             	mov    %rax,%rcx
  16:	48 c1 f9 20          	sar    $0x20,%rcx
  1a:	83 c1 01             	add    $0x1,%ecx
  1d:	48 89 ce             	mov    %rcx,%rsi
  20:	89 c1                	mov    %eax,%ecx
  22:	48 89 d0             	mov    %rdx,%rax
  25:	48 c1 e6 20          	shl    $0x20,%rsi
  29:	48 09 f1             	or     %rsi,%rcx
  2c:	f0 48 0f b1 4d 00    	lock cmpxchg %rcx,0x0(%rbp)
  32:	48 39 d0             	cmp    %rdx,%rax
  35:	75 17                	jne    4e <lockref_get+0x4e>

to:

  13:	48 89 ca             	mov    %rcx,%rdx
  16:	48 c1 fa 20          	sar    $0x20,%rdx
  1a:	83 c2 01             	add    $0x1,%edx
  1d:	48 89 d6             	mov    %rdx,%rsi
  20:	89 ca                	mov    %ecx,%edx
  22:	48 c1 e6 20          	shl    $0x20,%rsi
  26:	48 09 f2             	or     %rsi,%rdx
  29:	f0 48 0f b1 55 00    	lock cmpxchg %rdx,0x0(%rbp)
  2f:	75 02                	jne    33 <lockref_get+0x33>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman.Long@hp.com
Cc: paulmck@linux.vnet.ibm.com
---
 lib/lockref.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/lockref.c b/lib/lockref.c
index 5b34bbd3eba8..c6f0b183b937 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -14,12 +14,11 @@
 	BUILD_BUG_ON(sizeof(old) != 8);						\
 	old.lock_count = READ_ONCE(lockref->lock_count);			\
 	while (likely(arch_spin_value_unlocked(old.lock.rlock.raw_lock))) {  	\
-		struct lockref new = old, prev = old;				\
+		struct lockref new = old;					\
 		CODE								\
-		old.lock_count = cmpxchg64_relaxed(&lockref->lock_count,	\
-						   old.lock_count,		\
-						   new.lock_count);		\
-		if (likely(old.lock_count == prev.lock_count)) {		\
+		if (likely(try_cmpxchg64_relaxed(&lockref->lock_count,		\
+						 &old.lock_count,		\
+						 new.lock_count))) {		\
 			SUCCESS;						\
 		}								\
 		if (!--retry)							\
-- 
2.35.3

