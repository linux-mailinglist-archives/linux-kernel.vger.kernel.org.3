Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ACA5B0289
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiIGLLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiIGLKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:10:39 -0400
X-Greylist: delayed 1068 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Sep 2022 04:10:20 PDT
Received: from spamfilter.jmicron.com (spamfilter.jmicron.com [220.130.51.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA73A193CA;
        Wed,  7 Sep 2022 04:10:19 -0700 (PDT)
Received: from spamfilter.jmicron.com (localhost [127.0.0.2] (may be forged))
        by spamfilter.jmicron.com with ESMTP id 287ArVKY086128;
        Wed, 7 Sep 2022 18:53:31 +0800 (+08)
        (envelope-from mdlin@jmicron.com)
Received: from JMEH601.jmicron.com (jmeh601.jmicron.com [10.88.10.17])
        by spamfilter.jmicron.com with ESMTP id 287ArNaW086108;
        Wed, 7 Sep 2022 18:53:23 +0800 (+08)
        (envelope-from mdlin@jmicron.com)
Received: from JMEH601.jmicron.com (10.88.10.17) by JMEH601.jmicron.com
 (10.88.10.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.28; Wed, 7
 Sep 2022 18:52:23 +0800
Received: from localhost.localdomain (10.88.20.234) by JMEH601.jmicron.com
 (10.88.10.17) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 7 Sep 2022 18:52:23 +0800
From:   MD Lin <mdlin@jmicron.com>
To:     <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mdlin@jmicron.com>, <kevinliu@jmicron.com>,
        <charonchen@jmicron.com>, <corahuang@jmicron.com>,
        <mhchen@jmicron.com>, <georgechao@jmicron.com>,
        <banks@jmicron.com>, <tzuwei@jmicron.com>
Subject: [PATCH] libata/ahci: quirk for JMB585/JMB582
Date:   Wed, 7 Sep 2022 10:51:30 +0000
Message-ID: <20220907105130.13797-1-mdlin@jmicron.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-DNSRBL: 
X-MAIL: spamfilter.jmicron.com 287ArVKY086128
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a quirk, which enable error bit handling functions
and SATA configuration for JMicron JMB585/JMB582.

Signed-off-by: MD Lin <mdlin@jmicron.com>
---
 drivers/ata/ahci.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 505920d45..b0768fae3 100755
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1657,6 +1657,68 @@ static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hp
 	}
 }
 
+static void ahci_jmb585_write_sata_phy(void __iomem *mmio, u32 addr, u32 data)
+{
+	writel((addr & 0x01FFFUL) + (1UL << 18UL), mmio + 0xC0);
+	writel(data, mmio + 0xC8);
+}
+
+static void ahci_jmicron_585_quirk(void __iomem *mmio)
+{
+	u32 pi = readl(mmio + HOST_PORTS_IMPL);
+	u32 b8_data;
+
+	/*
+	 * enable error bit handling functions, these might overwrite
+	 * the setting which loads from external SPI flash
+	 */
+	b8_data = (pi > 3) ? 0x13 : 0x92;
+	writel(0x03060004+b8_data, mmio + 0xB8);
+	writel(0x00FF0B01,         mmio + 0x30);
+	writel(0x0000003F,         mmio + 0x34);
+	writel(0x0000001F,         mmio + 0x38);
+	writel(0x03060000+b8_data, mmio + 0xB8);
+	writel(0xF9E4EFBF,         mmio + 0xB0);
+
+	/*
+	 * set SATA configuration, these might overwrite
+	 * the setting which loads from external SPI flash
+	 */
+	ahci_jmb585_write_sata_phy(mmio, 0x06, 0x70005BE3); /* port0 */
+	ahci_jmb585_write_sata_phy(mmio, 0x13, 0x70005BE3); /* port1 */
+	ahci_jmb585_write_sata_phy(mmio, 0x73, 0x000001E5); /* port0 */
+	ahci_jmb585_write_sata_phy(mmio, 0x75, 0x000001E5); /* port1 */
+	ahci_jmb585_write_sata_phy(mmio, 0x74, 0x00000024); /* port0 */
+	ahci_jmb585_write_sata_phy(mmio, 0x80, 0x250B0003); /* port1 */
+	if (pi > 3) {
+		ahci_jmb585_write_sata_phy(mmio, 0x20, 0x70005BE3); /* port2 */
+		ahci_jmb585_write_sata_phy(mmio, 0x2D, 0x70005BE3); /* port3 */
+		ahci_jmb585_write_sata_phy(mmio, 0x3A, 0x70005BE3); /* port4 */
+		ahci_jmb585_write_sata_phy(mmio, 0x79, 0x000001E5); /* port3 */
+		ahci_jmb585_write_sata_phy(mmio, 0x83, 0x250B0003); /* port3 */
+		ahci_jmb585_write_sata_phy(mmio, 0x7A, 0x00000024); /* port3 */
+		ahci_jmb585_write_sata_phy(mmio, 0x84, 0x250B0003); /* port3 */
+	}
+}
+
+static void ahci_jmicron_quirk(struct pci_dev *pdev,
+			struct ahci_host_priv *hpriv)
+{
+	void __iomem *mmio = hpriv->mmio;
+	u8 tmp8;
+
+	if (pdev->vendor != PCI_VENDOR_ID_JMICRON)
+		return;
+
+	switch (pdev->device) {
+	case 0x585: /* check if the chip is JMB585 */
+		tmp8 = readb(mmio + 0x44);
+		if (tmp8)
+			ahci_jmicron_585_quirk(mmio);
+		break;
+	}
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1775,6 +1837,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	ahci_intel_pcs_quirk(pdev, hpriv);
 
+	/* set JMicron configuration */
+	ahci_jmicron_quirk(pdev, hpriv);
+
 	/* prepare host */
 	if (hpriv->cap & HOST_CAP_NCQ) {
 		pi.flags |= ATA_FLAG_NCQ;
-- 
2.17.1

