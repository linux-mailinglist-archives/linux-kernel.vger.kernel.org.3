Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BCB470B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbhLJT5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242977AbhLJT5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:57:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A3EC061746;
        Fri, 10 Dec 2021 11:54:06 -0800 (PST)
Date:   Fri, 10 Dec 2021 19:54:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639166044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4gQ4m556HjoKHwLhkdHkFUABIDnZBvZUuEzZhIcOsjM=;
        b=JTpxlCso00HWoKYwAQnh4coLDpYcLvqeJeMNy1fOhiEDwBetx1tHHS3w+Qb5U5OMnQgvQp
        jCgSf2gsgqQodmSDvHMT0QW4470ywMDskJmItxXxyZJby/V8hOTJnsGFSx80X0768dpazq
        29AkWzfNBXuJqjGrSUrmXqd/ILU15F1MCu4k9ewTUhsUzUlMbVtFS7lv9bnT1OtUwju9xO
        KRhVYmaSVO4EtLBfl9S5CVblvD36H0jCGwpQI683XDJjBeM2mpQUlOuKVv9HrP8tqLDxvW
        yDmtXVt+tpeql4041ssUp/desKJwFP75MaTyF1Ka7b06tc4E7+al/oAWcp0a+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639166044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4gQ4m556HjoKHwLhkdHkFUABIDnZBvZUuEzZhIcOsjM=;
        b=vLbaNji2p3UFwbGuH+5gxAkWRe49SLOrlaPr+rdXSXcHuvWE6bThZjBQGMuikD5yKtnV5U
        dT+wIR8nQPsXvrAw==
From:   "tip-bot2 for Nitesh Narayan Lal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] scsi: lpfc: Use irq_set_affinity()
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Smart <jsmart2021@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210903152430.244937-12-nitesh@redhat.com>
References: <20210903152430.244937-12-nitesh@redhat.com>
MIME-Version: 1.0
Message-ID: <163916604383.23020.16524606796134796447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ce5a58a96ccc241c6e5cbb3360494ddfaf118afe
Gitweb:        https://git.kernel.org/tip/ce5a58a96ccc241c6e5cbb3360494ddfaf118afe
Author:        Nitesh Narayan Lal <nitesh@redhat.com>
AuthorDate:    Fri, 03 Sep 2021 11:24:27 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 Dec 2021 20:47:39 +01:00

scsi: lpfc: Use irq_set_affinity()

The driver uses irq_set_affinity_hint to set the affinity for the lpfc
interrupts to a mask corresponding to the local NUMA node to avoid
performance overhead on AMD architectures.

However, irq_set_affinity_hint() setting the affinity is an undocumented
side effect that this function also sets the affinity under the hood.
To remove this side effect irq_set_affinity_hint() has been marked as
deprecated and new interfaces have been introduced.

Also, as per the commit dcaa21367938 ("scsi: lpfc: Change default IRQ model
on AMD architectures"):
"On AMD architecture, revert the irq allocation to the normal style
(non-managed) and then use irq_set_affinity_hint() to set the cpu affinity
and disable user-space rebalancing."
we don't really need to set the affinity_hint as user-space rebalancing for
the lpfc interrupts is not desired.

Hence, replace the irq_set_affinity_hint() with irq_set_affinity() which
only applies the affinity for the interrupts.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: James Smart <jsmart2021@gmail.com>
Link: https://lore.kernel.org/r/20210903152430.244937-12-nitesh@redhat.com

---
 drivers/scsi/lpfc/lpfc_init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index ba17a8f..9457552 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12709,7 +12709,7 @@ lpfc_irq_set_aff(struct lpfc_hba_eq_hdl *eqhdl, unsigned int cpu)
 	cpumask_clear(&eqhdl->aff_mask);
 	cpumask_set_cpu(cpu, &eqhdl->aff_mask);
 	irq_set_status_flags(eqhdl->irq, IRQ_NO_BALANCING);
-	irq_set_affinity_hint(eqhdl->irq, &eqhdl->aff_mask);
+	irq_set_affinity(eqhdl->irq, &eqhdl->aff_mask);
 }
 
 /**
@@ -12998,7 +12998,6 @@ cfg_fail_out:
 	for (--index; index >= 0; index--) {
 		eqhdl = lpfc_get_eq_hdl(index);
 		lpfc_irq_clear_aff(eqhdl);
-		irq_set_affinity_hint(eqhdl->irq, NULL);
 		free_irq(eqhdl->irq, eqhdl);
 	}
 
@@ -13159,7 +13158,6 @@ lpfc_sli4_disable_intr(struct lpfc_hba *phba)
 		for (index = 0; index < phba->cfg_irq_chann; index++) {
 			eqhdl = lpfc_get_eq_hdl(index);
 			lpfc_irq_clear_aff(eqhdl);
-			irq_set_affinity_hint(eqhdl->irq, NULL);
 			free_irq(eqhdl->irq, eqhdl);
 		}
 	} else {
