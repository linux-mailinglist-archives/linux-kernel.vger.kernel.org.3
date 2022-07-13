Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EFE572D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiGMFct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbiGMFbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:31:07 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F05EB96B8;
        Tue, 12 Jul 2022 22:29:48 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id E1A5416CA;
        Wed, 13 Jul 2022 08:31:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com E1A5416CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1657690292;
        bh=ygMX+bu6gc/yMuo4QKjk1bUpr5VLHBbRrZJps6eSGfc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=jSKLdH1HfeUXinxvMbACTsI5hGLrRPYMnA1uP6hbaJlynSV4R5O5hqyhG+zq/pC/D
         YMKWmJQ++p9d3ajx56lWfNBuqvzFfVGUCn+VpQebI+VnDnKUP7cIpmggXW40Sh4klA
         EZJxiWLFtH7J1lRhcBlInCMV5+ztdSzTv5SgSEDM=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Jul 2022 08:29:37 +0300
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
Subject: [PATCH v5 15/23] ata: ahci: Convert __ahci_port_base to accepting hpriv as arguments
Date:   Wed, 13 Jul 2022 08:29:08 +0300
Message-ID: <20220713052917.27036-16-Sergey.Semin@baikalelectronics.ru>
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

The port base address may be required even before the ata_host instance is
initialized and activated, for instance in the ahci_save_initial_config()
method which we are about to update (consider this modification as a
preparation for that one). Seeing the __ahci_port_base() function isn't
used much it's the best candidate to provide the required functionality.
So let's convert it to accepting the ahci_host_priv structure pointer.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Hannes Reinecke <hare@suse.de>

---

Changelog v5:
- Fix some grammar notes in the patchlog. (@Damien)
---
 drivers/ata/ahci.c | 2 +-
 drivers/ata/ahci.h | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index bacb597a0d32..51c0c1dd91ea 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -690,7 +690,7 @@ static void ahci_pci_init_controller(struct ata_host *host)
 			mv = 2;
 		else
 			mv = 4;
-		port_mmio = __ahci_port_base(host, mv);
+		port_mmio = __ahci_port_base(hpriv, mv);
 
 		writel(0, port_mmio + PORT_IRQ_MASK);
 
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index cc4f40e6c924..5d9db5e7476c 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -432,10 +432,9 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht);
 void ahci_error_handler(struct ata_port *ap);
 u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked);
 
-static inline void __iomem *__ahci_port_base(struct ata_host *host,
+static inline void __iomem *__ahci_port_base(struct ahci_host_priv *hpriv,
 					     unsigned int port_no)
 {
-	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
 
 	return mmio + 0x100 + (port_no * 0x80);
@@ -443,7 +442,9 @@ static inline void __iomem *__ahci_port_base(struct ata_host *host,
 
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

