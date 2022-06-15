Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC63254C137
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbiFOFd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbiFOFdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:33:54 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518D449F83
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:33:52 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 1LezokaKRm7vs1Lf0omtfX; Wed, 15 Jun 2022 07:33:50 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 15 Jun 2022 07:33:50 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei WANG <wei_wang@realsil.com.cn>,
        Samuel Ortiz <sameo@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] misc: rtsx: Fix an error handling path in rtsx_pci_probe()
Date:   Wed, 15 Jun 2022 07:33:44 +0200
Message-Id: <e8dc41716cbf52fb37a12e70d8972848e69df6d6.1655271216.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after a successful idr_alloc() call, the corresponding
resource must be released with idr_remove() as already done in the .remove
function.

Update the error handling path to add the missing idr_remove() call.

Fixes: ada8a8a13b13 ("mfd: Add realtek pcie card reader driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/cardreader/rtsx_pcr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 2a2619e3c72c..f001d99bf366 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1507,7 +1507,7 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
 	pcr->remap_addr = ioremap(base, len);
 	if (!pcr->remap_addr) {
 		ret = -ENOMEM;
-		goto free_handle;
+		goto free_idr;
 	}
 
 	pcr->rtsx_resv_buf = dma_alloc_coherent(&(pcidev->dev),
@@ -1570,6 +1570,10 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
 			pcr->rtsx_resv_buf, pcr->rtsx_resv_buf_addr);
 unmap:
 	iounmap(pcr->remap_addr);
+free_idr:
+	spin_lock(&rtsx_pci_lock);
+	idr_remove(&rtsx_pci_idr, pcr->id);
+	spin_unlock(&rtsx_pci_lock);
 free_handle:
 	kfree(handle);
 free_pcr:
-- 
2.34.1

