Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401764D2434
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350734AbiCHW00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350612AbiCHW0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:26:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD6C583BA;
        Tue,  8 Mar 2022 14:25:22 -0800 (PST)
Date:   Tue, 08 Mar 2022 22:25:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646778321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgIg+RGNbAl6ezULiF4qZGaZ/BoWG95mXozz/hgGITc=;
        b=vK1qmd1FiF1f6egJVVEmoP3IHG8dEOyEYBwzi2e0dJ32enG4Gwr2NFn1Z3kyADWkD3ByO+
        JI8vkvtIENKpzi7ShegiJW3FSN1Z7Bj643wdmOfJfnE69ysrvVZ06YhWXKRUk+2bwOqDXG
        HTgAjKh3+EdE1Tm+mRRS6rhYXGVmQH2+/kCJLUtiR3F6VqBGaFAufPc5kgEKO9hTSMALdg
        8k/WV12dtWkawSvPcTqapnXUIwFD7QtBDLRWFiuaU4cg3s3+ZrnxXG5kAtUURosDac9E3s
        K4QGkwwPgvLKd8Vto0F4BFndFGXKgMp5JlA7lHuuL4Ici2zuc+1DoD92N1J7/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646778321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgIg+RGNbAl6ezULiF4qZGaZ/BoWG95mXozz/hgGITc=;
        b=yJnV+nGFWAqRTxcPN4TxrUOav4poxFLyeM4s2CTMuBd3P0km+bR0REeNmJqLFehjDcqFpa
        jmcRMsCKuHk9vMCA==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline,rt: Remove unused functions for !CONFIG_SMP
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220302183433.333029-6-dietmar.eggemann@arm.com>
References: <20220302183433.333029-6-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <164677832057.16921.7741887633414790955.tip-bot2@tip-bot2>
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

Commit-ID:     71d29747b0e26f36a50e6a65dc0191ca742b9222
Gitweb:        https://git.kernel.org/tip/71d29747b0e26f36a50e6a65dc0191ca742b9222
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Wed, 02 Mar 2022 19:34:32 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 16:08:39 +01:00

sched/deadline,rt: Remove unused functions for !CONFIG_SMP

The need_pull_[rt|dl]_task() and pull_[rt|dl]_task() functions are not
used on a !CONFIG_SMP system. Remove them.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20220302183433.333029-6-dietmar.eggemann@arm.com
---
 kernel/sched/deadline.c |  9 ---------
 kernel/sched/rt.c       | 11 -----------
 2 files changed, 20 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3242dd4..93fcef5 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -723,15 +723,6 @@ void dec_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
 }
 
-static inline bool need_pull_dl_task(struct rq *rq, struct task_struct *prev)
-{
-	return false;
-}
-
-static inline void pull_dl_task(struct rq *rq)
-{
-}
-
 static inline void deadline_queue_push_tasks(struct rq *rq)
 {
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 14f273c..b62e765 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -271,8 +271,6 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 
 #ifdef CONFIG_SMP
 
-static void pull_rt_task(struct rq *this_rq);
-
 static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
 {
 	/* Try to pull RT tasks here if we lower this rq's prio */
@@ -429,15 +427,6 @@ void dec_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 {
 }
 
-static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
-{
-	return false;
-}
-
-static inline void pull_rt_task(struct rq *this_rq)
-{
-}
-
 static inline void rt_queue_push_tasks(struct rq *rq)
 {
 }
