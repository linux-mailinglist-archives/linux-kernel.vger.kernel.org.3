Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC98952774B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 13:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbiEOLjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 07:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbiEOLji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 07:39:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05B23B02A
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 04:39:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652614775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E7coA4n0dI3fqeFnc8eo8/SPSzp9dmnMdNF96cR4v+Q=;
        b=reJMpeQ91nOn88ki2cd7jTX8T5PA6JUA9+8o9tliUsU0RHuAniceU/HeHcb5PXj3cjHM73
        EJjijl65+fV8ErhfU22eoZcYXinl7/KKmClDCv3Zl8XkJygz6NAo3/EtscTAoe8iniaM3u
        SF2+iOGLgxPrE0JnkoxK+wDXknxhkzem8Fnr7ZS+Ajwdn0boWUA4u3Ml8DxxpHspxXUpRs
        PIQKqwC3t6Tu9hrcJOsph+fLEcglTpaigN7iAGgHC2CFmXEn6X4by8JETh3/Fx4IFUdnQ9
        CjnF9RfGIKT9qK69wNgmv65H9x5e9+O6yIzaTignaiLo4TvI6UfWZHM2BDlNMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652614775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E7coA4n0dI3fqeFnc8eo8/SPSzp9dmnMdNF96cR4v+Q=;
        b=OVT9LHoMA95dMXQbGub7KwAHvDmXULy5xfgoflBTVBR0aV164hpD//bhFG1Z5uJuAw52ZG
        WvO1j/g3aGj2VPCA==
To:     Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH V2] x86/nmi: Make register_nmi_handler() more robust
In-Reply-To: <87zgjlsn75.ffs@tglx>
References: <20220511234332.3654455-1-seanjc@google.com> <87zgjlsn75.ffs@tglx>
Date:   Sun, 15 May 2022 13:39:34 +0200
Message-ID: <87tu9rqb2h.ffs@tglx>
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
Link: https://lore.kernel.org/lkml/20220511234332.3654455-1-seanjc@google.com
---
V2: Warn if no handler provided and not for the correct case (Boris)
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
+	if (WARN_ON_ONCE(!action->handler || !list_empty(&action->list)))
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
 
