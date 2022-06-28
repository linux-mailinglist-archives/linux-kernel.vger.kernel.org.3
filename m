Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F48155E904
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiF1QXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiF1QXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:23:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8CD9FCE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84720617BC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1968C3411D;
        Tue, 28 Jun 2022 16:14:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O3iwaGMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656432889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXmnNH3o8efGVBV7aZl5KFeyRPzqM794vtugZOZRSX8=;
        b=O3iwaGMoTsnIr4Ad8K06gJ++QwVe5KSheFUCgR4e77HGY2TgmkhrmCRTeydJORa/R6wRU8
        dPAMlyNsE/sFD9S/I0NxSIyNtwHjOfZ+9Iml4oXUXqRcGGrHJhk3kp4jqyT6xXYk38iETV
        s2UaTcw1MQ0f9PheZzhJjiSqlj6Ef70=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 976fed0a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 28 Jun 2022 16:14:48 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3] signal: break out of wait loops on kthread_stop()
Date:   Tue, 28 Jun 2022 18:14:41 +0200
Message-Id: <20220628161441.892925-1-Jason@zx2c4.com>
In-Reply-To: <YrslT9h0whngMIhw@zx2c4.com>
References: <YrslT9h0whngMIhw@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was recently surprised to learn that msleep_interruptible(),
wait_for_completion_interruptible_timeout(), and related functions
simply hung when I called kthread_stop() on kthreads using them. The
solution to fixing the case with msleep_interruptible() was more simply
to move to schedule_timeout_interruptible(). Why?

The reason is that msleep_interruptible(), and many functions just like
it, has a loop like this:

        while (timeout && !signal_pending(current))
                timeout = schedule_timeout_interruptible(timeout);

The call to kthread_stop() woke up the thread, so schedule_timeout_
interruptible() returned early, but because signal_pending() returned
true, it went back into another timeout, which was never woken up.

This wait loop pattern is common to various pieces of code, and I
suspect that the subtle misuse in a kthread that caused a deadlock in
the code I looked at last week is also found elsewhere.

So this commit causes signal_pending() to return true when
kthread_stop() is called, by setting TIF_NOTIFY_SIGNAL.

The same also applies to the similar kthread_park() functionality.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 kernel/kthread.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3c677918d8f2..63d5a1f4cb93 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -661,12 +661,14 @@ int kthread_park(struct task_struct *k)
 
 	set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	if (k != current) {
+		test_and_set_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
 		wake_up_process(k);
 		/*
 		 * Wait for __kthread_parkme() to complete(), this means we
 		 * _will_ have TASK_PARKED and are about to call schedule().
 		 */
 		wait_for_completion(&kthread->parked);
+		clear_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
 		/*
 		 * Now wait for that schedule() to complete and the task to
 		 * get scheduled out.
@@ -704,8 +706,10 @@ int kthread_stop(struct task_struct *k)
 	kthread = to_kthread(k);
 	set_bit(KTHREAD_SHOULD_STOP, &kthread->flags);
 	kthread_unpark(k);
+	test_and_set_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
 	wake_up_process(k);
 	wait_for_completion(&kthread->exited);
+	clear_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
 	ret = kthread->result;
 	put_task_struct(k);
 
-- 
2.35.1

