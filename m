Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D709535B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiE0IhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349745AbiE0IgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:36:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CF0FF5B2;
        Fri, 27 May 2022 01:36:04 -0700 (PDT)
Date:   Fri, 27 May 2022 08:36:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653640563;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiStZ62kTMetBTZYFuwPo3IHsjUKw8tDe9G2BGo6de4=;
        b=NGPBHrjRJCsYDalSl661x0rNVBKmt5zM6GmbBmQCZHMGpsX08hOJmH/Oyiew+/akhqqkA+
        PUpM/Pni/C3lom/qTRwZhxlUImoGgocB6zdTJBQqQWKyvkT35ZrMgfywxoG7eXEwu1EDOT
        AwBK1YFKnPaOSGCJ7PyhbRnkI3edtd9EWJb3G/0gL/VJUe1It0fX/aj6nZsNiHc2+lEjeN
        7fB5g5xkBkb5F4CtoJ/2rTxk4ykzuvS8iG7HZduGxUWT8v3J5bs23GPl0621+Z30vO0wEJ
        KmMXojgQpXsVM9Qn0UORYbNaGNDnOepGg4271/78kcLqkIftOijxfBomN0Uxzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653640563;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiStZ62kTMetBTZYFuwPo3IHsjUKw8tDe9G2BGo6de4=;
        b=g8ph4PbJVRnzgY3bC+0OTnrYrlMqKbhTRDslc8r9TDOq5AYWrmya1ICV3BpN4Ggb/Zp2fC
        aauyisZiqArR97CQ==
From:   "tip-bot2 for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/riscv: Events are stopped
 during CPU suspend
Cc:     Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220509012121.40031-1-samuel@sholland.org>
References: <20220509012121.40031-1-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165364056209.4207.17309950751359309277.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     232ccac1bd9b5bfe73895f527c08623e7fa0752d
Gitweb:        https://git.kernel.org/tip/232ccac1bd9b5bfe73895f527c08623e7fa0752d
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Sun, 08 May 2022 20:21:21 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 18 May 2022 11:08:52 +02:00

clocksource/drivers/riscv: Events are stopped during CPU suspend

Some implementations of the SBI time extension depend on hart-local
state (for example, CSRs) that are lost or hardware that is powered
down when a CPU is suspended. To be safe, the clockevents driver
cannot assume that timer IRQs will be received during CPU suspend.

Fixes: 62b019436814 ("clocksource: new RISC-V SBI timer driver")
Signed-off-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20220509012121.40031-1-samuel@sholland.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 1767f8b..593d5a9 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -34,7 +34,7 @@ static int riscv_clock_next_event(unsigned long delta,
 static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.name			= "riscv_timer_clockevent",
-	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
 	.rating			= 100,
 	.set_next_event		= riscv_clock_next_event,
 };
