Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BA4513F07
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 01:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353263AbiD1X2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiD1X2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:28:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063CE694B8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:25:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so7080333pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=3i63Gua/vuLdMfOkLrBhash2jdLg2GEMUWtLvv/TlUI=;
        b=VD5O8MB7E9MVrRah4Ce/+b8ng2HQ1VbzRaKRHy2ZI9pRNMR71WRfC3aICC5NRmvAme
         87pSBi08ICiaScgjMUeh8AjYv940jyO/j5JuyBa9tLzcIYnm8GoVk26yYQVWjXHs48YA
         9QJ/OM5szo+3Hv3LwD+b50DCXhqO5T0q6F7FvO8uyVcFWqZE9OV0VyrIpWSNC+TuaIAu
         TjtXY+Cxgjy7CNmGZgo5whWf1eers1cmzeOMMuuq6Mw/A372CjoahrSBnJICmpT7ShLa
         5F1bjP9iw6qmD5tPnMojBILpgVQfKwzqF/1SNFtkS8B5n/Et5hTgNB2nGixJ0j+6Hp4c
         igCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=3i63Gua/vuLdMfOkLrBhash2jdLg2GEMUWtLvv/TlUI=;
        b=Y33SGP95sl1D1kMgf1+PERdVKye+5l2nyrkWgtzdBymJSpZ2hqXkO+4FDbocGkNtn+
         rZwQ8jZsBTXnt+3R5rB61eTOBsVpNJ2UxQfIbyD+dwml5SzJ0ud+MhQRD8lRLyfGx5cd
         SjMozpoK+ZpZosLdSOABtm2yWBR5a23tRhgRnz8YKESN7unzHsGLWeelQqegy5U0bvTU
         X99SZ4ZsKODffjxKelRXZJc4oRBNn3xJTEm3CwRFPQbnI5NBdirtHYv4EM3TqvqYaoYP
         K2ACbDdVMFe2s0rGbTET6GN4osQn+seEMUWEkdCtWq2aNtPR5XkFx3K44B69sLJX8TUF
         fapg==
X-Gm-Message-State: AOAM533fx+toYgVgikEVNzbTLHEZXA0LRfVE3QvptSu0MnRPB5X4etSy
        DjrpQnld4c4wambasCltnxnL48fk1z5++N30
X-Google-Smtp-Source: ABdhPJwAlbqByfjUxd6nYad+wT7XJDqwmTtqImQIXFkPE1XAW1diD5P7Pxsyq8/I54lmvajV7lkDow==
X-Received: by 2002:a17:90b:3e82:b0:1d9:3195:f259 with SMTP id rj2-20020a17090b3e8200b001d93195f259mr741360pjb.150.1651188318065;
        Thu, 28 Apr 2022 16:25:18 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 1-20020a631541000000b003c14af50646sm3909894pgv.94.2022.04.28.16.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 16:25:17 -0700 (PDT)
Message-ID: <821f42b6-7d91-8074-8212-d34998097de4@kernel.dk>
Date:   Thu, 28 Apr 2022 17:25:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] task_work: allow TWA_SIGNAL without a rescheduling IPI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some use cases don't always need an IPI when sending a TWA_SIGNAL
notification. Add TWA_SIGNAL_NO_IPI, which is just like TWA_SIGNAL, except
it doesn't send an IPI to the target task. It merely sets
TIF_NOTIFY_SIGNAL and wakes up the task.

This can be useful in avoiding a forceful transition to the kernel if the
task is running in userspace. Depending on the task_work in question, it
may be quite fine waiting for the next reschedule or kernel enter anyway,
or the use case may even have other mechanisms for hinting to the task
that a transition may be useful. This can drive more cooperative
scheduling of task_work.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---

v2: - improve code comments and split it up a bit rather than have it be
      one giant blob.
    - improve commit message.

 include/linux/sched/signal.h | 13 +++++++++++--
 include/linux/task_work.h    |  1 +
 kernel/task_work.c           | 25 +++++++++++++++++++------
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3c8b34876744..66b689f6cfcb 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -355,14 +355,23 @@ static inline void clear_notify_signal(void)
 	smp_mb__after_atomic();
 }
 
+/*
+ * Returns 'true' if kick_process() is needed to force a transition from
+ * user -> kernel to guarantee expedient run of TWA_SIGNAL based task_work.
+ */
+static inline bool __set_notify_signal(struct task_struct *task)
+{
+	return !test_and_set_tsk_thread_flag(task, TIF_NOTIFY_SIGNAL) &&
+	       !wake_up_state(task, TASK_INTERRUPTIBLE);
+}
+
 /*
  * Called to break out of interruptible wait loops, and enter the
  * exit_to_user_mode_loop().
  */
 static inline void set_notify_signal(struct task_struct *task)
 {
-	if (!test_and_set_tsk_thread_flag(task, TIF_NOTIFY_SIGNAL) &&
-	    !wake_up_state(task, TASK_INTERRUPTIBLE))
+	if (__set_notify_signal(task))
 		kick_process(task);
 }
 
diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 897494b597ba..795ef5a68429 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -17,6 +17,7 @@ enum task_work_notify_mode {
 	TWA_NONE,
 	TWA_RESUME,
 	TWA_SIGNAL,
+	TWA_SIGNAL_NO_IPI,
 };
 
 static inline bool task_work_pending(struct task_struct *task)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index c59e1a49bc40..2f21a1e64ad4 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -12,12 +12,22 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
  * @notify: how to notify the targeted task
  *
  * Queue @work for task_work_run() below and notify the @task if @notify
- * is @TWA_RESUME or @TWA_SIGNAL. @TWA_SIGNAL works like signals, in that the
- * it will interrupt the targeted task and run the task_work. @TWA_RESUME
- * work is run only when the task exits the kernel and returns to user mode,
- * or before entering guest mode. Fails if the @task is exiting/exited and thus
- * it can't process this @work. Otherwise @work->func() will be called when the
- * @task goes through one of the aforementioned transitions, or exits.
+ * is @TWA_RESUME, @TWA_SIGNAL, or @TWA_SIGNAL_NO_IPI.
+ * 
+ * @TWA_SIGNAL works like signals, in that the it will interrupt the targeted
+ * task and run the task_work, regardless of whether the task is currently
+ * running in the kernel or userspace.
+ * @TWA_SIGNAL_NO_IPI works like @TWA_SIGNAL, except it doesn't send a
+ * reschedule IPI to force the targeted task to reschedule and run task_work.
+ * This can be advantageous if there's no strict requirement that the
+ * task_work be run as soon as possible, just whenever the task enters the
+ * kernel anyway.
+ * @TWA_RESUME work is run only when the task exits the kernel and returns to
+ * user mode, or before entering guest mode.
+ * 
+ * Fails if the @task is exiting/exited and thus it can't process this @work.
+ * Otherwise @work->func() will be called when the @task goes through one of
+ * the aforementioned transitions, or exits.
  *
  * If the targeted task is exiting, then an error is returned and the work item
  * is not queued. It's up to the caller to arrange for an alternative mechanism
@@ -53,6 +63,9 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 	case TWA_SIGNAL:
 		set_notify_signal(task);
 		break;
+	case TWA_SIGNAL_NO_IPI:
+		__set_notify_signal(task);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
-- 
2.35.1

-- 
Jens Axboe

