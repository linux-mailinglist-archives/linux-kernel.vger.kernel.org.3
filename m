Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5DA561D99
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiF3OOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbiF3ON6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C996427C5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656597589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YL9f1II4Mw4H7t2E0klzVA5qKcGu0RnSH4xCbZTGJWU=;
        b=BZvAiuP8l2H+y0czby0wKhDY79o4M+i05/qNDaw2VqAqONNp3YxQtNPx0xvD09aBLrvk/Q
        g/O3YofRvNSDfs8wn4hM091Wv7peUrarvfH3h7J2g1EJnhxqCKSXm8bZisOoMW088fHRLo
        Jt3vdthpIWyv7fogYlyurciy0aRHcos=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22--w1_ynfMMyqKXXq4Nnz9sA-1; Thu, 30 Jun 2022 09:59:45 -0400
X-MC-Unique: -w1_ynfMMyqKXXq4Nnz9sA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E44E31C004ED;
        Thu, 30 Jun 2022 13:59:44 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9166A815B;
        Thu, 30 Jun 2022 13:59:44 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     will@kernel.org
Cc:     peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        thunder.leizhen@huawei.com, jacob.e.keller@intel.com,
        akpm@linux-foundation.org, linux-sparse@vger.kernel.org,
        cluster-devel@redhat.com, luc.vanoostenryck@gmail.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        aahringo@redhat.com
Subject: [RFC 1/2] refcount: add __cond_lock() for conditional lock refcount API
Date:   Thu, 30 Jun 2022 09:59:33 -0400
Message-Id: <20220630135934.1799248-2-aahringo@redhat.com>
In-Reply-To: <20220630135934.1799248-1-aahringo@redhat.com>
References: <20220630135934.1799248-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the __cond_lock() macro to refcounts conditional lock
API. Currently sparse cannot detect the conditional lock handling of
refcount_dec_and_lock() functionality and prints a context imbalance
warning like:

warning: context imbalance in 'put_rsb' - unexpected unlock

with this patch and having the refcount_dec_and_lock() functionality
inside the if condition to decide whenever doing unlock or not the
warning disappears.

The patch follows a similar naming scheme like raw_spin_trylock() by
adding a "raw_" prefix to refcount_dec_and_lock() functionality and
introduce a macro for the replaced functions that uses __cond_lock()
to signal that an acquire depends on the return value of the passed
function.

A cast to bool seems to be necessary because __cond_lock() does return a
non-boolean scalar type.

The __must_check annotation was tested and is still working with this
patch applied.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/linux/refcount.h | 21 ++++++++++++++++-----
 lib/refcount.c           | 23 ++++++++++++-----------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index b8a6e387f8f9..be7b970ce475 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -361,9 +361,20 @@ static inline void refcount_dec(refcount_t *r)
 
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
-extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock);
-extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock);
-extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
-						       spinlock_t *lock,
-						       unsigned long *flags);
+extern __must_check bool raw_refcount_dec_and_mutex_lock(refcount_t *r,
+							 struct mutex *lock);
+#define refcount_dec_and_mutex_lock(r, lock) \
+	((bool)(__cond_lock(lock, raw_refcount_dec_and_mutex_lock(r, lock))))
+
+extern __must_check bool raw_refcount_dec_and_lock(refcount_t *r,
+						   spinlock_t *lock);
+#define refcount_dec_and_lock(r, lock) \
+	((bool)(__cond_lock(lock, raw_refcount_dec_and_lock(r, lock))))
+
+extern __must_check bool raw_refcount_dec_and_lock_irqsave(refcount_t *r,
+							   spinlock_t *lock,
+							   unsigned long *flags);
+#define refcount_dec_and_lock_irqsave(r, lock, flags) \
+	((bool)(__cond_lock(lock, raw_refcount_dec_and_lock_irqsave(r, lock, flags))))
+
 #endif /* _LINUX_REFCOUNT_H */
diff --git a/lib/refcount.c b/lib/refcount.c
index a207a8f22b3c..1a8c7b9aba23 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -110,7 +110,7 @@ EXPORT_SYMBOL(refcount_dec_not_one);
  * Return: true and hold mutex if able to decrement refcount to 0, false
  *         otherwise
  */
-bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock)
+bool raw_refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock)
 {
 	if (refcount_dec_not_one(r))
 		return false;
@@ -123,11 +123,11 @@ bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock)
 
 	return true;
 }
-EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
+EXPORT_SYMBOL(raw_refcount_dec_and_mutex_lock);
 
 /**
- * refcount_dec_and_lock - return holding spinlock if able to decrement
- *                         refcount to 0
+ * raw_refcount_dec_and_lock - return holding spinlock if able to decrement
+ *			       refcount to 0
  * @r: the refcount
  * @lock: the spinlock to be locked
  *
@@ -141,7 +141,7 @@ EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
  * Return: true and hold spinlock if able to decrement refcount to 0, false
  *         otherwise
  */
-bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
+bool raw_refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 {
 	if (refcount_dec_not_one(r))
 		return false;
@@ -154,11 +154,12 @@ bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 
 	return true;
 }
-EXPORT_SYMBOL(refcount_dec_and_lock);
+EXPORT_SYMBOL(raw_refcount_dec_and_lock);
 
 /**
- * refcount_dec_and_lock_irqsave - return holding spinlock with disabled
- *                                 interrupts if able to decrement refcount to 0
+ * raw_refcount_dec_and_lock_irqsave - return holding spinlock with disabled
+ *				       interrupts if able to decrement
+ *				       refcount to 0
  * @r: the refcount
  * @lock: the spinlock to be locked
  * @flags: saved IRQ-flags if the is acquired
@@ -169,8 +170,8 @@ EXPORT_SYMBOL(refcount_dec_and_lock);
  * Return: true and hold spinlock if able to decrement refcount to 0, false
  *         otherwise
  */
-bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
-				   unsigned long *flags)
+bool raw_refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
+				       unsigned long *flags)
 {
 	if (refcount_dec_not_one(r))
 		return false;
@@ -183,4 +184,4 @@ bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
 
 	return true;
 }
-EXPORT_SYMBOL(refcount_dec_and_lock_irqsave);
+EXPORT_SYMBOL(raw_refcount_dec_and_lock_irqsave);
-- 
2.31.1

