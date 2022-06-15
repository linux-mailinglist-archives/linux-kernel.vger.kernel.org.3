Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE32554CEA0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353973AbiFOQ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355472AbiFOQ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:28:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886CA2937D;
        Wed, 15 Jun 2022 09:28:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DCE5D1F974;
        Wed, 15 Jun 2022 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655310515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qF2II44HGvEm6Nwb6+bY89tJcKcCfhBYiXA23CUhE9A=;
        b=Mc9FS+6ZM/YmeCGoMDktOoyjyZOxslB0f+1cgRXGiepN3pj9tDATJtodgPVpHepDNmb4Wf
        HH66JpL6qhv/nDT26/pRSN9iiV79Vp7NFq2IzwEIKbkNWBHFQWYTqBnoOt/J/MgPj9AMBt
        iyXW+4o5QAvdwWmurgClqgGpBVbTBAI=
Received: from alley.suse.cz (unknown [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id 747E22C141;
        Wed, 15 Jun 2022 16:28:35 +0000 (UTC)
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
Subject: [PATCH 1/2] printk: Block console kthreads when direct printing will be required
Date:   Wed, 15 Jun 2022 18:28:04 +0200
Message-Id: <20220615162805.27962-2-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220615162805.27962-1-pmladek@suse.com>
References: <20220615162805.27962-1-pmladek@suse.com>
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

There are known situations when the console kthreads are not
reliable or does not work in principle, for example, early boot,
panic, shutdown.

For these situations there is the direct (legacy) mode when printk() tries
to get console_lock() and flush the messages directly. It works very well
during the early boot when the console kthreads are not available at all.
It gets more complicated in the other situations when console kthreads
might be actively printing and block console_trylock() in printk().

The same problem is in the legacy code as well. Any console_lock()
owner could block console_trylock() in printk(). It is solved by
a trick that the current console_lock() owner is responsible for
printing all pending messages. It is actually the reason why there
is the risk of softlockups and why the console kthreads were
introduced.

The console kthreads use the same approach. They are responsible
for printing the messages by definition. So that they handle
the messages anytime when they are awake and see new ones.
The global console_lock is available when there is nothing
to do.

It should work well when the problematic context is correctly
detected and printk() switches to the direct mode. But it seems
that it is not enough in practice. There are reports that
the messages are not printed during panic() or shutdown()
even though printk() tries to use the direct mode here.

The problem seems to be that console kthreads become active in these
situation as well. They steel the job before other CPUs are stopped.
Then they are stopped in the middle of the job and block the global
console_lock.

First part of the solution is to block console kthreads when
the system is in a problematic state and requires the direct
printk() mode.

BugLink: https://lore.kernel.org/r/20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1
BugLink: https://lore.kernel.org/r/CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com
Suggested-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ea3dd55709e7..45c6c2b0b104 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3729,7 +3729,9 @@ static bool printer_should_wake(struct console *con, u64 seq)
 		return true;
 
 	if (con->blocked ||
-	    console_kthreads_atomically_blocked()) {
+	    console_kthreads_atomically_blocked() ||
+	    system_state > SYSTEM_RUNNING ||
+	    oops_in_progress) {
 		return false;
 	}
 
-- 
2.35.3

