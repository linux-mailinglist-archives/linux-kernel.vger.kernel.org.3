Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1561E516F3C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384871AbiEBMIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384862AbiEBMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:08:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BFA12AFA;
        Mon,  2 May 2022 05:04:35 -0700 (PDT)
Date:   Mon, 02 May 2022 12:04:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651493072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YATk2HB+C5fwK8D8cN/gu91IL0UXOJNedtSVFfvFfmc=;
        b=YQCTJtMuvi4kUrtZ2UK05zVIn76iqKAGULzgVzbMMb9f4mZevp2G/rGlo0akG0rfe/adKx
        D7KRdvpHhv+fR1wJ6Es7qpn2zsubI4quXlCH51uXwNL7Kfr0uF6EjjxQuw1BkTRInPgJuw
        GU+2u61TcxcUbVudlGYrlPybNUFjdExAGUaFDDnhg6pRaF1knISG1iClneiD6F3kDpAWJA
        49wtMLHCM9RLfLKxljNTzYbslV9ICtd/Xe5pEhZwG9cpCLDvjd3/RuTeuvuUMbvqkdQQfu
        2eI7LcK+EGBWWGX/X8n79keOzGGvbeK0INQStxQiYBhGUSP8TA31W1mg+VRdEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651493072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YATk2HB+C5fwK8D8cN/gu91IL0UXOJNedtSVFfvFfmc=;
        b=k3U2UU3Bwkbkv86MYlSSzwaHDvwhYTosOjA5Ouj//sgD95ZeVOaSCNUBnwzeA+lVKu01Cz
        eT/acSOuNU5oYuDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Consolidate fast timekeeper
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415091921.072296632@linutronix.de>
References: <20220415091921.072296632@linutronix.de>
MIME-Version: 1.0
Message-ID: <165149307143.4207.5088655039432642801.tip-bot2@tip-bot2>
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

Commit-ID:     90be8d6c1f91e1e5121c219726524c91b52bfc20
Gitweb:        https://git.kernel.org/tip/90be8d6c1f91e1e5121c219726524c91b52bfc20
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Apr 2022 11:19:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 02 May 2022 14:00:20 +02:00

timekeeping: Consolidate fast timekeeper

Provide a inline function which replaces the copy & pasta.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220415091921.072296632@linutronix.de

---
 kernel/time/timekeeping.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 3479804..8895ff2 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -429,6 +429,14 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
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
@@ -439,12 +447,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
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
@@ -560,10 +563,7 @@ static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
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
