Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255E85272B6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiENPne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiENPnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:43:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE8CFD3B;
        Sat, 14 May 2022 08:43:27 -0700 (PDT)
Date:   Sat, 14 May 2022 15:43:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652543004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ey17U1j0ae8/OyAMJAQzay89E2ztl5A31+9DlKk5bco=;
        b=CIeAwenoIwr/d1cIyIdo73ERP3kVhpvHIMLliwD1g1zByIo6kFBSpiQ4WhLzGRCp7R28P9
        /MDOw8KPHacs1Y5eIPDi91hYgv4sdhiHAa7D4f9qpsltqvpM+B3PF5kgTLNg+/itPGWMgu
        C5cL3NXR3zvWZLnsjvQ33LWO/HAAHcptQdt7NqRiPLG4OV6XoSHsJvKbKxBshWCaqegwoQ
        z/8eowUx4ubp5gbSts6H3ubrywzLfTehcCwNfc4uAACKENC64og/FaCm+Przdg9FvKafsb
        IzmqR8NyZ4u116qdkP8Rv65APbN51IP2FFeDQSTbi48ZbckpvslS0ZgK1U2E/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652543004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ey17U1j0ae8/OyAMJAQzay89E2ztl5A31+9DlKk5bco=;
        b=IKADpQYF7V8E3ak/V7wH/egrb1SxQ3IsvClJDqEiL4wR5CDlW1q/3lntF5cc7Pomd+4bA/
        2EN+r4jysTGXXFDw==
From:   "tip-bot2 for Stephen Boyd" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Provide a better debugobjects hint for
 delayed works
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220511201951.42408-1-swboyd@chromium.org>
References: <20220511201951.42408-1-swboyd@chromium.org>
MIME-Version: 1.0
Message-ID: <165254300323.4207.7727256341828519425.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     317f29c14d0cca09952f1022491454b23455ebcb
Gitweb:        https://git.kernel.org/tip/317f29c14d0cca09952f1022491454b23455ebcb
Author:        Stephen Boyd <swboyd@chromium.org>
AuthorDate:    Wed, 11 May 2022 13:19:51 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 14 May 2022 17:40:36 +02:00

timers: Provide a better debugobjects hint for delayed works

With debugobjects enabled the timer hint for freeing of active timers
embedded inside delayed works is always the same, i.e. the hint is
delayed_work_timer_fn, even though the function the delayed work is going
to run can be wildly different depending on what work was queued.  Enabling
workqueue debugobjects doesn't help either because the delayed work isn't
considered active until it is actually queued to run on a workqueue. If the
work is freed while the timer is pending the work isn't considered active
so there is no information from workqueue debugobjects.

Special case delayed works in the timer debugobjects hint logic so that the
delayed work function is returned instead of the delayed_work_timer_fn.
This will help to understand which delayed work was pending that got
freed.

Apply the same treatment for kthread_delayed_work because it follows the
same pattern.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220511201951.42408-1-swboyd@chromium.org
---
 kernel/time/timer.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index ef082d4..a0666d9 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -638,9 +638,39 @@ static void internal_add_timer(struct timer_base *base, struct timer_list *timer
 
 static const struct debug_obj_descr timer_debug_descr;
 
+struct timer_hint {
+	void	(*function)(struct timer_list *t);
+	long	offset;
+};
+
+#define TIMER_HINT(fn, container, timr, hintfn)			\
+	{							\
+		.function = fn,					\
+		.offset	  = offsetof(container, hintfn) -	\
+			    offsetof(container, timr)		\
+	}
+
+static const struct timer_hint timer_hints[] = {
+	TIMER_HINT(delayed_work_timer_fn,
+		   struct delayed_work, timer, work.func),
+	TIMER_HINT(kthread_delayed_work_timer_fn,
+		   struct kthread_delayed_work, timer, work.func),
+};
+
 static void *timer_debug_hint(void *addr)
 {
-	return ((struct timer_list *) addr)->function;
+	struct timer_list *timer = addr;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(timer_hints); i++) {
+		if (timer_hints[i].function == timer->function) {
+			void (**fn)(void) = addr + timer_hints[i].offset;
+
+			return *fn;
+		}
+	}
+
+	return timer->function;
 }
 
 static bool timer_is_static_object(void *addr)
