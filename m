Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08314AC9D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbiBGTpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbiBGTna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:43:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81463C0401E0;
        Mon,  7 Feb 2022 11:43:28 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644263005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MdxDRNNBc3a7TPDYRAGdfkzwCVJZGysq69JGSiTARZo=;
        b=KZEy10hDutMfaU7BOQdyVVOPIBOS4KP6ewAyK4hKFQNiuO/SRjJehVsWlroqzy26l9Muso
        B7BHJLcCPExCZ1f2hpqX79R3YV0v50wgdf+FuV7bQt24SZJaHYTcIU3jghXaWvD40sjAFJ
        RwrhOFKAO9siMogdq7KTdebml/AeKNACYhNlx+oBI+CNBRUu491sSOxz9/rceBUn7XE0Cz
        a9OorMkDOcXoI8zeyE9NNmrFwLy2qp+MdHnVSbSPRGvFPzZ2niy8e23MzmIHL9CzA2aJqt
        x6k8TXhJ2veAGeTtJLQV/v/cVPUt4W4imq0xwijbiOhEC7Sq0PEg/4fCvbIG2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644263005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MdxDRNNBc3a7TPDYRAGdfkzwCVJZGysq69JGSiTARZo=;
        b=aea7eqXhsYSTt2SiFzTd8KOQ9QlKly9EhstysiNyYY7FxfrEpEg55FSdRKEg1ZAHNCaOsh
        Ep3r1Hcy/lnMRLBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Corey Minyard <cminyard@mvista.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Wang Qing <wangqing@vivo.com>, Tejun Heo <tj@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, rcu@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Sterba <dsterba@suse.com>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        nick black <dankamongmen@gmail.com>
Subject: [PATCH printk v1 00/13] implement threaded console printing
Date:   Mon,  7 Feb 2022 20:49:10 +0106
Message-Id: <20220207194323.273637-1-john.ogness@linutronix.de>
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

This is the next part of our printk-rework effort (points 2 and 6 of
the LPC 2019 summary [0]).

This series implements a kthread for each registered console. The
kthreads locklessly retrieve the records from the printk ringbuffer
and also do not cause any lock contention between one another. This
allows consoles to run at full speed. For example, a netconsole is
able to dump records much faster than a serial or vt console.

There are situations where kthread printing is not sufficient. For
example, during early boot before kthreads exist or during panic
situations, where the kthreads may not get a chance to schedule. In
these cases, the current method of printing directly within the
printk() caller context is used. New functions printk_direct_enter()
and printk_direct_exit() are made available to mark areas of the
kernel where direct printing should be used.

This series also introduces pr_flush(): a might_sleep() function
that will block until all active printing threads have caught up
to the latest record at the time of the pr_flush() call. This
function is useful, for example, to wait until pending records
are flushed to consoles before suspending.

And finally, this series introduces a new console flag
CON_MIGHT_SLEEP that can be set by consoles that only want their
write() callback called in sleepable contexts. This was requested
by Daniel Vetter [1] due to the many and growing number of deadlock
situations in the fbcon code.

Note that this series does *not* increase the reliability of console
printing. Rather it focuses on the non-interference aspect of
printk() by decoupling printk() callers from printing (during normal
operation). Nonetheless, the reliability aspect should not worsen
due to this series (with perhaps the exception of the fbcon, which
will only print from sleepable contexts).

[0] https://lore.kernel.org/lkml/87k1acz5rx.fsf@linutronix.de
[1] https://lore.kernel.org/all/YYuS1uNhxWOEX1Ci@phenom.ffwll.local

John Ogness (13):
  printk: rename cpulock functions
  printk: cpu sync always disable interrupts
  printk: use percpu flag instead of cpu_online()
  printk: get caller_id/timestamp after migration disable
  printk: call boot_delay_msec() in printk_delay()
  printk: refactor and rework printing logic
  printk: move buffer definitions into console_emit_next_record() caller
  printk: add pr_flush()
  printk: add functions to allow direct printing
  printk: add kthread console printers
  printk: reimplement console_lock for proper kthread support
  printk: remove @console_locked
  console: introduce CON_MIGHT_SLEEP for vt

 drivers/tty/sysrq.c     |   2 +
 drivers/tty/vt/vt.c     |   2 +-
 include/linux/console.h |  22 +-
 include/linux/printk.h  |  70 ++--
 kernel/hung_task.c      |  11 +-
 kernel/printk/printk.c  | 903 +++++++++++++++++++++++++++++-----------
 kernel/rcu/tree_stall.h |   2 +
 kernel/reboot.c         |  14 +-
 kernel/watchdog.c       |   4 +
 kernel/watchdog_hld.c   |   4 +
 lib/dump_stack.c        |   6 +-
 lib/nmi_backtrace.c     |   6 +-
 12 files changed, 765 insertions(+), 281 deletions(-)


base-commit: a229327733b86aa585effdb0d27a87b12aa51597
-- 
2.30.2

