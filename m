Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49B6545EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347565AbiFJIUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347244AbiFJISl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:18:41 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E99B2453AE;
        Fri, 10 Jun 2022 01:18:24 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 389B816A1;
        Fri, 10 Jun 2022 11:19:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 389B816A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849146;
        bh=rCo7ZHGnBDh7rOvYOigVWDBCADB9Ck2vksFAutZCEoY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=pSb9doOz4dZmuXFT2Lvw5s3Rwwsp74BJilW1IsdDAjFCb0b3hV9O67/YG9ci9ocvA
         2alKC0qmx7E1P7f3s7Bm1nvQlO7McThNGMXKNhE6maviAa8DTF4DbgZl9/1W09SZj/
         +yEXYuAPYYK0hO5vVsUkHtcNOJnvaTahVuE9vyzQ=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:18:14 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 13/23] ata: libahci: Discard redundant force_port_map parameter
Date:   Fri, 10 Jun 2022 11:17:51 +0300
Message-ID: <20220610081801.11854-14-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are four port-map-related fields declared in the
ahci_host_priv structure and used to setup the HBA ports mapping. First
the ports-mapping is read from the PI register and immediately stored in
the saved_port_map field. If forced_port_map is initialized with non-zero
value then its value will have greater priority over the value read from
PI, thus it will override the saved_port_map field. That value will be
then masked by a non-zero mask_port_map field and after some sanity checks
it will be stored in the ahci_host_priv.port_map field as a final port
mapping.

As you can see the logic is a bit too complicated for such a simple task.
We can freely get rid from at least one of the fields with no change to
the implemented semantic. The force_port_map field can be replaced with
taking non-zero saved_port_map value into account. So if saved_port_map is
pre-initialized by the low level drivers (platform drivers) then it will
have greater priority over the value read from PI register and will be
used as actual HBA ports mapping later on. Thus the ports map forcing task
will be just transferred from force_port_map to the saved_port_map field.

This modification will perfectly fit into the feature of having OF-based
initialization of the HW-init HBA CSR fields we are about to introduce in
the next commit.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/ahci.c             |  2 +-
 drivers/ata/ahci.h             |  1 -
 drivers/ata/libahci.c          | 10 ++++++----
 drivers/ata/libahci_platform.c |  2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 397dfd27c90d..9bc8fa77e92f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -656,7 +656,7 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 {
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
 		dev_info(&pdev->dev, "JMB361 has only one port\n");
-		hpriv->force_port_map = 1;
+		hpriv->saved_port_map = 1;
 	}
 
 	/*
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index f501531bd1b3..0e66446a5883 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -327,7 +327,6 @@ struct ahci_port_priv {
 struct ahci_host_priv {
 	/* Input fields */
 	unsigned int		flags;		/* AHCI_HFLAG_* */
-	u32			force_port_map;	/* force port map */
 	u32			mask_port_map;	/* mask out particular bits */
 
 	void __iomem *		mmio;		/* bus-independent mem map */
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index cf8c7fd59ada..000a7072614f 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -453,7 +453,6 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 	 * reset.  Values without are used for driver operation.
 	 */
 	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
-	hpriv->saved_port_map = port_map = readl(mmio + HOST_PORTS_IMPL);
 
 	/* CAP2 register is only defined for AHCI 1.2 and later */
 	vers = readl(mmio + HOST_VERSION);
@@ -517,10 +516,13 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 		cap &= ~HOST_CAP_SXS;
 	}
 
-	if (hpriv->force_port_map && port_map != hpriv->force_port_map) {
+	/* Override the HBA ports mapping if the platform needs it */
+	port_map = readl(mmio + HOST_PORTS_IMPL);
+	if (hpriv->saved_port_map && port_map != hpriv->saved_port_map) {
 		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
-			 port_map, hpriv->force_port_map);
-		port_map = hpriv->force_port_map;
+			 port_map, hpriv->saved_port_map);
+		port_map = hpriv->saved_port_map;
+	} else {
 		hpriv->saved_port_map = port_map;
 	}
 
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index fcf00ffc7d12..efe640603f3f 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -524,7 +524,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	}
 
 	of_property_read_u32(dev->of_node,
-			     "ports-implemented", &hpriv->force_port_map);
+			     "ports-implemented", &hpriv->saved_port_map);
 
 	if (child_nodes) {
 		for_each_child_of_node(dev->of_node, child) {
-- 
2.35.1

