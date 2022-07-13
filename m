Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07DE572D43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiGMFcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbiGMFbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:31:01 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EC48A8501;
        Tue, 12 Jul 2022 22:29:45 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id B0B6316C7;
        Wed, 13 Jul 2022 08:31:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com B0B6316C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1657690290;
        bh=6quWTjpWV5I5nvvlfLaHvQO0AsMBbCA9KCjJzXHXt+k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=m2PqIO04YkRVhhrVF4pTxOi+YxV0BrcDWHoSm5gsU+13Pq9NJIFa2l7sA6B6kTX7x
         1FBGvj/YKTEreoGtlWvGe/EC3bGxvgTa9W6cdWPkE/uQ9YYXlTo9eNMjKhue9/X3rG
         19rRGo6dc6ikq4BgM/sARn+wwYt+YIZC2RgOPEMk=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Jul 2022 08:29:34 +0300
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
Subject: [PATCH v5 13/23] ata: libahci: Discard redundant force_port_map parameter
Date:   Wed, 13 Jul 2022 08:29:06 +0300
Message-ID: <20220713052917.27036-14-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
References: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
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
index c1eca72b4575..bacb597a0d32 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -657,7 +657,7 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 {
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
 		dev_info(&pdev->dev, "JMB361 has only one port\n");
-		hpriv->force_port_map = 1;
+		hpriv->saved_port_map = 1;
 	}
 
 	/*
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 27cab4e909a5..cc4f40e6c924 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -328,7 +328,6 @@ struct ahci_port_priv {
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
index 307908a0d69d..691737b1a5ba 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -527,7 +527,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	}
 
 	of_property_read_u32(dev->of_node,
-			     "ports-implemented", &hpriv->force_port_map);
+			     "ports-implemented", &hpriv->saved_port_map);
 
 	if (child_nodes) {
 		for_each_child_of_node(dev->of_node, child) {
-- 
2.35.1

