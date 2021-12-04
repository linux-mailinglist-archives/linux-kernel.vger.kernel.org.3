Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB6468551
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385202AbhLDOXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241124AbhLDOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:23:15 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8E8C061751;
        Sat,  4 Dec 2021 06:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638627589;
        bh=4UpQiGaFFla6kEoSrEB6tjLYKfWhGPQkWDOaRHaaWeo=;
        h=Message-ID:Subject:From:To:Date:From;
        b=MI5kuW6om69NEOKzJEHolPs3JdY2ks6Lgyl9en+keXRWI8VKBCNDtipB2HI1/9K99
         KaeFwH5SpodqCVaTcC/v7JgYxSkqtZe98R0lHth6TueCJSBAFyJtK4KG7Hy+/1T2Pe
         h2tQX5xTcJIEOhfVtNhCobGasUagStfp+Oi7SGMY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 478221280998;
        Sat,  4 Dec 2021 09:19:49 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2xSxmAU7tXoP; Sat,  4 Dec 2021 09:19:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638627589;
        bh=4UpQiGaFFla6kEoSrEB6tjLYKfWhGPQkWDOaRHaaWeo=;
        h=Message-ID:Subject:From:To:Date:From;
        b=MI5kuW6om69NEOKzJEHolPs3JdY2ks6Lgyl9en+keXRWI8VKBCNDtipB2HI1/9K99
         KaeFwH5SpodqCVaTcC/v7JgYxSkqtZe98R0lHth6TueCJSBAFyJtK4KG7Hy+/1T2Pe
         h2tQX5xTcJIEOhfVtNhCobGasUagStfp+Oi7SGMY=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C24271280994;
        Sat,  4 Dec 2021 09:19:48 -0500 (EST)
Message-ID: <a6cae8ac4c95123d9dbda07a7cc553ea0367f4b8.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.16-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 04 Dec 2021 09:19:47 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

two patches, both in drivers.  One is a fix to FC recovery (lpfc) and
the other is an enhancement to support the Intel Alder Motherboard with
the UFS driver which comes under the -rc exception process for hardware
enabling.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Adrian Hunter (1):
      scsi: ufs: ufs-pci: Add support for Intel ADL

James Smart (1):
      scsi: lpfc: Fix non-recovery of remote ports following an unsolicited LOGO

And the diffstat:

 drivers/scsi/lpfc/lpfc_els.c  |  9 ++-------
 drivers/scsi/ufs/ufshcd-pci.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

With full diff below.

James

---
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index b940e0268f96..e83453bea2ae 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -5095,14 +5095,9 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		/* NPort Recovery mode or node is just allocated */
 		if (!lpfc_nlp_not_used(ndlp)) {
 			/* A LOGO is completing and the node is in NPR state.
-			 * If this a fabric node that cleared its transport
-			 * registration, release the rpi.
+			 * Just unregister the RPI because the node is still
+			 * required.
 			 */
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			if (phba->sli_rev == LPFC_SLI_REV4)
-				ndlp->nlp_flag |= NLP_RELEASE_RPI;
-			spin_unlock_irq(&ndlp->lock);
 			lpfc_unreg_rpi(vport, ndlp);
 		} else {
 			/* Indicate the node has already released, should
diff --git a/drivers/scsi/ufs/ufshcd-pci.c b/drivers/scsi/ufs/ufshcd-pci.c
index 51424557810d..f725248ba57f 100644
--- a/drivers/scsi/ufs/ufshcd-pci.c
+++ b/drivers/scsi/ufs/ufshcd-pci.c
@@ -421,6 +421,13 @@ static int ufs_intel_lkf_init(struct ufs_hba *hba)
 	return err;
 }
 
+static int ufs_intel_adl_init(struct ufs_hba *hba)
+{
+	hba->nop_out_timeout = 200;
+	hba->quirks |= UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8;
+	return ufs_intel_common_init(hba);
+}
+
 static struct ufs_hba_variant_ops ufs_intel_cnl_hba_vops = {
 	.name                   = "intel-pci",
 	.init			= ufs_intel_common_init,
@@ -449,6 +456,15 @@ static struct ufs_hba_variant_ops ufs_intel_lkf_hba_vops = {
 	.device_reset		= ufs_intel_device_reset,
 };
 
+static struct ufs_hba_variant_ops ufs_intel_adl_hba_vops = {
+	.name			= "intel-pci",
+	.init			= ufs_intel_adl_init,
+	.exit			= ufs_intel_common_exit,
+	.link_startup_notify	= ufs_intel_link_startup_notify,
+	.resume			= ufs_intel_resume,
+	.device_reset		= ufs_intel_device_reset,
+};
+
 #ifdef CONFIG_PM_SLEEP
 static int ufshcd_pci_restore(struct device *dev)
 {
@@ -563,6 +579,8 @@ static const struct pci_device_id ufshcd_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x4B41), (kernel_ulong_t)&ufs_intel_ehl_hba_vops },
 	{ PCI_VDEVICE(INTEL, 0x4B43), (kernel_ulong_t)&ufs_intel_ehl_hba_vops },
 	{ PCI_VDEVICE(INTEL, 0x98FA), (kernel_ulong_t)&ufs_intel_lkf_hba_vops },
+	{ PCI_VDEVICE(INTEL, 0x51FF), (kernel_ulong_t)&ufs_intel_adl_hba_vops },
+	{ PCI_VDEVICE(INTEL, 0x54FF), (kernel_ulong_t)&ufs_intel_adl_hba_vops },
 	{ }	/* terminate list */
 };
 

