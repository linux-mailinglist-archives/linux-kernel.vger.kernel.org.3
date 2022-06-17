Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD91A54FA07
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382810AbiFQPSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382588AbiFQPSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:18:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8623D20BDB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:18:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2D62921C24;
        Fri, 17 Jun 2022 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655479084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=rIuqjHFmC+w6nfNOwP4JflZgc1+ZlZz9xW15jPNBpZw=;
        b=ChVBhRxNj+HYybXR2zGqDGZC507KYxHqlTCKlpDNAXa9q78C/ZPLjQOScESbeB8VtdQGTJ
        xwckAhe2kH4U4zD3Sa1TkR/iU92+KZDDh8ieOHLgW56URdCh088E5OxVRQ1GywxRjQOyes
        3Z9IXE/W93fDzfwXGO/u3XEw3vHZe6o=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B16EE2C141;
        Fri, 17 Jun 2022 15:18:03 +0000 (UTC)
Date:   Fri, 17 Jun 2022 17:18:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk fixups for 5.19-rc3
Message-ID: <YqybK+kFriV9yeIx@alley>
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

please pull two printk fixups from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19-rc3

=============================

- Make the global console_sem available for CPU that is handling
  panic() or shutdown. It is an old problem when an existing
  console lock owner might block console output. It became
  more visible with the kthreads.

=============================

I am sorry for the late pull request. I wanted to give it at
least two days in linux-next.

----------------------------------------------------------------
Petr Mladek (3):
      printk: Block console kthreads when direct printing will be required
      printk: Wait for the global console lock when the system is going down
      Merge branch 'rework/kthreads' into for-linus

 include/linux/printk.h      |  5 +++++
 kernel/panic.c              |  2 ++
 kernel/printk/internal.h    |  2 ++
 kernel/printk/printk.c      |  8 +++++++-
 kernel/printk/printk_safe.c | 32 ++++++++++++++++++++++++++++++++
 kernel/reboot.c             |  2 ++
 6 files changed, 50 insertions(+), 1 deletion(-)
