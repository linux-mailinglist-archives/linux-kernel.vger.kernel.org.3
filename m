Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31562560449
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiF2PQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiF2PQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:16:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381D39B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:16:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e2so22697896edv.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xo5XDdU3k73O+LPIQC9ckNh2PFM7T8Z4eFoOV/cfbtQ=;
        b=PHQ5d4HRiScaOUuh8kYH34chDVQ8ZRopjPUcb9Xvk2fDJT2OayKkn2q8l4r/bujBVt
         qF2GjrfaCddQSdpdMmG8EH/+Vg08vvh19Sm5d9kY4FTxeu2hd8PBGDsWvf3EzJQBGKyn
         UoqeS/W1UiRz729ewHcKR/ndFPffWOYzB6rZ71ooUdoWpX+RZeo+VGyxT3Q/i09ab1Mx
         s6+BD05p8gdSM7TX5aHO1ZOjUZF5X4QYp7Q2V6YNuLgXy4qT4gQOZR9F3qswb1Wg+i+u
         iDiOuII5Uts0SY5kFdWjM26OEVVkl4nsP/jI3BVdvIlVhEbmkYSVh+ETnvTzXVyZ+76+
         H21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xo5XDdU3k73O+LPIQC9ckNh2PFM7T8Z4eFoOV/cfbtQ=;
        b=tMKnxd0Erk7S3HR/2e/BVNXD3ehVqGj1o7KHxdt4uLGYPis07R/MjW4u6tZoFa4Gym
         J5iXIbVk1S/TGsBmdVmHfxJ+kaVMv20BpmIMaPF/xBsrb0WW89EIGDM4EPWy7SgHypfV
         brnEaoOdyeJj5kshzsMGTywk8L5kRcHNExmsCPc67PBb4xxMgxFB/nK6Vi20uxZ2oLzc
         mRyx5qod2Bp//WTo7Oa/v0O231UNG3F1BZLZDxdJnbJiYUbrzyqv2G7AhNNx76ttcy43
         Q5gKaTUIA4HTD2WkWldCMA+qB30trq8XhSiopYlZHcEB79Kpw2t41QDqu4efkwk+XeOb
         p9IQ==
X-Gm-Message-State: AJIora+JDpTT+0bvo2FGMT/WWGBVcozGsOavdSKRLvU9DA7lJwyEmxq2
        ZFBXCGH3nx44rWyjMJVjGC9rtD8HjR+yWw==
X-Google-Smtp-Source: AGRyM1tsMl7DvaJ2GyOerd69RISp1DRmyUz9YfcAf0174+qKxCGUTI8Ecxd7fMs2yhGTxNHx8rbNkA==
X-Received: by 2002:a05:6402:1249:b0:435:5e0c:20ac with SMTP id l9-20020a056402124900b004355e0c20acmr4966825edw.100.1656515764535;
        Wed, 29 Jun 2022 08:16:04 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906545000b006feb20b5235sm7901424ejp.84.2022.06.29.08.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:16:04 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH RESEND] sched/core: Use try_cmpxchg in set_nr_{and_not,if}_polling
Date:   Wed, 29 Jun 2022 17:15:52 +0200
Message-Id: <20220629151552.6015-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
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
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
---
 kernel/sched/core.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecd..88806e9110b7 100644
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
-- 
2.35.3

