Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A010F5240E9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349319AbiEKXUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349112AbiEKXSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:18:34 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75F39188E5A;
        Wed, 11 May 2022 16:18:28 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5A2D2BBE;
        Thu, 12 May 2022 02:19:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 5A2D2BBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652311154;
        bh=kAvAo0Xyh3tr65Bbm2f0YNCTB8PUXE60W2QC7FBw7fk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=AfayDkrKrq4CdV3rUMm4RKLKG0f7ypDLYVrRDyiPS0KlGUVrMXVesEK2sOdtXqlL3
         Ih/ZPMCAhmzcdWIMHAtQpi+mmUYnaUPW/zi5HBF3tleLJHM9195CXx3Mp5hcd168XN
         piOhy4WoVDWXImyN3+tcFprKHbkLGYIeC/V1lRFI=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 May 2022 02:18:25 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 10/23] ata: libahci_platform: Parse ports-implemented property in resources getter
Date:   Thu, 12 May 2022 02:17:57 +0300
Message-ID: <20220511231810.4928-11-Sergey.Semin@baikalelectronics.ru>
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

The ports-implemented property is mainly used on the OF-based platforms
with no ports mapping initialized by a bootloader/BIOS firmware. Seeing
the same of_property_read_u32()-based pattern has already been implemented
in the generic AHCI LLDD (glue) driver and in the Mediatek, St AHCI
drivers let's move the property read procedure to the generic
ahci_platform_get_resources() method. Thus we'll have the forced ports
mapping feature supported for each OF-based platform which requires that,
and stop re-implementing the same pattern in there a bit simplifying the
code.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/ata/ahci_mtk.c         | 2 --
 drivers/ata/ahci_platform.c    | 3 ---
 drivers/ata/ahci_st.c          | 3 ---
 drivers/ata/libahci_platform.c | 3 +++
 4 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
index 1f6c85fde983..c056378e3e72 100644
--- a/drivers/ata/ahci_mtk.c
+++ b/drivers/ata/ahci_mtk.c
@@ -118,8 +118,6 @@ static int mtk_ahci_parse_property(struct ahci_host_priv *hpriv,
 				   SYS_CFG_SATA_EN);
 	}
 
-	of_property_read_u32(np, "ports-implemented", &hpriv->force_port_map);
-
 	return 0;
 }
 
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 28a8de5b48b9..9b56490ecbc3 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -56,9 +56,6 @@ static int ahci_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	of_property_read_u32(dev->of_node,
-			     "ports-implemented", &hpriv->force_port_map);
-
 	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
 		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
 
diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index 7526653c843b..068621099c00 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -168,9 +168,6 @@ static int st_ahci_probe(struct platform_device *pdev)
 
 	st_ahci_configure_oob(hpriv->mmio);
 
-	of_property_read_u32(dev->of_node,
-			     "ports-implemented", &hpriv->force_port_map);
-
 	err = ahci_platform_init_host(pdev, hpriv, &st_ahci_port_info,
 				      &ahci_platform_sht);
 	if (err) {
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 4e54e19f07b2..f7f9cac10cb1 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -512,6 +512,9 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		goto err_out;
 	}
 
+	of_property_read_u32(dev->of_node,
+			     "ports-implemented", &hpriv->force_port_map);
+
 	if (child_nodes) {
 		for_each_child_of_node(dev->of_node, child) {
 			u32 port;
-- 
2.35.1

