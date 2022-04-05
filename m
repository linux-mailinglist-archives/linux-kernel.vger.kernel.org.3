Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCE04F2FC7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 14:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346055AbiDEKmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241195AbiDEIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6061707C;
        Tue,  5 Apr 2022 01:29:22 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5uCs7UENJtSoAUyE+dqZLYGf6l4slWoZDuxdKMo52E=;
        b=JRjfzcFlUoFZZGkU8is1r9XXTk9IhNaiZC0opudsuTKbhpFMn/HzhilKR1mHHVTSC6qRPd
        qYPh/GrNnF6yElLSP8EhXpiwisRL1sA7zGXwFh4Vs4uir8lxf5wBJrI+iEr6p/ECdhZFgt
        z4SRL0qKJaOVXuq72qHC+NndJGMrRJRqpjk2N2xN7r85uLGmG2nzSb9iwukAbakTVPWA1N
        OcxXV74b7e/LVP8UmDD+k3O/5H14fIeFItkQ90TRhdP/1KhbAP4c1/gIypUgEngw5UOV7C
        Sjm1tv72HmuvKO+8V+mDxgh+e9MRMJvsihWg95odmnJNfYBGz1dGmj/gfvsVLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5uCs7UENJtSoAUyE+dqZLYGf6l4slWoZDuxdKMo52E=;
        b=Gy/z4LFcD2b8I+Q7AsCYEtIj8fOgLLPMK6LzdbStw38Q1KDqT58wrZ7FEr87kD/XvWPe7G
        dyDezNv0xAoMu6Bg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] ftrace: Use preemption model accessors for trace
 header printout
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211112185203.280040-5-valentin.schneider@arm.com>
References: <20211112185203.280040-5-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <164914735969.389.308359767987530418.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     089c02ae2771a14af2928c59c56abfb9b885a8d7
Gitweb:        https://git.kernel.org/tip/089c02ae2771a14af2928c59c56abfb9b885a8d7
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Fri, 12 Nov 2021 18:52:03 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:42 +02:00

ftrace: Use preemption model accessors for trace header printout

Per PREEMPT_DYNAMIC, checking CONFIG_PREEMPT doesn't tell you the actual
preemption model of the live kernel. Use the newly-introduced accessors
instead.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20211112185203.280040-5-valentin.schneider@arm.com
---
 kernel/trace/trace.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f4de111..124f189 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4289,17 +4289,11 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 		   entries,
 		   total,
 		   buf->cpu,
-#if defined(CONFIG_PREEMPT_NONE)
-		   "server",
-#elif defined(CONFIG_PREEMPT_VOLUNTARY)
-		   "desktop",
-#elif defined(CONFIG_PREEMPT)
-		   "preempt",
-#elif defined(CONFIG_PREEMPT_RT)
-		   "preempt_rt",
-#else
+		   preempt_model_none()      ? "server" :
+		   preempt_model_voluntary() ? "desktop" :
+		   preempt_model_full()      ? "preempt" :
+		   preempt_model_rt()        ? "preempt_rt" :
 		   "unknown",
-#endif
 		   /* These are reserved for later use */
 		   0, 0, 0, 0);
 #ifdef CONFIG_SMP
