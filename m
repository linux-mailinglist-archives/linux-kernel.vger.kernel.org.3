Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EA6516F99
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385051AbiEBMfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385034AbiEBMfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:35:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901D012A94;
        Mon,  2 May 2022 05:31:37 -0700 (PDT)
Date:   Mon, 02 May 2022 12:31:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651494696;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/r4Cr4LIbct+QmoLMEDKJK9N84oHAeuGCRsDKpfLa4=;
        b=wmIBmj5/NmsyAiy4G03UEEKkVhke5koL9VlVEDxlqpZ3kQ0KoSi9IwtrVJ4CxbbSqi9U7z
        oFv2mzHfCZSmfheNQk4wnl+4nTsikNgTW/zuBV2g91UK4M4gbjjMNAzS7q1r+ZUv/Pfws8
        7PMufNmgDCZZGFG4sR6YYZFT8PXBZA0DnZYpTcpT3glwgB2ytGHiFf03SH1Ryg4RT9YTQp
        m4t0FqDU7jkGqR6Mz/l/UwMR83slg4u3TovEhZZlAj+a9vRDf2C5amyV61yohh/+W812Cv
        4pdKY/Il0qXONM2/IM3WnLszoWp2hilBW4mq1aOHagbT3fIweJJ7FsJygGsgYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651494696;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/r4Cr4LIbct+QmoLMEDKJK9N84oHAeuGCRsDKpfLa4=;
        b=7FCP9M6OTc6fnS3HsvhXQicxOOZif520lggPMa8d3BxxCRd7S53G/tEWmkdI2zIiWG1tWh
        ZEREP3gd81uZ1pCg==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/sched_clock: Round the frequency reported to
 nearest rather than down
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2204240055590.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2204240055590.9383@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <165149469466.4207.13955503601048091435.tip-bot2@tip-bot2>
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

Commit-ID:     92067440f1311dfa4d77b57a9da6b3706f5da32e
Gitweb:        https://git.kernel.org/tip/92067440f1311dfa4d77b57a9da6b3706f5da32e
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Sun, 24 Apr 2022 12:47:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 02 May 2022 14:29:04 +02:00

time/sched_clock: Round the frequency reported to nearest rather than down

The frequency reported for clock sources are rounded down, which gives
misleading figures, e.g.:

 I/O ASIC clock frequency 24999480Hz
 sched_clock: 32 bits at 24MHz, resolution 40ns, wraps every 85901132779ns
 MIPS counter frequency 59998512Hz
 sched_clock: 32 bits at 59MHz, resolution 16ns, wraps every 35792281591ns

Rounding to nearest is more adequate:

 I/O ASIC clock frequency 24999664Hz
 sched_clock: 32 bits at 25MHz, resolution 40ns, wraps every 85900499947ns
 MIPS counter frequency 59999728Hz
 sched_clock: 32 bits at 60MHz, resolution 16ns, wraps every 35791556599ns

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2204240055590.9383@angie.orcam.me.uk

---
 kernel/time/sched_clock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index b1b9b12..ee07f3a 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -8,6 +8,7 @@
 #include <linux/jiffies.h>
 #include <linux/ktime.h>
 #include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
@@ -199,11 +200,11 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 
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
