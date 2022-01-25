Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBDA49B79D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349259AbiAYP3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:29:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50162 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245413AbiAYP1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:27:06 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643124421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xPl6JJmaxFMiMF1HCiC/9kPvONkq8tgAsmevFg4jzY=;
        b=iVdADx/xPjvAQGiDep5yk3M0GtKam0QpkJOF+cPo0VKvQoISkzoHagUSU74m7xt4GbZO64
        8dHmy5Sf2ScJDgSLbB+DX9c1bbfUGg6Yf+0peMgk8xnsRFjFrXrQguesBC3tgrCpQPEhGY
        O4tZNAcZqe4TMpFCS/hVDyO3124Em6DCBKVvqyQ4uMSat3vH9sOZ6pTWyASI1IItTNh2Ya
        HnzTyhVls1ZPs2gDBKlNuWuX+dNLY2Mu+67j1Ll5VyVmqcR3vkZQ9YAIJgIlLGNjEgoOeq
        fAn2EXm1+Etl8EHs9sxCoGytaEZ3zZXmZOxXg1Rsm0uDszEYYtmyTb05G3qm3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643124421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xPl6JJmaxFMiMF1HCiC/9kPvONkq8tgAsmevFg4jzY=;
        b=Ha/zzR85LuJA1nsKu3bh/UKX5GfnHRbj7uPJ6fYxNZv6dZoWppUB1t5SYEWJOSgBPxhm6V
        U4RNFtKaHZUPpVBg==
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
Subject: [PATCH 8/8] kernel/fork: Use IS_ENABLED() in account_kernel_stack().
Date:   Tue, 25 Jan 2022 16:26:52 +0100
Message-Id: <20220125152652.1963111-9-bigeasy@linutronix.de>
In-Reply-To: <20220125152652.1963111-1-bigeasy@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not strickly needed but checking CONFIG_VMAP_STACK instead of
task_stack_vm_area()' result allows the compiler the remove the else
path in the CONFIG_VMAP_STACK case where the pointer can't be NULL.

Check for CONFIG_VMAP_STACK in order to use the proper path.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index f48f666582b09..92cafad00c653 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -468,16 +468,16 @@ void vm_area_free(struct vm_area_struct *vma)
=20
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
-	void *stack =3D task_stack_page(tsk);
-	struct vm_struct *vm =3D task_stack_vm_area(tsk);
-
-	if (vm) {
+	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
+		struct vm_struct *vm =3D task_stack_vm_area(tsk);
 		int i;
=20
 		for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
 			mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
 					      account * (PAGE_SIZE / 1024));
 	} else {
+		void *stack =3D task_stack_page(tsk);
+
 		/* All stack pages are in the same node. */
 		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
 				      account * (THREAD_SIZE / 1024));
--=20
2.34.1

