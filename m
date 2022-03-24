Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAADF4E9B57
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbiC1Pq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbiC1PqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:46:10 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D689B4B1C7;
        Mon, 28 Mar 2022 08:44:19 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D9DF81E28CF;
        Thu, 24 Mar 2022 03:16:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru D9DF81E28CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648080993;
        bh=aK+AXzgy4GQ6VXYGDSa5RLQTkFNgn+a6IY6MpvTdvSA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=qgT6k5uK7KTnYXHGSbbgOrwoHmrK5C5TonTFeskkQZVt8ILs029HEPKbMOCYpjKZQ
         M9MX3rsKW7FkEv45xzr2fK7/0qNP1tVw+j5ZJlrayMs3emmpVZUr3mvamHbwSyH4Ku
         8zpM4xiIUNLFNe8h8G5oDxjD4PsRbYYvLWCMQkb4=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 03:16:33 +0300
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
Subject: [PATCH 04/21] ata: libahci_platform: Convert to using handy devm-ioremap methods
Date:   Thu, 24 Mar 2022 03:16:11 +0300
Message-ID: <20220324001628.13028-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/ata/libahci_platform.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 1bd2f1686239..8eabbb5f208c 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -404,11 +404,13 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 
 	devres_add(dev, hpriv);
 
-	hpriv->mmio = devm_ioremap_resource(dev,
-			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
+	hpriv->mmio = devm_platform_ioremap_resource_byname(pdev, "ahci");
 	if (IS_ERR(hpriv->mmio)) {
-		rc = PTR_ERR(hpriv->mmio);
-		goto err_out;
+		hpriv->mmio = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(hpriv->mmio)) {
+			rc = PTR_ERR(hpriv->mmio);
+			goto err_out;
+		}
 	}
 
 	for (i = 0; i < AHCI_MAX_CLKS; i++) {
-- 
2.35.1

