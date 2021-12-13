Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58513473316
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbhLMRf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:35:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36212 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241412AbhLMRfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:35:07 -0500
Date:   Mon, 13 Dec 2021 17:35:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639416906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8OSkXut/5UMHKqKOrsE39ZdSujYPk5KLZLGsJIPICQ=;
        b=u54Tp9frUeICkl9gkiMKbFBw03kKLpx3tpB5pW5mRDSSmpp001Vww+KOhJ0UfFOph36ooj
        7uz0ZntE0mKVg5I/XMf631zSfBL1mw4VTAQ2BCr3tAJXYPqCjuAj0YGx537c+0xOWlIZ0C
        sfxHBEeTNwXdzcHO3Eidot0ieYtmIKacYCdviMCtjI5+5qqq5HQGwIrKfAkS6EZmgqo1mj
        J+Wc0xojiNFG+uJxRSnRvCIvvNlnMf2HD7cvINxLqLSW5/BlQq4OsGjl9T9pZ569xCIBxC
        AJpod3Ir+JZuKW4dyU5FWg4jAQhup2JWyPzlCLbpUtZUEK/CJn+nJBBRxRxWlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639416906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8OSkXut/5UMHKqKOrsE39ZdSujYPk5KLZLGsJIPICQ=;
        b=tWN+uu+xyhrQSI3ZmcOH33P9A3K9eFEDl1nOau0kcr0i3vbquy/6iO7K8TdBt6KZ7kCi20
        nfySKt5r2TPmMsDg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Mark mce_panic() noinstr
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211208111343.8130-8-bp@alien8.de>
References: <20211208111343.8130-8-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163941690503.23020.16105876910046633752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     3c7ce80a818fa7950be123cac80cd078e5ac1013
Gitweb:        https://git.kernel.org/tip/3c7ce80a818fa7950be123cac80cd078e5ac1013
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 01 Nov 2021 13:39:35 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Dec 2021 14:13:01 +01:00

x86/mce: Mark mce_panic() noinstr

And allow instrumentation inside it because it does calls to other
facilities which will not be tagged noinstr.

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0xc73: call to mce_panic() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211208111343.8130-8-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d788ccc..ec0f7bb 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -266,11 +266,17 @@ static void wait_for_panic(void)
 	panic("Panicing machine check CPU died");
 }
 
-static void mce_panic(const char *msg, struct mce *final, char *exp)
+static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 {
-	int apei_err = 0;
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
+	int apei_err = 0;
+
+	/*
+	 * Allow instrumentation around external facilities usage. Not that it
+	 * matters a whole lot since the machine is going to panic anyway.
+	 */
+	instrumentation_begin();
 
 	if (!fake_panic) {
 		/*
@@ -285,7 +291,7 @@ static void mce_panic(const char *msg, struct mce *final, char *exp)
 	} else {
 		/* Don't log too much for fake panic */
 		if (atomic_inc_return(&mce_fake_panicked) > 1)
-			return;
+			goto out;
 	}
 	pending = mce_gen_pool_prepare_records();
 	/* First print corrected ones that are still unlogged */
@@ -321,6 +327,9 @@ static void mce_panic(const char *msg, struct mce *final, char *exp)
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
+
+out:
+	instrumentation_end();
 }
 
 /* Support code for software error injection */
