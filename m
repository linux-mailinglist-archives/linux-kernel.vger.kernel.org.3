Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2585550AC8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbiFSNNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbiFSNMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:12:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF608218D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:12:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655644358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=A+mBiAbEUCjjF8Uxx7EzjgheEYh1PQiCV+hIgTkaoWg=;
        b=kj37sL5eIzO8CeHfSwwu98RfRN5cDDZRIvdPlaHEIpioDCCAc/4m+bDHaCRKXi0oIEpRfr
        7yg3gpoX/A06BkJNR6/+uz7KO92Kjkru9XetygkVKh51k0AdmVAhUeuAXeNg3pDXWHQFc+
        fQhLjKrzE6nPjvF/rrUAx9hB9Jeqrdq+8mu5vgmbPPkOu2BLYVX3maH+imv2W0CxLmf8F+
        Ae7JF6dQRkjJXQgHbxxR+Ah13Rf7DexA93RoZNEfneBWO2dq1UNaEtZqnYUp3TN0cEYPcJ
        ZG3hLKditXuNeuQf5u1bIx9FCu1XiMUPAT6px5IcOcx+IWubqn5kNZg2AKKQlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655644358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=A+mBiAbEUCjjF8Uxx7EzjgheEYh1PQiCV+hIgTkaoWg=;
        b=teI/Ubx3spftKd4/j1xEGM9kQMp6TUs+3cl5yyFCrUmUffyld4o669NlIfLJkkAN4uk4UE
        f6Gjp9AjmiljJVAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for 5.19-rc3
References: <165564429738.1413209.17302088152547038708.tglx@xen13>
Message-ID: <165564430177.1413209.17080752287209695297.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 19 Jun 2022 15:12:38 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-202=
2-06-19

up to:  04193d590b39: sched: Fix balance_push() vs __sched_setscheduler()


A single scheduler fix plugging a race between sched_setscheduler() and
balance_push(). sched_setscheduler() spliced the balance callbacks accross
a lock break which makes an interleaving schedule() observe an empty list.


Thanks,

	tglx

------------------>
Peter Zijlstra (1):
      sched: Fix balance_push() vs __sched_setscheduler()


 kernel/sched/core.c  | 36 +++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h |  5 +++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bfa7452ca92e..da0bf6fe9ecd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4798,25 +4798,55 @@ static void do_balance_callbacks(struct rq *rq, struc=
t callback_head *head)
=20
 static void balance_push(struct rq *rq);
=20
+/*
+ * balance_push_callback is a right abuse of the callback interface and plays
+ * by significantly different rules.
+ *
+ * Where the normal balance_callback's purpose is to be ran in the same cont=
ext
+ * that queued it (only later, when it's safe to drop rq->lock again),
+ * balance_push_callback is specifically targeted at __schedule().
+ *
+ * This abuse is tolerated because it places all the unlikely/odd cases behi=
nd
+ * a single test, namely: rq->balance_callback =3D=3D NULL.
+ */
 struct callback_head balance_push_callback =3D {
 	.next =3D NULL,
 	.func =3D (void (*)(struct callback_head *))balance_push,
 };
=20
-static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+static inline struct callback_head *
+__splice_balance_callbacks(struct rq *rq, bool split)
 {
 	struct callback_head *head =3D rq->balance_callback;
=20
+	if (likely(!head))
+		return NULL;
+
 	lockdep_assert_rq_held(rq);
-	if (head)
+	/*
+	 * Must not take balance_push_callback off the list when
+	 * splice_balance_callbacks() and balance_callbacks() are not
+	 * in the same rq->lock section.
+	 *
+	 * In that case it would be possible for __schedule() to interleave
+	 * and observe the list empty.
+	 */
+	if (split && head =3D=3D &balance_push_callback)
+		head =3D NULL;
+	else
 		rq->balance_callback =3D NULL;
=20
 	return head;
 }
=20
+static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+{
+	return __splice_balance_callbacks(rq, true);
+}
+
 static void __balance_callbacks(struct rq *rq)
 {
-	do_balance_callbacks(rq, splice_balance_callbacks(rq));
+	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
 }
=20
 static inline void balance_callbacks(struct rq *rq, struct callback_head *he=
ad)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 01259611beb9..47b89a0fc6e5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1693,6 +1693,11 @@ queue_balance_callback(struct rq *rq,
 {
 	lockdep_assert_rq_held(rq);
=20
+	/*
+	 * Don't (re)queue an already queued item; nor queue anything when
+	 * balance_push() is active, see the comment with
+	 * balance_push_callback.
+	 */
 	if (unlikely(head->next || rq->balance_callback =3D=3D &balance_push_callba=
ck))
 		return;
=20

