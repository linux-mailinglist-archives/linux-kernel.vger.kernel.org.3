Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CB54AE44E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387192AbiBHW1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386199AbiBHTnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:43:43 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1487C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:43:42 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id c8-20020a17090a674800b001b91184b732so477022pjm.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IzYAh6mtxyAZ2drjtva0WxDIoe1TxiIdW6u31Cu1VZ0=;
        b=Z59AvqUCCa7UbRG2nJztf5OxSI9qQovj8CB7b/+6lPnCSxvE10jTasby5VST/dsbG1
         OVAlzmtRVmJN3/xEluUeFGgv1tku1k8Nky1bf3K3UyyMEpAv+4GM/d3AktiTvQIyazqO
         5j10K6DkStDMQzABmX4PqlAbgIRA6ciTLM7NS6tIMDt/dmzNEbNc3VkwyT9Qn+EJxZ85
         ktaf1EYyxRpltgGfKwJJdoDhXWsasI/9JyvWq2tCFdcmgLPYumpRIDSQiOnjS8z/KHie
         7ZKsxkOiOyeOUpXGax2FJI5NkjnTyMtx31xhASonu1EuJA+sL7BBAK3xT03dxNzO4c6a
         8g8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IzYAh6mtxyAZ2drjtva0WxDIoe1TxiIdW6u31Cu1VZ0=;
        b=798saKTHREHNW+qICWqHQ8FXa3iqOvuVjDPa3yU2ABYor4A+nVFeKlTtrK4GXGfeqB
         L9xpoNvvU7qoCVOQk+WlW5BjjXQy0MXKjhL4D6z/GIgAJkFeFcLjJN2uuLkSON83SHLS
         K4ir4Ug0ytSqxjtRwMhvsnDtGBlHCGUZKWBUh33YC3/AV1BLov/Y5pNhTPgJ4Tntvpim
         5H7xjvjsYGMfw66pnjp2H9MmGI1eyEZDAae07+l9rpjVb6O37vtujO/5ZH00FLiV3tBA
         AplvbzclveJzWXBAuPiRmYU5luvITDTVD8badcV6IexTlwM8/ynm9/34YydhDxkNKgX7
         1dnA==
X-Gm-Message-State: AOAM53172iod4rzI5P7vFZiJ9hSOFhpShT+MTHNhCGnQnyXfgkNyZzH+
        0PTRY9C98fzsESp4N3rPm+8=
X-Google-Smtp-Source: ABdhPJxHfW73Un1j2m77knqGc5baEAyVhu9540XuJH25WpcdoAtQ7dfy05NOE3I/jDz5uR2KU/cH5w==
X-Received: by 2002:a17:903:248:: with SMTP id j8mr3728183plh.123.1644349422264;
        Tue, 08 Feb 2022 11:43:42 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id w11sm16876839pfu.50.2022.02.08.11.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:43:41 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>
Subject: [PATCH 03/12] timer: Protect lockdep functions with #ifdef
Date:   Tue,  8 Feb 2022 11:43:15 -0800
Message-Id: <20220208194324.85333-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208194324.85333-1-namhyung@kernel.org>
References: <20220208194324.85333-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With upcoming lock tracepoints config, it'd define some of lockdep
functions without enabling CONFIG_LOCKDEP actually.  The existing code
assumes those functions will be removed by the preprocessor but it's
not the case anymore.  Let's protect the code with #ifdef's explicitly.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/time/timer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 85f1021ad459..4af95dbf6435 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -794,7 +794,10 @@ static void do_init_timer(struct timer_list *timer,
 	if (WARN_ON_ONCE(flags & ~TIMER_INIT_FLAGS))
 		flags &= TIMER_INIT_FLAGS;
 	timer->flags = flags | raw_smp_processor_id();
+
+#ifdef CONFIG_LOCKDEP
 	lockdep_init_map(&timer->lockdep_map, name, key, 0);
+#endif
 }
 
 /**
@@ -1409,19 +1412,22 @@ static void call_timer_fn(struct timer_list *timer,
 	struct lockdep_map lockdep_map;
 
 	lockdep_copy_map(&lockdep_map, &timer->lockdep_map);
-#endif
+
 	/*
 	 * Couple the lock chain with the lock chain at
 	 * del_timer_sync() by acquiring the lock_map around the fn()
 	 * call here and in del_timer_sync().
 	 */
 	lock_map_acquire(&lockdep_map);
+#endif
 
 	trace_timer_expire_entry(timer, baseclk);
 	fn(timer);
 	trace_timer_expire_exit(timer);
 
+#ifdef CONFIG_LOCKDEP
 	lock_map_release(&lockdep_map);
+#endif
 
 	if (count != preempt_count()) {
 		WARN_ONCE(1, "timer: %pS preempt leak: %08x -> %08x\n",
-- 
2.35.0.263.gb82422642f-goog

