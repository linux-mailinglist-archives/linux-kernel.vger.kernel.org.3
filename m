Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E59B5554F2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376409AbiFVTrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376550AbiFVTqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:46:34 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDED3FD9C;
        Wed, 22 Jun 2022 12:46:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C6C443AB802;
        Wed, 22 Jun 2022 15:46:29 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id m-jy1RtUmQVv; Wed, 22 Jun 2022 15:46:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8C0B73AB36A;
        Wed, 22 Jun 2022 15:46:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8C0B73AB36A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1655927189;
        bh=TcQ14VO8gGnhK+1+KLJBgnTqON0UY5FC/xRWU4kIMH0=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=gJHu2MmSqaAMhjO6HKJCbXeZ07MHwLkQowshbIqSnmkP4RpLCvImgWLC7oMv8K6IQ
         I7jnjJnEZagtd3DN/1JFgeaUbv1/fryjfss+2oaZ5b7+jcX//tQiCtzycLQbe4s7lw
         DJOtwhBZzS87Z0Q69eqwoyQQZ4ev26No+9HtO/qrbr7W3ZxpQmP/C5OGt51r+kAoOh
         BokpAJmCwI4T5T4kNVY/fKnS7Qi/9gQrhnszplVp+3JAXiqxI9DPUQmwHHs1YBlxUm
         z3qum0Qvx3umK99f90MMj6oOtDg3jU5NmiKX/1Qb9N0p48bM2w0DFKPxQdpEjFHRH4
         N5RLfnfAER4CQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KdzmRRtccORe; Wed, 22 Jun 2022 15:46:29 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 4936E3AB698;
        Wed, 22 Jun 2022 15:46:29 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Peter Oskolkov <posk@posk.io>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 2/2] rseq: Kill process when unknown flags are encountered in ABI structures
Date:   Wed, 22 Jun 2022 15:46:17 -0400
Message-Id: <20220622194617.1155957-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220622194617.1155957-1-mathieu.desnoyers@efficios.com>
References: <20220622194617.1155957-1-mathieu.desnoyers@efficios.com>
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

rseq_abi()->flags and rseq_abi()->rseq_cs->flags 29 upper bits are
currently unused.

The current behavior when those bits are set is to ignore them. This is
not an ideal behavior, because when future features will start using
those flags, if user-space fails to correctly validate that the kernel
indeed supports those flags (e.g. with a new sys_rseq flags bit) before
using them, it may incorrectly assume that the kernel will handle those
flags way when in fact those will be silently ignored on older kernels.

Validating that unused flags bits are cleared will allow a smoother
transition when those flags will start to be used by allowing
applications to fail early, and obviously, when they attempt to use the
new flags on an older kernel that does not support them.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/rseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 81d7dc80787b..bda8175f8f99 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -176,7 +176,7 @@ static int rseq_need_restart(struct task_struct *t, u=
32 cs_flags)
 	u32 flags, event_mask;
 	int ret;
=20
-	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS))
+	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS) || cs_flags)
 		return -EINVAL;
=20
 	/* Get thread flags. */
@@ -184,7 +184,7 @@ static int rseq_need_restart(struct task_struct *t, u=
32 cs_flags)
 	if (ret)
 		return ret;
=20
-	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS))
+	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS) || flags)
 		return -EINVAL;
=20
 	/*
--=20
2.30.2

