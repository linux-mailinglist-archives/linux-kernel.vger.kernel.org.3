Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E11F50A8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391746AbiDUTIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391738AbiDUTIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4093457A0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650567952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AmYL0y+hCk1491gF9Io/zt26uV8J/a8ENaiSiyYWeXE=;
        b=US67dKAykGHeilAvg4PrEzZLpli1baWt6J9IhFG/NLMvpGpLk/zqrzmKWdTabrvyn4AS3d
        JpjqA5deyv8M/WOFps2cA/ksFsH/N9+g4VSGMMW2BV+36E7b4EQivN1d1Lii1RudXXFNN9
        TsSk3XMnVtbm32x8C+4Yipevl9yYHqw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-NMYJwTonP3e0DVRyVtnEXg-1; Thu, 21 Apr 2022 15:05:49 -0400
X-MC-Unique: NMYJwTonP3e0DVRyVtnEXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E83BA85A5BC;
        Thu, 21 Apr 2022 19:05:48 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.16.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E8CAC2812A;
        Thu, 21 Apr 2022 19:05:48 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Ulrich Drepper <drepper@redhat.com>
Subject: [RFC 2/3] futex: exit: Print a warning when futex_cleanup fails
Date:   Thu, 21 Apr 2022 15:05:32 -0400
Message-Id: <20220421190533.1601879-3-npache@redhat.com>
In-Reply-To: <20220421190533.1601879-1-npache@redhat.com>
References: <20220421190533.1601879-1-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The futex_cleanup routines currently fails silently.

Allow the futex_cleanup routines to fail more verbosely so we can
leave a message behind for easier debugging/error detecting.

Fixes: 0771dfefc9e5 ("[PATCH] lightweight robust futexes: core")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "André Almeida" <andrealmeid@collabora.com>
Cc: Arjan van de Ven <arjan@infradead.org>
Cc: Ulrich Drepper <drepper@redhat.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 kernel/futex/core.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index b22ef1efe751..8a62eb1b5d77 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -760,9 +760,9 @@ static inline int fetch_robust_entry(struct robust_list __user **entry,
  * Walk curr->robust_list (very carefully, it's a userspace list!)
  * and mark any locks found there dead, and notify any waiters.
  *
- * We silently return on any sign of list-walking problem.
+ * We return false on any sign of list-walking problem.
  */
-static void exit_robust_list(struct task_struct *curr)
+static bool exit_robust_list(struct task_struct *curr)
 {
 	struct robust_list_head __user *head = curr->robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
@@ -771,23 +771,25 @@ static void exit_robust_list(struct task_struct *curr)
 	unsigned long futex_offset;
 	int rc;
 
+	if (!futex_cmpxchg_enabled)
+		return false;
 	/*
 	 * Fetch the list head (which was registered earlier, via
 	 * sys_set_robust_list()):
 	 */
 	if (fetch_robust_entry(&entry, &head->list.next, &pi))
-		return;
+		return false;
 	/*
 	 * Fetch the relative futex offset:
 	 */
 	if (get_user(futex_offset, &head->futex_offset))
-		return;
+		return false;
 	/*
 	 * Fetch any possibly pending lock-add first, and handle it
 	 * if it exists:
 	 */
 	if (fetch_robust_entry(&pending, &head->list_op_pending, &pip))
-		return;
+		return false;
 
 	next_entry = NULL;	/* avoid warning with gcc */
 	while (entry != &head->list) {
@@ -803,10 +805,10 @@ static void exit_robust_list(struct task_struct *curr)
 		if (entry != pending) {
 			if (handle_futex_death((void __user *)entry + futex_offset,
 						curr, pi, HANDLE_DEATH_LIST))
-				return;
+				return false;
 		}
 		if (rc)
-			return;
+			return false;
 		entry = next_entry;
 		pi = next_pi;
 		/*
@@ -819,9 +821,10 @@ static void exit_robust_list(struct task_struct *curr)
 	}
 
 	if (pending) {
-		handle_futex_death((void __user *)pending + futex_offset,
+		return handle_futex_death((void __user *)pending + futex_offset,
 				   curr, pip, HANDLE_DEATH_PENDING);
 	}
+	return true;
 }
 
 #ifdef CONFIG_COMPAT
@@ -854,9 +857,9 @@ compat_fetch_robust_entry(compat_uptr_t *uentry, struct robust_list __user **ent
  * Walk curr->robust_list (very carefully, it's a userspace list!)
  * and mark any locks found there dead, and notify any waiters.
  *
- * We silently return on any sign of list-walking problem.
+ * We return false on any sign of list-walking problem.
  */
-static void compat_exit_robust_list(struct task_struct *curr)
+static bool compat_exit_robust_list(struct task_struct *curr)
 {
 	struct compat_robust_list_head __user *head = curr->compat_robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
@@ -866,24 +869,26 @@ static void compat_exit_robust_list(struct task_struct *curr)
 	compat_long_t futex_offset;
 	int rc;
 
+	if (!futex_cmpxchg_enabled)
+		return false;
 	/*
 	 * Fetch the list head (which was registered earlier, via
 	 * sys_set_robust_list()):
 	 */
 	if (compat_fetch_robust_entry(&uentry, &entry, &head->list.next, &pi))
-		return;
+		return false;
 	/*
 	 * Fetch the relative futex offset:
 	 */
 	if (get_user(futex_offset, &head->futex_offset))
-		return;
+		return false;
 	/*
 	 * Fetch any possibly pending lock-add first, and handle it
 	 * if it exists:
 	 */
 	if (compat_fetch_robust_entry(&upending, &pending,
 			       &head->list_op_pending, &pip))
-		return;
+		return false;
 
 	next_entry = NULL;	/* avoid warning with gcc */
 	while (entry != (struct robust_list __user *) &head->list) {
@@ -902,10 +907,10 @@ static void compat_exit_robust_list(struct task_struct *curr)
 
 			if (handle_futex_death(uaddr, curr, pi,
 					       HANDLE_DEATH_LIST))
-				return;
+				return false;
 		}
 		if (rc)
-			return;
+			return false;
 		uentry = next_uentry;
 		entry = next_entry;
 		pi = next_pi;
@@ -920,8 +925,9 @@ static void compat_exit_robust_list(struct task_struct *curr)
 	if (pending) {
 		void __user *uaddr = futex_uaddr(pending, futex_offset);
 
-		handle_futex_death(uaddr, curr, pip, HANDLE_DEATH_PENDING);
+		return handle_futex_death(uaddr, curr, pip, HANDLE_DEATH_PENDING);
 	}
+	return true;
 }
 #endif
 
@@ -1007,13 +1013,15 @@ static inline void exit_pi_state_list(struct task_struct *curr) { }
 static void futex_cleanup(struct task_struct *tsk)
 {
 	if (unlikely(tsk->robust_list)) {
-		exit_robust_list(tsk);
+		if (!exit_robust_list(tsk))
+			pr_info("futex: exit_robust_list failed");
 		tsk->robust_list = NULL;
 	}
 
 #ifdef CONFIG_COMPAT
 	if (unlikely(tsk->compat_robust_list)) {
-		compat_exit_robust_list(tsk);
+		if (!compat_exit_robust_list(tsk))
+			pr_info("futex: compat_exit_robust_list failed");
 		tsk->compat_robust_list = NULL;
 	}
 #endif
-- 
2.35.1

