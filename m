Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2550853F98F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbiFGJY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiFGJYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:24:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366C260AA0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:24:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so14906985pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Mo+/PN3jA6jIMUCrvxiVoi6NMY2+U7ufggGeRcQuNE=;
        b=F8cxIfum7BfcisWC0Wg0BlpAKkhAczt19iju8fLF3bRb68HZHa/NU3caY61S8rXpBm
         CXPBXks123tM0yrpSj3BfUW1v4fDSGujah0Pyvxw9LwVtprR03tFf1F7uuyRm6pgY/4Z
         /AFd/w/t3jyedlUzV6Oc2yLky5PHas1ohkdw+Tq66TdmP6e9BYTSgT7g6O/RaBPOWVgi
         kjpMX/K4twreFqWw09Ayo7N/pfz7Xrn08di0pxL9mxGi7UjtpjxC4zegpuJYWJxXg0uC
         1H1X9RLGCvdcK/7cQcJ3mG4iwET+6m0sgTef/Am8lKeTQoZ/tekjuVjlykGIRX1wLAHR
         tkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Mo+/PN3jA6jIMUCrvxiVoi6NMY2+U7ufggGeRcQuNE=;
        b=ZfyRo5lp1O0rTLw83MMLx5QRENWdkWkHcRu+xLex0CuCVx/2PeWExsOEP6eIxc9bxU
         88DHZPoX/VR8sLKl++QIXMiDH8PxV0gHu+hTVcf32CGwkWXLTPlLZlk+X5sWUZ65ntGj
         UgH/+Y7fqmflMA2ER+b1KaRXSWgrXXxFp0OZn4e5M2yudjRE/HDubcQQOJ6jS3bN5f7b
         IRt0FyVnhO0ZIUuomGRGAUoqL81y2Ip3Gt79/CEtjmxhzqBpFR0eKs0YfQFYXsMtDoy6
         ocKpA/8hdiWwM3AURBmN7kEtK+AmTUwvWGEAaeRpTKC/g7dDt2wtAR/Xixo0TWadnmah
         EUAA==
X-Gm-Message-State: AOAM5324U0SP+qsn3nJnAP789O9VAr03Ox/+CIFQjmsB1+hsglaYN50I
        AW0AJWHlDWMAavZuCKG4HVY=
X-Google-Smtp-Source: ABdhPJxBFeIqlzZAUUJSlcl6q685wNT3fhyqqGB+muz/4fU7C0PYZ8PZjCw6UXavoP7yFqvgmpNxmQ==
X-Received: by 2002:a17:90b:1d0a:b0:1e8:7f14:8db with SMTP id on10-20020a17090b1d0a00b001e87f1408dbmr10999609pjb.218.1654593860781;
        Tue, 07 Jun 2022 02:24:20 -0700 (PDT)
Received: from ubuntu20.hobot.cc ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id ix9-20020a170902f80900b0016797c486e4sm899364plb.259.2022.06.07.02.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:24:20 -0700 (PDT)
From:   Zhipeng Shi <zhipeng.shi0@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     tglx@linutronix.de, bigeasy@linutronix.de, schspa@gmail.com,
        shengjian.xu@horizon.ai, linux-kernel@vger.kernel.org,
        Zhipeng Shi <zhipeng.shi0@gmail.com>
Subject: [PATCH] locking/rtmutex: Provide proper spin_is_contended
Date:   Tue,  7 Jun 2022 17:24:04 +0800
Message-Id: <20220607092404.900755-1-zhipeng.shi0@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d89c70356acf ("locking/core: Remove break_lock field when
CONFIG_GENERIC_LOCKBREAK=y") removed GENERIC_LOCKBREAK, which caused
spin_is_contended depend on the implementation of arch_spin_is_contended.
But now in rt-spinlock, spin_is_contended returns 0 directly.

This causes cond_resched_lock to fail to correctly detect lock contention
in RT-linux. In some scenarios (such as __purge_vmap_area_lazy in vmalloc),
this will cause a large latency.

This patch provides the implementation of spin_is_contended for
rt-spinlock.

Signed-off-by: Zhipeng Shi <zhipeng.shi0@gmail.com>
---
 include/linux/rtmutex.h         |  2 ++
 include/linux/spinlock_rt.h     | 13 ++++++++++++-
 kernel/locking/rtmutex_common.h |  2 --
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 7d049883a08a..cd7ac1785c6a 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -70,6 +70,8 @@ extern void rt_mutex_debug_task_free(struct task_struct *tsk);
 static inline void rt_mutex_debug_task_free(struct task_struct *tsk) { }
 #endif
 
+#define RT_MUTEX_HAS_WAITERS	1UL
+
 #define rt_mutex_init(mutex) \
 do { \
 	static struct lock_class_key __key; \
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 835aedaf68ac..54abf2b50494 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -145,7 +145,18 @@ static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 #define spin_trylock_irqsave(lock, flags)		\
 	__cond_lock(lock, __spin_trylock_irqsave(lock, flags))
 
-#define spin_is_contended(lock)		(((void)(lock), 0))
+/**
+ * spin_is_contended - check if the lock is contended
+ * @lock : Pointer to spinlock structure
+ *
+ * Return: 1 if lock is contended, 0 otherwise
+ */
+static inline int spin_is_contended(spinlock_t *lock)
+{
+	unsigned long *p = (unsigned long *) &lock->lock.owner;
+
+	return (READ_ONCE(*p) & RT_MUTEX_HAS_WAITERS);
+}
 
 static inline int spin_is_locked(spinlock_t *lock)
 {
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index c47e8361bfb5..70c765a26163 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -131,8 +131,6 @@ static inline struct rt_mutex_waiter *task_top_pi_waiter(struct task_struct *p)
 			pi_tree_entry);
 }
 
-#define RT_MUTEX_HAS_WAITERS	1UL
-
 static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
 {
 	unsigned long owner = (unsigned long) READ_ONCE(lock->owner);
-- 
2.25.1

