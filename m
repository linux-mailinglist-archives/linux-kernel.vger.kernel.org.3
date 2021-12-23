Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF56B47E57C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349000AbhLWPbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:31:06 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50210 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348996AbhLWPbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:31:05 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F5841EC050F;
        Thu, 23 Dec 2021 16:31:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640273460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NZFAMZtyznfRy9FSPfN4x5Z+DA8XjFd54VpWXNHETQI=;
        b=abKrQOtv93Jc4J6G1Q+y5+nvSO4H3plQTGLwv9rrILUVaWKilfEMi9uT6+HXGHmsqukemv
        etLXEXzhQHDOJ6+YGfnhrG+RevkcvsyFzpgZFP1JsoCqtfA98dTEasH+xQFjT7H+DhefgY
        hzZcqDIgXtsh0eoy0EKmaWyxtHq+ftE=
Date:   Thu, 23 Dec 2021 16:31:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -v2] notifier: Return an error when a callback has already
 been registered
Message-ID: <YcSWNdUBS8A2ZB3s@zn.tnic>
References: <20211202133601.23527-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211202133601.23527-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

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
---
 kernel/notifier.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index b8251dc0bc0f..ba005ebf4730 100644
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
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
