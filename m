Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA286486CE4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244822AbiAFVyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:54:17 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:60391 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244818AbiAFVyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:54:15 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 5ai5ntWZ52lVY5ai6nSlfv; Thu, 06 Jan 2022 22:54:14 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 06 Jan 2022 22:54:14 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 11/16] scsi: mptbase: Use dma_alloc_coherent() in 'mpt_alloc_fw_memory()'
Date:   Thu,  6 Jan 2022 22:54:13 +0100
Message-Id: <db3db9db219005b75659561d08117d312d0cfb13.1641500561.git.christophe.jaillet@wanadoo.fr>
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


mpt_alloc_fw_memory() should still use GFP_ATOMIC, because it can be
called from mpt_do_upload() which might sleep.


[1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
[2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Instead of using GFP_ATOMIC, we could pass the 'sleepFlag' from
mpt_do_upload() and check all other callers to pass the expected flag.
---
 drivers/message/fusion/mptbase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 5a3b7b56e85a..c4702ef87897 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -3512,7 +3512,8 @@ mpt_alloc_fw_memory(MPT_ADAPTER *ioc, int size)
 		rc = 0;
 		goto out;
 	}
-	ioc->cached_fw = pci_alloc_consistent(ioc->pcidev, size, &ioc->cached_fw_dma);
+	ioc->cached_fw = dma_alloc_coherent(&ioc->pcidev->dev, size,
+					    &ioc->cached_fw_dma, GFP_ATOMIC);
 	if (!ioc->cached_fw) {
 		printk(MYIOC_s_ERR_FMT "Unable to allocate memory for the cached firmware image!\n",
 		    ioc->name);
-- 
2.32.0

