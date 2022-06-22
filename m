Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BFC5554F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358356AbiFVTrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376536AbiFVTq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:46:29 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4C83FBF2;
        Wed, 22 Jun 2022 12:46:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7001A3AB52A;
        Wed, 22 Jun 2022 15:46:26 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NXZ1sSTyeDmO; Wed, 22 Jun 2022 15:46:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 03E303AB528;
        Wed, 22 Jun 2022 15:46:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 03E303AB528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1655927186;
        bh=REdjFWHkNgTslxzEt0v47qXrGBzea93HG4yuCFGNgQ4=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=r1UyxCjO9jMe4KmqPrfFcKcCO/CC55FitGeyLD9COovhVtGW+hKn6PCHR5EdSO7pB
         YP0qE+YUba3AkzHiHpbXvRVJUfY/GcZ61cGjUf1Hojp6fpp3za/C8QgsnwPOAjdghI
         Jrd3QwZSy1Tx/Q1Eu3eAW0dH6JfJy8XXSiDFfbPF5s5x2+UM9l/rJS5HU94O9twTvp
         iXc+ySPCU8UL2+ALERB+nyI3pMVBt/uArcmo6QqX+l0hcqtXonrOP0x9SxCsP8Gq7f
         99kPfkjIadGsFe/K9ZjqCgOp72kPdQ4X+3hdE4Bwobr9pRWPOk3aEencBcvgRlmDzA
         6ULfCE+I2SUiQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id us-ZVGYFXR8W; Wed, 22 Jun 2022 15:46:25 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id A24A23AB522;
        Wed, 22 Jun 2022 15:46:25 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Peter Oskolkov <posk@posk.io>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 1/2] rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_* flags
Date:   Wed, 22 Jun 2022 15:46:16 -0400
Message-Id: <20220622194617.1155957-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
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

The pretty much unused RSEQ_CS_FLAG_NO_RESTART_ON_* flags introduce
complexity in rseq, and are subtly buggy [1]. Solving those issues
requires introducing additional complexity in the rseq implementation
for each supported architecture.

Considering that it complexifies the rseq ABI, I am proposing that we
deprecate those flags. [2]

So far there appears to be consensus from maintainers of user-space
projects impacted by this feature that its removal would be a welcome
simplification. [3]

The deprecation approach proposed here is to issue WARN_ON_ONCE() when
encountering those flags and kill the offending process with sigsegv.
This should allow us to quickly identify whether anyone yells at us for
removing this.

Link: https://lore.kernel.org/lkml/20220618182515.95831-1-minhquangbui99@=
gmail.com/ [1]
Link: https://lore.kernel.org/lkml/258546133.12151.1655739550814.JavaMail=
.zimbra@efficios.com/ [2]
Link: https://lore.kernel.org/lkml/87pmj1enjh.fsf@email.froward.int.ebied=
erm.org/ [3]
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/rseq.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 97ac20b4f738..81d7dc80787b 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -18,8 +18,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/rseq.h>
=20
-#define RSEQ_CS_PREEMPT_MIGRATE_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRAT=
E | \
-				       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)
+#define RSEQ_CS_NO_RESTART_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT | \
+				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
+				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
=20
 /*
  *
@@ -175,23 +176,15 @@ static int rseq_need_restart(struct task_struct *t,=
 u32 cs_flags)
 	u32 flags, event_mask;
 	int ret;
=20
+	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS))
+		return -EINVAL;
+
 	/* Get thread flags. */
 	ret =3D get_user(flags, &t->rseq->flags);
 	if (ret)
 		return ret;
=20
-	/* Take critical section flags into account. */
-	flags |=3D cs_flags;
-
-	/*
-	 * Restart on signal can only be inhibited when restart on
-	 * preempt and restart on migrate are inhibited too. Otherwise,
-	 * a preempted signal handler could fail to restart the prior
-	 * execution context on sigreturn.
-	 */
-	if (unlikely((flags & RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL) &&
-		     (flags & RSEQ_CS_PREEMPT_MIGRATE_FLAGS) !=3D
-		     RSEQ_CS_PREEMPT_MIGRATE_FLAGS))
+	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS))
 		return -EINVAL;
=20
 	/*
@@ -203,7 +196,7 @@ static int rseq_need_restart(struct task_struct *t, u=
32 cs_flags)
 	t->rseq_event_mask =3D 0;
 	preempt_enable();
=20
-	return !!(event_mask & ~flags);
+	return !!event_mask;
 }
=20
 static int clear_rseq_cs(struct task_struct *t)
--=20
2.30.2

