Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266A84D944E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345093AbiCOGGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbiCOGGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:06:48 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8C937BCE;
        Mon, 14 Mar 2022 23:05:36 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ae8f9.dynamic.kabel-deutschland.de [95.90.232.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C634161EA1927;
        Tue, 15 Mar 2022 07:05:32 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: 3w-sas: Correct log level of several messages
Date:   Tue, 15 Mar 2022 07:05:00 +0100
Message-Id: <20220315060459.133090-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a Dell PowerEdge T630, Linux logs some 3w-sas warnings:

    $ dmesg | grep DMI:
    [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 2.5.4 08/17/2017
    $ dmesg --level=warn | grep 3w
    [   22.449617] 3w-sas: scsi12: AEN: INFO (0x04:0x0053): Battery capacity test is overdue:.
    [   22.680618] 3w-sas: scsi12: Found an LSI 3ware 9750-8e Controller at 0xc8040000, IRQ: 117.
    [   23.001611] 3w-sas: scsi12: Firmware FH9X 5.12.00.016, BIOS BE9X 5.11.00.007, Phys: 8.

These are obviously no warnings, and just informational messages. Look
through the file, and adapt the log level of several messages mostly
according to the level string in the message.

The message below is the only tricky change, as the log level actually
depends on the AEN severity determined by `twl_aen_severity_lookup()`.

	printk(KERN_INFO "3w-sas:%s AEN: %s (0x%02X:0x%04X): %s:%s.\n",
	       host,
	       twl_aen_severity_lookup(TW_SEV_OUT(header->status_block.severity__reserved)),
	       TW_MESSAGE_SOURCE_CONTROLLER_EVENT, aen, error_str,
	       header->err_specific_desc);

The AEN severity levels below exist.

	/* AEN severity table */
	static char *twl_aen_severity_table[] =
	{
		"None", "ERROR", "WARNING", "INFO", "DEBUG", NULL
	};

It’s demoted from a warning to an informational message nevertheless to
avoid adding if-else statements.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2: Fix KERN_ERROR to KERN_ERR

 drivers/scsi/3w-sas.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index 3ebe66151dcb..cf7657939d43 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -256,7 +256,7 @@ static void twl_aen_queue_event(TW_Device_Extension *tw_dev, TW_Command_Apache_H
 	event->parameter_len = strlen(header->err_specific_desc);
 	memcpy(event->parameter_data, header->err_specific_desc, event->parameter_len + 1 + strlen(error_str));
 	if (event->severity != TW_AEN_SEVERITY_DEBUG)
-		printk(KERN_WARNING "3w-sas:%s AEN: %s (0x%02X:0x%04X): %s:%s.\n",
+		printk(KERN_INFO "3w-sas:%s AEN: %s (0x%02X:0x%04X): %s:%s.\n",
 		       host,
 		       twl_aen_severity_lookup(TW_SEV_OUT(header->status_block.severity__reserved)),
 		       TW_MESSAGE_SOURCE_CONTROLLER_EVENT, aen, error_str,
@@ -873,14 +873,14 @@ static int twl_fill_sense(TW_Device_Extension *tw_dev, int i, int request_id, in
 	error = le16_to_cpu(header->status_block.error);
 	if ((error != TW_ERROR_LOGICAL_UNIT_NOT_SUPPORTED) && (error != TW_ERROR_UNIT_OFFLINE) && (error != TW_ERROR_INVALID_FIELD_IN_CDB)) {
 		if (print_host)
-			printk(KERN_WARNING "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
+			printk(KERN_ERR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
 			       tw_dev->host->host_no,
 			       TW_MESSAGE_SOURCE_CONTROLLER_ERROR,
 			       header->status_block.error,
 			       error_str,
 			       header->err_specific_desc);
 		else
-			printk(KERN_WARNING "3w-sas: ERROR: (0x%02X:0x%04X): %s:%s.\n",
+			printk(KERN_ERR "3w-sas: ERROR: (0x%02X:0x%04X): %s:%s.\n",
 			       TW_MESSAGE_SOURCE_CONTROLLER_ERROR,
 			       header->status_block.error,
 			       error_str,
@@ -1493,13 +1493,13 @@ static void __twl_shutdown(TW_Device_Extension *tw_dev)
 	/* Free up the IRQ */
 	free_irq(tw_dev->tw_pci_dev->irq, tw_dev);
 
-	printk(KERN_WARNING "3w-sas: Shutting down host %d.\n", tw_dev->host->host_no);
+	printk(KERN_INFO "3w-sas: Shutting down host %d.\n", tw_dev->host->host_no);
 
 	/* Tell the card we are shutting down */
 	if (twl_initconnection(tw_dev, 1, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x16, "Connection shutdown failed");
 	} else {
-		printk(KERN_WARNING "3w-sas: Shutdown complete.\n");
+		printk(KERN_INFO "3w-sas: Shutdown complete.\n");
 	}
 
 	/* Clear doorbell interrupt just before exit */
@@ -1631,7 +1631,7 @@ static int twl_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 
 	pci_set_drvdata(pdev, host);
 
-	printk(KERN_WARNING "3w-sas: scsi%d: Found an LSI 3ware %s Controller at 0x%llx, IRQ: %d.\n",
+	printk(KERN_INFO "3w-sas: scsi%d: Found an LSI 3ware %s Controller at 0x%llx, IRQ: %d.\n",
 	       host->host_no,
 	       (char *)twl_get_param(tw_dev, 1, TW_VERSION_TABLE,
 				     TW_PARAM_MODEL, TW_PARAM_MODEL_LENGTH),
@@ -1642,7 +1642,7 @@ static int twl_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 	if (ptr_phycount)
 		phycount = le32_to_cpu(*(int *)ptr_phycount);
 
-	printk(KERN_WARNING "3w-sas: scsi%d: Firmware %s, BIOS %s, Phys: %d.\n",
+	printk(KERN_INFO "3w-sas: scsi%d: Firmware %s, BIOS %s, Phys: %d.\n",
 	       host->host_no,
 	       (char *)twl_get_param(tw_dev, 1, TW_VERSION_TABLE,
 				     TW_PARAM_FWVER, TW_PARAM_FWVER_LENGTH),
@@ -1753,7 +1753,7 @@ static int __maybe_unused twl_suspend(struct device *dev)
 	struct Scsi_Host *host = dev_get_drvdata(dev);
 	TW_Device_Extension *tw_dev = (TW_Device_Extension *)host->hostdata;
 
-	printk(KERN_WARNING "3w-sas: Suspending host %d.\n", tw_dev->host->host_no);
+	printk(KERN_INFO "3w-sas: Suspending host %d.\n", tw_dev->host->host_no);
 	/* Disable interrupts */
 	TWL_MASK_INTERRUPTS(tw_dev);
 
@@ -1763,7 +1763,7 @@ static int __maybe_unused twl_suspend(struct device *dev)
 	if (twl_initconnection(tw_dev, 1, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x23, "Connection shutdown failed during suspend");
 	} else {
-		printk(KERN_WARNING "3w-sas: Suspend complete.\n");
+		printk(KERN_INFO "3w-sas: Suspend complete.\n");
 	}
 
 	/* Clear doorbell interrupt */
@@ -1780,7 +1780,7 @@ static int __maybe_unused twl_resume(struct device *dev)
 	struct Scsi_Host *host = pci_get_drvdata(pdev);
 	TW_Device_Extension *tw_dev = (TW_Device_Extension *)host->hostdata;
 
-	printk(KERN_WARNING "3w-sas: Resuming host %d.\n", tw_dev->host->host_no);
+	printk(KERN_INFO "3w-sas: Resuming host %d.\n", tw_dev->host->host_no);
 	pci_try_set_mwi(pdev);
 
 	retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
@@ -1811,7 +1811,7 @@ static int __maybe_unused twl_resume(struct device *dev)
 	/* Re-enable interrupts on the card */
 	TWL_UNMASK_INTERRUPTS(tw_dev);
 
-	printk(KERN_WARNING "3w-sas: Resume complete.\n");
+	printk(KERN_INFO "3w-sas: Resume complete.\n");
 	return 0;
 
 out_disable_device:
-- 
2.35.1

