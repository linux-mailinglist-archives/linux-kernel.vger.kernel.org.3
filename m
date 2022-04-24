Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196CD50D189
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbiDXLuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 07:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239343AbiDXLuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 07:50:22 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87CDD1344F6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 04:47:21 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BF91792009D; Sun, 24 Apr 2022 13:47:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B7C5792009B;
        Sun, 24 Apr 2022 12:47:20 +0100 (BST)
Date:   Sun, 24 Apr 2022 12:47:20 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@kernel.org>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sched_clock: Round the frequency reported to nearest
 rather than down
In-Reply-To: <alpine.DEB.2.21.2204211556270.9383@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204240055590.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2204211556270.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently round the frequency reported for clock sources down, which 
gives misleading figures, e.g.:

I/O ASIC clock frequency 24999480Hz
clocksource: dec-ioasic: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76452008078 ns
sched_clock: 32 bits at 24MHz, resolution 40ns, wraps every 85901132779ns
MIPS counter frequency 59998512Hz
clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 31855130776 ns
sched_clock: 32 bits at 59MHz, resolution 16ns, wraps every 35792281591ns

Rounding to nearest seems more adequate:

I/O ASIC clock frequency 24999664Hz
clocksource: dec-ioasic: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76451445358 ns
sched_clock: 32 bits at 25MHz, resolution 40ns, wraps every 85900499947ns
MIPS counter frequency 59999728Hz
clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 31854485176 ns
sched_clock: 32 bits at 60MHz, resolution 16ns, wraps every 35791556599ns

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 112f38a4a316 ("ARM: sched_clock: provide common infrastructure for sched_clock()")
---
 kernel/time/sched_clock.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

linux-sched-clock-rate-round.diff
Index: linux-macro/kernel/time/sched_clock.c
===================================================================
--- linux-macro.orig/kernel/time/sched_clock.c
+++ linux-macro/kernel/time/sched_clock.c
@@ -8,6 +8,7 @@
 #include <linux/jiffies.h>
 #include <linux/ktime.h>
 #include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
@@ -199,11 +200,11 @@ sched_clock_register(u64 (*read)(void),
 
 	r = rate;
 	if (r >= 4000000) {
-		r /= 1000000;
+		r = DIV_ROUND_CLOSEST(r, 1000000);
 		r_unit = 'M';
 	} else {
 		if (r >= 1000) {
-			r /= 1000;
+			r = DIV_ROUND_CLOSEST(r, 1000);
 			r_unit = 'k';
 		} else {
 			r_unit = ' ';
