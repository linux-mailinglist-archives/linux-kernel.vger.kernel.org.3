Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E125240E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349158AbiEKXTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349126AbiEKXSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:18:35 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9598185C82;
        Wed, 11 May 2022 16:18:32 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id EECD4BB4;
        Thu, 12 May 2022 02:19:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru EECD4BB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652311159;
        bh=uSCjkMj4dYFheq+/FSKGiwDai6D+f5d7WfzOKA5SOcI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=NYGNnfRkgpOSnzsg0m1FA7rPtauvNzmQ9RlW5ixN6TudX+cubC/AcodDmU49N658F
         2eNZ+J+Zhq+P+Qq+AmksHkzkWCtCTAOitotcrmrBPOX6aHA2BUf5DeRPGbq3osS1QT
         B3gzM1A/YJefZ3QeSkx2UVldv/EoshF3m7FZD7+s=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 May 2022 02:18:32 +0300
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
Subject: [PATCH v3 16/23] ata: ahci: Convert __ahci_port_base to accepting hpriv as arguments
Date:   Thu, 12 May 2022 02:18:03 +0300
Message-ID: <20220511231810.4928-17-Sergey.Semin@baikalelectronics.ru>
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

It may get required to retrieve the port-base address even before the
ata_host instance is initialized and activated, for instance in the
ahci_save_initial_config() method which we about to update (consider this
modification as a preparation for that one). Seeing the __ahci_port_base()
function isn't used much it's the best candidate to provide the required
functionality. So let's convert it to accepting the ahci_host_priv
structure pointer.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/ata/ahci.c | 2 +-
 drivers/ata/ahci.h | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9bc8fa77e92f..d14d74649e0e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -689,7 +689,7 @@ static void ahci_pci_init_controller(struct ata_host *host)
 			mv = 2;
 		else
 			mv = 4;
-		port_mmio = __ahci_port_base(host, mv);
+		port_mmio = __ahci_port_base(hpriv, mv);
 
 		writel(0, port_mmio + PORT_IRQ_MASK);
 
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 0e66446a5883..8b9826533ae5 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -431,10 +431,9 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht);
 void ahci_error_handler(struct ata_port *ap);
 u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked);
 
-static inline void __iomem *__ahci_port_base(struct ata_host *host,
+static inline void __iomem *__ahci_port_base(struct ahci_host_priv *hpriv,
 					     unsigned int port_no)
 {
-	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
 
 	return mmio + 0x100 + (port_no * 0x80);
@@ -442,7 +441,9 @@ static inline void __iomem *__ahci_port_base(struct ata_host *host,
 
 static inline void __iomem *ahci_port_base(struct ata_port *ap)
 {
-	return __ahci_port_base(ap->host, ap->port_no);
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+
+	return __ahci_port_base(hpriv, ap->port_no);
 }
 
 static inline int ahci_nr_ports(u32 cap)
-- 
2.35.1

