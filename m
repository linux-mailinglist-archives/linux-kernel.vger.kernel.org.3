Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9292A4F500E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450355AbiDFBJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352131AbiDEPLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:11:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BC8108741;
        Tue,  5 Apr 2022 06:25:40 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649165137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3uTtNKEIWvK40el6X/tph7T5OFPK+Qu+KPdH0jY6/NM=;
        b=nUIDNekKdxeQDgfR6WR0r5ry08qg4CHFu3HMoiENog4Pmqwzgiz6j/H2nDVwQ7X4I7ZBTc
        LVVeIErmf+0eMJDu4z0m+MkgJzZo8H14BoaXZXvBixke8URYXcOQhspk0wehzCD8X/8bFM
        7k3eUay7ycFm2+USCUYO5oGn9ycxvvx7mnfHkhx0aiVAaM8Vsb1au1biFYfol0cQxVTOd6
        RD8qnVXDU+0N64DgudnxcD9o/K5D/emT5HCKSX91o99sx/ni4aTlPxj0hZPYhA2fnVoSiU
        OS81aVoCcwLrLKl1GgemvSl6WE6akmtyeV/FtctY5sKo0MDpCTaxGt90OdpGZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649165137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3uTtNKEIWvK40el6X/tph7T5OFPK+Qu+KPdH0jY6/NM=;
        b=+nzqxfmjtL5R0gTBDsuIkCbGDRHq1Z/T5zsfM/DHW+QxwPbN/tyS1il78axqHyzAVBdv5p
        vCw069dKqi684iCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
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
        Wei Liu <wei.liu@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Phil Auld <pauld@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Wang Qing <wangqing@vivo.com>, rcu@vger.kernel.org
Subject: [PATCH printk v2 00/12] implement threaded console printing
Date:   Tue,  5 Apr 2022 15:31:23 +0206
Message-Id: <20220405132535.649171-1-john.ogness@linutronix.de>
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

This is v2 of a series to implement a kthread for each registered
console. v1 is here [0]. The kthreads locklessly retrieve the
records from the printk ringbuffer and also do not cause any lock
contention between each other. This allows consoles to run at full
speed. For example, a netconsole is able to dump records much
faster than a serial or vt console. Also, during normal operation,
it completely decouples printk() callers from console printing.

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

Changes since v1:

- Rename nearly all new variables, functions, macros, and flags:

  variables:
  @console_lock_count        --> @console_kthreads_active
  @consoles_paused           --> @console_kthreads_blocked
  @kthreads_started          --> @printk_kthreads_available
  @printk_direct             --> @printk_prefer_direct

  functions/macros:
  console_excl_trylock()     --> console_kthreads_atomic_tryblock()
  console_excl_unlock()      --> console_kthreads_atomic_unblock()
  console_printer_tryenter() --> console_kthread_printing_tryenter()
  console_printer_exit()     --> console_kthread_printing_exit()
  pause_all_consoles()       --> console_kthreads_block()
  unpause_all_consoles()     --> console_kthreads_unblock()
  printk_direct_enter()      --> printk_prefer_direct_enter()
  printk_direct_exit()       --> printk_prefer_direct_exit()
  start_printk_kthread()     --> printk_start_kthread()

  console flags:
  CON_PAUSED                 --> CON_THD_BLOCKED

- Drop the patch to avoid VT printing if in an atomic context. (This
  can only be done after the Linux BSoD feature is implemented.)

- Keep printk_delay() in the printk() context. (We may want to move
  this into printer contexts later.)

- Keep console_trylock() usage to reacquire the console lock in
  console_unlock().

- Keep cpu_online(raw_smp_processor_id()) in the check if a console
  is usable and remove the printk_percpu_data_ready() check (percpu
  data is always ready for consoles).

- Start console printer threads as an early_initcall. This means
  threads are active before multiple CPUs come online.

- Remove "system_state < SYSTEM_RUNNING" as a reason to allow direct
  printing. @kthreads_started is used for the early boot decision.

- Add console_kthreads_atomically_blocked() macro.

- Add printk_console_msg() macro to printk messages with console
  details. The macro allows print indexing.

- Add __pr_flush() to allow waiting for only a single console.

- Add a full memory barrier in wake_up_klogd() to ensure new records
  are visible before checking if the waitqueue is empty.

- Wake kthreads when exiting preferred direct mode.

- Wake kthreads when a CPU comes online.

- In unregister_console(), stop the printer thread before acquiring
  the console lock.

- Print "thread started" message after all allocations successful.

- Permanently enable preferred direct printing if there are any
  errors setting up any of the threaded console printers.

- Keep threaded printers asleep if there is no con->write()
  callback.

- Keep threaded printers asleep if preferred direct printing is
  active.

- Always allow handovers if the console is locked.

- Only stop irqsoff tracing if handovers are allowed.

- console_emit_next_record() is for when the console is not locked,
  console_emit_next_record_transferable() is for when the console is
  locked.

- Wait for console printers to catch up after unblanking the screen.

- In console_stop(), only wait for the stopping console.

- In console_start(), only wait for the starting console.

- Print only 1 record per wait cycle to increase chances of direct
  printing taking over.

- Repurpose the irqwork flag PRINTK_PENDING_OUTPUT for direct
  printing.

- Add caution notice and tips to description of
  printk_cpu_sync_get_irqsave() on how to use it correctly.

- Improve the comments explaining why preemption is disabled during
  direct printing.

- Improve commit message to explain the motivation for expanding the
  console lock and how it works.

John Ogness

[0] https://lore.kernel.org/all/20220207194323.273637-1-john.ogness@linutronix.de

John Ogness (12):
  printk: rename cpulock functions
  printk: cpu sync always disable interrupts
  printk: get caller_id/timestamp after migration disable
  printk: call boot_delay_msec() in printk_delay()
  printk: add macro for console detail messages
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
 kernel/printk/printk.c  | 1070 +++++++++++++++++++++++++++++----------
 kernel/rcu/tree_stall.h |    2 +
 kernel/reboot.c         |   14 +-
 kernel/watchdog.c       |    4 +
 kernel/watchdog_hld.c   |    4 +
 lib/dump_stack.c        |    4 +-
 lib/nmi_backtrace.c     |    4 +-
 12 files changed, 908 insertions(+), 312 deletions(-)


base-commit: 3ef4ea3d84ca568dcd57816b9521e82e3bd94f08
-- 
2.30.2

