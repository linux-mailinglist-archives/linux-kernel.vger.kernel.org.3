Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BE4489B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiAJOd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:33:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39154 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiAJOdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:33:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6EC9B1F393;
        Mon, 10 Jan 2022 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641825234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=nIdYnUKKHSYPz1SXjOAJXSBQBLUMF5SXe7Kpd5udxW4=;
        b=A1FspWCAyGfwjMoY6lOS4wE0nn98w7K6PRnOFYkm1O72I0HvanG3Yj3ZKWAIBpHE+C2ugY
        Crnaf1f03/mqL1TDUjTlPhJfZO9EldBCSNaSO+oUYdN9braD1axgNEf5wlYTkXigpgclf+
        d3/DhiiSzDnxVieVvYGLZiH41jMzBzA=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F40EAA3B84;
        Mon, 10 Jan 2022 14:33:53 +0000 (UTC)
Date:   Mon, 10 Jan 2022 15:33:50 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 5.17
Message-ID: <YdxDzgijikydIwOP@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.17

============================================

- Remove some twists in the console registration code. It does not change
  the existing behavior except for one corner case. The proper default
  console (with tty binding) will be registered again even when it has
  been removed in the meantime. It is actually a bug fix. Anyway, this
  modified behavior requires some manual interaction.

- Optimize gdb extension for huge ring buffers.

- Do not use atomic operations for a local bitmap variable.

- Update git links in MAINTAINERS.

----------------------------------------------------------------
Christophe JAILLET (1):
      vsprintf: Use non-atomic bitmap API when applicable

John Ogness (1):
      scripts/gdb: lx-dmesg: read records individually

Petr Mladek (8):
      printk/console: Split out code that enables default console
      printk/console: Rename has_preferred_console to need_default_console
      printk/console: Remove unnecessary need_default_console manipulation
      printk/console: Remove need_default_console variable
      printk/console: Clean up boot console handling in register_console()
      MAINTAINERS/vsprintf: Update link to printk git tree
      MAINTAIERS/printk: Add link to printk git
      Merge branch 'console-registration-cleanup' into for-linus

 MAINTAINERS                |   3 +-
 kernel/printk/printk.c     | 104 +++++++++++++++++++++++++--------------------
 lib/vsprintf.c             |   4 +-
 scripts/gdb/linux/dmesg.py |  35 +++++++--------
 4 files changed, 80 insertions(+), 66 deletions(-)
