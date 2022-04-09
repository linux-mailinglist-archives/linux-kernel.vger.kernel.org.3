Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2754FAAB6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiDIUYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiDIUYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:24:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF37263ED;
        Sat,  9 Apr 2022 13:22:34 -0700 (PDT)
Date:   Sat, 09 Apr 2022 20:22:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649535753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTzvCHEYDUlqnK+ZbcSe8Sk4SDcgMjxKlr8pEKOKhy8=;
        b=RgkxMX49qLQkhC4Ie8L6RezwXtOLmo5Fh3K8fCoir1TwlGc3z5prmB5dB4hVBd1xfbHySd
        hD2317GMT8hNy5PU7IFg5HSKsVQ300FraRU3zPl1qYVolnxuaVZC1YxYJ86Jh6VoSmIDL6
        giRqk5aw8NCObFUtll1hqHQi3q2dJoaW+aAuuTxzeCKeGnwD/spQFTK4x/4t4XM6+IICyj
        mm80qbkPPLpxmY5NlmtuT5ypF1oElyanp3HLic+1d6vN+rjewDmuiGsZY8412Z8LA0onZZ
        wDCpvLTIMZR/igc/bqFUfXrVeFVVTSS55zMQWdo6WI8pWFa8MOtBnYP3Zzx2Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649535753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTzvCHEYDUlqnK+ZbcSe8Sk4SDcgMjxKlr8pEKOKhy8=;
        b=YSdAjyFHXO73s10cQKfW+g7H36AC57wSstLSdeoH28mXeUB9nGgzXKwZzm+XE7E5Ma1rD2
        LTnPTVsm2VMLdHBw==
From:   "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Initialize base::next_expiry_recalc in
 timers_prepare_cpu()
Cc:     "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405191732.7438-2-anna-maria@linutronix.de>
References: <20220405191732.7438-2-anna-maria@linutronix.de>
MIME-Version: 1.0
Message-ID: <164953575207.4207.15972758061168040795.tip-bot2@tip-bot2>
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

Commit-ID:     2731aa7d65dbb31c6dad14347c37d522bb3bc7c6
Gitweb:        https://git.kernel.org/tip/2731aa7d65dbb31c6dad14347c37d522bb3bc7c6
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 05 Apr 2022 21:17:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 09 Apr 2022 22:19:39 +02:00

timers: Initialize base::next_expiry_recalc in timers_prepare_cpu()

When base::next_expiry_recalc is not initialized to false during cpu
bringup in HOTPLUG_CPU and is accidently true and no timer is queued in the
meantime, the loop through the wheel to find __next_timer_interrupt() might
be done for nothing.

Therefore initialize base::next_expiry_recalc to false in
timers_prepare_cpu().

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20220405191732.7438-2-anna-maria@linutronix.de

---
 kernel/time/timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9dd2a39..204d6cd 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1953,6 +1953,7 @@ int timers_prepare_cpu(unsigned int cpu)
 		base = per_cpu_ptr(&timer_bases[b], cpu);
 		base->clk = jiffies;
 		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
+		base->next_expiry_recalc = false;
 		base->timers_pending = false;
 		base->is_idle = false;
 	}
