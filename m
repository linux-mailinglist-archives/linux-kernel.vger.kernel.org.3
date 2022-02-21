Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1534BE4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348600AbiBUPpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:45:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379534AbiBUPpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:45:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5395D22BF8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:44:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D27E5B81223
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE832C340E9;
        Mon, 21 Feb 2022 15:44:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="L5eUZeh7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645458280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqnKR0BFpDKQNAT0nDTPG+o8dIz539BXbxHycmJ2vBA=;
        b=L5eUZeh7c1apK2tjqh7RRwwaMin/3abegip9J4peH5steLj0t2mQu/criG1ZEa9PQUAM1L
        cF9rLNHDzwInmxIMuCxGqMr4H8Ke3EPAjgUoKyR1Xg/ypaTAH7iQj/KKN7W1z6iJuYeISf
        IYH+iesWL4/vJp59WPc8J84/1SXx+qE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 24677fe8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 21 Feb 2022 15:44:40 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     ebiggers@kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v2] random: remove ifdef'd out interrupt bench
Date:   Mon, 21 Feb 2022 16:44:34 +0100
Message-Id: <20220221154434.2291742-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9pAf_ZJjkn4jqDwgwAMBxXjkAZb3BdznJi2AvSCAsSUaw@mail.gmail.com>
References: <CAHmME9pAf_ZJjkn4jqDwgwAMBxXjkAZb3BdznJi2AvSCAsSUaw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With tools like kbench9000 giving more finegrained responses, and this
basically never having been used ever since it was initially added,
let's just get rid of this. There *is* still work to be done on the
interrupt handler, but this really isn't the way it's being developed.

Cc: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
v2 updates kernel.rst.

 Documentation/admin-guide/sysctl/kernel.rst |  9 -----
 drivers/char/random.c                       | 40 ---------------------
 2 files changed, 49 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d3c6d9a501a9..5dd660aac0ae 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1041,15 +1041,6 @@ This is a directory, with the following entries:
   are woken up. This file is writable for compatibility purposes, but
   writing to it has no effect on any RNG behavior.
 
-If ``drivers/char/random.c`` is built with ``ADD_INTERRUPT_BENCH``
-defined, these additional entries are present:
-
-* ``add_interrupt_avg_cycles``: the average number of cycles between
-  interrupts used to feed the pool;
-
-* ``add_interrupt_avg_deviation``: the standard deviation seen on the
-  number of cycles between interrupts used to feed the pool.
-
 
 randomize_va_space
 ==================
diff --git a/drivers/char/random.c b/drivers/char/random.c
index c27ebf707380..35c440a0d83c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -240,8 +240,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/random.h>
 
-/* #define ADD_INTERRUPT_BENCH */
-
 enum {
 	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
 	POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
@@ -808,27 +806,6 @@ EXPORT_SYMBOL_GPL(add_input_randomness);
 
 static DEFINE_PER_CPU(struct fast_pool, irq_randomness);
 
-#ifdef ADD_INTERRUPT_BENCH
-static unsigned long avg_cycles, avg_deviation;
-
-#define AVG_SHIFT 8 /* Exponential average factor k=1/256 */
-#define FIXED_1_2 (1 << (AVG_SHIFT - 1))
-
-static void add_interrupt_bench(cycles_t start)
-{
-	long delta = random_get_entropy() - start;
-
-	/* Use a weighted moving average */
-	delta = delta - ((avg_cycles + FIXED_1_2) >> AVG_SHIFT);
-	avg_cycles += delta;
-	/* And average deviation */
-	delta = abs(delta) - ((avg_deviation + FIXED_1_2) >> AVG_SHIFT);
-	avg_deviation += delta;
-}
-#else
-#define add_interrupt_bench(x)
-#endif
-
 static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 {
 	u32 *ptr = (u32 *)regs;
@@ -865,7 +842,6 @@ void add_interrupt_randomness(int irq)
 		(sizeof(ip) > 4) ? ip >> 32 : get_reg(fast_pool, regs);
 
 	fast_mix(fast_pool);
-	add_interrupt_bench(cycles);
 
 	if (unlikely(crng_init == 0)) {
 		if (fast_pool->count >= 64 &&
@@ -1574,22 +1550,6 @@ static struct ctl_table random_table[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_do_uuid,
 	},
-#ifdef ADD_INTERRUPT_BENCH
-	{
-		.procname	= "add_interrupt_avg_cycles",
-		.data		= &avg_cycles,
-		.maxlen		= sizeof(avg_cycles),
-		.mode		= 0444,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "add_interrupt_avg_deviation",
-		.data		= &avg_deviation,
-		.maxlen		= sizeof(avg_deviation),
-		.mode		= 0444,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-#endif
 	{ }
 };
 
-- 
2.35.1

