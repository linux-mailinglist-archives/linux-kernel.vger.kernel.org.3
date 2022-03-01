Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1274C8EF3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiCAPZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiCAPZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:25:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA878A6EA;
        Tue,  1 Mar 2022 07:24:41 -0800 (PST)
Date:   Tue, 01 Mar 2022 15:24:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646148279;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+C4zxahFpofeKdmB8B2bK0pDakASv/HEHs6T0IquZC4=;
        b=LMu9Fk+4IA2154VMKVieYwSdp6oo+JVXwFU+C+WUIgJfpvrPHs3pKW50xyjrime4oVZEl/
        cB4hzWoyy7+pYEmRg1dzJ5/AxCiuzpk/3z/NEj5vUfrmu5NCB9EJOLsTuOCOMgmMRBEVjc
        GIqBvTd7+sHPrTq4rqgvBBAOgajpPuBI8OqgL0jeQXo7mTWSZRBkY5NiXfFLE0ZsG1TVaF
        T2jcF9AQctwfRqx1P1WzyObKAPYHpbr4o2H1Ol6qw4BcilDry+f3Pw+yYU6wkSIVAhJBZQ
        ae9Cf9gVWJJdq4ND7AnAzNruA0hBh+IXk9QxX9tz4QB//L0Pot5grzn3rz9UZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646148279;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+C4zxahFpofeKdmB8B2bK0pDakASv/HEHs6T0IquZC4=;
        b=6ryV83fU8Y/zRiErNYfaATMXaGk9v88bYluYyDkkB65/EAb1ZOdYufjUNd5rAaTNshxTtK
        utumibyRqXp+l4CQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/tracing: Report TASK_RTLOCK_WAIT tasks as
 TASK_UNINTERRUPTIBLE
Cc:     u.kleine-koenig@pengutronix.de,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220120162520.570782-3-valentin.schneider@arm.com>
References: <20220120162520.570782-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <164614827854.16921.2637635769821476298.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

Commit-ID:     25795ef6299f07ce3838f3253a9cb34f64efcfae
Gitweb:        https://git.kernel.org/tip/25795ef6299f07ce3838f3253a9cb34f64e=
fcfae
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Thu, 20 Jan 2022 16:25:20=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Mar 2022 16:18:39 +01:00

sched/tracing: Report TASK_RTLOCK_WAIT tasks as TASK_UNINTERRUPTIBLE

TASK_RTLOCK_WAIT currently isn't part of TASK_REPORT, thus a task blocking
on an rtlock will appear as having a task state =3D=3D 0, IOW TASK_RUNNING.

The actual state is saved in p->saved_state, but reading it after reading
p->__state has a few issues:
o that could still be TASK_RUNNING in the case of e.g. rt_spin_lock
o ttwu_state_match() might have changed that to TASK_RUNNING

As pointed out by Eric, adding TASK_RTLOCK_WAIT to TASK_REPORT implies
exposing a new state to userspace tools which way not know what to do with
them. The only information that needs to be conveyed here is that a task is
waiting on an rt_mutex, which matches TASK_UNINTERRUPTIBLE - there's no
need for a new state.

Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20220120162520.570782-3-valentin.schneider@ar=
m.com
---
 include/linux/sched.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 457c8a0..78b606c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1630,6 +1630,14 @@ static inline unsigned int __task_state_index(unsigned=
 int tsk_state,
 	if (tsk_state =3D=3D TASK_IDLE)
 		state =3D TASK_REPORT_IDLE;
=20
+	/*
+	 * We're lying here, but rather than expose a completely new task state
+	 * to userspace, we can make this appear as if the task has gone through
+	 * a regular rt_mutex_lock() call.
+	 */
+	if (tsk_state =3D=3D TASK_RTLOCK_WAIT)
+		state =3D TASK_UNINTERRUPTIBLE;
+
 	return fls(state);
 }
=20
