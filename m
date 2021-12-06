Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF58469071
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbhLFGqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237187AbhLFGqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:46:42 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8758C0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 22:43:13 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id f3-20020a5d50c3000000b00183ce1379feso1699826wrt.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 22:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Mof/wiYmoBGxtT831oqCwy9BE2boVy0/SSf3ri1WpLU=;
        b=pu3nHfeEpZeG6yImoZEbAyqhUSpMZuQHBi1+1Ho42VxnDV1hZEZQHk+PV6dSrjeIvd
         wRcfZeHje2p5Ms2GNMWu+/z1A9FrUt8ke9plSKySu/sNTbBN/5zQSdjnzl6eitM5+McO
         nm9WDOaXmlWPgNd34WRoOEI5pydtMJT7SDFW9mHPaM54A086hNOguxh7RAO1SS7F2jVB
         9LjqLqXADDKrPFg0XzYdR6rXPjCoY42u0L4/ItpZZhMy966bD9g46JeKchUVBQMjRkUP
         A6or1trrqrET4qu8lWIw91eNSlxiDh+6tYawtkdvYJ344BPoJXhzCyFfh/hTRiHT2XEr
         9ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Mof/wiYmoBGxtT831oqCwy9BE2boVy0/SSf3ri1WpLU=;
        b=My6RRJpUTsUCuNjIU0eHqgoUtJpD0fm3TdAE4bRWth62h/Ku5Lbd1XBT8HAJyxrJc1
         ORBIMpUmF7j6VNG9RFbG1i7ZspOefvwvY8IqoUrG4Kqh+xnmPyLSKZ6yIxv6qi/4fVN6
         U04JdtCl3XFrBg7WG3VSPY0z6tcghhKcpBvv+PBsupTaDEj/pAADZd4l0wMbXZBap1Yp
         t8UNEfbsAwQFkOgHEzZoQBiA5jKRCui/xtFTgkFIdeV4krDxlBWzLHsrXWrcwBXSsBqv
         fOLS+PkSIr8KezKrGNF/RwX4BWpVTVAoaQECueG9CsimxLDw0oP660tgKSVFK65UD9nY
         LxEQ==
X-Gm-Message-State: AOAM533vBKCG9KynXDXbO9QdA7ULdRkdftSYd87PNmJUyQfAuOvySoxP
        +AKgmd0Yd1WIAAysCawANWwPDMbo8g==
X-Google-Smtp-Source: ABdhPJy8wYI4P3EaYgzSS6dU2eYg11EuxhUo4WY1tmrJ3wRj3VuR72ARQ6bdNLe62bo74juyCjykfPyA6g==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:88f3:db53:e34:7bb0])
 (user=elver job=sendgmr) by 2002:a05:600c:3c91:: with SMTP id
 bg17mr37190024wmb.80.1638772992245; Sun, 05 Dec 2021 22:43:12 -0800 (PST)
Date:   Mon,  6 Dec 2021 07:41:50 +0100
Message-Id: <20211206064151.3337384-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH -rcu 1/2] kcsan: Avoid nested contexts reading inconsistent reorder_access
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nested contexts, such as nested interrupts or scheduler code, share the
same kcsan_ctx. When such a nested context reads an inconsistent
reorder_access due to an interrupt during set_reorder_access(), we can
observe the following warning:

 | ------------[ cut here ]------------
 | Cannot find frame for torture_random kernel/torture.c:456 in stack trace
 | WARNING: CPU: 13 PID: 147 at kernel/kcsan/report.c:343 replace_stack_entry kernel/kcsan/report.c:343
 | ...
 | Call Trace:
 |  <TASK>
 |  sanitize_stack_entries kernel/kcsan/report.c:351 [inline]
 |  print_report kernel/kcsan/report.c:409
 |  kcsan_report_known_origin kernel/kcsan/report.c:693
 |  kcsan_setup_watchpoint kernel/kcsan/core.c:658
 |  rcutorture_one_extend kernel/rcu/rcutorture.c:1475
 |  rcutorture_loop_extend kernel/rcu/rcutorture.c:1558 [inline]
 |  ...
 |  </TASK>
 | ---[ end trace ee5299cb933115f5 ]---
 | ==================================================================
 | BUG: KCSAN: data-race in _raw_spin_lock_irqsave / rcutorture_one_extend
 |
 | write (reordered) to 0xffffffff8c93b300 of 8 bytes by task 154 on cpu 12:
 |  queued_spin_lock                include/asm-generic/qspinlock.h:80 [inline]
 |  do_raw_spin_lock                include/linux/spinlock.h:185 [inline]
 |  __raw_spin_lock_irqsave         include/linux/spinlock_api_smp.h:111 [inline]
 |  _raw_spin_lock_irqsave          kernel/locking/spinlock.c:162
 |  try_to_wake_up                  kernel/sched/core.c:4003
 |  sysvec_apic_timer_interrupt     arch/x86/kernel/apic/apic.c:1097
 |  asm_sysvec_apic_timer_interrupt arch/x86/include/asm/idtentry.h:638
 |  set_reorder_access              kernel/kcsan/core.c:416 [inline]    <-- inconsistent reorder_access
 |  kcsan_setup_watchpoint          kernel/kcsan/core.c:693
 |  rcutorture_one_extend           kernel/rcu/rcutorture.c:1475
 |  rcutorture_loop_extend          kernel/rcu/rcutorture.c:1558 [inline]
 |  rcu_torture_one_read            kernel/rcu/rcutorture.c:1600
 |  rcu_torture_reader              kernel/rcu/rcutorture.c:1692
 |  kthread                         kernel/kthread.c:327
 |  ret_from_fork                   arch/x86/entry/entry_64.S:295
 |
 | read to 0xffffffff8c93b300 of 8 bytes by task 147 on cpu 13:
 |  rcutorture_one_extend           kernel/rcu/rcutorture.c:1475
 |  rcutorture_loop_extend          kernel/rcu/rcutorture.c:1558 [inline]
 |  ...

The warning is telling us that there was a data race which KCSAN wants
to report, but the function where the original access (that is now
reordered) happened cannot be found in the stack trace, which prevents
KCSAN from generating the right stack trace. The stack trace of "write
(reordered)" now only shows where the access was reordered to, but
should instead show the stack trace of the original write, with a final
line saying "reordered to".

At the point where set_reorder_access() is interrupted, it just set
reorder_access->ptr and size, at which point size is non-zero. This is
sufficient (if ctx->disable_scoped is zero) for further accesses from
nested contexts to perform checking of this reorder_access.

That then happened in _raw_spin_lock_irqsave(), which is called by
scheduler code. However, since reorder_access->ip is still stale (ptr
and size belong to a different ip not yet set) this finally leads to
replace_stack_entry() not finding the frame in reorder_access->ip and
generating the above warning.

Fix it by ensuring that a nested context cannot access reorder_access
while we update it in set_reorder_access(): set ctx->disable_scoped for
the duration that reorder_access is updated, which effectively locks
reorder_access and prevents concurrent use by nested contexts. Note,
set_reorder_access() can do the update only if disabled_scoped is zero
on entry, and must therefore set disable_scoped back to non-zero after
the initial check in set_reorder_access().

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 916060913966..fe12dfe254ec 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -412,11 +412,20 @@ set_reorder_access(struct kcsan_ctx *ctx, const volatile void *ptr, size_t size,
 	if (!reorder_access || !kcsan_weak_memory)
 		return;
 
+	/*
+	 * To avoid nested interrupts or scheduler (which share kcsan_ctx)
+	 * reading an inconsistent reorder_access, ensure that the below has
+	 * exclusive access to reorder_access by disallowing concurrent use.
+	 */
+	ctx->disable_scoped++;
+	barrier();
 	reorder_access->ptr		= ptr;
 	reorder_access->size		= size;
 	reorder_access->type		= type | KCSAN_ACCESS_SCOPED;
 	reorder_access->ip		= ip;
 	reorder_access->stack_depth	= get_kcsan_stack_depth();
+	barrier();
+	ctx->disable_scoped--;
 }
 
 /*
-- 
2.34.1.400.ga245620fadb-goog

