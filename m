Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B611507D59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358227AbiDSXt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357832AbiDSXtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:49:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671081DA52;
        Tue, 19 Apr 2022 16:46:41 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650411999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=amsD5ngGoHNxzOapZmiX6RWDTlrbhD4eIamwPBjOGnE=;
        b=Gxo4/9cVoAImG+nETmQGGkVp0vPVglLoi4r/PVws1ExFJw37Se4h2/0GFqov0FNM0qooE2
        NCIiaEeuCTz5khNCho4M5krVfzU/Or/noUuIApiMYuYVds7cnxtmF64yNnZmFQVYY7V2M2
        J1JWdrNrFwfMxiiMedhuV7Oy4Rhg3+s45EFOt8Xl0HRqtijQrZDf8bGc4CFxgYhUlyblXZ
        G7wvs0p5Nq+e1Y7Hkm5lR7UmhfqUbLtJ83Yt+LfvND3rEf6FSd7bcRgc9R+ymf1IZ4SiWi
        OA5itp3d7oMIw0M5hj5Jiqtsf5fugFbejMZQCuFjNgf778zWGvfQdxiX4VliWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650411999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=amsD5ngGoHNxzOapZmiX6RWDTlrbhD4eIamwPBjOGnE=;
        b=LX8e26OXpd/EW+sYtboMatcoGX9fng7Ypms4ROp9fqRxCNItFnz4rv043CAFh/JaEE8+G5
        Rm7UzLTM1xoxjaBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
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
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Marco Elver <elver@google.com>, Wei Liu <wei.liu@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Wang Qing <wangqing@vivo.com>, rcu@vger.kernel.org
Subject: [PATCH printk v3 00/15] printk/for-next
Date:   Wed, 20 Apr 2022 01:52:22 +0206
Message-Id: <20220419234637.357112-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v3 of a series to implement a kthread for each registered
console. v2 is here [0]. The kthreads locklessly retrieve the
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

[0] https://lore.kernel.org/lkml/20220405132535.649171-1-john.ogness@linutronix.de

Changes since v2:

- Threaded printers no longer care about preferred direct printing.
  As with v1, they will print whenever they are not blocked.

- Provide a separate patch to fix a missing memory barrier in
  wake_up_klogd() and add memory barrier comments to all
  appropriate @log_wait usage sites.

- Provide a separate patch to wake all waiters.

- Provide a separate patch to wake waiters for deferred console
  output and add comments explaining why.

- Introduce console_lock_single_hold() and
  console_unlock_single_release() to acquire @console_sem and lock a
  single threaded printer. This allows console start/stop and
  console unregistration with synchronized con->flags and without
  disturbing other threaded printers.

- Introduce __console_is_usable() to avoid some redundance between
  threaded and direct printing code.

- Do not create a printer thread if con->write() is not set. (I do
  not understand why we even allow registration if con->write() is
  not set. The checks were added in 2.1.31 for no obvious reason.)

- Only allow handovers between console_trylock() contexts. A
  console_lock() context cannot handover the console_lock to a
  console_trylock() context because the blocked kthreads would need
  to be unblocked via mutex.

- console_flush_all() returns true only if at least one console is
  usable and all messages to all usable consoles were printed.
  Otherwise it returns false.

- Remove redundant panic check in console_unlock().

- Rename printk_console_msg() to con_printk() and use syntax similar
  to dev_printk(). (I did not name it console_printk() because there
  already exists a symbol with that name.)

- Remove blocked check in register_console() since it is always
  true.

- In unregister_console(), stop the kthread after the console has
  been removed from the list. Use the per-console mutex for
  synchronized kthread stopping.

- Use the console_lock for synchronized activation of the fallback
  permanent direct printing mode.

- Use the same checks in printer_should_wake() as in
  printk_kthread_func() to avoid infinite loop danger.

- Rename PRINTK_PENDING_OUTPUT flag to PRINTK_PENDING_DIRECT_OUTPUT.

- Expand commit messages relating to memory barriers, kthreads, and
  the usage of the per-console mutex.

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
 kernel/printk/printk.c  | 1197 +++++++++++++++++++++++++++++----------
 kernel/rcu/tree_stall.h |    2 +
 kernel/reboot.c         |   14 +-
 kernel/watchdog.c       |    4 +
 kernel/watchdog_hld.c   |    4 +
 lib/dump_stack.c        |    4 +-
 lib/nmi_backtrace.c     |    4 +-
 12 files changed, 1021 insertions(+), 326 deletions(-)


base-commit: 84d7df104dbab9c3dda8f2c5b46f9a6fc256fe02
-- 
2.30.2

