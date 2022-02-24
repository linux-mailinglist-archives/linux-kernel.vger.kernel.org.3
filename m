Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120D74C36D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiBXUXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiBXUXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:23:02 -0500
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB57B17B0F1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:22:31 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id NKdAnAst4eKJJNKdBn2zGZ; Thu, 24 Feb 2022 21:22:30 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 24 Feb 2022 21:22:30 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jorgen Hansen <jhansen@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        pv-drivers@vmware.com
Subject: [PATCH v2 2/3] VMCI: No need to clear memory after a dma_alloc_coherent() call
Date:   Thu, 24 Feb 2022 21:22:27 +0100
Message-Id: <3e8c0bfaa77500e22d6c90f249da1c53dbae716e.1645734041.git.christophe.jaillet@wanadoo.fr>
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

dma_alloc_coherent() already clear the allocated memory, there is no need
to explicitly call memset().
This saves a few cycles and a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Vishnu Dasa <vdasa@vmware.com>
---
v2:
   - no change
---
 drivers/misc/vmw_vmci/vmci_guest.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index 1a1858742f75..02d4722d8474 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -706,13 +706,11 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 		vmci_dev->notification_bitmap = dma_alloc_coherent(
 			&pdev->dev, PAGE_SIZE, &vmci_dev->notification_base,
 			GFP_KERNEL);
-		if (!vmci_dev->notification_bitmap) {
+		if (!vmci_dev->notification_bitmap)
 			dev_warn(&pdev->dev,
 				 "Unable to allocate notification bitmap\n");
-		} else {
-			memset(vmci_dev->notification_bitmap, 0, PAGE_SIZE);
+		else
 			caps_in_use |= VMCI_CAPS_NOTIFICATIONS;
-		}
 	}
 
 	if (mmio_base != NULL) {
-- 
2.32.0

