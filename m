Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6694F32E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 15:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbiDEKTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241201AbiDEIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5153E11A3C;
        Tue,  5 Apr 2022 01:29:23 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLAn9GLraFUF0+Wziqpwl6DlJuaDd5JyMsXt0a6TOUU=;
        b=cguKSRAZKUVMmNDefWb3wIu0S8SqVj6IPTjWPL1RZRwkm2FKbXGK0SbqKxb/9EeTPSlgQr
        ZmywhMLSyvzN8X9lIxfNDTkITUkJGZpvfue/FcvWw0K5RsNTqrp7bAhaIPHt1eo8NHV8LE
        QHxkIQmclPIoHd6fQNLxLDQxeCP22d9M2KaFFsUL4EegR/BFnZ2/60kI78zw/XKPx4/zeX
        sfJSTg6BBlZ130Qo8Z71M1+dzzHVUGAD7HDeiUXCchZbLg0XpXzyKryn1R92UadEGZuFYU
        NLaiK6+HZ6rXJdGXwDLQOwLxLHcdnYaHTl3ik6BepTkRQJrIVc/rx51y+4Dw5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLAn9GLraFUF0+Wziqpwl6DlJuaDd5JyMsXt0a6TOUU=;
        b=4tV93tldwGS7gzj0I8Fa7BR+euyu+G5yX6w4jH9kw0wuFW/bG0ubsYMEdNsqnJDkChO1gz
        nJXUaBugRbOI50AA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] kcsan: Use preemption model accessors
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211112185203.280040-4-valentin.schneider@arm.com>
References: <20211112185203.280040-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <164914736082.389.472482358413646316.tip-bot2@tip-bot2>
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

Commit-ID:     5693fa74f98afed5421ac0165e9e9291bde7d9e1
Gitweb:        https://git.kernel.org/tip/5693fa74f98afed5421ac0165e9e9291bde7d9e1
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Fri, 12 Nov 2021 18:52:02 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:42 +02:00

kcsan: Use preemption model accessors

Per PREEMPT_DYNAMIC, checking CONFIG_PREEMPT doesn't tell you the actual
preemption model of the live kernel. Use the newly-introduced accessors
instead.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Marco Elver <elver@google.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20211112185203.280040-4-valentin.schneider@arm.com
---
 kernel/kcsan/kcsan_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index a36fca0..767dfac 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1380,13 +1380,14 @@ static const void *nthreads_gen_params(const void *prev, char *desc)
 	else
 		nthreads *= 2;
 
-	if (!IS_ENABLED(CONFIG_PREEMPT) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
+	if (!preempt_model_preemptible() ||
+	    !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
 		/*
 		 * Without any preemption, keep 2 CPUs free for other tasks, one
 		 * of which is the main test case function checking for
 		 * completion or failure.
 		 */
-		const long min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE) ? 2 : 0;
+		const long min_unused_cpus = preempt_model_none() ? 2 : 0;
 		const long min_required_cpus = 2 + min_unused_cpus;
 
 		if (num_online_cpus() < min_required_cpus) {
