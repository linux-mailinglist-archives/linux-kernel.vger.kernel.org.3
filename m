Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758144C36D6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbiBXUXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiBXUXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:23:11 -0500
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C3F17B0ED
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:22:41 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id NKdLnAsz0eKJJNKdLn2zIS; Thu, 24 Feb 2022 21:22:39 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 24 Feb 2022 21:22:39 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jorgen Hansen <jhansen@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        pv-drivers@vmware.com
Subject: [PATCH v2 3/3] VMCI: Fix some error handling paths in vmci_guest_probe_device()
Date:   Thu, 24 Feb 2022 21:22:37 +0100
Message-Id: <959218ce3b135197946d85cd9453551cd04fa5da.1645734041.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <c181bec88aab1145d3868d61b7e52d53923f8206.1645734041.git.christophe.jaillet@wanadoo.fr>
References: <c181bec88aab1145d3868d61b7e52d53923f8206.1645734041.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Vishnu Dasa <vdasa@vmware.com>
---
v2:
   - Fix a typo (s/err_unsubscrive_event/err_unsubscribe_event/)
---
 drivers/misc/vmw_vmci/vmci_guest.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index 02d4722d8474..981b19308e6f 100644
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
+			goto err_unsubscribe_event;
 	} else {
 		vmci_dev->exclusive_vectors = true;
 	}
@@ -871,13 +871,19 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 err_disable_msi:
 	pci_free_irq_vectors(pdev);
 
+err_unsubscribe_event:
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

