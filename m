Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A72B5260BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379780AbiEMLKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379733AbiEMLKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:10:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9DA2A5E9D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:10:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652440207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D8KLHqVQtCIkBNwToZ5fdFqQrvPlxGtB7EqGxkiaVLg=;
        b=C3YN/lpNIatUZ1jSSajMzf8gAKJjdczxnx1vlBtduen8gZaEhL29kev4HdGFUyDDvmj2SQ
        OPPtRtr5bGyQQhMdvgQSYFoniI5Lvka974v9oieFM1oeVonF8VAT/KsZcJoVWltQy+E3qR
        vxx8khx/ECbgI+gtIJPilEx2lPigvSjqklAiKc6Crj0ywjx0GN3l0AyMx5LG5b5/8w9CeT
        HrBkK6m45vUChJ1JeBEMEmOvd4AQ4Y8jlJ0pS7CQ41NB6ozQUkYATZ252ShRuckKokICIn
        TY4zP1UjhDrU7qyxDg48KFFyo9S1NsZhj3IzBFNkS3Pj50OhQXltGQRx8SxFAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652440207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D8KLHqVQtCIkBNwToZ5fdFqQrvPlxGtB7EqGxkiaVLg=;
        b=8/Q5H2F71NRtRscbCKIedtWvnXfCIPftVKtCvXBUsGHfV2qlGD9eajiPVRiVlkskqt83v8
        8mQ7GrqQHWBjcDAg==
To:     Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH] x86/nmi: Make register_nmi_handler() more robust
In-Reply-To: <20220511234332.3654455-1-seanjc@google.com>
References: <20220511234332.3654455-1-seanjc@google.com>
Date:   Fri, 13 May 2022 13:10:06 +0200
Message-ID: <87zgjlsn75.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

register_nmi_handler() has no sanity check whether a handler has been
registered already. Such an unintended double-add leads to list corruption
and hard to diagnose problems during the next NMI handling.

Init the list head in the static nmi action struct and check it for being
empty in register_nmi_handler().

Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/nmi.h |    1 +
 arch/x86/kernel/nmi.c      |   10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -47,6 +47,7 @@ struct nmiaction {
 #define register_nmi_handler(t, fn, fg, n, init...)	\
 ({							\
 	static struct nmiaction init fn##_na = {	\
+		.list = LIST_HEAD_INIT(fn##_na.list),	\
 		.handler = (fn),			\
 		.name = (n),				\
 		.flags = (fg),				\
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -157,7 +157,7 @@ int __register_nmi_handler(unsigned int
 	struct nmi_desc *desc = nmi_to_desc(type);
 	unsigned long flags;
 
-	if (!action->handler)
+	if (WARN_ON_ONCE(action->handler || !list_empty(&action->list)))
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
@@ -186,7 +186,7 @@ EXPORT_SYMBOL(__register_nmi_handler);
 void unregister_nmi_handler(unsigned int type, const char *name)
 {
 	struct nmi_desc *desc = nmi_to_desc(type);
-	struct nmiaction *n;
+	struct nmiaction *n, *found = NULL;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
@@ -200,12 +200,16 @@ void unregister_nmi_handler(unsigned int
 			WARN(in_nmi(),
 				"Trying to free NMI (%s) from NMI context!\n", n->name);
 			list_del_rcu(&n->list);
+			found = n;
 			break;
 		}
 	}
 
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
-	synchronize_rcu();
+	if (found) {
+		synchronize_rcu();
+		INIT_LIST_HEAD(found);
+	}
 }
 EXPORT_SYMBOL_GPL(unregister_nmi_handler);
 
