Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA355486CEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244967AbiAFVzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:55:05 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:52910 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245072AbiAFVyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:54:44 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 5aiVntWht2lVY5aiWnSlhj; Thu, 06 Jan 2022 22:54:42 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 06 Jan 2022 22:54:42 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 15/16] scsi: mptctl: Use dma_alloc_coherent()
Date:   Thu,  6 Jan 2022 22:54:39 +0100
Message-Id: <516375d6d06114484533baf03aae351306100246.1641500561.git.christophe.jaillet@wanadoo.fr>
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


When memory is allocated in kbuf_alloc_2_sgl() GFP_KERNEL can be used
because this function already uses the GFP_USER flag for some memory
allocation and not spin_lock is taken in the between.

When memory is allocated in mptctl_do_mpt_command() GFP_KERNEL can be
used because this function already uses copy_from_user() and this
function can sleep.

When memory is allocated in mptctl_hp_hostinfo() GFP_KERNEL can be used
because this function already uses mpt_config() and this function has
an explicit might_sleep().

When memory is allocated in mptctl_hp_targetinfo() GFP_KERNEL can be used
because this function already uses mpt_config() and this function has
an explicit might_sleep().


[1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
[2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I'm a bit unsure about the use of GFP_KERNEL in kbuf_alloc_2_sgl().

In all conversion that I've done, GFP_USER was never used. I don't fully
understand the difference between GFP_USER and GFP_KERNEL.
---
 drivers/message/fusion/mptctl.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index 0f447179e3f5..03c8fb1795c2 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -1041,7 +1041,8 @@ kbuf_alloc_2_sgl(int bytes, u32 sgdir, int sge_offset, int *frags,
 	 * copying the data in this array into the correct place in the
 	 * request and chain buffers.
 	 */
-	sglbuf = pci_alloc_consistent(ioc->pcidev, MAX_SGL_BYTES, sglbuf_dma);
+	sglbuf = dma_alloc_coherent(&ioc->pcidev->dev, MAX_SGL_BYTES,
+				    sglbuf_dma, GFP_KERNEL);
 	if (sglbuf == NULL)
 		goto free_and_fail;
 
@@ -1062,9 +1063,9 @@ kbuf_alloc_2_sgl(int bytes, u32 sgdir, int sge_offset, int *frags,
 	while (bytes_allocd < bytes) {
 		this_alloc = min(alloc_sz, bytes-bytes_allocd);
 		buflist[buflist_ent].len = this_alloc;
-		buflist[buflist_ent].kptr = pci_alloc_consistent(ioc->pcidev,
-								 this_alloc,
-								 &pa);
+		buflist[buflist_ent].kptr = dma_alloc_coherent(&ioc->pcidev->dev,
+							       this_alloc,
+							       &pa, GFP_KERNEL);
 		if (buflist[buflist_ent].kptr == NULL) {
 			alloc_sz = alloc_sz / 2;
 			if (alloc_sz == 0) {
@@ -2105,8 +2106,9 @@ mptctl_do_mpt_command (MPT_ADAPTER *ioc, struct mpt_ioctl_command karg, void __u
 			}
 			flagsLength |= karg.dataOutSize;
 			bufOut.len = karg.dataOutSize;
-			bufOut.kptr = pci_alloc_consistent(
-					ioc->pcidev, bufOut.len, &dma_addr_out);
+			bufOut.kptr = dma_alloc_coherent(&ioc->pcidev->dev,
+							 bufOut.len,
+							 &dma_addr_out, GFP_KERNEL);
 
 			if (bufOut.kptr == NULL) {
 				rc = -ENOMEM;
@@ -2139,8 +2141,9 @@ mptctl_do_mpt_command (MPT_ADAPTER *ioc, struct mpt_ioctl_command karg, void __u
 			flagsLength |= karg.dataInSize;
 
 			bufIn.len = karg.dataInSize;
-			bufIn.kptr = pci_alloc_consistent(ioc->pcidev,
-					bufIn.len, &dma_addr_in);
+			bufIn.kptr = dma_alloc_coherent(&ioc->pcidev->dev,
+							bufIn.len,
+							&dma_addr_in, GFP_KERNEL);
 
 			if (bufIn.kptr == NULL) {
 				rc = -ENOMEM;
@@ -2400,7 +2403,9 @@ mptctl_hp_hostinfo(MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
 			/* Issue the second config page request */
 			cfg.action = MPI_CONFIG_ACTION_PAGE_READ_CURRENT;
 
-			pbuf = pci_alloc_consistent(ioc->pcidev, hdr.PageLength * 4, &buf_dma);
+			pbuf = dma_alloc_coherent(&ioc->pcidev->dev,
+						  hdr.PageLength * 4,
+						  &buf_dma, GFP_KERNEL);
 			if (pbuf) {
 				cfg.physAddr = buf_dma;
 				if (mpt_config(ioc, &cfg) == 0) {
@@ -2477,7 +2482,7 @@ mptctl_hp_hostinfo(MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
 	else
 		IstwiRWRequest->DeviceAddr = 0xB0;
 
-	pbuf = pci_alloc_consistent(ioc->pcidev, 4, &buf_dma);
+	pbuf = dma_alloc_coherent(&ioc->pcidev->dev, 4, &buf_dma, GFP_KERNEL);
 	if (!pbuf)
 		goto out;
 	ioc->add_sge((char *)&IstwiRWRequest->SGL,
@@ -2592,7 +2597,8 @@ mptctl_hp_targetinfo(MPT_ADAPTER *ioc, unsigned long arg)
        /* Get the data transfer speeds
         */
 	data_sz = ioc->spi_data.sdp0length * 4;
-	pg0_alloc = pci_alloc_consistent(ioc->pcidev, data_sz, &page_dma);
+	pg0_alloc = dma_alloc_coherent(&ioc->pcidev->dev, data_sz, &page_dma,
+				       GFP_KERNEL);
 	if (pg0_alloc) {
 		hdr.PageVersion = ioc->spi_data.sdp0version;
 		hdr.PageLength = data_sz;
@@ -2657,7 +2663,8 @@ mptctl_hp_targetinfo(MPT_ADAPTER *ioc, unsigned long arg)
 		/* Issue the second config page request */
 		cfg.action = MPI_CONFIG_ACTION_PAGE_READ_CURRENT;
 		data_sz = (int) cfg.cfghdr.hdr->PageLength * 4;
-		pg3_alloc = pci_alloc_consistent(ioc->pcidev, data_sz, &page_dma);
+		pg3_alloc = dma_alloc_coherent(&ioc->pcidev->dev, data_sz,
+					       &page_dma, GFP_KERNEL);
 		if (pg3_alloc) {
 			cfg.physAddr = page_dma;
 			cfg.pageAddr = (karg.hdr.channel << 8) | karg.hdr.id;
-- 
2.32.0

