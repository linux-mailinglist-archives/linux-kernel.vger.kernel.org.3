Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DBF586D65
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiHAPIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHAPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:08:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C7C22BF0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:08:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 16219205CD;
        Mon,  1 Aug 2022 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659366480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=tZ5/mt7pK+Lds/lRdOSRmYcWBntq5z5pKDBstGKZLkQ=;
        b=HX4Cii1hu4LtXGA4C3pZcloj8FWzs/VfMBOC5Jy2NpKFAvP2RqYNZBIpRCPJoyXHLDhQ8C
        tBPCO+8XP6k+65k2BIOAylA2dO4yIkegQNyLwrnUgdSP4fJVR//EYZShrzuRDbLwa6J9OT
        AOzGvRKeJLG/7UkvKvoXXDbgf+wr+E8=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A394A2C141;
        Mon,  1 Aug 2022 15:07:59 +0000 (UTC)
Date:   Mon, 1 Aug 2022 17:07:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 5.20
Message-ID: <YufsTLpighCI7qSf@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.20

=====================================

- Completely disable printing on consoles with CONFIG_RT. They break
  RT guarantees. They are too slow to be called with raw spinlocks.
  They can't be called with normal spinlocks in an atomic context because
  RT spinlocks might sleep. It is going to get fixed by the kthreads and
  atomic consoles. In the meantime, the debugging of CONFIG_RT kernel
  will be possible only by the user space kernel log readers.

- Allow to read kernel log in gdb even on 32 bits systems.

- More granular check of the buffer usage in printf selftest.

- Clang warning fix.

----------------------------------------------------------------
Antonio Borneo (1):
      scripts/gdb: fix 'lx-dmesg' on 32 bits arch

Justin Stitt (1):
      lib/test_printf.c: fix clang -Wformat warnings

Petr Mladek (2):
      Merge branch 'for-5.20' into for-linus
      Merge branch 'rework/kthreads' into for-linus

Rasmus Villemoes (1):
      lib/test_printf.c: split write-beyond-buffer check in two

Sebastian Andrzej Siewior (1):
      printk: Skip console drivers on PREEMPT_RT.

 kernel/printk/printk.c     | 10 ++++++++++
 lib/test_printf.c          | 21 +++++++++++++++++----
 scripts/gdb/linux/dmesg.py |  9 +++------
 scripts/gdb/linux/utils.py | 14 ++++++++++++--
 4 files changed, 42 insertions(+), 12 deletions(-)
