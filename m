Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99BF52DF91
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245275AbiESVuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiESVt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:49:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59407972BA;
        Thu, 19 May 2022 14:49:55 -0700 (PDT)
Date:   Thu, 19 May 2022 21:49:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652996992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hV2SaG1IK3wDUfs/GoFvzBuAP14waZ2g55indvNhtwk=;
        b=DgSoJBY2DsC/lG5hhFyAdVLBkTDxhm879Is5Q9ulbJEGYBwPBnv4fIEUu/GUDAJDIWh3Ne
        2QBdmIaBVMkzYIy/uJvhWkW0fB/nYavuOSIfTwxtN6wZwKJH/EgC53KADR9c0m5mA4x5Md
        jAsWN4jc4jAZI+5UHaTfmUeRQ3fXVvhCOO1/7YYTNIPg/Z1fgzUUufXYZfUJ47Rqu8B68Y
        3J51aLSfF4UhO/UcHgNrCHoIFWOUc8+4sj8zrHN5c1Ky5HqjuOETmY4g/0wAfYVN0OuBWx
        fxrhOxGOxHVyj7M3sd14SdvH6lIk5fHjZAgWGs4cJsI7QoBtbmipWi0Bk9s9kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652996992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hV2SaG1IK3wDUfs/GoFvzBuAP14waZ2g55indvNhtwk=;
        b=W10vRmFydBMlsHgGA3iFZQRmb0CdxonPKRRanrxxBgFWZmELraBbid5fu4M3rH+tjpdnVE
        XhvMfSpjCrnL4cAg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched/clock: Use try_cmpxchg64 in
 sched_clock_{local,remote}
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220518184953.3446778-1-ubizjak@gmail.com>
References: <20220518184953.3446778-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <165299699122.4207.8125991535807221103.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8491d1bdf5de152f27fc941e2dcdc4e66c950542
Gitweb:        https://git.kernel.org/tip/8491d1bdf5de152f27fc941e2dcdc4e66c950542
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 18 May 2022 20:49:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 May 2022 23:46:09 +02:00

sched/clock: Use try_cmpxchg64 in sched_clock_{local,remote}

Use try_cmpxchg64 instead of cmpxchg64 (*ptr, old, new) != old in
sched_clock_{local,remote}. x86 cmpxchg returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220518184953.3446778-1-ubizjak@gmail.com
---
 kernel/sched/clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index d9272d9..e374c0c 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -287,7 +287,7 @@ again:
 	clock = wrap_max(clock, min_clock);
 	clock = wrap_min(clock, max_clock);
 
-	if (cmpxchg64(&scd->clock, old_clock, clock) != old_clock)
+	if (!try_cmpxchg64(&scd->clock, &old_clock, clock))
 		goto again;
 
 	return clock;
@@ -349,7 +349,7 @@ again:
 		val = remote_clock;
 	}
 
-	if (cmpxchg64(ptr, old_val, val) != old_val)
+	if (!try_cmpxchg64(ptr, &old_val, val))
 		goto again;
 
 	return val;
