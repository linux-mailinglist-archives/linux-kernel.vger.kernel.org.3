Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF3F4FBE1C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346838AbiDKODu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346807AbiDKODs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:03:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B251331DEC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:01:34 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649685692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4pUbC1Fgmyja0K+qhle5lJlFQ72155p8vUtXDOr8wxg=;
        b=MtCOhzm2Po/vG6ggnB8hGlZHMClmBevvlTUArvnw1ws4UoNHVfmplbwX/CJQ77dnv3XQaP
        v/EOkiMaxoKrK1AHzY2g+3zo9G9p7aLsECIL/OZI1PID1PAnOFOW3dwWc5tf4ImQSLGbJT
        B1+LeD15FON1KKBua++l8MvvFBL6qBs01upvV7JF3AxNvB0hLApLf4T8vblpd6XzL0zKBm
        nil1Q5aIN3EvbZKgQ0PYhrzmaI/JqX1kKYQVpdNUVInZWzAypNLzJfKaXZTS/OoqFX435b
        l04BzdxI3XauzmOl1bW1yY5ZUm1Q1tzmI55fyMNsTl2FE++hpPfRbu1T0jCNTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649685692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4pUbC1Fgmyja0K+qhle5lJlFQ72155p8vUtXDOr8wxg=;
        b=LQH1TZ3Px9Q6CfkpIGhfG3IPja/2bV+CmXQ3Sw/HEua30zjhhItuGlY+Z7jGvh8DOolJLW
        XoDLLezQJbYApFAw==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] tracing/timer: Add missing argument documentation of trace points
Date:   Mon, 11 Apr 2022 16:01:15 +0200
Message-Id: <20220411140115.24185-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation of trace points timer_start, timer_expire_entry and
hrtimer_start lack always the last argument. Add it to keep implementation
and documentation in sync.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/trace/events/timer.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 6ad031c71be7..2e713a7d9aa3 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -48,6 +48,7 @@ DEFINE_EVENT(timer_class, timer_init,
  * timer_start - called when the timer is started
  * @timer:	pointer to struct timer_list
  * @expires:	the timers expiry time
+ * @flags:	the timers flags
  */
 TRACE_EVENT(timer_start,
 
@@ -84,6 +85,7 @@ TRACE_EVENT(timer_start,
 /**
  * timer_expire_entry - called immediately before the timer callback
  * @timer:	pointer to struct timer_list
+ * @baseclk:	value of timer_base::clk when timer expires
  *
  * Allows to determine the timer latency.
  */
@@ -190,7 +192,8 @@ TRACE_EVENT(hrtimer_init,
 
 /**
  * hrtimer_start - called when the hrtimer is started
- * @hrtimer: pointer to struct hrtimer
+ * @hrtimer:	pointer to struct hrtimer
+ * @mode:	the hrtimers mode
  */
 TRACE_EVENT(hrtimer_start,
 
-- 
2.20.1

