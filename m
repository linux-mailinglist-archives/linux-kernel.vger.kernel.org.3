Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9548D531365
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiEWNVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiEWNVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:21:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FC063DE
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:21:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CDF3A21AD6;
        Mon, 23 May 2022 13:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653312070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=ewYw1fRxVPzaahbUqFNs5STtZWay9ceigZCWA51wXME=;
        b=J5zwYsGflaUsl4B6PY4vfyuGwRyQ3hR4LH0PNF3GLk4MwilRuPFQnqp32ms6P1PL5R9Dep
        9WV8zjlw/DeWcVE5LhQslKdA9w3X8wKARwdlVa4Mio/pMPAsWVj5niCC9yZZ32q6BrwPTt
        f4O5FLAnzAj85rX9O6cR1UejKi/ypCI=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 682362C141;
        Mon, 23 May 2022 13:21:10 +0000 (UTC)
Date:   Mon, 23 May 2022 15:21:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 5.19
Message-ID: <YouKQw72H7y9EJQK@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19

================================================

- Offload writing printk() messages on consoles to per-console kthreads.

  It prevents soft-lockups when an extensive amount of messages is printed.
  It was observed, for example, during boot of large systems with a lot
  of peripherals like disks or network interfaces.

  It prevents live-lockups that were observed, for example, when messages
  about allocation failures were reported and a CPU handled consoles
  instead of reclaiming the memory. It was hard to solve even with
  rate limiting because it would need to take into account the amount
  of messages and the speed of all consoles.

  It is a must to have for real time. Otherwise, any printk() might break
  latency guarantees.

  The per-console kthreads allow to handle each console on its own speed.
  Slow consoles do not longer slow down faster ones. And printk() does
  not longer unpredictably slows down various code paths.

  There are situations when the kthreads are either not available or
  not reliable, for example, early boot, suspend, or panic. In these
  situations, printk() uses the legacy mode and tries to handle consoles
  immediately.


- Add documentation for the printk index.


===============================================

Risk:

There was always fear that messages might not reach the console when
the kthreads could not be scheduled. It blocked introducing the kthreads
for nearly a decade.

It is clear that the kthreads adds some risk that the messages will
not reach consoles. But the original solution was just the best
effort either.

The kthreads fix some real bugs as mentioned above. Also they allow
to see the messages on other consoles when other consoles are slow
or get stuck.

The patchset has been in linux-next for nearly one month since April 26.
It helped to find one already existing race when initializing
a console device. It made the race more visible, see
https://lore.kernel.org/r/20220508103547.626355-1-john.ogness@linutronix.de

Nobody reported problems with missing messages. Of course, it just
a good sign but it is not proof of anything. Let's see how it
works when it gets more testing in the mainline. I am afraid
that we won't find without trying.


----------------------------------------------------------------
Chris Down (1):
      MAINTAINERS: Add printk indexing maintainers on mention of printk_index

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
      printk: extend console_lock for per-console locking
      printk: remove @console_locked

Marco Elver (1):
      printk, tracing: fix console tracepoint

Petr Mladek (2):
      printk/index: Printk index feature documentation
      Merge branch 'rework/kthreads' into for-linus

 Documentation/core-api/index.rst        |    1 +
 Documentation/core-api/printk-index.rst |  137 ++++
 MAINTAINERS                             |    2 +
 drivers/tty/sysrq.c                     |    2 +
 include/linux/console.h                 |   19 +
 include/linux/printk.h                  |   82 ++-
 kernel/hung_task.c                      |   11 +-
 kernel/panic.c                          |    4 +
 kernel/printk/printk.c                  | 1205 +++++++++++++++++++++++--------
 kernel/rcu/tree_stall.h                 |    2 +
 kernel/reboot.c                         |   14 +-
 kernel/watchdog.c                       |    4 +
 kernel/watchdog_hld.c                   |    4 +
 lib/dump_stack.c                        |    4 +-
 lib/nmi_backtrace.c                     |    4 +-
 15 files changed, 1174 insertions(+), 321 deletions(-)
 create mode 100644 Documentation/core-api/printk-index.rst
