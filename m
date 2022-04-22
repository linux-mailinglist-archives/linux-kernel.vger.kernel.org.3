Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384FA50BA30
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448713AbiDVOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448707AbiDVOhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:37:05 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60855B3DA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:34:11 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h83so8755266iof.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=oH3leSqKDga9NZO+bBSqAcrROxxIXZVikqhqPeAfS1Q=;
        b=K1gIMEIfLl85rfD2GqcuCIyX229fRksXEenYNCb3Xa50L1SN5M0fJEn5nyuVoZmaHm
         ahtOwuUI7bloePgpydDuYVQ3HWjwHiZqsUh61ZbccJP2fRPNL5hhhx9Du09Hs/DpDqqX
         UDrmSnwbOD3KZbIhnEju7pWhDNoXyywJ8om/9UHhceyAiaUBumNcBuOH2LCarTHo96wg
         54c7bzp0tAQTddtEQaJ2dccXOZTAuRQDZq2fJyX6l6VobYP2hKpOjhISgVaAwZcwv1e/
         o3AFCJ0J8ult4wQW5ZX+dAKo7Oicd3laeiGQyH5GFP3xa2RtQmBZqqXc2Q+Nfyg+jehO
         tqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=oH3leSqKDga9NZO+bBSqAcrROxxIXZVikqhqPeAfS1Q=;
        b=dg+npftN/y7l5frPx3tkgJ3XCPA8FqGPdcrwwxrJaAzVZjvy4JMvRUnjZxnU8tzQHH
         45oGCPREIceJfo/8LB5iUn03eSQhUsN8GpnaNzSj+PFLRQN18TCny81eFC1uNooQGNGm
         Ly0vJXGPWAk0a1WTjCkn2/ocAr3AiNmhG2ckxACu+1ohl5Sd/5/BhgXRkYILx0eb+VFm
         UozCMVo56QulJR9MiwAXo9ASCsG7Cdu2CczQp5AngpLR/i1CWE9MT1/IJ/OXMZXJIHEo
         Ts0n21VJxFmKGlNqiboz9lZP4aEfCJgdJyvw8VInyRShMHD8czpPngf8m/3NLfBuHEKr
         r2vQ==
X-Gm-Message-State: AOAM533KTHotcTEFGXuhWP64Ee6DBBfzY/7gH8roONYRy8WFud+ksF5v
        ypIPkfchTgcDYmHlxyrAMVzvqJPCxJSoDQ==
X-Google-Smtp-Source: ABdhPJxBi7W9wfBZ2S9+LH5Q+sn+Rxvz1vKqYD/sxXkVPy/hdOSts1/14BapXfh+RrpMxd0caZG8gw==
X-Received: by 2002:a02:7f4f:0:b0:326:760d:8ec0 with SMTP id r76-20020a027f4f000000b00326760d8ec0mr2287590jac.3.1650638050510;
        Fri, 22 Apr 2022 07:34:10 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i9-20020a056e02054900b002cc1959aa6fsm1408236ils.87.2022.04.22.07.34.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 07:34:09 -0700 (PDT)
Message-ID: <543452ca-f82e-4f00-cd51-88bb9723a975@kernel.dk>
Date:   Fri, 22 Apr 2022 08:34:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] task_work: allow TWA_SIGNAL without a rescheduling IPI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some use cases don't always need an IPI when sending a TWA_SIGNAL
notification. Add TWA_SIGNAL_NO_IPI, which is just like TWA_SIGNAL,
except it doesn't send an IPI to the target task. It merely sets
TIF_NOTIFY_SIGNAL and wakes up the task.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

This is a prep patch for an io_uring change where we don't need the IPI,
and skipping it can reduce rescheduling/IPI rate by tens to hundreds of
thousands per second.

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
index c59e1a49bc40..fa8fdd04aa17 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -13,11 +13,13 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
  *
  * Queue @work for task_work_run() below and notify the @task if @notify
  * is @TWA_RESUME or @TWA_SIGNAL. @TWA_SIGNAL works like signals, in that the
- * it will interrupt the targeted task and run the task_work. @TWA_RESUME
- * work is run only when the task exits the kernel and returns to user mode,
- * or before entering guest mode. Fails if the @task is exiting/exited and thus
- * it can't process this @work. Otherwise @work->func() will be called when the
- * @task goes through one of the aforementioned transitions, or exits.
+ * it will interrupt the targeted task and run the task_work. @TWA_SIGNAL_NO_IPI
+ * works like @TWA_SIGNAL, except it doesn't send a reschedule IPI to force the
+ * targeted task to reschedule and run task_work. @TWA_RESUME work is run only
+ * when the task exits the kernel and returns to user mode, or before entering
+ * guest mode. Fails if the @task is exiting/exited and thus it can't process
+ * this @work. Otherwise @work->func() will be called when the @task goes
+ * through one of the aforementioned transitions, or exits.
  *
  * If the targeted task is exiting, then an error is returned and the work item
  * is not queued. It's up to the caller to arrange for an alternative mechanism
@@ -53,6 +55,9 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
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
Jens Axboe

