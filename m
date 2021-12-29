Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210C2481176
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbhL2J6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbhL2J6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:58:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA14C061574;
        Wed, 29 Dec 2021 01:58:49 -0800 (PST)
Date:   Wed, 29 Dec 2021 09:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640771927;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lQ2GBaTDKY5phPpCNdXNkIkZnFzaDBEOC0/Hrz+M8Vs=;
        b=c3jl0tibtSTnkiFmS0hNGAhL+KdF/9YOn+qZK1Rlyv+JtXOHWqU0d3k/nXDP3IQlkTjz/x
        2NYadCDTZYMmlr93Gxm9lKJrQEsw516VPiTEU0qEnJmN/k/rI5UGyYTpDAJz8g6kWXyefU
        /dvpCWDU1QLDVYKYN6AoKZXPF2wXWsh2TT1gTLwtddnGzWvXQVFAZRzHl4obbF7a6nXs4a
        0r4cuDKrZOWnxofT4k1x7fVQvJlEdzZhxFLjr4t/r8T8W1ZqBIRPFMe0xqozPa/fJlVTId
        B9F7FVCfk3/KMphxhfrJg60D0u3ISLJxeyV4K3F5j1OYcFaYCUlwBMhq8JogJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640771927;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lQ2GBaTDKY5phPpCNdXNkIkZnFzaDBEOC0/Hrz+M8Vs=;
        b=Ix4yXRutdbjsX/roCG5OwSWxxoaLw10Mmi2jnMhJVCRk++Or+psHSQ9suul8BlQFhis03n
        FasoWNAefVl18lAw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] notifier: Return an error when a callback has
 already been registered
Cc:     Borislav Petkov <bp@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YcSWNdUBS8A2ZB3s@zn.tnic>
References: <YcSWNdUBS8A2ZB3s@zn.tnic>
MIME-Version: 1.0
Message-ID: <164077192559.16921.2913213776082540007.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/core branch of tip:

Commit-ID:     5abb065dca7301de90b7c44bbcdc378e49e4d362
Gitweb:        https://git.kernel.org/tip/5abb065dca7301de90b7c44bbcdc378e49e4d362
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 01 Dec 2021 22:28:14 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 29 Dec 2021 10:37:33 +01:00

notifier: Return an error when a callback has already been registered

Return -EEXIST when a notifier callback has already been registered on a
notifier chain.

This should avoid any homegrown registration tracking at the callsite
like

  https://lore.kernel.org/amd-gfx/20210512013058.6827-1-mukul.joshi@amd.com

for example.

This version is an alternative of

  https://lore.kernel.org/r/20211108101157.15189-1-bp@alien8.de

which needed to touch every caller not checking the registration
routine's return value.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/YcSWNdUBS8A2ZB3s@zn.tnic
---
 kernel/notifier.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index b8251dc..ba005eb 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -20,12 +20,13 @@ BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
  */
 
 static int notifier_chain_register(struct notifier_block **nl,
-		struct notifier_block *n)
+				   struct notifier_block *n)
 {
 	while ((*nl) != NULL) {
 		if (unlikely((*nl) == n)) {
-			WARN(1, "double register detected");
-			return 0;
+			WARN(1, "notifier callback %ps already registered",
+			     n->notifier_call);
+			return -EEXIST;
 		}
 		if (n->priority > (*nl)->priority)
 			break;
@@ -134,7 +135,7 @@ static int notifier_call_chain_robust(struct notifier_block **nl,
  *
  *	Adds a notifier to an atomic notifier chain.
  *
- *	Currently always returns zero.
+ *	Returns 0 on success, %-EEXIST on error.
  */
 int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
 		struct notifier_block *n)
@@ -216,7 +217,7 @@ NOKPROBE_SYMBOL(atomic_notifier_call_chain);
  *	Adds a notifier to a blocking notifier chain.
  *	Must be called in process context.
  *
- *	Currently always returns zero.
+ *	Returns 0 on success, %-EEXIST on error.
  */
 int blocking_notifier_chain_register(struct blocking_notifier_head *nh,
 		struct notifier_block *n)
@@ -335,7 +336,7 @@ EXPORT_SYMBOL_GPL(blocking_notifier_call_chain);
  *	Adds a notifier to a raw notifier chain.
  *	All locking must be provided by the caller.
  *
- *	Currently always returns zero.
+ *	Returns 0 on success, %-EEXIST on error.
  */
 int raw_notifier_chain_register(struct raw_notifier_head *nh,
 		struct notifier_block *n)
@@ -406,7 +407,7 @@ EXPORT_SYMBOL_GPL(raw_notifier_call_chain);
  *	Adds a notifier to an SRCU notifier chain.
  *	Must be called in process context.
  *
- *	Currently always returns zero.
+ *	Returns 0 on success, %-EEXIST on error.
  */
 int srcu_notifier_chain_register(struct srcu_notifier_head *nh,
 		struct notifier_block *n)
