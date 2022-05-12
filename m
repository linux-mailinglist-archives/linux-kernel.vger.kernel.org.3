Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AC95240EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349335AbiEKXVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349166AbiEKXTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:19:03 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33DC419CB70;
        Wed, 11 May 2022 16:18:39 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1307EBAA;
        Thu, 12 May 2022 02:19:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 1307EBAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652311166;
        bh=0oMK30WdtHcOYdp8lm9r9navitmXPLaU64ebdlFu5B0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=PQWn75V0P2YD2KSr3PwGw8PY+VYycMwyFxMcW5J1886hUZ0xpksVAzHU0o2K2xbqP
         oGUoQ1e4S3nbBeUhHyHW6MA6XTCG4JeVgWXrVLs5p5g/PpqhNL36I2kXH2yz+RuZfg
         jXbA8EHWFgjlz9b7OlVuIjS5nowwb56IFOlnMYjA=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 May 2022 02:18:38 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 21/23] ata: ahci-dwc: Add platform-specific quirks support
Date:   Thu, 12 May 2022 02:18:08 +0300
Message-ID: <20220511231810.4928-22-Sergey.Semin@baikalelectronics.ru>
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

Some DWC AHCI SATA IP-core derivatives require to perform small platform
or IP-core specific setups. They are too small to be placed in a dedicated
driver. It's just much easier to have a set of quirks for them right in
the DWC AHCI driver code. Since we are about to add such platform support,
as a pre-requisite we introduce a platform-data based DWC AHCI quirks API.
The platform data can be used to define the flags passed to the
ahci_platform_get_resources() method, additional AHCI host-flags and a set
of callbacks to initialize, re-initialize and clear the platform settings.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Change the local objects prefix from 'dwc_ahci_' to 'ahci_dwc_'.
  (@Damien)
---
 drivers/ata/ahci_dwc.c | 52 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
index 73380aaaebab..f987efa1ad59 100644
--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -90,7 +90,16 @@
 #define AHCI_DWC_PORT_PHYCR		0x74
 #define AHCI_DWC_PORT_PHYSR		0x78
 
+struct ahci_dwc_plat_data {
+	unsigned int pflags;
+	unsigned int hflags;
+	int (*init)(struct ahci_host_priv *hpriv);
+	int (*reinit)(struct ahci_host_priv *hpriv);
+	void (*clear)(struct ahci_host_priv *hpriv);
+};
+
 struct ahci_dwc_host_priv {
+	const struct ahci_dwc_plat_data *pdata;
 	struct platform_device *pdev;
 
 	u32 timv;
@@ -107,11 +116,15 @@ static struct ahci_host_priv *ahci_dwc_get_resources(struct platform_device *pde
 		return ERR_PTR(-ENOMEM);
 
 	dpriv->pdev = pdev;
+	dpriv->pdata = device_get_match_data(&pdev->dev);
+	if (!dpriv->pdata)
+		return ERR_PTR(-EINVAL);
 
-	hpriv = ahci_platform_get_resources(pdev, AHCI_PLATFORM_GET_RESETS);
+	hpriv = ahci_platform_get_resources(pdev, dpriv->pdata->pflags);
 	if (IS_ERR(hpriv))
 		return hpriv;
 
+	hpriv->flags |= dpriv->pdata->hflags;
 	hpriv->plat_data = (void *)dpriv;
 
 	return hpriv;
@@ -242,22 +255,33 @@ static int ahci_dwc_init_dmacr(struct ahci_host_priv *hpriv)
 
 static int ahci_dwc_init_host(struct ahci_host_priv *hpriv)
 {
+	struct ahci_dwc_host_priv *dpriv = hpriv->plat_data;
 	int rc;
 
 	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
 		return rc;
 
+	if (dpriv->pdata->init) {
+		rc = dpriv->pdata->init(hpriv);
+		if (rc)
+			goto err_disable_resources;
+	}
+
 	ahci_dwc_check_cap(hpriv);
 
 	ahci_dwc_init_timer(hpriv);
 
 	rc = ahci_dwc_init_dmacr(hpriv);
 	if (rc)
-		goto err_disable_resources;
+		goto err_clear_platform;
 
 	return 0;
 
+err_clear_platform:
+	if (dpriv->pdata->clear)
+		dpriv->pdata->clear(hpriv);
+
 err_disable_resources:
 	ahci_platform_disable_resources(hpriv);
 
@@ -275,6 +299,12 @@ static int ahci_dwc_reinit_host(struct ahci_host_priv *hpriv)
 	if (rc)
 		return rc;
 
+	if (dpriv->pdata->reinit) {
+		rc = dpriv->pdata->reinit(hpriv);
+		if (rc)
+			goto err_disable_resources;
+	}
+
 	writel(dpriv->timv, hpriv->mmio + AHCI_DWC_HOST_TIMER1MS);
 
 	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
@@ -283,10 +313,20 @@ static int ahci_dwc_reinit_host(struct ahci_host_priv *hpriv)
 	}
 
 	return 0;
+
+err_disable_resources:
+	ahci_platform_disable_resources(hpriv);
+
+	return rc;
 }
 
 static void ahci_dwc_clear_host(struct ahci_host_priv *hpriv)
 {
+	struct ahci_dwc_host_priv *dpriv = hpriv->plat_data;
+
+	if (dpriv->pdata->clear)
+		dpriv->pdata->clear(hpriv);
+
 	ahci_platform_disable_resources(hpriv);
 }
 
@@ -371,9 +411,13 @@ static int ahci_dwc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(ahci_dwc_pm_ops, ahci_dwc_suspend, ahci_dwc_resume);
 
+struct ahci_dwc_plat_data ahci_dwc_plat = {
+	.pflags = AHCI_PLATFORM_GET_RESETS,
+};
+
 static const struct of_device_id ahci_dwc_of_match[] = {
-	{ .compatible = "snps,dwc-ahci", },
-	{ .compatible = "snps,spear-ahci", },
+	{ .compatible = "snps,dwc-ahci", &ahci_dwc_plat },
+	{ .compatible = "snps,spear-ahci", &ahci_dwc_plat },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_dwc_of_match);
-- 
2.35.1

