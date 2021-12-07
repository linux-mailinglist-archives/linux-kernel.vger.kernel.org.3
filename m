Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F9146BD7B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbhLGOZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:25:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53290 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhLGOZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:25:33 -0500
Date:   Tue, 07 Dec 2021 14:22:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638886922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lB6kLZBCKy5PCslxlsJbGwNwRKAk3vu/raZLCi3dnDM=;
        b=cmOJYYv2b0gihUf4I698TaF3t4dfRIpI3z77t/L+WvyDaYaAdS8Gq0dQlc4ZQ7jVyFjpk8
        rXW77lsu44FxQIqjd5OySuVg3nfeBiQA90jhsexeZGTrsA9iA/Ke6VJCGpX4lPxoZfZJax
        BESZd9pKBteSuf/9Mqb6nBqfpaqy/v9+EPZTASBdQy4gTYePaQ9UBs7M5/GvYvDZx0l0+a
        pQjskklqd+kYGCHq1VGzyEhChZqbklY5NdM3FygBpYZTmJRgOxQA8j0epxPF3nP58adpj0
        wRKBwmc4icsMBirAOjBwdZDTLpd5Zy2TohzCWrMGTL7d11tb2jnH7Vu2Tp2yMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638886922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lB6kLZBCKy5PCslxlsJbGwNwRKAk3vu/raZLCi3dnDM=;
        b=5MNobfqqX3+FDCXM5ElCp8ddz0f2KzQbtAIhx72NruypPzxGu+na0wF7HEXnpLGQBy/D22
        gCjVP51NIkMDvsCw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/mm: Include spinlock_t definition in pgtable.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129174654.668506-11-bigeasy@linutronix.de>
References: <20211129174654.668506-11-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163888692149.11128.5427700289897520105.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0cf292b569bc9bc87d29ac87ca5c47fdd5882e10
Gitweb:        https://git.kernel.org/tip/0cf292b569bc9bc87d29ac87ca5c47fdd5882e10
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 29 Nov 2021 18:46:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 07 Dec 2021 15:14:12 +01:00

x86/mm: Include spinlock_t definition in pgtable.

This header file provides forward declartion for pgd_lock but does not
include the header defining its type. This works since the definition of
spinlock_t is usually included somehow via printk.

By trying to avoid recursive includes on PREEMPT_RT I avoided the loop
in printk and as a consequnce kernel/intel.c failed to compile due to
missing type definition.

Include the needed definition for spinlock_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211129174654.668506-11-bigeasy@linutronix.de
---
 arch/x86/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01..a34430b 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -22,6 +22,7 @@
 #define pgprot_decrypted(prot)	__pgprot(__sme_clr(pgprot_val(prot)))
 
 #ifndef __ASSEMBLY__
+#include <linux/spinlock.h>
 #include <asm/x86_init.h>
 #include <asm/pkru.h>
 #include <asm/fpu/api.h>
