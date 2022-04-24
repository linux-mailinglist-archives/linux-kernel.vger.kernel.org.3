Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B1A50D18D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 13:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiDXLuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 07:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbiDXLu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 07:50:27 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7D60135B0D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 04:47:26 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2BB3292009E; Sun, 24 Apr 2022 13:47:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 25EBA92009B;
        Sun, 24 Apr 2022 12:47:26 +0100 (BST)
Date:   Sun, 24 Apr 2022 12:47:26 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@kernel.org>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sched_clock: Use Hz as the unit for clock rate reporting
 below 4kHz
In-Reply-To: <alpine.DEB.2.21.2204211556270.9383@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204240106380.9383@angie.orcam.me.uk>
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

We have always used kHz as the unit for clock rates reported between 
1MHz (inclusive) and 4MHz (exclusive), e.g.:

riscv_timer_init_dt: Registering clocksource cpuid [0] hartid [1]
clocksource: riscv_clocksource: mask: 0xffffffffffffffff max_cycles: 0x1d854df40, max_idle_ns: 3526361616960 ns
sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps every 2199023255500ns

This reduces the amount of data lost due to rounding, but hasn't been 
replicated for the kHz range when support was added for proper reporting 
of sub-kHz clock rates.  Take the same approach then for rates between 
1kHz (inclusive) and 4kHz (exclusive), also for consistency.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 2f0778afac79 ("ARM: 7205/2: sched_clock: allow sched_clock to be selected at runtime")
---
Russell,

 Please correct me if I am wrong with my guess for the origin of the 4MHz 
boundary as there's no mention of it with your commit 112f38a4a316 ("ARM: 
sched_clock: provide common infrastructure for sched_clock()"), which is 
where this code has come from.

  Maciej
---
 kernel/time/sched_clock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-sched-clock-rate-4khz.diff
Index: linux-macro/kernel/time/sched_clock.c
===================================================================
--- linux-macro.orig/kernel/time/sched_clock.c
+++ linux-macro/kernel/time/sched_clock.c
@@ -203,7 +203,7 @@ sched_clock_register(u64 (*read)(void),
 		r = DIV_ROUND_CLOSEST(r, 1000000);
 		r_unit = 'M';
 	} else {
-		if (r >= 1000) {
+		if (r >= 4000) {
 			r = DIV_ROUND_CLOSEST(r, 1000);
 			r_unit = 'k';
 		} else {
