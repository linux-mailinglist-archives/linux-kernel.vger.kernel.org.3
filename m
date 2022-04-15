Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630CD50274A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351722AbiDOJWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351705AbiDOJWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:22:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C521CFEF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:19:40 -0700 (PDT)
Message-ID: <20220415091921.072296632@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650014378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EAbcvD3w/Qe5XFk2KaNTjkMhsV3VfKHB6dq2gEtX3x0=;
        b=sWHaIiPVM3s8LDFAOnl+hV1E4oYspbf6r1Zum5/5haqyt+89+pvLXo6PP1uQiE8tSSQ3hl
        sV7a+/3ypOazj8dCXnYHv0hE1a6zQAQsHkiKQygNttOkLrACgTjg+Y/NSjBJmwtD7gvh4/
        nwj+V7MxvGE3WkkgR7THeUjLb8ugZQ/Vin+wZIz8tzvaZl/DMIt7X/9Y55aCI0/21X6VXZ
        u33xVZD/eisayrAHj8q7Zwriq+OzxFAk5XF+3eftO9zgpw7dWs92z3D5bvQ4jyqhlqpXBh
        mAR8UZhQ6Wz98BuWCHjCZRH5dqGcYhUADM0lFNIZ35vT8OPKSIuzqO+Qq7VwFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650014378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EAbcvD3w/Qe5XFk2KaNTjkMhsV3VfKHB6dq2gEtX3x0=;
        b=t4ilOYRan2rlKdrvnCSZOppW4U6oz9/xdDY4Qxoe+Wonpcj8fpxrq0JGk5MuL/L01+Wv15
        1iJ2ueBEkf0x6uBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [patch 3/3] timekeeping: Consolidate fast timekeeper
References: <20220415091223.187169221@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Apr 2022 11:19:38 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a inline function which replaces the copy & pasta.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -429,6 +429,14 @@ static void update_fast_timekeeper(const
 	memcpy(base + 1, base, sizeof(*base));
 }
 
+static __always_inline u64 fast_tk_get_delta_ns(struct tk_read_base *tkr)
+{
+	u64 delta, cycles = tk_clock_read(tkr);
+
+	delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
+	return timekeeping_delta_to_ns(tkr, delta);
+}
+
 static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
 {
 	struct tk_read_base *tkr;
@@ -439,12 +447,7 @@ static __always_inline u64 __ktime_get_f
 		seq = raw_read_seqcount_latch(&tkf->seq);
 		tkr = tkf->base + (seq & 0x01);
 		now = ktime_to_ns(tkr->base);
-
-		now += timekeeping_delta_to_ns(tkr,
-				clocksource_delta(
-					tk_clock_read(tkr),
-					tkr->cycle_last,
-					tkr->mask));
+		now += fast_tk_get_delta_ns(tkr);
 	} while (read_seqcount_latch_retry(&tkf->seq, seq));
 
 	return now;
@@ -560,10 +563,7 @@ static __always_inline u64 __ktime_get_r
 		tkr = tkf->base + (seq & 0x01);
 		basem = ktime_to_ns(tkr->base);
 		baser = ktime_to_ns(tkr->base_real);
-
-		delta = timekeeping_delta_to_ns(tkr,
-				clocksource_delta(tk_clock_read(tkr),
-				tkr->cycle_last, tkr->mask));
+		delta = fast_tk_get_delta_ns(tkr);
 	} while (read_seqcount_latch_retry(&tkf->seq, seq));
 
 	if (mono)

