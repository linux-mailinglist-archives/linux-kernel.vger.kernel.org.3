Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C0E5589FE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiFWUXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWUXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:23:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F684527EA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:23:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 326961F390;
        Thu, 23 Jun 2022 20:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656015826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=wlCVyssV36O+AxHHl0EJRZceHte52CXCv1KuJI7gCgM=;
        b=ukvqcfLLcncgGQglAvnHRugMpgXWEgNn6fOT7NoLLT3smql9JvPOQir+ncTpQ029ET8E67
        icqpyr1Y+TAZJ5+GB9BrCkYr7Gp6jouA62O8K8xMvgupZ/6VCb3fMLst+TcSQI+Lh/DpID
        S47xYgUXzzyXr9QjxGvFfaWw1Bak0oE=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7D9272C197;
        Thu, 23 Jun 2022 20:23:45 +0000 (UTC)
Date:   Thu, 23 Jun 2022 22:23:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk fixups for 5.19-rc4
Message-ID: <YrTLziUjfxDP/34M@alley>
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

please pull the revert of printk console kthreads from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19-rc4

We, printk maintainers, really appreciate that you gave us
the chance to try the console kthreads in 5.19 release candidates.
We expected some problems and were able so solve them. But
the missing synchronization between early and normal consoles
made us nervous. We would like to review all console drivers and
look for this kind of expectations that were provided by the original
code.

There are many console drivers and the review will take some time.
We do not want to risk bigger changes late in the release cycle
and problems in the released 5.19. We prefer to revert it now.

Thanks a lot for the chance and sorry for the troubles.
We have new material for improvements.

=========================================

- Revert printk console kthreads. The testing of 5.19 release candidates
  revealed issues that did not happen when all consoles were serialized
  using the console semaphore. More time is needed to check expectations
  of the existing console drivers and be confident that they can
  be safely used in parallel.

----------------------------------------------------------------
Petr Mladek (7):
      Revert "printk: Wait for the global console lock when the system is going down"
      Revert "printk: Block console kthreads when direct printing will be required"
      Revert "printk: remove @console_locked"
      Revert "printk: extend console_lock for per-console locking"
      Revert "printk: add kthread console printers"
      Revert "printk: add functions to prefer direct printing"
      Merge branch 'rework/kthreads' into for-linus

 drivers/tty/sysrq.c         |   2 -
 include/linux/console.h     |  17 --
 include/linux/printk.h      |  16 --
 kernel/hung_task.c          |  11 +-
 kernel/panic.c              |   6 -
 kernel/printk/internal.h    |   2 -
 kernel/printk/printk.c      | 593 +++++---------------------------------------
 kernel/printk/printk_safe.c |  32 ---
 kernel/rcu/tree_stall.h     |   2 -
 kernel/reboot.c             |  16 +-
 kernel/watchdog.c           |   4 -
 kernel/watchdog_hld.c       |   4 -
 12 files changed, 65 insertions(+), 640 deletions(-)
