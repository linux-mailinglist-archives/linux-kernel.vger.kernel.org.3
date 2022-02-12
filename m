Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B824B3884
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 00:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiBLXKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 18:10:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiBLXKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 18:10:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC033CFDC
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 15:10:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1631BB80761
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 23:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A13C340E7;
        Sat, 12 Feb 2022 23:10:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="W17lDIFh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644707443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdvfLAsU9/N/fGr1+dI8JJUEnNk2YhAvefoKc6v2QBA=;
        b=W17lDIFhH01yOWrK4Dzoflfhyyvd8ODbztfT5/XLSDIc3+VbwO3HCfLFucR9A6g/2hOnbm
        xuTPD8ycrPhrfjpaWwdT0v9QGA4WxVPcoQedtK1td9SIbeED7cDJkRGgF8T+h0ZyJ4dF65
        Ks1hdVsYYVuTt+rWd1rTS7jFK509s8A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ffce0cd2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 12 Feb 2022 23:10:43 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 3/3] random: use trylock in irq handler rather than spinning
Date:   Sun, 13 Feb 2022 00:10:22 +0100
Message-Id: <20220212231022.679926-4-Jason@zx2c4.com>
In-Reply-To: <20220212231022.679926-1-Jason@zx2c4.com>
References: <20220212231022.679926-1-Jason@zx2c4.com>
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

crng_pre_init_inject() (and prior crng_fast_load()) uses a trylock when
in fast mode, so that it never contends. We should be doing the same
when grabbing a spinlock for mixing into the entropy pool. So switch to
doing that before calling the underscored _mix_pool_bytes().

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 9a8e1bb9845d..ca224c3f2561 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1286,13 +1286,10 @@ void add_interrupt_randomness(int irq)
 			atomic_set(&fast_pool->count, 0);
 			fast_pool->last = now;
 
-			/*
-			 * Technically this call means that we're using a spinlock_t
-			 * in the IRQ handler, which isn't terrific for PREEMPT_RT.
-			 * However, this only happens during boot, and then never
-			 * again, so we live with it.
-			 */
-			mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
+			if (spin_trylock(&input_pool.lock)) {
+				_mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
+				spin_unlock(&input_pool.lock);
+			}
 		}
 		return;
 	}
-- 
2.35.0

