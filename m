Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515B5475BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243904AbhLOPTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:19:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48598 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243891AbhLOPTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:19:43 -0500
Date:   Wed, 15 Dec 2021 15:19:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639581581;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8aw+dzbZV9sL0G2zG8PyRV9RCl/3aZAvEXoPr3WcNaY=;
        b=eCyciDGq1LQvcNVKGxzMJBjz7Cc/Dz3RWBBAcGkDStswnspYLD7pbiU238KOrKJEJ0W35y
        eQOkSOj/3p0uIjeYwQmhx3N4eSM5XpzYpay9Sb7U+e/ZyuYvpK4E92c/zKHyVSOdH2RrFy
        5X3WekzMm2pyaAcGGjCkTpzQZAuI0pLLaHxDgTMxA+IJEDPxH6mbLRTiHzBV8qIPofVrJA
        1tfXQXxIwJQq8Hj6q+YsR0voWEC416jufPAXlYxv6uYroyo7nnAk44cgzGesmOZxIkfmsJ
        g7d5RuwVNQuEYH5v46h5FoN5+/Nl3gkfPg9uBnn2hDvFpAXs4Zy2ZZChXXTLPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639581581;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8aw+dzbZV9sL0G2zG8PyRV9RCl/3aZAvEXoPr3WcNaY=;
        b=8EKStKLIwjKDgP1fv4eibthHR17eq7YtEOtlRMmEV8WWHXymYO6HH7aghPBCkJvXtit+8k
        kQgvnCCx7L3ZAhCA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] x86/xen: Use correct #ifdef guard for
 xen_initdom_restore_msi()
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211215140209.451379-1-arnd@kernel.org>
References: <20211215140209.451379-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <163958158059.23020.1721008355650214462.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     91f7d2dbf952f54442fa81bb62f78ee023179bf9
Gitweb:        https://git.kernel.org/tip/91f7d2dbf952f54442fa81bb62f78ee023179bf9
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 15 Dec 2021 15:01:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Dec 2021 16:13:23 +01:00

x86/xen: Use correct #ifdef guard for xen_initdom_restore_msi()

The #ifdef check around the definition doesn't match the one around the
declaration, leading to a link failure when CONFIG_XEN_DOM0 is enabled
but CONFIG_XEN_PV_DOM0 is not:

x86_64-linux-ld: arch/x86/kernel/apic/msi.o: in function `arch_restore_msi_irqs':
msi.c:(.text+0x29a): undefined reference to `xen_initdom_restore_msi'

Change the declaration to use the same check that was already present
around the function definition.

Fixes: ae72f3156729 ("PCI/MSI: Make arch_restore_msi_irqs() less horrible.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20211215140209.451379-1-arnd@kernel.org

---
 arch/x86/include/asm/xen/hypervisor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 677f84d..1bf2ad3 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -59,7 +59,7 @@ static inline bool __init xen_x2apic_para_available(void)
 
 struct pci_dev;
 
-#ifdef CONFIG_XEN_DOM0
+#ifdef CONFIG_XEN_PV_DOM0
 bool xen_initdom_restore_msi(struct pci_dev *dev);
 #else
 static inline bool xen_initdom_restore_msi(struct pci_dev *dev) { return true; }
