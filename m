Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377685240CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349248AbiEKXTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349100AbiEKXSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:18:32 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB354185C82;
        Wed, 11 May 2022 16:18:27 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 88A0ABB9;
        Thu, 12 May 2022 02:19:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 88A0ABB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652311147;
        bh=ghQlSwR0k/fSp9BKKIsDgiCPjiVeG/HGpUtiHAxSYNU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=iyfHYuGLu7YL8QriBlEGMvDOL7zXT05QTba3ZZaklSm242SUuYd0Kt83aemFxdc6Y
         W4VUvOwCTbyWjEoX8juE2PZGuWhlzSY7oVmebth0dSVpsAwPjUsWsuUk/o7O4+duPb
         Icz4qhvRW4CoBLz/Mibk7fnhX8gBvtM1uQ8xrewc=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 May 2022 02:18:20 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 06/23] ata: libahci_platform: Convert to using platform devm-ioremap methods
Date:   Thu, 12 May 2022 02:17:53 +0300
Message-ID: <20220511231810.4928-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the IOMEM AHCI registers space is mapped by means of the
two functions invocation: platform_get_resource() is used to get the very
first memory resource and devm_ioremap_resource() is called to remap that
resource. Device-managed kernel API provides a handy wrapper to perform
the same in single function call: devm_platform_ioremap_resource().

While at it seeing many AHCI platform drivers rely on having the AHCI CSR
space marked with "ahci" name let's first try to find and remap the CSR
IO-mem with that name and only if it fails fallback to getting the very
first registers space platform resource.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Check whether there is "ahhi" reg resource before using the
  devm_platform_ioremap_resource_byname() method in order to prevent a
  false error message printed in the log (@Damien)
- Slightly update the patch title due to the change above and to be more
  specific that the platform device managed methods are utilized.
---
 drivers/ata/libahci_platform.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index f7f9bfcfc164..8c9fbcc3043b 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -404,8 +404,14 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 
 	devres_add(dev, hpriv);
 
-	hpriv->mmio = devm_ioremap_resource(dev,
-			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
+	/*
+	 * If the DT provided an "ahci" named resource, use it. Otherwise,
+	 * fallback to using the default first resource for the device node.
+	 */
+	if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci"))
+		hpriv->mmio = devm_platform_ioremap_resource_byname(pdev, "ahci");
+	else
+		hpriv->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hpriv->mmio)) {
 		rc = PTR_ERR(hpriv->mmio);
 		goto err_out;
-- 
2.35.1

