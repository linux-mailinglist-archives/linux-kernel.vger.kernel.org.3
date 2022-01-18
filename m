Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C8F492495
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239943AbiARLS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:18:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239854AbiARLSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:18:11 -0500
Date:   Tue, 18 Jan 2022 11:18:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642504690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bk/9twIBlVgr/UmrtZdDPQtXp5zaM6nzEXilX/lUysA=;
        b=JNPmiNtq5IEzGnwkBusuzeZuFCf7obaBiqwGaDOAzIm59BMSsz4xCTdJ1ATV0QCV2JS/gR
        4KeFEeqMShjr3+QpawHUXSt4258iCw/8qIdZXoneU7wBBzg5lwvIUVDZXUW99qr5eXh4XE
        G3Ln1+tH+mQW3e/cJ6GYPvP2GtmnF8EYsXt7hWpkRwzFJfVAPSjyoL5XAz+PhuoHGWk5oP
        ccRi4/txs6zsXnmMLUZf2jn3/GSjIUUObEkp9t9CklgM5uX7wTp6hniIt3tUpwqY0ezbn5
        08/knmLR8ISP6wfzDNg0XJKa9rb288HB+KYkWom2cUsGYaTmyyRylRFaaNKjbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642504690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bk/9twIBlVgr/UmrtZdDPQtXp5zaM6nzEXilX/lUysA=;
        b=31hGylwayp3rduEJfmdQZg1Hs5o9gkqq/H7zb4ZaCaciloulld2l1eiSRW+FbgNCiHFkJ9
        P3+HGST00lE/NIDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Avoid double preemption in __cond_resched_*lock*()
Cc:     xuhaifeng <xuhaifeng@oppo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YcGnvDEYBwOiV0cR@hirez.programming.kicks-ass.net>
References: <YcGnvDEYBwOiV0cR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164250468946.16921.3796443718413078010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     7e406d1ff39b8ee574036418a5043c86723170cf
Gitweb:        https://git.kernel.org/tip/7e406d1ff39b8ee574036418a5043c86723170cf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 25 Dec 2021 01:04:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Jan 2022 12:09:59 +01:00

sched: Avoid double preemption in __cond_resched_*lock*()

For PREEMPT/DYNAMIC_PREEMPT the *_unlock() will already trigger a
preemption, no point in then calling preempt_schedule_common()
*again*.

Use _cond_resched() instead, since this is a NOP for the preemptible
configs while it provide a preemption point for the others.

Reported-by: xuhaifeng <xuhaifeng@oppo.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YcGnvDEYBwOiV0cR@hirez.programming.kicks-ass.net
---
 kernel/sched/core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d2ab2a..56b428c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8218,9 +8218,7 @@ int __cond_resched_lock(spinlock_t *lock)
 
 	if (spin_needbreak(lock) || resched) {
 		spin_unlock(lock);
-		if (resched)
-			preempt_schedule_common();
-		else
+		if (!_cond_resched())
 			cpu_relax();
 		ret = 1;
 		spin_lock(lock);
@@ -8238,9 +8236,7 @@ int __cond_resched_rwlock_read(rwlock_t *lock)
 
 	if (rwlock_needbreak(lock) || resched) {
 		read_unlock(lock);
-		if (resched)
-			preempt_schedule_common();
-		else
+		if (!_cond_resched())
 			cpu_relax();
 		ret = 1;
 		read_lock(lock);
@@ -8258,9 +8254,7 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
 
 	if (rwlock_needbreak(lock) || resched) {
 		write_unlock(lock);
-		if (resched)
-			preempt_schedule_common();
-		else
+		if (!_cond_resched())
 			cpu_relax();
 		ret = 1;
 		write_lock(lock);
