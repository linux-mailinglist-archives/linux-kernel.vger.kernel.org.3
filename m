Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB9C4B2433
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbiBKLXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:23:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiBKLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:23:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06950E76
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:23:39 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644578617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJouc3QVVJgp9Loq33XddcMozbLzg+YfW/kufsdqZI0=;
        b=mytSf6U43JAcwtPAgFiKRtJnZWHudGff1Aew3V7cNfL4s41Y83whscxKdQD52MhQrfA9BK
        LSvzUxjAKVVLTAEZu6GwjDqbvWxCDFDrpBYqJrsTW3YgKgyYyRoD9gxzcOieCnVl9Lv4Dh
        E3ZnRyOZDKrcY9yo/IeusvP880JQw6X8NYoDo1XZgi85e+7SZRQgp/UlIRkEzPOtItnGHQ
        CpGbDsy7N6ojhVL8BOGwbLkf2aq30GV72TwKyMdoQGdqMIfqbdv61kKvzGs0lexcxJRRQZ
        k/md7dqufPmn56s334JrJQ/Yzz4Eh7JpGw/DI/eS2lIV6GtAyU+BB1UwseBThw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644578617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJouc3QVVJgp9Loq33XddcMozbLzg+YfW/kufsdqZI0=;
        b=s0dfgbJw22swlYUJdQo//bR6+cWJhp5EifVkE4igyRY/69hJx7ZKF0t0IUCmkASf9T7ve5
        kV/3tnLpgZy/c3DA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3] printk: use atomic updates for klogd work
In-Reply-To: <87leyhd4wc.fsf@jogness.linutronix.de>
References: <20220203112915.1350753-1-john.ogness@linutronix.de>
 <YfzP50vDiJiaRVCr@google.com> <87bkzj3t77.fsf@jogness.linutronix.de>
 <YgUzm5POctivsjUg@alley> <87leyhd4wc.fsf@jogness.linutronix.de>
Date:   Fri, 11 Feb 2022 12:29:37 +0106
Message-ID: <87iltld4ue.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per-cpu @printk_pending variable can be updated from
sleepable contexts, such as:

  get_random_bytes()
    warn_unseeded_randomness()
      printk_deferred()
        defer_console_output()

and can be updated from interrupt contexts, such as:

  handle_irq_event_percpu()
    __irq_wake_thread()
      wake_up_process()
        try_to_wake_up()
          select_task_rq()
            select_fallback_rq()
              printk_deferred()
                defer_console_output()

and can be updated from NMI contexts, such as:

  vprintk()
    if (in_nmi()) defer_console_output()

Therefore the atomic variant of the updating functions must be used.

Replace __this_cpu_xchg() with this_cpu_xchg().
Replace __this_cpu_or() with this_cpu_or().

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 Changes:

 v3: also fix __this_cpu_xchg() usage

 v2: fix commit message

 kernel/printk/printk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82abfaf3c2aa..c7280b40de6c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3228,7 +3228,7 @@ static DEFINE_PER_CPU(int, printk_pending);
 
 static void wake_up_klogd_work_func(struct irq_work *irq_work)
 {
-	int pending = __this_cpu_xchg(printk_pending, 0);
+	int pending = this_cpu_xchg(printk_pending, 0);
 
 	if (pending & PRINTK_PENDING_OUTPUT) {
 		/* If trylock fails, someone else is doing the printing */
@@ -3262,7 +3262,7 @@ void defer_console_output(void)
 		return;
 
 	preempt_disable();
-	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
+	this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
 	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	preempt_enable();
 }
-- 
2.30.2
