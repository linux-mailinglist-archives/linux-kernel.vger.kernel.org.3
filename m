Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460935240D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349208AbiEKXTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349099AbiEKXSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:18:31 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB4DB185C87;
        Wed, 11 May 2022 16:18:27 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id CE5DEBBC;
        Thu, 12 May 2022 02:19:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru CE5DEBBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652311150;
        bh=6HMO+sQEG0eDggOCw6HtXOnAgHhA4OiT4KgL3s0gPcs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Sk8pjUUXEyBxiZ4ioFh8b8YbNQMuFp2HBMoCXfD6d7hwQcSgXp0QJRBsm9fki/Kbg
         uxzx13shOrH4+fJR0aPoJtSZad86xAfCQ+FBu5qeb5knhG7hmeJZ7+CB4TZJQwjhIf
         pLeco7WRX//pzQx58tpIXE2glxStMasirHAMK7JA=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 May 2022 02:18:22 +0300
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
Subject: [PATCH v3 08/23] ata: libahci_platform: Add function returning a clock-handle by id
Date:   Thu, 12 May 2022 02:17:55 +0300
Message-ID: <20220511231810.4928-9-Sergey.Semin@baikalelectronics.ru>
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

Since all the clocks are retrieved by the method
ahci_platform_get_resources() there is no need for the LLD (glue) drivers
to be looking for some particular of them in the kernel clocks table
again. Instead we suggest to add a simple method returning a
device-specific clock with passed connection ID if it is managed to be
found. Otherwise the function will return NULL. Thus the glue-drivers
won't need to either manually touching the hpriv->clks array or calling
clk_get()-friends. The AHCI platform drivers will be able to use the new
function right after the ahci_platform_get_resources() method invocation
and up to the device removal.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Fix some grammar mistakes in the method description.
---
 drivers/ata/libahci_platform.c | 27 +++++++++++++++++++++++++++
 include/linux/ahci_platform.h  |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 3cff86c225fd..7ff6626fd569 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -94,6 +94,33 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
 }
 EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
 
+/**
+ * ahci_platform_find_clk - Find platform clock
+ * @hpriv: host private area to store config values
+ * @con_id: clock connection ID
+ *
+ * This function returns a pointer to the clock descriptor of the clock with
+ * the passed ID.
+ *
+ * RETURNS:
+ * Pointer to the clock descriptor on success otherwise NULL
+ */
+struct clk *ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id)
+{
+	struct clk *clk = NULL;
+	int i;
+
+	for (i = 0; i < hpriv->n_clks; i++) {
+		if (!strcmp(hpriv->clks[i].id, con_id)) {
+			clk = hpriv->clks[i].clk;
+			break;
+		}
+	}
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(ahci_platform_find_clk);
+
 /**
  * ahci_platform_enable_clks - Enable platform clocks
  * @hpriv: host private area to store config values
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 49e5383d4222..fd964e6a68d6 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -13,6 +13,7 @@
 
 #include <linux/compiler.h>
 
+struct clk;
 struct device;
 struct ata_port_info;
 struct ahci_host_priv;
@@ -21,6 +22,8 @@ struct scsi_host_template;
 
 int ahci_platform_enable_phys(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_phys(struct ahci_host_priv *hpriv);
+struct clk *
+ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id);
 int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
 int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv);
-- 
2.35.1

