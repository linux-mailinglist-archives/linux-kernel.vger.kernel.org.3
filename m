Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477F94AB838
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbiBGJte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245201AbiBGJqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:46:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A7DC043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 01:46:23 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644227180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0RBBdWwxOY62NA2K6sRnag/9lJllybBsMojcDW+50rk=;
        b=HV1wjgSgsjwbeDPi0YnQN3LEcdv1qz24IToe/yCBydxfm06XXHdqNaGTA/HiCIBu+mIu/B
        rxDhgaloIATE8eXsEkuu+65jz3h69nApK4JcYC0w5vTpiuo7Toz/zMxKyNkSHpnJEooZl8
        e02lJKMO9vwPYABDtTbcGUGs0JFJpy7MU8MSDQdpDSlXlXer7Gx7k7r1P4RqHkhbXsPnug
        EUr7ktJcNjnP4RLZ9ipLe9opuItpDvySWv4UT0wiCIEIgKcbxn9udfMrtAjUIhHdnGcBef
        YEx3ysAw0fiYztw4wIZyuAR403mcQ8W2DQNWb2g7jlpNgBNu36DH8+r2xV29gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644227180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0RBBdWwxOY62NA2K6sRnag/9lJllybBsMojcDW+50rk=;
        b=qsVkc5OmeGvljANWBOl7If1Ppr4DGAumqKZajU5D3tN4umJkFIBn1v3EeWPIDU6o3GoX+j
        QtCi93fAr0a07nDQ==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2] printk: defer_console_output: use atomic update
In-Reply-To: <YfzP50vDiJiaRVCr@google.com>
References: <20220203112915.1350753-1-john.ogness@linutronix.de>
 <YfzP50vDiJiaRVCr@google.com>
Date:   Mon, 07 Feb 2022 10:52:20 +0106
Message-ID: <87bkzj3t77.fsf@jogness.linutronix.de>
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

Therefore this_cpu_or(), the atomic variant of __this_cpu_or(),
should be used to update the variable.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 Change from v1:
 
 Sebastian comments made it clear that the v1 title and message were not
 correctly specifying the problem or the reason for the fix. I hope this
 text is clearer.

 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82abfaf3c2aa..164ccdb9423e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3262,7 +3262,7 @@ void defer_console_output(void)
 		return;
 
 	preempt_disable();
-	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
+	this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
 	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	preempt_enable();
 }

base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
-- 
2.30.2
