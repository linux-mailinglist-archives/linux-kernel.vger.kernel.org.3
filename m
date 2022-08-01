Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431BE586BEA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiHANZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiHANZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:25:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8FB6159;
        Mon,  1 Aug 2022 06:25:41 -0700 (PDT)
Date:   Mon, 01 Aug 2022 13:25:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659360340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89+GN4tvYaXWzLnoWQk8SgCig5h3O2fWdKef/JpooCc=;
        b=W7IiaIxE38TrsFuNlxbA7vQ/CQ/UmpxC3tCJCKN04mrbfM4JMk1fyqSEM4K9tP8mX9PVBe
        U5CrWFyqRREFR0rDEF7BjbE9Qjfxw3FDJk7xFQ5pfVWLDn8aJnKj0QrTEXmQGjd3s1gddD
        uzFK1oZSqa36T5oJVXeeDI4VnscUK448Ef15fgdNi/sIHBlqiMAVET72biPok5csBHfmy+
        1bF6APf+8eDeSQP+78JilTO7IkAL+jx4sWTBV/l8MpsJhTPJKzHZcRQoOiSpY6cDJl0sY2
        1iSywEtkfZUvfMD0/0Y9dFVK2ONoPuFBF2kmc9363p62ckcOsEuHcl5OIQAgGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659360340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89+GN4tvYaXWzLnoWQk8SgCig5h3O2fWdKef/JpooCc=;
        b=D5HGMT7Oqh+9CXnGf/dnOFz0nmG36P80fj2iblZqtIEJDkTiDXHPru6tYmSmnuke8ul1Rj
        CeuLnkvAul4jVgDg==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Kill process when unknown flags are
 encountered in ABI structures
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220622194617.1155957-2-mathieu.desnoyers@efficios.com>
References: <20220622194617.1155957-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <165936033805.15455.17306563207808386039.tip-bot2@tip-bot2>
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

Commit-ID:     c17a6ff9321355487d7d5ccaa7d406a0ea06b6c4
Gitweb:        https://git.kernel.org/tip/c17a6ff9321355487d7d5ccaa7d406a0ea06b6c4
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Wed, 22 Jun 2022 15:46:17 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 01 Aug 2022 15:21:42 +02:00

rseq: Kill process when unknown flags are encountered in ABI structures

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20220622194617.1155957-2-mathieu.desnoyers@efficios.com
---
 kernel/rseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 81d7dc8..bda8175 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -176,7 +176,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 	u32 flags, event_mask;
 	int ret;
 
-	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS))
+	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS) || cs_flags)
 		return -EINVAL;
 
 	/* Get thread flags. */
@@ -184,7 +184,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 	if (ret)
 		return ret;
 
-	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS))
+	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS) || flags)
 		return -EINVAL;
 
 	/*
