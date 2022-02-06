Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5444AAE7C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 09:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiBFIkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 03:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiBFIkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 03:40:08 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33474C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 00:40:07 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id Gd5XnoDgy41cbGd5XnhTwE; Sun, 06 Feb 2022 09:40:04 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 06 Feb 2022 09:40:04 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] misc: alcor_pci: Fix an error handling path
Date:   Sun,  6 Feb 2022 09:39:54 +0100
Message-Id: <918a9875b7f67b7f8f123c4446452603422e8c5e.1644136776.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
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

A successful ida_simple_get() should be balanced by a corresponding
ida_simple_remove().

Add the missing call in the error handling path of the probe.

While at it, switch to ida_alloc()/ida_free() instead to
ida_simple_get()/ida_simple_remove().
The latter is deprecated and more verbose.

Fixes: 4f556bc04e3c ("misc: cardreader: add new Alcor Micro Cardreader PCI driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/cardreader/alcor_pci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index de6d44a158bb..3f514d77a843 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -266,7 +266,7 @@ static int alcor_pci_probe(struct pci_dev *pdev,
 	if (!priv)
 		return -ENOMEM;
 
-	ret = ida_simple_get(&alcor_pci_idr, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&alcor_pci_idr, GFP_KERNEL);
 	if (ret < 0)
 		return ret;
 	priv->id = ret;
@@ -280,7 +280,8 @@ static int alcor_pci_probe(struct pci_dev *pdev,
 	ret = pci_request_regions(pdev, DRV_NAME_ALCOR_PCI);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request region\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto error_free_ida;
 	}
 
 	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
@@ -324,6 +325,8 @@ static int alcor_pci_probe(struct pci_dev *pdev,
 
 error_release_regions:
 	pci_release_regions(pdev);
+error_free_ida:
+	ida_free(&alcor_pci_idr, priv->id);
 	return ret;
 }
 
@@ -337,7 +340,7 @@ static void alcor_pci_remove(struct pci_dev *pdev)
 
 	mfd_remove_devices(&pdev->dev);
 
-	ida_simple_remove(&alcor_pci_idr, priv->id);
+	ida_free(&alcor_pci_idr, priv->id);
 
 	pci_release_regions(pdev);
 	pci_set_drvdata(pdev, NULL);
-- 
2.32.0

