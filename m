Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B79486CE7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244857AbiAFVyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:54:24 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:60359 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244853AbiAFVyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:54:21 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 5aiCntWbS2lVY5aiCnSlgM; Thu, 06 Jan 2022 22:54:20 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 06 Jan 2022 22:54:20 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 12/16] scsi: mptbase: Use dma_alloc_coherent()
Date:   Thu,  6 Jan 2022 22:54:19 +0100
Message-Id: <3bea2452deb8cc8be65982e87efa4c6861caa01c.1641500561.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In [1], Christoph Hellwig has proposed to remove the wrappers in
include/linux/pci-dma-compat.h.

Some reasons why this API should be removed have been given by Julia
Lawall in [2].


In all these places where some memory is allocated GFP_KERNEL can be used
because they already call mpt_config() which has an explicit might_sleep().


[1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
[2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/message/fusion/mptbase.c | 52 ++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index c4702ef87897..e90adfa57950 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -300,8 +300,8 @@ mpt_is_discovery_complete(MPT_ADAPTER *ioc)
 	if (!hdr.ExtPageLength)
 		goto out;
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-	    &dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 	if (!buffer)
 		goto out;
 
@@ -4966,7 +4966,8 @@ GetLanConfigPages(MPT_ADAPTER *ioc)
 
 	if (hdr.PageLength > 0) {
 		data_sz = hdr.PageLength * 4;
-		ppage0_alloc = pci_alloc_consistent(ioc->pcidev, data_sz, &page0_dma);
+		ppage0_alloc = dma_alloc_coherent(&ioc->pcidev->dev, data_sz,
+						  &page0_dma, GFP_KERNEL);
 		rc = -ENOMEM;
 		if (ppage0_alloc) {
 			memset((u8 *)ppage0_alloc, 0, data_sz);
@@ -5013,7 +5014,8 @@ GetLanConfigPages(MPT_ADAPTER *ioc)
 
 	data_sz = hdr.PageLength * 4;
 	rc = -ENOMEM;
-	ppage1_alloc = pci_alloc_consistent(ioc->pcidev, data_sz, &page1_dma);
+	ppage1_alloc = dma_alloc_coherent(&ioc->pcidev->dev, data_sz,
+					  &page1_dma, GFP_KERNEL);
 	if (ppage1_alloc) {
 		memset((u8 *)ppage1_alloc, 0, data_sz);
 		cfg.physAddr = page1_dma;
@@ -5315,7 +5317,8 @@ GetIoUnitPage2(MPT_ADAPTER *ioc)
 	/* Read the config page */
 	data_sz = hdr.PageLength * 4;
 	rc = -ENOMEM;
-	ppage_alloc = pci_alloc_consistent(ioc->pcidev, data_sz, &page_dma);
+	ppage_alloc = dma_alloc_coherent(&ioc->pcidev->dev, data_sz,
+					 &page_dma, GFP_KERNEL);
 	if (ppage_alloc) {
 		memset((u8 *)ppage_alloc, 0, data_sz);
 		cfg.physAddr = page_dma;
@@ -5401,7 +5404,9 @@ mpt_GetScsiPortSettings(MPT_ADAPTER *ioc, int portnum)
 		 return -EFAULT;
 
 	if (header.PageLength > 0) {
-		pbuf = pci_alloc_consistent(ioc->pcidev, header.PageLength * 4, &buf_dma);
+		pbuf = dma_alloc_coherent(&ioc->pcidev->dev,
+					  header.PageLength * 4, &buf_dma,
+					  GFP_KERNEL);
 		if (pbuf) {
 			cfg.action = MPI_CONFIG_ACTION_PAGE_READ_CURRENT;
 			cfg.physAddr = buf_dma;
@@ -5481,7 +5486,9 @@ mpt_GetScsiPortSettings(MPT_ADAPTER *ioc, int portnum)
 	if (header.PageLength > 0) {
 		/* Allocate memory and read SCSI Port Page 2
 		 */
-		pbuf = pci_alloc_consistent(ioc->pcidev, header.PageLength * 4, &buf_dma);
+		pbuf = dma_alloc_coherent(&ioc->pcidev->dev,
+					  header.PageLength * 4, &buf_dma,
+					  GFP_KERNEL);
 		if (pbuf) {
 			cfg.action = MPI_CONFIG_ACTION_PAGE_READ_NVRAM;
 			cfg.physAddr = buf_dma;
@@ -5664,8 +5671,8 @@ mpt_inactive_raid_volumes(MPT_ADAPTER *ioc, u8 channel, u8 id)
 	if (!hdr.PageLength)
 		goto out;
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.PageLength * 4,
-	    &dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 
 	if (!buffer)
 		goto out;
@@ -5757,8 +5764,8 @@ mpt_raid_phys_disk_pg0(MPT_ADAPTER *ioc, u8 phys_disk_num,
 		goto out;
 	}
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.PageLength * 4,
-	    &dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 
 	if (!buffer) {
 		rc = -ENOMEM;
@@ -5824,8 +5831,8 @@ mpt_raid_phys_disk_get_num_paths(MPT_ADAPTER *ioc, u8 phys_disk_num)
 		goto out;
 	}
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.PageLength * 4,
-	    &dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 
 	if (!buffer) {
 		rc = 0;
@@ -5896,8 +5903,8 @@ mpt_raid_phys_disk_pg1(MPT_ADAPTER *ioc, u8 phys_disk_num,
 		goto out;
 	}
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.PageLength * 4,
-	    &dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 
 	if (!buffer) {
 		rc = -ENOMEM;
@@ -5991,7 +5998,8 @@ mpt_findImVolumes(MPT_ADAPTER *ioc)
 		return -EFAULT;
 
 	iocpage2sz = header.PageLength * 4;
-	pIoc2 = pci_alloc_consistent(ioc->pcidev, iocpage2sz, &ioc2_dma);
+	pIoc2 = dma_alloc_coherent(&ioc->pcidev->dev, iocpage2sz, &ioc2_dma,
+				   GFP_KERNEL);
 	if (!pIoc2)
 		return -ENOMEM;
 
@@ -6058,7 +6066,8 @@ mpt_read_ioc_pg_3(MPT_ADAPTER *ioc)
 	/* Read Header good, alloc memory
 	 */
 	iocpage3sz = header.PageLength * 4;
-	pIoc3 = pci_alloc_consistent(ioc->pcidev, iocpage3sz, &ioc3_dma);
+	pIoc3 = dma_alloc_coherent(&ioc->pcidev->dev, iocpage3sz, &ioc3_dma,
+				   GFP_KERNEL);
 	if (!pIoc3)
 		return 0;
 
@@ -6109,7 +6118,8 @@ mpt_read_ioc_pg_4(MPT_ADAPTER *ioc)
 
 	if ( (pIoc4 = ioc->spi_data.pIocPg4) == NULL ) {
 		iocpage4sz = (header.PageLength + 4) * 4; /* Allow 4 additional SEP's */
-		pIoc4 = pci_alloc_consistent(ioc->pcidev, iocpage4sz, &ioc4_dma);
+		pIoc4 = dma_alloc_coherent(&ioc->pcidev->dev, iocpage4sz,
+					   &ioc4_dma, GFP_KERNEL);
 		if (!pIoc4)
 			return;
 		ioc->alloc_total += iocpage4sz;
@@ -6165,7 +6175,8 @@ mpt_read_ioc_pg_1(MPT_ADAPTER *ioc)
 	/* Read Header good, alloc memory
 	 */
 	iocpage1sz = header.PageLength * 4;
-	pIoc1 = pci_alloc_consistent(ioc->pcidev, iocpage1sz, &ioc1_dma);
+	pIoc1 = dma_alloc_coherent(&ioc->pcidev->dev, iocpage1sz, &ioc1_dma,
+				   GFP_KERNEL);
 	if (!pIoc1)
 		return;
 
@@ -6245,7 +6256,8 @@ mpt_get_manufacturing_pg_0(MPT_ADAPTER *ioc)
 		goto out;
 
 	cfg.action = MPI_CONFIG_ACTION_PAGE_READ_CURRENT;
-	pbuf = pci_alloc_consistent(ioc->pcidev, hdr.PageLength * 4, &buf_dma);
+	pbuf = dma_alloc_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+				  &buf_dma, GFP_KERNEL);
 	if (!pbuf)
 		goto out;
 
-- 
2.32.0

