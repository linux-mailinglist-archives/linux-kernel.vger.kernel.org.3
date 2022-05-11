Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFCD523DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347247AbiEKTsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347219AbiEKTrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:47:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC6A483B7;
        Wed, 11 May 2022 12:47:15 -0700 (PDT)
Date:   Wed, 11 May 2022 19:47:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652298434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9cErrf120Gs7NDjCU8OQgjMjOQVMHCeq5JBSf62u7gk=;
        b=kLJNOse5QMiSylPpNqFy8ico+grhVqmu+BuJxWVCmKCEIiwAxyGFXkBm03RN1WVaZorSQ8
        kLwLKhURhCcTW0Df7fvt+DcSq8OFYaKWm25CN3Iff7xiJZrmz1POdBMw26yEbVUAuyP/QK
        mFJVVbEKCbWN2mAPxFRWuWUZDqzjggDoOPDSuH+sFWXyU6UceYAc7svLYCo4BHtO6t7HDj
        nPUtLa/TmOr9S3VDLvZGHrayqbfp8JLZv2fKo6zJTesIDo3ge24nOse711TvsaH3aoa1oQ
        txLU7U/AA21vAhUu0QuecCZ0PUn/gs5SXq+Dch7A9muzqgkMdNmq5XQzIB1Vlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652298434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9cErrf120Gs7NDjCU8OQgjMjOQVMHCeq5JBSf62u7gk=;
        b=HbFwf4JWGVR3xddaWay/Hqa2sGSnWASIr3Tele1xo8LiK8hYzXwKdDp5MCDpqIIumzk00F
        5uWQ9RGuusEHbwAg==
From:   "tip-bot2 for Hao Jia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Remove superfluous rq clock update
 in push_dl_task()
Cc:     Hao Jia <jiahao.os@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220430085843.62939-3-jiahao.os@bytedance.com>
References: <20220430085843.62939-3-jiahao.os@bytedance.com>
MIME-Version: 1.0
Message-ID: <165229843321.4207.9114080870680211177.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     734387ec2f9d77b00276042b1fa7c95f48ee879d
Gitweb:        https://git.kernel.org/tip/734387ec2f9d77b00276042b1fa7c95f48ee879d
Author:        Hao Jia <jiahao.os@bytedance.com>
AuthorDate:    Sat, 30 Apr 2022 16:58:43 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 May 2022 16:27:12 +02:00

sched/deadline: Remove superfluous rq clock update in push_dl_task()

The change to call update_rq_clock() before activate_task()
commit 840d719604b0 ("sched/deadline: Update rq_clock of later_rq
when pushing a task") is no longer needed since commit f4904815f97a
("sched/deadline: Fix double accounting of rq/running bw in push & pull")
removed the add_running_bw() before the activate_task().

So we remove some comments that are no longer needed and update
rq clock in activate_task().

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lore.kernel.org/r/20220430085843.62939-3-jiahao.os@bytedance.com
---
 kernel/sched/deadline.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0ad2818..936817a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2318,13 +2318,7 @@ retry:
 
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, later_rq->cpu);
-
-	/*
-	 * Update the later_rq clock here, because the clock is used
-	 * by the cpufreq_update_util() inside __add_running_bw().
-	 */
-	update_rq_clock(later_rq);
-	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
+	activate_task(later_rq, next_task, 0);
 	ret = 1;
 
 	resched_curr(later_rq);
