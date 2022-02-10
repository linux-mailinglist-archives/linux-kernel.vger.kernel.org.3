Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67E94B1213
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243551AbiBJPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:50:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243765AbiBJPua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:50:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7E5BAF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:50:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7F3BB825F5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DA3C004E1;
        Thu, 10 Feb 2022 15:50:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l0XwdyNm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644508228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SrmOgRgCaKtuegs/zNMknyUNQ4MANgwqqGhERaYqVE4=;
        b=l0XwdyNm7+Cgcs4yuMG3uvY18HHyqO8hLPdLj1oIkva4XGRSqb0KdIEgrL1IdyfhOmWOAF
        byq+SI97D14baqMZYlEq1VHOFdVua04BMoBqc16iEwrj8z/xIaNapxrZfUFuGVQWL6nnDn
        EbaJpqPCeHNhSlioBNGHNeb3UnrSsLs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bdb71592 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Feb 2022 15:50:27 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 1/3] random: remove ifdef'd out interrupt bench
Date:   Thu, 10 Feb 2022 16:50:10 +0100
Message-Id: <20220210155012.136485-2-Jason@zx2c4.com>
In-Reply-To: <20220210155012.136485-1-Jason@zx2c4.com>
References: <20220210155012.136485-1-Jason@zx2c4.com>
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
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 57d36f13e3a6..cf535596d1bc 100644
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
@@ -806,27 +804,6 @@ EXPORT_SYMBOL_GPL(add_input_randomness);
 
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
@@ -885,7 +862,6 @@ void add_interrupt_randomness(int irq)
 		(sizeof(ip) > 4) ? ip >> 32 : get_reg(fast_pool, regs);
 
 	fast_mix(fast_pool);
-	add_interrupt_bench(cycles);
 	new_count = ++fast_pool->count;
 
 	if (unlikely(crng_init == 0)) {
@@ -1595,22 +1571,6 @@ static struct ctl_table random_table[] = {
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
2.35.0

