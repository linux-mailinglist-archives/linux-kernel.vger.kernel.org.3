Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E979A4BC7A7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242041AbiBSKWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:22:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbiBSKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:21:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE98E03;
        Sat, 19 Feb 2022 02:21:29 -0800 (PST)
Date:   Sat, 19 Feb 2022 10:21:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645266088;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJhHvKEXRPHSAjTa2sh1695Mi5ecnxmwtw9hbQv4+W0=;
        b=hsvFUjlGJhcfXUEovd6KFOX+j1amOBHyOTSNhZu6apHe7oHY9aNg4Y71DGY+zDA2cpUTMb
        ERbB1LGn1V9IxpAbhltgFBvSBoKBfN+30/ET3jVX4kdAb9V+44/xqbYIiB/zqqxLsdPBh5
        IVgDzvbKCHJuokkgGPXcWPaGZUrPAj1YFg4eZw4tnVBHamJznxmG+fPZamnXj4xq+odidt
        UUm4DDQY7tPWvUn1J7SHuXyoz4GrRGoEVcIcJ9023L8CVJeUdRZiKkW02dVrbT2J1oljKL
        Gp6xGyTEaSeKBo3CDywEDOBOWyiqwJuHAMe6GSRpKxPjhRKVKQ7DhIy5enSCVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645266088;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJhHvKEXRPHSAjTa2sh1695Mi5ecnxmwtw9hbQv4+W0=;
        b=thWtI1LUSC/CeDmZNN+mnA99iCMLsxlFGzMcP8FimAo1EDRcHBACxdkCQHEDlBwzASiw0l
        VytRnsptnq0oaiBA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/preempt: Simplify
 irqentry_exit_cond_resched() callers
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220214165216.2231574-4-mark.rutland@arm.com>
References: <20220214165216.2231574-4-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <164526608700.16921.17683501386513808570.tip-bot2@tip-bot2>
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

Commit-ID:     4624a14f4daa8ab4578d274555fd8847254ce339
Gitweb:        https://git.kernel.org/tip/4624a14f4daa8ab4578d274555fd8847254ce339
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 14 Feb 2022 16:52:12 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 19 Feb 2022 11:11:08 +01:00

sched/preempt: Simplify irqentry_exit_cond_resched() callers

Currently callers of irqentry_exit_cond_resched() need to be aware of
whether the function should be indirected via a static call, leading to
ugly ifdeffery in callers.

Save them the hassle with a static inline wrapper that does the right
thing. The raw_irqentry_exit_cond_resched() will also be useful in
subsequent patches which will add conditional wrappers for preemption
functions.

Note: in arch/x86/entry/common.c, xen_pv_evtchn_do_upcall() always calls
irqentry_exit_cond_resched() directly, even when PREEMPT_DYNAMIC is in
use. I believe this is a latent bug (which this patch corrects), but I'm
not entirely certain this wasn't deliberate.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20220214165216.2231574-4-mark.rutland@arm.com
---
 include/linux/entry-common.h |  9 ++++++---
 kernel/entry/common.c        | 12 ++++--------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index a01ac1a..dfd84c5 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -454,11 +454,14 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  *
  * Conditional reschedule with additional sanity checks.
  */
-void irqentry_exit_cond_resched(void);
+void raw_irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#define irqentry_exit_cond_resched_dynamic_enabled	irqentry_exit_cond_resched
+#define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
 #define irqentry_exit_cond_resched_dynamic_disabled	NULL
-DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
+#define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
+#else
+#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
 #endif
 
 /**
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bad7136..1739ca7 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -380,7 +380,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	return ret;
 }
 
-void irqentry_exit_cond_resched(void)
+void raw_irqentry_exit_cond_resched(void)
 {
 	if (!preempt_count()) {
 		/* Sanity check RCU and thread stack */
@@ -392,7 +392,7 @@ void irqentry_exit_cond_resched(void)
 	}
 }
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
 #endif
 
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
@@ -420,13 +420,9 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		}
 
 		instrumentation_begin();
-		if (IS_ENABLED(CONFIG_PREEMPTION)) {
-#ifdef CONFIG_PREEMPT_DYNAMIC
-			static_call(irqentry_exit_cond_resched)();
-#else
+		if (IS_ENABLED(CONFIG_PREEMPTION))
 			irqentry_exit_cond_resched();
-#endif
-		}
+
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
 		instrumentation_end();
