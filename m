Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB59F54CE9D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355764AbiFOQ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349398AbiFOQ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:28:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDA42937D;
        Wed, 15 Jun 2022 09:28:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BD86D21A47;
        Wed, 15 Jun 2022 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655310509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DXpHoMVOTbJZvwmLuZ1ddHOOFHEz9OlFs7FNkZTzEKY=;
        b=MNOtK2KQaTbGI8cC0CayNNC/my3nY+Z7+F6lFyz6nHZTumVwPU+czy3QgFFMXKFbc74gA/
        23CMB39X8ncXoGNk/XFCmAfCqAVHVAKPYb5uTbeNzq4GjXYgYKGceRrcA6WcsgbRgwuMp8
        i7NRTaMLeZfQp1D0Vu902soE+5mQqGo=
Received: from alley.suse.cz (unknown [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id C84B12C141;
        Wed, 15 Jun 2022 16:28:27 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, frederic@kernel.org,
        Peter Geis <pgwipeout@gmail.com>, zhouzhouyi@gmail.com,
        dave@stgolabs.net, josh@joshtriplett.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rcu@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/2] printk: Prevent printk kthreads from blocking direct console handling
Date:   Wed, 15 Jun 2022 18:28:03 +0200
Message-Id: <20220615162805.27962-1-pmladek@suse.com>
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

There are reports that console kthreads prevented printing
messages during panic() or shutdown(), see
BugLink: https://lore.kernel.org/r/20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1
BugLink: https://lore.kernel.org/r/CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com

In both situations, printk() correctly tries to flush the consoles
directly but it fails to get the global console_lock(). Both
problems went away with these patches:

1st patch blocks console kthreads so that they do not start
handling new messages when the direct printing is preferred
by the system state. It is probably enough on its own. It
solves the problem when the kthreads actively did
the wrong thing.

2nd patch allows to wait for the console kthreads to release
the lock in any context. It should make it more reliable.
It would have been useful even for the legacy code.

More possible improvements:

  +  the waiting might be necessary also in the suspend code paths

  + convert con->mutex to con->spinlock to avoid blocking
    the global console_lock() when sleeping with con->lock

  + at least disable preemption around console_emit_next_record()
    in console kthread to avoid sleeping in the console driver
    code

  + somehow change the priority of the kthread so that it gets
    scheduled immediately when the scheduler works

Petr Mladek (2):
  printk: Block console kthreads when direct printing will be required
  printk: Wait for the global console lock when the system is going down

 include/linux/printk.h      |  5 +++++
 kernel/panic.c              |  2 ++
 kernel/printk/internal.h    |  2 ++
 kernel/printk/printk.c      |  8 +++++++-
 kernel/printk/printk_safe.c | 32 ++++++++++++++++++++++++++++++++
 kernel/reboot.c             |  2 ++
 6 files changed, 50 insertions(+), 1 deletion(-)

-- 
2.35.3

