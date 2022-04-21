Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2179050AAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442011AbiDUVZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442003AbiDUVZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:25:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F2B4D26A;
        Thu, 21 Apr 2022 14:22:53 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650576172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8gmUY81SNptAD3CDWEkaKXdJ4XucqcW0xuaGxHRqtCU=;
        b=c36rgdaqxz38sULcWqwk3G6Udz0kBy50qYRBTRtoM8I/fOmlM22mbp6jNkpjPmyJsZqM5u
        8UATj844pKGOcMPFOjM6LwB5qW21aQXTKS1mzXk9cXvVOq8L/P3uDfIqJMnD5womNCbitb
        Yh3OXqPsR4BAKda9QMDNA44HC5oxMR0GVFEHv7XR2j1MDLvxCNVdHgpBh5BmH7Lwk5q5Hu
        4G/vr/p808w1iXprTBHUx27Vp7MJELTH0qQ7Gy2OnqsYtDJYn8zGjsZGvy/FYEp9wQUljd
        sdejP2qyLfk5jLgUzYtVyq2zK55pzFuwYxHm6+IMsSNhzZ31XE8Jz7L8t/+NcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650576172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8gmUY81SNptAD3CDWEkaKXdJ4XucqcW0xuaGxHRqtCU=;
        b=zjx+60fy1lZASOZeylFWmhy5sOK7lgqz1gFHpNTmAKajfPizmMOGNRzn72bsneg1gMoG22
        Hv8Y9msrGtbpzCAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marco Elver <elver@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Corey Minyard <cminyard@mvista.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Wang Qing <wangqing@vivo.com>, rcu@vger.kernel.org
Subject: [PATCH printk v4 00/15] implement threaded console printing
Date:   Thu, 21 Apr 2022 23:28:35 +0206
Message-Id: <20220421212250.565456-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v4 of a series to implement a kthread for each registered
console. v3 is here [0]. The kthreads locklessly retrieve the
records from the printk ringbuffer and also do not cause any lock
contention between each other. This allows consoles to run at full
speed. For example, a netconsole is able to dump records much
faster than a serial or vt console. Also, during normal operation,
printk() callers are completely decoupled from console printing.

There are situations where kthread printing is not sufficient. For
example, during panic situations, where the kthreads may not get a
chance to schedule. In such cases, the current method of attempting
to print directly within the printk() caller context is used. New
functions printk_prefer_direct_enter() and
printk_prefer_direct_exit() are made available to mark areas of the
kernel where direct printing is preferred. (These should only be
areas that do not occur during normal operation.)

This series also introduces pr_flush(): a might_sleep() function
that will block until all active printing threads have caught up
to the latest record at the time of the pr_flush() call. This
function is useful, for example, to wait until pending records
are flushed to consoles before suspending.

Note that this series does *not* increase the reliability of console
printing. Rather it focuses on the non-interference aspect of
printk() by decoupling printk() callers from printing (during normal
operation). Nonetheless, the reliability aspect should not worsen
due to this series.

John Ogness

[0] https://lore.kernel.org/lkml/20220419234637.357112-1-john.ogness@linutronix.de

Changes since v3:

- For defer_console_output(), call allow_direct_printing() instead
  of only checking @printk_prefer_direct.

- Remove console_lock_single_hold() and
  console_unlock_single_release() functions. Use the console_lock
  for console_stop(), console_start(), unregister_console(),
  printk_kthread_func().

- Introduce macros console_flags_set() and console_flags_clear() to
  adjust con->flags using READ_ONCE()/WRITE_ONCE() in order to
  guarantee consistent values for the variable. (This does not make
  the RMW operations atomic, but the console_lock and con->lock are
  still used to synchronize between tasks that modify con->flags.)

- Add and/or expand comments for allow_direct_printing(),
  console_cpu_notify(), __console_unlock(), console_stop(),
  console_start(), unregister_console(), printk_kthread_func(),
  defer_console_output().

John Ogness (15):
  printk: rename cpulock functions
  printk: cpu sync always disable interrupts
  printk: add missing memory barrier to wake_up_klogd()
  printk: wake up all waiters
  printk: wake waiters for safe and NMI contexts
  printk: get caller_id/timestamp after migration disable
  printk: call boot_delay_msec() in printk_delay()
  printk: add con_printk() macro for console details
  printk: refactor and rework printing logic
  printk: move buffer definitions into console_emit_next_record() caller
  printk: add pr_flush()
  printk: add functions to prefer direct printing
  printk: add kthread console printers
  printk: extend console_lock for proper kthread support
  printk: remove @console_locked

 drivers/tty/sysrq.c     |    2 +
 include/linux/console.h |   19 +
 include/linux/printk.h  |   82 ++-
 kernel/hung_task.c      |   11 +-
 kernel/panic.c          |    4 +
 kernel/printk/printk.c  | 1234 +++++++++++++++++++++++++++++----------
 kernel/rcu/tree_stall.h |    2 +
 kernel/reboot.c         |   14 +-
 kernel/watchdog.c       |    4 +
 kernel/watchdog_hld.c   |    4 +
 lib/dump_stack.c        |    4 +-
 lib/nmi_backtrace.c     |    4 +-
 12 files changed, 1059 insertions(+), 325 deletions(-)


base-commit: 84d7df104dbab9c3dda8f2c5b46f9a6fc256fe02
-- 
2.30.2

