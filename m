Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD25512B87
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbiD1G3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243818AbiD1G2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:28:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60B374DE5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:24:53 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651127091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Us0ooCC+vQg6P64YAupdTNJDnfjI3fHewWA7ZNyTAlg=;
        b=cP/eRu8X8k7WJ4ICNDGClrZvd6U2gfBUIJHLMrhBVN/eQjrdmJYTTj8+3eJs5f+5ZISxf3
        h+J/7jQ9cFLk5ezfXqIwFi9R2mlUdDDjhNdAoiqA54ARUP/r2938ak2y6p8pAxdSBgr5GS
        Wz7rJlO3JW3St51V7SETfXXqWVXCaL+5blWccLq+/AiOf9Qp+W4k7kQQ/bNfxPLOJUwtaT
        2Qv54Ch5YIMCufrHuB2RYR3MiHKnfLe6492kgNf3AFs0NCHayDtfEi8vIiOFWXhy87ZWUf
        kUFMZkumKhAsSKqyFnoyKeRqr8RiOfedS3VX0VD89VsdIOP43X+nfyY/12N7cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651127091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Us0ooCC+vQg6P64YAupdTNJDnfjI3fHewWA7ZNyTAlg=;
        b=u6URXPCqG20dEeteH9FT+51ZGsfV1cCY05a5yB22Vc6yoFCk67b0Wsb+had0LJqDfWwivR
        TvB0YG3UdBJ8fKDg==
To:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] timekeeping: Mark mono fast time accessors as notrace
Date:   Thu, 28 Apr 2022 08:24:32 +0200
Message-Id: <20220428062432.61063-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the CLOCK_MONOTONIC fast time accessors as notrace. These functions are
used in tracing to retrieve timestamps.

Link: https://lore.kernel.org/r/20220426175338.3807ca4f@gandalf.local.home/
Fixes: 4498e7467e9e ("time: Parametrize all tk_fast_mono users")
Fixes: f09cb9a1808e ("time: Introduce tk_fast_raw")
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 kernel/time/timekeeping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 2c22023fbf5f..dddc37035215 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -482,7 +482,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
  * of the following timestamps. Callers need to be aware of that and
  * deal with it.
  */
-u64 ktime_get_mono_fast_ns(void)
+u64 notrace ktime_get_mono_fast_ns(void)
 {
 	return __ktime_get_fast_ns(&tk_fast_mono);
 }
@@ -494,7 +494,7 @@ EXPORT_SYMBOL_GPL(ktime_get_mono_fast_ns);
  * Contrary to ktime_get_mono_fast_ns() this is always correct because the
  * conversion factor is not affected by NTP/PTP correction.
  */
-u64 ktime_get_raw_fast_ns(void)
+u64 notrace ktime_get_raw_fast_ns(void)
 {
 	return __ktime_get_fast_ns(&tk_fast_raw);
 }
-- 
2.30.2

