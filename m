Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEDE529B04
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiEQHhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241667AbiEQHfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:35:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E6E49C9A;
        Tue, 17 May 2022 00:34:17 -0700 (PDT)
Date:   Tue, 17 May 2022 07:34:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652772855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGGPCoT30zsHoUM7qYF9vcnNujH3Hey0sMxDFkGEqkI=;
        b=inYQMdnQZzE3vnRrvSO+PMY2/HlWPmsrY/sA/Dvt06pk+IH+6RztNzp0GFkdLSsF2NNJgM
        LPDWpiNXp6lsnOOGxe1B8h6tJfAcRIbftAfgUQwo1aDO8qAI3yI7l/xMOhtKdT5TlaqbY5
        +hU7AsMoMEtAUBpMNvI+rY6L0zRCwTSSxZyARTfPqxMhbh6RKNX6DV8s/wX7RO7oG238cz
        djnYBqCuWH0VKK970DCq25H5Khj29nJSf4uWO3vhZPMxYMEo1tqdHWmWZWx2SNolqpuTGq
        3niuv3TJml4IilkKnPWXQCzDfMM2aK0yHvn1QTzmmDozAIwWJ3ubehHFVriIYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652772855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGGPCoT30zsHoUM7qYF9vcnNujH3Hey0sMxDFkGEqkI=;
        b=xiDAFAm3hH7eBs58Xp40/7Y7p3DXKRjyzfNF60fH1P4YIGUlPL9S4TNxHUp6vs8KGudbYF
        NlxKhhbynSUH7BDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/nmi: Make register_nmi_handler() more robust
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220511234332.3654455-1-seanjc@google.com>
References: <20220511234332.3654455-1-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <165277285410.4207.10970267068162746336.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     a7fed5c0431dbfa707037848830f980e0f93cfb3
Gitweb:        https://git.kernel.org/tip/a7fed5c0431dbfa707037848830f980e0f93cfb3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 May 2022 13:39:34 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 May 2022 09:25:25 +02:00

x86/nmi: Make register_nmi_handler() more robust

register_nmi_handler() has no sanity check whether a handler has been
registered already. Such an unintended double-add leads to list corruption
and hard to diagnose problems during the next NMI handling.

Init the list head in the static NMI action struct and check it for being
empty in register_nmi_handler().

  [ bp: Fixups. ]

Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/lkml/20220511234332.3654455-1-seanjc@google.com
---
 arch/x86/include/asm/nmi.h |  1 +
 arch/x86/kernel/nmi.c      | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 1cb9c17..5c5f1e5 100644
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
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index e73f7df..cec0bfa 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -157,7 +157,7 @@ int __register_nmi_handler(unsigned int type, struct nmiaction *action)
 	struct nmi_desc *desc = nmi_to_desc(type);
 	unsigned long flags;
 
-	if (!action->handler)
+	if (WARN_ON_ONCE(!action->handler || !list_empty(&action->list)))
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
@@ -177,7 +177,7 @@ int __register_nmi_handler(unsigned int type, struct nmiaction *action)
 		list_add_rcu(&action->list, &desc->head);
 	else
 		list_add_tail_rcu(&action->list, &desc->head);
-	
+
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 	return 0;
 }
@@ -186,7 +186,7 @@ EXPORT_SYMBOL(__register_nmi_handler);
 void unregister_nmi_handler(unsigned int type, const char *name)
 {
 	struct nmi_desc *desc = nmi_to_desc(type);
-	struct nmiaction *n;
+	struct nmiaction *n, *found = NULL;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
@@ -200,12 +200,16 @@ void unregister_nmi_handler(unsigned int type, const char *name)
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
+		INIT_LIST_HEAD(&found->list);
+	}
 }
 EXPORT_SYMBOL_GPL(unregister_nmi_handler);
 
