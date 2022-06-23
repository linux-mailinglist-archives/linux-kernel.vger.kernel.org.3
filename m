Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D593557E45
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiFWOw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiFWOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:52:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24194832C;
        Thu, 23 Jun 2022 07:52:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8E6DF21AC0;
        Thu, 23 Jun 2022 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655995922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2gzzB9tWoC3eNj6y+QzCcTzE3FCX4WAk6WctZpnJe/s=;
        b=XBVbUbvwWJuO7d6ybQ35HQmWh1FQdfL77bd+28PNsOZP9dfHTOqyo01V+mEcOgwSb7MRln
        KT2r2h+fMjXQ2REI/XMCNG83/TNk2MjmRZGWZvAzbbcSsYJFKl0i6sWbIIehckHq4v4fQN
        XeR1kgTGWt7AnBQGSy8irTFHKgZnlU8=
Received: from alley.suse.cz (unknown [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id 93D7C2C142;
        Thu, 23 Jun 2022 14:52:01 +0000 (UTC)
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
Subject: [PATCH 2/6] Revert "printk: Block console kthreads when direct printing will be required"
Date:   Thu, 23 Jun 2022 16:51:53 +0200
Message-Id: <20220623145157.21938-3-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220623145157.21938-1-pmladek@suse.com>
References: <20220623145157.21938-1-pmladek@suse.com>
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

This reverts commit c3230283e2819a69dad2cf7a63143fde8bab8b5c.

The testing of 5.19 release candidates revealed missing synchronization
between early and regular console functionality.

It would be possible to start the console kthreads later as a workaround.
But it is clear that console lock serialized console drivers between
each other. It opens a big area of possible problems that were not
considered by people involved in the development and review.

printk() is crucial for debugging kernel issues and console output is
very important part of it. The number of consoles is huge and a proper
review would take some time. As a result it need to be reverted for 5.19.

Link: https://lore.kernel.org/r/YrBdjVwBOVgLfHyb@alley
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 45c6c2b0b104..ea3dd55709e7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3729,9 +3729,7 @@ static bool printer_should_wake(struct console *con, u64 seq)
 		return true;
 
 	if (con->blocked ||
-	    console_kthreads_atomically_blocked() ||
-	    system_state > SYSTEM_RUNNING ||
-	    oops_in_progress) {
+	    console_kthreads_atomically_blocked()) {
 		return false;
 	}
 
-- 
2.35.3

