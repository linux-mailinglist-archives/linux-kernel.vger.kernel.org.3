Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ABE4B9D19
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbiBQKYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:24:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbiBQKY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:24:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71499279087;
        Thu, 17 Feb 2022 02:24:12 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645093451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cvc7OKGjIgjSJRVBHrDCTpoYiTTVf4ZQnsLwC8HQM0=;
        b=CMMLLs9kVHZMiydXabuSbbrrQdMQxrIVEqiadZfw83BkIVxJGRnGW8h5gkWrgG83UJkeUZ
        o/F0AMivQaN5bHDviR5jTIHOHQqSLTV6gkxaWQ9RaPWIB9JWZYVgR2HrC3NxzqOs0FJAIO
        ulzfIndoIkX8Q7coVLQCqm8cDk4xyaWiz+TU3qEUBkMIJyk7oDDccboAWTyuMgOZxeTxZp
        zozloP/LDl4EqYi7z0x5OMctOqJ/2aiVMemE7Cwp/gsenihfjmx1RmRkyFAhza/DUFCmns
        gBaJdVGKuvg/2m9RvJ3D2nFcB6OGfL9G9usQ30qT71Gd8B0rivt6/J3rrO7WhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645093451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cvc7OKGjIgjSJRVBHrDCTpoYiTTVf4ZQnsLwC8HQM0=;
        b=RtZ/Qg7YlYC5hILg38EdaNn2FAmOMrgZz3c1+VAh7suz2PdyJGeCsmvEipZP7TioeqwXS5
        p/6xFzumIKIjneBw==
To:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/8] kernel/fork: Duplicate task_struct before stack allocation.
Date:   Thu, 17 Feb 2022 11:24:00 +0100
Message-Id: <20220217102406.3697941-3-bigeasy@linutronix.de>
In-Reply-To: <20220217102406.3697941-1-bigeasy@linutronix.de>
References: <20220217102406.3697941-1-bigeasy@linutronix.de>
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

alloc_thread_stack_node() already populates the task_struct::stack
member except on IA64. The stack pointer is saved and populated again
because IA64 needs it and arch_dup_task_struct() overwrites it.

Allocate thread's stack after task_struct has been duplicated as a
preparation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index f63c0af6002da..c47dcba5d66d2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -888,6 +888,10 @@ static struct task_struct *dup_task_struct(struct task=
_struct *orig, int node)
 	if (!tsk)
 		return NULL;
=20
+	err =3D arch_dup_task_struct(tsk, orig);
+	if (err)
+		goto free_tsk;
+
 	stack =3D alloc_thread_stack_node(tsk, node);
 	if (!stack)
 		goto free_tsk;
@@ -897,8 +901,6 @@ static struct task_struct *dup_task_struct(struct task_=
struct *orig, int node)
=20
 	stack_vm_area =3D task_stack_vm_area(tsk);
=20
-	err =3D arch_dup_task_struct(tsk, orig);
-
 	/*
 	 * arch_dup_task_struct() clobbers the stack-related fields.  Make
 	 * sure they're properly initialized before using any stack-related
@@ -912,9 +914,6 @@ static struct task_struct *dup_task_struct(struct task_=
struct *orig, int node)
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
=20
-	if (err)
-		goto free_stack;
-
 	err =3D scs_prepare(tsk, node);
 	if (err)
 		goto free_stack;
--=20
2.34.1

