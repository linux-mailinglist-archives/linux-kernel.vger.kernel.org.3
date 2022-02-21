Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4AB4BE80C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356273AbiBULZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:25:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356207AbiBULYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:24:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE58C41;
        Mon, 21 Feb 2022 03:19:47 -0800 (PST)
Date:   Mon, 21 Feb 2022 11:19:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645442385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3C9EMptlshmlFrp7KuOawjBBSEBh/nqa78XFkZiqeqg=;
        b=HI2b8Q3dMU51MXjCEthE0Q13fYsDYsj+x6c+oszZql/Ze/Gni5c9C7Q39PLiHyZ4H3IlUB
        +R2RHT+/IzD5Dr3z3lwJ1VP20a5Pdz1emf9aWnHb8rCPqH/en4c1JS2QJEgHszOfzfnmdV
        ZUkn4pWW6fK4EZ3oA2wXJe5aCoeFKkpw7a4XwpF8XgPUIylEAN90yur63ashQY6waBkll/
        UiLmVId5jjBsqWKEwrV4Ae9Zmls2/Q4QdCru7oMYgxvPc7ujrCmB5Xs7EpjZe7IK6Eey7U
        JHpotVejFa5dGg04+R7qWZhLaktDrvmfqln6SXwnJfe18YxMzOItspM5JDff+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645442385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3C9EMptlshmlFrp7KuOawjBBSEBh/nqa78XFkZiqeqg=;
        b=2htBa3reRHwcoJSJga/TPWCsolqoeZpXy0Y9VhXwdQoLKDh8gc5OBQLij8SeclcVsuOVtI
        2NsRT91qMoeJyOAw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Provide generic_handle_irq_safe()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220211181500.1856198-2-bigeasy@linutronix.de>
References: <20220211181500.1856198-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164544238423.16921.14685093775166733539.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     509853f9e1e7b1490dc79f735a5dbafc9298f40d
Gitweb:        https://git.kernel.org/tip/509853f9e1e7b1490dc79f735a5dbafc9298f40d
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 11 Feb 2022 19:14:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 21 Feb 2022 11:31:06 +01:00

genirq: Provide generic_handle_irq_safe()

Provide generic_handle_irq_safe() which can used from any context.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20220211181500.1856198-2-bigeasy@linutronix.de
---
 include/linux/irqdesc.h |  1 +
 kernel/irq/irqdesc.c    | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 93d270c..a775845 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -160,6 +160,7 @@ static inline void generic_handle_irq_desc(struct irq_desc *desc)
 
 int handle_irq_desc(struct irq_desc *desc);
 int generic_handle_irq(unsigned int irq);
+int generic_handle_irq_safe(unsigned int irq);
 
 #ifdef CONFIG_IRQ_DOMAIN
 /*
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 2267e65..346d283 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -662,6 +662,29 @@ int generic_handle_irq(unsigned int irq)
 }
 EXPORT_SYMBOL_GPL(generic_handle_irq);
 
+/**
+ * generic_handle_irq_safe - Invoke the handler for a particular irq from any
+ *			     context.
+ * @irq:	The irq number to handle
+ *
+ * Returns:	0 on success, a negative value on error.
+ *
+ * This function can be called from any context (IRQ or process context). It
+ * will report an error if not invoked from IRQ context and the irq has been
+ * marked to enforce IRQ-context only.
+ */
+int generic_handle_irq_safe(unsigned int irq)
+{
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+	ret = handle_irq_desc(irq_to_desc(irq));
+	local_irq_restore(flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(generic_handle_irq_safe);
+
 #ifdef CONFIG_IRQ_DOMAIN
 /**
  * generic_handle_domain_irq - Invoke the handler for a HW irq belonging
