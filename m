Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA3146DD9C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 22:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhLHVbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:31:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34618 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhLHVbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:31:05 -0500
Date:   Wed, 08 Dec 2021 21:27:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638998851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2EdNhkqeZy7zrOgK4I+WWbnwvgg/fzF/4SNYclDzNpg=;
        b=IVc3dyPw86CST+WyiSg2UMlEH+dk4KqblpMc6VpMuAyXJ7HmX6edjZdM1EON+2McV6c0d8
        XdOfWcQxtWbuNiaHGeT2kRT8Zge7IG9t/PWlU5zHtdW8OIkkSujOKL4w7d0JAy3wT7GHTa
        glMj50mE1rS7ydnBH2d3l06ZfAz7N3OywXdBDyoOy6GO4Yj0qdlmeZUPzqJ3pFCZZkiBv2
        ziCFYr04Le0lLYzxvJ78HKomI17p5o60D1jiqA7J+zo0nuER108A/ruG0nGQBBtEGOhAtU
        BeuwmP2gh+ARsb/mXv2wb6VwQWXXam9uS7MNuVf8qlKtKLk0FAfE6osBJDHAAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638998851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2EdNhkqeZy7zrOgK4I+WWbnwvgg/fzF/4SNYclDzNpg=;
        b=CpvVSOyb3lp6pR5FUrvz7Yuxuo+wqTbVYYNgbJ0OHI5KYKQ2AEg3dqh4JxmaqyNbA2urVh
        IaOfeDIdlmnIW/BQ==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Cleanup task_util and capacity type
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211207095755.859972-1-vincent.donnefort@arm.com>
References: <20211207095755.859972-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <163899885062.11128.998557913310932670.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ef8df9798d469b7c45c66664550e93469749f1e8
Gitweb:        https://git.kernel.org/tip/ef8df9798d469b7c45c66664550e93469749f1e8
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Tue, 07 Dec 2021 09:57:55 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Dec 2021 22:22:02 +01:00

sched/fair: Cleanup task_util and capacity type

task_util and capacity are comparable unsigned long values. There is no
need for an intermidiate implicit signed cast.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211207095755.859972-1-vincent.donnefort@arm.com
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f34f2f3..ac5e554 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4070,7 +4070,8 @@ done:
 	trace_sched_util_est_se_tp(&p->se);
 }
 
-static inline int task_fits_capacity(struct task_struct *p, long capacity)
+static inline int task_fits_capacity(struct task_struct *p,
+				     unsigned long capacity)
 {
 	return fits_capacity(uclamp_task_util(p), capacity);
 }
@@ -6345,7 +6346,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	return best_cpu;
 }
 
-static inline bool asym_fits_capacity(int task_util, int cpu)
+static inline bool asym_fits_capacity(unsigned long task_util, int cpu)
 {
 	if (static_branch_unlikely(&sched_asym_cpucapacity))
 		return fits_capacity(task_util, capacity_of(cpu));
