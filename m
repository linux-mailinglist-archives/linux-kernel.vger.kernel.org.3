Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D587450B507
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446586AbiDVKau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446545AbiDVKai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:30:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7113454BF3;
        Fri, 22 Apr 2022 03:27:44 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:27:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623263;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ys/0N4EPkERPEVQYAUsEp2DEfjpFkxrd5BfrrdOAlj4=;
        b=FNf1qYeod4KbwDEdcpgiW4KmR/vbt6Q6ncs0ULPFZJ02+TT8nDY4YRqs4BqXNMd0Z5RMCU
        2Fr6BlAVmuZtLk1Elri1fwmhEtuT4SZuUmeyYgSk7h9Sqafa/Mlaq17fQdc3bVy37ImlLG
        jZh9mqtiysiqnVJjpsvHq0y78zvaRycg15QNzV0jaLSm0dHPHhGQnLfHv2fNTszQDkBxqo
        4ko7Z7VSUvll+2eGv/xaG+kyBsa10lFZxmU1R6xtfSMZQIDn1Sb88hAIWdRwv1b8QMniWg
        89BNXKoePmY01LN/ChMkbZk6iRgeegPhsS8BjkKDjGcLUhw/5DsK6HfgdXUWqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623263;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ys/0N4EPkERPEVQYAUsEp2DEfjpFkxrd5BfrrdOAlj4=;
        b=iEDNq5geI05d1SMHaVSrlyuKRZdev/J1sJgCesx5kGv8IL4BfVRhz7dYmm92lv0Fre+qu1
        LdoGZtnCKcdbxRBQ==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Delete useless condition in tg_unthrottle_up()
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220408115309.81603-2-zhouchengming@bytedance.com>
References: <20220408115309.81603-2-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <165062326204.4207.16036597032362236478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0a00a354644ee1800d31c47cf5927b9b50272fac
Gitweb:        https://git.kernel.org/tip/0a00a354644ee1800d31c47cf5927b9b50272fac
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Fri, 08 Apr 2022 19:53:09 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:14:07 +02:00

sched/fair: Delete useless condition in tg_unthrottle_up()

We have tested cfs_rq->load.weight in cfs_rq_is_decayed(),
the first condition "!cfs_rq_is_decayed(cfs_rq)" is enough
to cover the second condition "cfs_rq->nr_running".

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ben Segall <bsegall@google.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20220408115309.81603-2-zhouchengming@bytedance.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f74b340..3eba0dc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4850,7 +4850,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 					     cfs_rq->throttled_clock_pelt;
 
 		/* Add cfs_rq with load or one or more already running entities to the list */
-		if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
+		if (!cfs_rq_is_decayed(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
