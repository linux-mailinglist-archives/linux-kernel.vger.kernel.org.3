Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412D64B1826
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344945AbiBJW1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:27:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344908AbiBJW1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:27:37 -0500
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EAB262B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:27:37 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id IHuZnjGYF9r2MIHuZnUs2h; Thu, 10 Feb 2022 23:27:35 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 10 Feb 2022 23:27:35 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jhansen@vmware.com, vdasa@vmware.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, acking@vmware.com, dtor@vmware.com
Cc:     pv-drivers@vmware.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] VMCI: Fix some error handling paths in vmci_guest_probe_device()
Date:   Thu, 10 Feb 2022 23:27:34 +0100
Message-Id: <c5c1a5f3547bea3c4a1cfb8474db683d83c0ca1d.1644531317.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1644531317.git.christophe.jaillet@wanadoo.fr>
References: <cover.1644531317.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'err_remove_vmci_dev_g' error label is not at the right place.
This could lead to un-released resource.

There is also a missing label. If pci_alloc_irq_vectors() fails, the
previous vmci_event_subscribe() call must be undone.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Review with GREAT care.

This patch is a recent rebase of an old patch that has never been
submitted.
This function is huge and modifying its error handling path is error
prone (at least for me).

The patch is compile-tested only.
---
 drivers/misc/vmw_vmci/vmci_guest.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index 02d4722d8474..2e8ad36895ae 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -765,7 +765,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	/* Check host capabilities. */
 	error = vmci_check_host_caps(pdev);
 	if (error)
-		goto err_remove_bitmap;
+		goto err_remove_vmci_dev_g;
 
 	/* Enable device. */
 
@@ -795,7 +795,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 		error = pci_alloc_irq_vectors(pdev, 1, 1,
 				PCI_IRQ_MSIX | PCI_IRQ_MSI | PCI_IRQ_LEGACY);
 		if (error < 0)
-			goto err_remove_bitmap;
+			goto err_unsubscrive_event;
 	} else {
 		vmci_dev->exclusive_vectors = true;
 	}
@@ -871,13 +871,19 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 err_disable_msi:
 	pci_free_irq_vectors(pdev);
 
+err_unsubscrive_event:
 	vmci_err = vmci_event_unsubscribe(ctx_update_sub_id);
 	if (vmci_err < VMCI_SUCCESS)
 		dev_warn(&pdev->dev,
 			 "Failed to unsubscribe from event (type=%d) with subscriber (ID=0x%x): %d\n",
 			 VMCI_EVENT_CTX_ID_UPDATE, ctx_update_sub_id, vmci_err);
 
-err_remove_bitmap:
+err_remove_vmci_dev_g:
+	spin_lock_irq(&vmci_dev_spinlock);
+	vmci_pdev = NULL;
+	vmci_dev_g = NULL;
+	spin_unlock_irq(&vmci_dev_spinlock);
+
 	if (vmci_dev->notification_bitmap) {
 		vmci_write_reg(vmci_dev, VMCI_CONTROL_RESET, VMCI_CONTROL_ADDR);
 		dma_free_coherent(&pdev->dev, PAGE_SIZE,
@@ -885,12 +891,6 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 				  vmci_dev->notification_base);
 	}
 
-err_remove_vmci_dev_g:
-	spin_lock_irq(&vmci_dev_spinlock);
-	vmci_pdev = NULL;
-	vmci_dev_g = NULL;
-	spin_unlock_irq(&vmci_dev_spinlock);
-
 err_free_data_buffers:
 	vmci_free_dg_buffers(vmci_dev);
 
-- 
2.32.0

