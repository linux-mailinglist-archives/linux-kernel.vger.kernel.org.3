Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7881753F93B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbiFGJPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239076AbiFGJPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:15:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB36387A2F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:15:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j6so14974622pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Mo+/PN3jA6jIMUCrvxiVoi6NMY2+U7ufggGeRcQuNE=;
        b=j95jxpRYhrHsRyrn92h3BAYJLk+yfHZ2fRLu0GR4JcefGv/EwLDj4AS99PRrxTx35W
         QGsoXEtd0jEvyKJWWyBhUzVYkjyQVvTKbsqMgyrecEFp94MWtxxEnyyawDs7PVCdStUm
         hnSgAdGF3IbTEgSa6qJqNCRQVbeEpn4Px9MkN6SiL2bTqdavSbZtYzgHftUc7aFno3t8
         ieoUVHQemPYB3jOXqWf7cH7CKvQTaMabdDj/vGFEh5PjgI3uI9we25l/M2rQPL7C02U2
         H1cgVYV+2pq+uresKx2w5AVaGpoLGhNOr67Nga+blzUEqs8qF9NssOs6fh7YJ22CUyhZ
         V9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Mo+/PN3jA6jIMUCrvxiVoi6NMY2+U7ufggGeRcQuNE=;
        b=2lBUrNJiEUKYv0xqG/E+qGW0eiXFzdXKYIl79bM5UeUvi/tLBFszjW09BoRmDlq3eM
         m2ccxkbWz3tbHSru381nhP56VDElsxzAEWyuHOKPhV1b1LUcbcADSQ1rvcz2xpVT2+Aw
         CjVHc0y0OfWQ2WThvd8bIFg2vhwZKY3ZIEDLPZkXSc0BkOee9ajwHdZrtyheoQ6SPXOf
         TX1jj4U7avnzV8MdxDszhYzySM90i7B949k3vlQyI4i/XaTtTv69P/Bc74qnF5AAuF5i
         KkPq0Ju91NPT7TQEBVwvo3KmSJd133lIdKjYugr+lYvsMtR71SqsDdsQzZVFbGmQvtUt
         P/Pg==
X-Gm-Message-State: AOAM531U0gywAHhEj2USXxzY/35jFOKgZngG1APTAX/8C2JSjol2WjaQ
        2ldfAKfQ9uA+9cZ49cjujJw=
X-Google-Smtp-Source: ABdhPJzGfNlMQQYJ+Sqz0TKIkUqKBUiP/oOGgm0p8pv20fC0j3zjQ+BfWZ06O7gmSkxSD552hoqxNg==
X-Received: by 2002:aa7:88cb:0:b0:51c:2627:2c03 with SMTP id k11-20020aa788cb000000b0051c26272c03mr7799782pff.63.1654593329400;
        Tue, 07 Jun 2022 02:15:29 -0700 (PDT)
Received: from ubuntu20.hobot.cc ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id p3-20020a625b03000000b0051c2fc79aa8sm1877775pfb.91.2022.06.07.02.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:15:28 -0700 (PDT)
From:   Zhipeng Shi <zhipeng.shi0@gmail.com>
To:     peterz@infradead.org, mingo@redhat.comb, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     tglx@linutronix.de, bigeasy@linutronix.de, schspa@gmail.com,
        shengjian.xu@horizon.ai, linux-kernel@vger.kernel.org,
        Zhipeng Shi <zhipeng.shi0@gmail.com>
Subject: [PATCH] locking/rtmutex: Provide proper spin_is_contended
Date:   Tue,  7 Jun 2022 17:15:14 +0800
Message-Id: <20220607091514.897833-1-zhipeng.shi0@gmail.com>
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

