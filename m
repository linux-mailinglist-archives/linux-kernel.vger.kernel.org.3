Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F7A4C03DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiBVV1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiBVV1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:27:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AB68A30E;
        Tue, 22 Feb 2022 13:27:04 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:27:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645565223;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+VJ8ulndxSSdJqTNPIDLFDHjk0EkO8BYbPFXzYRGMg=;
        b=RiSjBm9/s6zD978tU/9TKrJdoWb77+Xu2ZebW73WEDf8rGjFTV0RwNoCZtp1NQhl9ZAyr7
        uARCE/yRW6EjvqXWiA4cn6G3Z/NiTQwXPy4wDWEgReynhJVg27yLUochxWO/c/cCxKZMKA
        eZpvrpmy+YhDJULI2GL22zPy7xpRnhlVaNgABpMhae+/5rdXqJQeoWMmoFa+x6Wm8tITMp
        PcoyGRV5nMuVFQZu1W37dVe3sWN47/R0X32rcNEKKlD7UbsrVsXhiPovJMCXFZADF/iHZm
        69u3MFV7ZLgzPcdl8rQlBYrGLKNVK8F5VMubzZ+Hh5M6ozkgoHMHEtL1UTkHUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645565223;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+VJ8ulndxSSdJqTNPIDLFDHjk0EkO8BYbPFXzYRGMg=;
        b=LiHzXxX7T3fBaHDskLVHHaU+MU7OjmmIqYyr8WjdIAuMW+TNBmENiHYWhPKpOzru4YXFu1
        j5UsbeLfzmQBkrDQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] fork: Duplicate task_struct before stack allocation
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220217102406.3697941-3-bigeasy@linutronix.de>
References: <20220217102406.3697941-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164556522231.16921.3149765477233178742.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/core branch of tip:

Commit-ID:     546c42b2c5c161619736dd730d3df709181999d0
Gitweb:        https://git.kernel.org/tip/546c42b2c5c161619736dd730d3df709181999d0
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 17 Feb 2022 11:24:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Feb 2022 22:25:01 +01:00

fork: Duplicate task_struct before stack allocation

alloc_thread_stack_node() already populates the task_struct::stack
member except on IA64. The stack pointer is saved and populated again
because IA64 needs it and arch_dup_task_struct() overwrites it.

Allocate thread's stack after task_struct has been duplicated as a
preparation for further changes.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20220217102406.3697941-3-bigeasy@linutronix.de

---
 kernel/fork.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index f5cc101..30c01ce 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -888,6 +888,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (!tsk)
 		return NULL;
 
+	err = arch_dup_task_struct(tsk, orig);
+	if (err)
+		goto free_tsk;
+
 	stack = alloc_thread_stack_node(tsk, node);
 	if (!stack)
 		goto free_tsk;
@@ -897,8 +901,6 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 
 	stack_vm_area = task_stack_vm_area(tsk);
 
-	err = arch_dup_task_struct(tsk, orig);
-
 	/*
 	 * arch_dup_task_struct() clobbers the stack-related fields.  Make
 	 * sure they're properly initialized before using any stack-related
@@ -912,9 +914,6 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
 
-	if (err)
-		goto free_stack;
-
 	err = scs_prepare(tsk, node);
 	if (err)
 		goto free_stack;
