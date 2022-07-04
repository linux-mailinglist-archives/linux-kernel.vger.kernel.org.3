Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702835658CF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiGDOjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiGDOjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:39:12 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4F6E0AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:39:02 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s206so9112695pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGW1NrTsUYC2Caw9DUBG+Ft8zg9T88zFyoolpZns3jU=;
        b=LxLX9txAP1I2ZyM9IadVNNwAEJhkH6guqgpiBx1/i4W56bj5m8uVGAgawSaIRE9v/z
         kbFlddZhORjCpGFuKAjw/Ga3hskx1zW8w1Ltn08LBjW3+H/XQlmllzL6XDHcSv8zLUB6
         x/aBWIA/v5EGZ+RYnuxMEfyruuIFBP4Jz7tpVOTnZUIClvpKoUCTS/XR5YXtEVd8APpU
         uhs7FTLnbWJlRHs2IAhLgkic0eBMxvPJZSeWGUh0jWW26cGtvrAUI/e3hKv6FYzwSXye
         kdObCFZ6NRwHQE3ZEYPU1D3DqTyoI6Aq5o6PyvjhMSaiQmfURZPoVU1w89CIPNoMgkRR
         psTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGW1NrTsUYC2Caw9DUBG+Ft8zg9T88zFyoolpZns3jU=;
        b=P0LnuBYkoAINcrFUomDURfiXLTNr5KvVOh6HNEslQtmpaAZLiCZI2k7+byyD/5fqhN
         kcW15mVDnyb/9mpYdgdvp68U2K0ikHpcLBn0NXybuOze2UBLjPWGLOavG/Crm/0i/ljx
         E+o+OgUk4AualJkEwZf/hx0VKs1IXYeH2Is3VciUiTvt3PwgNkLpIlLX7j4mJx5vcWTh
         Dg2Y0+YIuxyqMtH6iJ97KutzePppOlI8Y6vkEWoOZ8Bui95VfhavvRUIrytSIcdc54mp
         lcMITxx4CSPLSboLQQItb+1cAbJW6NAM5eqPpixUthCIopswo4TYH2X/mU3m14CnjUsf
         srmg==
X-Gm-Message-State: AJIora8nfZjyPw33dZvLFGymOS2s7VIxNvRKOmpmGH7emL7Ce6RyUUh5
        XVo7UwdG7PXsEZNmi/QhxddTA0MfsZo=
X-Google-Smtp-Source: AGRyM1sIkImJ5OuS/BoTitHe4MSEwjyDwNCocDIjczgZeIrykkF8k7kA7nnjjIfALvoIfw1RStN1aA==
X-Received: by 2002:a63:2014:0:b0:411:90a4:6e9c with SMTP id g20-20020a632014000000b0041190a46e9cmr22616835pgg.500.1656945542233;
        Mon, 04 Jul 2022 07:39:02 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.221.247.188])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm20534365pgk.76.2022.07.04.07.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:39:01 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] locking/qspinlock: rename __pv_init_lock_hash to pv_spinlocks_init
Date:   Tue,  5 Jul 2022 00:38:16 +1000
Message-Id: <20220704143820.3071004-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220704143820.3071004-1-npiggin@gmail.com>
References: <20220704143820.3071004-1-npiggin@gmail.com>
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

The caller should not have to be aware what the implementation
initialisation does.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/qspinlock.h | 7 -------
 arch/powerpc/include/asm/spinlock.h  | 2 +-
 arch/x86/hyperv/hv_spinlock.c        | 2 +-
 arch/x86/include/asm/qspinlock.h     | 1 -
 arch/x86/kernel/kvm.c                | 2 +-
 arch/x86/xen/spinlock.c              | 2 +-
 include/asm-generic/qspinlock.h      | 6 ++++++
 kernel/locking/qspinlock.c           | 2 +-
 8 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index dd231c756233..39c1c7f80579 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -53,13 +53,6 @@ static __always_inline void pv_kick(int cpu)
 	prod_cpu(cpu);
 }
 
-extern void __pv_init_lock_hash(void);
-
-static inline void pv_spinlocks_init(void)
-{
-	__pv_init_lock_hash();
-}
-
 #endif
 
 /*
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index bd75872a6334..7dafca8e3f02 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -13,7 +13,7 @@
 /* See include/linux/spinlock.h */
 #define smp_mb__after_spinlock()	smp_mb()
 
-#ifndef CONFIG_PARAVIRT_SPINLOCKS
+#ifndef CONFIG_PPC_QUEUED_SPINLOCKS
 static inline void pv_spinlocks_init(void) { }
 #endif
 
diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 91cfe698bde0..c7b5c3211c79 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -76,7 +76,7 @@ void __init hv_init_spinlocks(void)
 	}
 	pr_info("PV spinlocks enabled\n");
 
-	__pv_init_lock_hash();
+	pv_spinlocks_init();
 	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
 	pv_ops.lock.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
 	pv_ops.lock.wait = hv_qlock_wait;
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 603ad61e9dfe..9a03fcc1b2b7 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -29,7 +29,6 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
-extern void __pv_init_lock_hash(void);
 extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
 extern bool nopvspin;
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 1a3658f7e6d9..98a2c4d3e91d 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -1106,7 +1106,7 @@ void __init kvm_spinlock_init(void)
 
 	pr_info("PV spinlocks enabled\n");
 
-	__pv_init_lock_hash();
+	pv_spinlocks_init();
 	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
 	pv_ops.lock.queued_spin_unlock =
 		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 043c73dfd2c9..5145c4aec4ea 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -135,7 +135,7 @@ void __init xen_init_spinlocks(void)
 	}
 	printk(KERN_DEBUG "xen: PV spinlocks enabled\n");
 
-	__pv_init_lock_hash();
+	pv_spinlocks_init();
 	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
 	pv_ops.lock.queued_spin_unlock =
 		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index 995513fa2690..e0fb29ee1adc 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -147,4 +147,10 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
 #define arch_spin_trylock(l)		queued_spin_trylock(l)
 #define arch_spin_unlock(l)		queued_spin_unlock(l)
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+void pv_spinlocks_init(void);
+#else
+static inline void pv_spinlocks_init(void) { }
+#endif
+
 #endif /* __ASM_GENERIC_QSPINLOCK_H */
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 412b83040bac..1d5b3443772c 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -403,7 +403,7 @@ static unsigned int pv_lock_hash_bits __read_mostly;
  * This function should be called from the paravirt spinlock initialization
  * routine.
  */
-void __init __pv_init_lock_hash(void)
+void __init pv_spinlocks_init(void)
 {
 	int pv_hash_size = ALIGN(4 * num_possible_cpus(), PV_HE_PER_LINE);
 
-- 
2.35.1

