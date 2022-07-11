Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59393570B43
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiGKUV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGKUV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:21:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893C3275EF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CFA5B81201
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DACC34115;
        Mon, 11 Jul 2022 20:21:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DjK+e1I6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657570913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eKHUD1ieT6ajZMW5LLFKvB//s7HOkz5t9N4D+wHx0eI=;
        b=DjK+e1I6klbjFQTA2QYxJDD2ojxIntEnhVARJ21ZvM4SAX4bKVHpL10lCO5FnDDZTHwmw8
        pX8fMCZ0810DyI5NJSj4qBq2oXBZCBMGufQjKfqP0z4GwwusX7jKrv95k1wkmIzPTBm4yM
        crCxIN4Xsoe265wOpoM2uyZaL0DfIms=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 539d9e25 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 11 Jul 2022 20:21:49 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, ebiederm@xmission.com
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v4] signal: break out of wait loops on kthread_stop()
Date:   Mon, 11 Jul 2022 22:21:36 +0200
Message-Id: <20220711202136.64458-1-Jason@zx2c4.com>
In-Reply-To: <YsyFhfAunVfVQKci@zx2c4.com>
References: <YsyFhfAunVfVQKci@zx2c4.com>
MIME-Version: 1.0
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

The same also probably applies to the similar kthread_park()
functionality, but that can be addressed later, as its semantics are
slightly different.

Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v3->v4:
- Don't address park() for now.
- Don't bother clearing the flag, since the task is about to be freed
  anyway.

 kernel/kthread.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3c677918d8f2..8888987f2b25 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -704,6 +704,7 @@ int kthread_stop(struct task_struct *k)
 	kthread = to_kthread(k);
 	set_bit(KTHREAD_SHOULD_STOP, &kthread->flags);
 	kthread_unpark(k);
+	test_and_set_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
 	wake_up_process(k);
 	wait_for_completion(&kthread->exited);
 	ret = kthread->result;
-- 
2.35.1

