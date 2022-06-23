Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D302C557E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiFWOwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiFWOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:52:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B4247AC5;
        Thu, 23 Jun 2022 07:52:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5B68621905;
        Thu, 23 Jun 2022 14:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655995920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uxU0hPXq49CJxI7UlQfc46Bp4k9dn5hDN7DK97QCwZ0=;
        b=mrQ7L/eHh0puHP36lIAwkc678zgDiclhM7sLpfn+Wb6a9F4rT+euTkMglAYJQYQfj/V4PO
        NbmkU00fMZNF/KLibynhvasRzYZ93gHRDjvjAk9sfsYyFFE06vuB6LjgtQpZhXfD5hPoKg
        19MPqnneyJtJQV8Ups3IelngGBILaCE=
Received: from alley.suse.cz (unknown [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id 0CE9E2C142;
        Thu, 23 Jun 2022 14:51:58 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Marco Elver <elver@google.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, dave@stgolabs.net,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        frederic@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] printk: Revert console kthreads for 5.19
Date:   Thu, 23 Jun 2022 16:51:51 +0200
Message-Id: <20220623145157.21938-1-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have had several discussions with the other printk developers and
together decided that we would like more time to investigate
the implicit expectations [1] of each and every console driver
because now we are concerned that there may be more hidden implicit
expectations. 

We much appreciate the chance to have this in 5.19 release candidates
because the wider user base helped us to get feedback from user cases
and architectures that we were not able to cover. And we see that
the patchset needs some more love.

We are sorry for the inconvenience and thanks a lot for the feedback
and help with debugging and testing.

This patchset reverts only the final patches adding the kthreads and
per-console. It keeps the refactoring of the console_unlock() code
that makes sense on its own.

[1] https://lore.kernel.org/all/YrBdjVwBOVgLfHyb@alley/

PS: I am going to prepare a proper pull request. I just wanted
    to send this in advance just in case anyone wants to comment
    on it.

Petr Mladek (6):
  Revert "printk: Wait for the global console lock when the system is
    going down"
  Revert "printk: Block console kthreads when direct printing will be
    required"
  Revert "printk: remove @console_locked"
  Revert "printk: extend console_lock for per-console locking"
  Revert "printk: add kthread console printers"
  Revert "printk: add functions to prefer direct printing"

 drivers/tty/sysrq.c         |   2 -
 include/linux/console.h     |  17 --
 include/linux/printk.h      |  16 -
 kernel/hung_task.c          |  11 +-
 kernel/panic.c              |   6 -
 kernel/printk/internal.h    |   2 -
 kernel/printk/printk.c      | 593 ++++--------------------------------
 kernel/printk/printk_safe.c |  32 --
 kernel/rcu/tree_stall.h     |   2 -
 kernel/reboot.c             |  16 +-
 kernel/watchdog.c           |   4 -
 kernel/watchdog_hld.c       |   4 -
 12 files changed, 65 insertions(+), 640 deletions(-)

-- 
2.35.3

