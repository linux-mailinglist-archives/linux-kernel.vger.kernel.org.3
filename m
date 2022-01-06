Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2EE486CEA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbiAFVyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:54:35 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:64027 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244871AbiAFVy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:54:28 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 5aiIntWdi2lVY5aiJnSlgt; Thu, 06 Jan 2022 22:54:27 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 06 Jan 2022 22:54:27 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 13/16] scsi: mptsas: Use dma_alloc_coherent() in mptsas_exp_repmanufacture_info()
Date:   Thu,  6 Jan 2022 22:54:26 +0100
Message-Id: <d78d4a5b096897932808ed7e3a4540db1687c25d.1641500561.git.christophe.jaillet@wanadoo.fr>
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


The only caller of mptsas_exp_repmanufacture_info() is
mptsas_probe_one_phy(). This function already calls sas_end_device_alloc()
or sas_expander_alloc(). They both already use GFP_KERNEL.

As no spin_lock is held at this point, it is safe to also use GFP_KERNEL
here.


[1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
[2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/message/fusion/mptsas.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 0363b2a2264d..9b40be04710c 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -2896,7 +2896,8 @@ mptsas_exp_repmanufacture_info(MPT_ADAPTER *ioc,
 
 	sz = sizeof(struct rep_manu_request) + sizeof(struct rep_manu_reply);
 
-	data_out = pci_alloc_consistent(ioc->pcidev, sz, &data_out_dma);
+	data_out = dma_alloc_coherent(&ioc->pcidev->dev, sz, &data_out_dma,
+				      GFP_KERNEL);
 	if (!data_out) {
 		printk(KERN_ERR "Memory allocation failure at %s:%d/%s()!\n",
 			__FILE__, __LINE__, __func__);
-- 
2.32.0

