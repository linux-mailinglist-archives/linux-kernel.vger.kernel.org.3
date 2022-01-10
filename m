Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006BF489F44
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbiAJS3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:29:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44542 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242055AbiAJS2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:28:45 -0500
Date:   Mon, 10 Jan 2022 18:28:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641839323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KFflniNiCZwXCgWFWhEWdhZx8Ljlv0rCoRqVa8swhw=;
        b=4jCDZ6yhb4vzy/8dbL8riLnkQKtGajZ6RuWKypICx8zV1zyZBNg6n3wBMA/BeEQjivNMBK
        T58fUeaiz1wIms5w5yrt+W1YoTjMKTXnswL3Dzp0D8og37WiKpKCXxInDOFaRQKW239VCD
        omw+0o5m0ai8CiCsVk9bJTJhoAOqJW/zwzRxaxqE116cr98RhjgLtv+uObhyC+5fCWeB6O
        LFnKXn84EBOWykxtSiBXt34MBgexHJoWNzDJpvpDO3VteSBbkVKgnsFwCDwNUK79VsMc1l
        8A8vamIMfoMcP0BrRBvd4RiCk+rMZXIx87sYpu5RWoUA4gUsnwZKozKHPwsYmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641839323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KFflniNiCZwXCgWFWhEWdhZx8Ljlv0rCoRqVa8swhw=;
        b=WbfHsnwp32Z3msqwLK+lvdYEP/ycZhr/Uxlj/C/5Q0ZJ0D8eeY0gICN7EvkY1X0lnYdIsw
        2aDx4abJX411srCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Populate sysfs entry only once
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87leznqx2a.ffs@tglx>
References: <87leznqx2a.ffs@tglx>
MIME-Version: 1.0
Message-ID: <164183932244.16921.9315200768989413599.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     74a5257a0c175810d620b5e631c4e7554955ac25
Gitweb:        https://git.kernel.org/tip/74a5257a0c175810d620b5e631c4e7554955ac25
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jan 2022 19:12:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 10 Jan 2022 19:22:10 +01:00

genirq/msi: Populate sysfs entry only once

The MSI entries for multi-MSI are populated en bloc for the MSI descriptor,
but the current code invokes the population inside the per interrupt loop
which triggers a warning in the sysfs code and causes the interrupt
allocation to fail.

Move it outside of the loop so it works correctly for single and multi-MSI.

Fixes: bf5e758f02fc ("genirq/msi: Simplify sysfs handling")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/87leznqx2a.ffs@tglx
---
 kernel/irq/msi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 173bc04..2bdfce5 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -887,12 +887,11 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			ret = msi_init_virq(domain, virq + i, vflags);
 			if (ret)
 				return ret;
-
-			if (info->flags & MSI_FLAG_DEV_SYSFS) {
-				ret = msi_sysfs_populate_desc(dev, desc);
-				if (ret)
-					return ret;
-			}
+		}
+		if (info->flags & MSI_FLAG_DEV_SYSFS) {
+			ret = msi_sysfs_populate_desc(dev, desc);
+			if (ret)
+				return ret;
 		}
 		allocated++;
 	}
