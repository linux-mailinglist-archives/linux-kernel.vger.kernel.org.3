Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BE5486CEE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244951AbiAFVzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:55:03 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:57105 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244851AbiAFVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:54:35 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 5aiPntWfy2lVY5aiPnSlhK; Thu, 06 Jan 2022 22:54:34 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 06 Jan 2022 22:54:34 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 14/16] scsi: mptsas: Use dma_alloc_coherent()
Date:   Thu,  6 Jan 2022 22:54:33 +0100
Message-Id: <443b81ecb08b2fe6f789bb2fdff13a53c809e401.1641500561.git.christophe.jaillet@wanadoo.fr>
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
 drivers/message/fusion/mptsas.c | 40 ++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 9b40be04710c..4acd8f9a48e1 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -702,8 +702,8 @@ mptsas_add_device_component_starget_ir(MPT_ADAPTER *ioc,
 	if (!hdr.PageLength)
 		goto out;
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.PageLength * 4,
-	    &dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 
 	if (!buffer)
 		goto out;
@@ -1399,8 +1399,8 @@ mptsas_sas_enclosure_pg0(MPT_ADAPTER *ioc, struct mptsas_enclosure *enclosure,
 		goto out;
 	}
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-			&dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 	if (!buffer) {
 		error = -ENOMEM;
 		goto out;
@@ -2058,8 +2058,8 @@ static int mptsas_get_linkerrors(struct sas_phy *phy)
 	if (!hdr.ExtPageLength)
 		return -ENXIO;
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-				      &dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -2412,8 +2412,8 @@ mptsas_sas_io_unit_pg0(MPT_ADAPTER *ioc, struct mptsas_portinfo *port_info)
 		goto out;
 	}
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-					    &dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 	if (!buffer) {
 		error = -ENOMEM;
 		goto out;
@@ -2487,8 +2487,8 @@ mptsas_sas_io_unit_pg1(MPT_ADAPTER *ioc)
 		goto out;
 	}
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-					    &dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 	if (!buffer) {
 		error = -ENOMEM;
 		goto out;
@@ -2551,8 +2551,8 @@ mptsas_sas_phy_pg0(MPT_ADAPTER *ioc, struct mptsas_phyinfo *phy_info,
 		goto out;
 	}
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-				      &dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 	if (!buffer) {
 		error = -ENOMEM;
 		goto out;
@@ -2614,8 +2614,8 @@ mptsas_sas_device_pg0(MPT_ADAPTER *ioc, struct mptsas_devinfo *device_info,
 		goto out;
 	}
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-				      &dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 	if (!buffer) {
 		error = -ENOMEM;
 		goto out;
@@ -2697,8 +2697,8 @@ mptsas_sas_expander_pg0(MPT_ADAPTER *ioc, struct mptsas_portinfo *port_info,
 		goto out;
 	}
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-				      &dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 	if (!buffer) {
 		error = -ENOMEM;
 		goto out;
@@ -2777,8 +2777,8 @@ mptsas_sas_expander_pg1(MPT_ADAPTER *ioc, struct mptsas_phyinfo *phy_info,
 		goto out;
 	}
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-				      &dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 	if (!buffer) {
 		error = -ENOMEM;
 		goto out;
@@ -4273,8 +4273,8 @@ mptsas_adding_inactive_raid_components(MPT_ADAPTER *ioc, u8 channel, u8 id)
 	if (!hdr.PageLength)
 		goto out;
 
-	buffer = pci_alloc_consistent(ioc->pcidev, hdr.PageLength * 4,
-	    &dma_handle);
+	buffer = dma_alloc_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+				    &dma_handle, GFP_KERNEL);
 
 	if (!buffer)
 		goto out;
-- 
2.32.0

