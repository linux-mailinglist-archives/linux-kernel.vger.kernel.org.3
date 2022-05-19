Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B084352DAD9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbiESRIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242359AbiESRH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:07:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174954AE03
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:07:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id en5so7804343edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OIxfpORtjfs4hiMHMwNdXpDrJbB8IlvaEvtbHzPyoqU=;
        b=LF0XsKUKLV3CxzPBZGc44cz+2Y4UjATPVwBaLtkmXQTxJmo2XdiSC0Yo6GHAqE7qZf
         aEkOg2EKK9G4i5sVW8UdKQTw9PDKjtt0fQLRrELM/elOU7a4YkbbjXF0/uz3kqQzPJl/
         1R5xUE8xPincCCVX+HsVwz/gAe4DyoyN/UgqVpWAueMokYZGFRPZUPbDJdW6alTC1YgO
         x9BgFfcISwyTgwJyapxopUdANLnba2UIqx0vS/GmRuSUNMCslvPtKWqW0AYgMHScJVrW
         5q/M/we0QHIskc349ZI5oiQW4wPfxGhWyetl8yXzjNWAx6/nHwVuQpfHRK1A9hJt2k2Y
         VUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OIxfpORtjfs4hiMHMwNdXpDrJbB8IlvaEvtbHzPyoqU=;
        b=Lb7PErq6xhbWF/nyvIy/L01DeSS/MF7jGhTMrAw8DJI0rbBGp3jmPinfV1JA2zoZrO
         Tc04aFijjYnd7Z0w1gp+EEL/+V7moS4b5zFR+xRLLjC/w0mSukITql4Xgb2TiqqIz+ux
         WHMCYYxXgc/J1O4i2MNFMsjhIRWEXCrt7HW5GvlCXXSz6vJIO0NHWlxE7Ce8qB3RWKWs
         CK7JZsVNgp9Q2ZnwpFVs1tKB+8wiSBlxwir1G2kgGtxaKPrXNrYbtEJ3ARU9p1lmTmOw
         stS9pvNBFEjptzS2hkyat9H+PFv4FozM9pI9NfT066WBqGMkEmdroJal0Apswl8OK4n2
         EfoQ==
X-Gm-Message-State: AOAM532LM6ReqeW3LoGcFvdNApHvifVc7581puuJhurnggrNZ6/6C7dz
        WpFahOStb6KiDH+wt1WJletJnWx8mUAXeA==
X-Google-Smtp-Source: ABdhPJwwrKFZbhtQECD+5GqQyPEVdMN9/wRvjx8Xt10nWD1B//yulalYWU9NPcYaHetSDqvSoI6wkg==
X-Received: by 2002:a05:6402:1941:b0:413:2822:9c8 with SMTP id f1-20020a056402194100b00413282209c8mr6601660edz.13.1652980075350;
        Thu, 19 May 2022 10:07:55 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id zd22-20020a17090698d600b006f3ef214e56sm2275003ejb.188.2022.05.19.10.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:07:54 -0700 (PDT)
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
Subject: [PATCH] sched/core: Use try_cmpxchg in set_nr_{and_not,if}_polling
Date:   Thu, 19 May 2022 19:07:47 +0200
Message-Id: <20220519170747.56094-1-ubizjak@gmail.com>
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

Also declare these two functions as inline. In the case of
set_nr_and_not_polling, the compiler (gcc) tries to outsmart itself
by constructing the boolean return value with logic operations on the
fetched value, and these extra operations enlarge the function over
the inlining threshold value.

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
 kernel/sched/core.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d58c0389eb23..5b160bc85cd6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -883,15 +883,11 @@ static inline void hrtick_rq_init(struct rq *rq)
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
@@ -900,7 +896,7 @@ static inline void hrtick_rq_init(struct rq *rq)
  * this avoids any races wrt polling state changes and thereby avoids
  * spurious IPIs.
  */
-static bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct task_struct *p)
 {
 	struct thread_info *ti = task_thread_info(p);
 	return !(fetch_or(&ti->flags, _TIF_NEED_RESCHED) & _TIF_POLLING_NRFLAG);
@@ -912,33 +908,31 @@ static bool set_nr_and_not_polling(struct task_struct *p)
  * If this returns true, then the idle task promises to call
  * sched_ttwu_pending() and reschedule soon.
  */
-static bool set_nr_if_polling(struct task_struct *p)
+static inline bool set_nr_if_polling(struct task_struct *p)
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

