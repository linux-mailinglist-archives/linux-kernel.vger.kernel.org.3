Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1734E2AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349241AbiCUOcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344963AbiCUOb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:31:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA46E56740
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:28:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7B0A01F387;
        Mon, 21 Mar 2022 14:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647872907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=i+GubjXlIXayFoOJawergPNhbOhtk2f3oUXUcOm+nAA=;
        b=Sk2/fLdEZyqRAFtMeQZLFvypARYlUKYEikv5N1YRD9m//ryui+62/az2pGanfXo8yONAKH
        +oD6/cJo24OrzSQiELEgYUwUJhBq35mOAO78nxpzmwV8cReIN4YLUvD6G8WksdS/EpMfDf
        hq63S634AK21PRQ3r0SAC3HD5HVzDmg=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 23ED9A3BC3;
        Mon, 21 Mar 2022 14:28:27 +0000 (UTC)
Date:   Mon, 21 Mar 2022 15:28:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 5.18
Message-ID: <YjiLijmVZGox94IH@alley>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.18

==========================================

- Make %pK behave the same as %p for kptr_restrict == 0 also
  with no_hash_pointers parameter.

- Ignore the default console in the device tree also when console=null
  or console="" is used on the command line.

- Document console=null and console="" behavior.

- Prevent a deadlock and a livelock caused by console_lock in panic().

- Make console_lock available for panicking CPU.

- Fast query for the next to-be-used sequence number.

- Use the expected return values in printk.devkmsg __setup handler.

- Use the correct atomic operations in wake_up_klogd() irq_work handler.

- Avoid possible unaligned access when handling %4cc printing format.

----------------------------------------------------------------
Andre Kalb (1):
      printk: Set console_set_on_cmdline=1 when __add_preferred_console() is called with user_specified == true

Andy Shevchenko (2):
      vsprintf: Fix potential unaligned access
      vsprintf: Move space out of string literals in fourcc_string()

Christophe Leroy (1):
      vsprintf: Fix %pK with kptr_restrict == 0

Jiapeng Chong (1):
      printk: make suppress_panic_printk static

John Ogness (1):
      printk: use atomic updates for klogd work

Petr Mladek (4):
      printk: ringbuffer: Improve prb_next_seq() performance
      Merge branch 'for-5.18-vsprintf-fourcc-fixup' into for-linus
      Merge branch 'for-5.18-panic-deadlocks' into for-linus
      Merge branch 'rework/fast-next-seq' into for-linus

Randy Dunlap (2):
      Docs: printk: add 'console=null|""' to admin/kernel-parameters
      printk: fix return value of printk.devkmsg __setup handler

Stephen Brennan (4):
      printk: Add panic_in_progress helper
      printk: disable optimistic spin during panic
      printk: Avoid livelock with heavy printk during panic
      printk: Drop console_sem during panic

 Documentation/admin-guide/kernel-parameters.txt |  9 ++-
 kernel/printk/printk.c                          | 85 ++++++++++++++++++++++---
 kernel/printk/printk_ringbuffer.c               | 52 +++++++++++++--
 kernel/printk/printk_ringbuffer.h               |  2 +
 lib/vsprintf.c                                  | 49 ++++++++------
 5 files changed, 161 insertions(+), 36 deletions(-)
