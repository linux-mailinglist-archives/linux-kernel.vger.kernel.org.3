Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1B5240BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349177AbiEKXTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349089AbiEKXSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:18:31 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B109A185C81;
        Wed, 11 May 2022 16:18:27 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7B117BB7;
        Thu, 12 May 2022 02:19:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 7B117BB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652311146;
        bh=zHaHwKz/yCVMvZJtPXeZzX7KArDCiwAc5Mq+USo7pmc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=jpga97EH1TqTILGk4JciWYBj5bLH2hcD4zJxDepe108OwpDIfUknqkxlc5DwX0nSK
         3dhVQcvMr8QsyZhdUSiy30qmFtNRDduwFpE+lVP506rpVsIkKeCPG4BHsRmJbo2v0r
         ocKek09uRwAMQO189DPI5bBXMPFKwF9BcRYlHGzM=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 May 2022 02:18:18 +0300
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
Subject: [PATCH v3 05/23] ata: libahci_platform: Explicitly set rc on devres_alloc failure
Date:   Thu, 12 May 2022 02:17:52 +0300
Message-ID: <20220511231810.4928-6-Sergey.Semin@baikalelectronics.ru>
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

It's better for readability and maintainability to explicitly assign an
error number to the variable used then as a return value from the method
on the cleanup-on-error path. So adding new code in the method we won't
have to think whether the overridden rc-variable is set afterward in case
of an error. Saving one line of code doesn't worth it especially seeing
the rest of the ahci_platform_get_resources() function errors handling
blocks do explicitly write errno to rc.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Drop rc variable initialization (@Damien)
---
 drivers/ata/libahci_platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 32495ae96567..f7f9bfcfc164 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -389,7 +389,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	struct ahci_host_priv *hpriv;
 	struct clk *clk;
 	struct device_node *child;
-	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
+	int i, enabled_ports = 0, rc, child_nodes;
 	u32 mask_port_map = 0;
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
@@ -397,8 +397,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 
 	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
 			     GFP_KERNEL);
-	if (!hpriv)
+	if (!hpriv) {
+		rc = -ENOMEM;
 		goto err_out;
+	}
 
 	devres_add(dev, hpriv);
 
-- 
2.35.1

