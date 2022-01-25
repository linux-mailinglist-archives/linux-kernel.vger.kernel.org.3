Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCCB49B7A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350231AbiAYPcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:32:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50052 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344538AbiAYP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:27:13 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643124418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cvc7OKGjIgjSJRVBHrDCTpoYiTTVf4ZQnsLwC8HQM0=;
        b=cfNnQT+O9ZYB37rXp1YHw/ZDlCwnxpZA01rjZQII13JWorJlD13W/DXlaAA4JqYcom/S86
        +eu/K6z2004cDk5gokX8gOATLH61yQDmZztKlVs3yaKQgUuctE9UdUNl3OTXmxs64wWC3x
        ILyC2Xs6nQSXbn7GU1RGbxSjq1W9o2M1dNVY+VRyHj7q7EVm8LuNJuJ/TPZMHgxFOKbN5C
        A9WXCRp4vDaKL8i/p97cQbW/uZIMnlix5kcf/RG1yoEVVvtevj4PcnwtqjKnLEaQnJD62D
        JN909QPQPswVtoFXTf5MAFqTT9xVPaA5LvJudSdcG2ejN6xARqeX4+DBA69DRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643124418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cvc7OKGjIgjSJRVBHrDCTpoYiTTVf4ZQnsLwC8HQM0=;
        b=VB3qlt8kBnb1OwNvf/uc0Kai2qRSd9He894kVw0tgnaKy9M7UlG9chLd6MEB8KrtJB9Plr
        8BpXchFMJlpXESCg==
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
Subject: [PATCH 2/8] kernel/fork: Duplicate task_struct before stack allocation.
Date:   Tue, 25 Jan 2022 16:26:46 +0100
Message-Id: <20220125152652.1963111-3-bigeasy@linutronix.de>
In-Reply-To: <20220125152652.1963111-1-bigeasy@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

