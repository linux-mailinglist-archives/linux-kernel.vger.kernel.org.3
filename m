Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CCF5686C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiGFLhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGFLhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:37:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B2A237E8;
        Wed,  6 Jul 2022 04:37:14 -0700 (PDT)
Date:   Wed, 06 Jul 2022 11:37:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657107432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bL/YIYy7J9s+zOR/CI+diiMMcmSKmXQ5zmPghbjrAs=;
        b=kuD1MjxcGnW9ZS/3a5zb3GzXyZ4KmvpUMfY5I0JvhQWhgdN8SXe5c9pkNZL7HxBAzHZJJA
        NRsAm5ZmadVWMuGxYBXMuP4UT6GqhSgDyO+Ce9h/ZS6EXxxV6s/UnPGIunO2mYLqaGYAED
        6K/EsL5H3Bc8WQYn72EH50/yeDHnMEcWOcQJ+TuoIptyRVI0x80D110qNr6SdSWTwbNQ+3
        ZeO4+Uef/RWiN5IQXBFesfd6JNtINuIOY/o5rIWGjfTbREKEbMMqaXpcjQWqEcOQMtMjvK
        HIPI6Syhgb4vZg65yMTg9pmyNl859O1udCnv+HON2cLVMPEZe5MHNe0H6rrQmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657107432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bL/YIYy7J9s+zOR/CI+diiMMcmSKmXQ5zmPghbjrAs=;
        b=KO5u+oyzEylWJApDtdUOt9eABO0gCAYM93irLyFsEC3OW3OLsMwib5r9uvof3wvdGkOq6i
        WiDWvMQOHBEu4fBw==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Use try_cmpxchg in set_nr_{and_not,if}_polling
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220629151552.6015-1-ubizjak@gmail.com>
References: <20220629151552.6015-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <165710743153.15455.1044580694574122081.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c02d5546ea34d589c83eda5055dbd727a396642b
Gitweb:        https://git.kernel.org/tip/c02d5546ea34d589c83eda5055dbd727a396642b
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 29 Jun 2022 17:15:52 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 04 Jul 2022 09:23:08 +02:00

sched/core: Use try_cmpxchg in set_nr_{and_not,if}_polling

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) != old in
set_nr_{and_not,if}_polling. x86 cmpxchg returns success in ZF flag,
so this change saves a compare after cmpxchg.

The definition of cmpxchg based fetch_or was changed in the
same way as atomic_fetch_##op definitions were changed
in e6790e4b5d5e97dc287f3496dd2cf2dbabdfdb35.

Also declare these two functions as inline to ensure inlining. In the
case of set_nr_and_not_polling, the compiler (gcc) tries to outsmart
itself by constructing the boolean return value with logic operations
on the fetched value, and these extra operations enlarge the function
over the inlining threshold value.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220629151552.6015-1-ubizjak@gmail.com
---
 kernel/sched/core.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dd69e85..c703d17 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -873,15 +873,11 @@ static inline void hrtick_rq_init(struct rq *rq)
 	({								\
 		typeof(ptr) _ptr = (ptr);				\
 		typeof(mask) _mask = (mask);				\
-		typeof(*_ptr) _old, _val = *_ptr;			\
+		typeof(*_ptr) _val = *_ptr;				\
 									\
-		for (;;) {						\
-			_old = cmpxchg(_ptr, _val, _val | _mask);	\
-			if (_old == _val)				\
-				break;					\
-			_val = _old;					\
-		}							\
-	_old;								\
+		do {							\
+		} while (!try_cmpxchg(_ptr, &_val, _val | _mask));	\
+	_val;								\
 })
 
 #if defined(CONFIG_SMP) && defined(TIF_POLLING_NRFLAG)
@@ -890,7 +886,7 @@ static inline void hrtick_rq_init(struct rq *rq)
  * this avoids any races wrt polling state changes and thereby avoids
  * spurious IPIs.
  */
-static bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct task_struct *p)
 {
 	struct thread_info *ti = task_thread_info(p);
 	return !(fetch_or(&ti->flags, _TIF_NEED_RESCHED) & _TIF_POLLING_NRFLAG);
@@ -905,30 +901,28 @@ static bool set_nr_and_not_polling(struct task_struct *p)
 static bool set_nr_if_polling(struct task_struct *p)
 {
 	struct thread_info *ti = task_thread_info(p);
-	typeof(ti->flags) old, val = READ_ONCE(ti->flags);
+	typeof(ti->flags) val = READ_ONCE(ti->flags);
 
 	for (;;) {
 		if (!(val & _TIF_POLLING_NRFLAG))
 			return false;
 		if (val & _TIF_NEED_RESCHED)
 			return true;
-		old = cmpxchg(&ti->flags, val, val | _TIF_NEED_RESCHED);
-		if (old == val)
+		if (try_cmpxchg(&ti->flags, &val, val | _TIF_NEED_RESCHED))
 			break;
-		val = old;
 	}
 	return true;
 }
 
 #else
-static bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct task_struct *p)
 {
 	set_tsk_need_resched(p);
 	return true;
 }
 
 #ifdef CONFIG_SMP
-static bool set_nr_if_polling(struct task_struct *p)
+static inline bool set_nr_if_polling(struct task_struct *p)
 {
 	return false;
 }
