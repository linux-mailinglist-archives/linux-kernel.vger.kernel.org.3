Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B088649EEE1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241288AbiA0Xfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:35:47 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:50089 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240787AbiA0Xfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:35:43 -0500
Received: from localhost.localdomain (ip5f5aeaa8.dynamic.kabel-deutschland.de [95.90.234.168])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9853061E6478B;
        Fri, 28 Jan 2022 00:35:41 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ata: ahci: Skip 200 ms debounce delay for Marvell 88SE9235
Date:   Fri, 28 Jan 2022 00:35:26 +0100
Message-Id: <20220127233527.445659-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 200 ms delay before debouncing the PHY in `sata_link_resume()` is
not needed for the Marvell 88SE9235.

    $ lspci -nn -s 0021:0e:00.0
    0021:0e:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9235 PCIe 2.0 x2 4-port SATA 6 Gb/s Controller [1b4b:9235] (rev 11)

So, remove it. Tested on IBM S822LC with current Linux 5.17-rc1:

Without this patch (with 200 ms delay):

    [    3.358158] ata1: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3fe881000100 irq 39
    [    3.358175] ata2: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3fe881000180 irq 39
    [    3.358191] ata3: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3fe881000200 irq 39
    [    3.358207] ata4: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3fe881000280 irq 39
    […]
    [    3.677542] ata3: SATA link down (SStatus 0 SControl 300)
    [    3.677719] ata4: SATA link down (SStatus 0 SControl 300)
    [    3.839242] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    [    3.839828] ata2.00: ATA-10: ST1000NX0313         00LY266 00LY265IBM, BE33, max UDMA/133
    [    3.840029] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
    [    3.841796] ata2.00: configured for UDMA/133
    [    3.843231] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    [    3.844083] ata1.00: ATA-10: ST1000NX0313         00LY266 00LY265IBM, BE33, max UDMA/133
    [    3.844313] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
    [    3.846043] ata1.00: configured for UDMA/133

With patch (no delay):

    [    3.624259] ata1: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3f e881000100 irq 39
    [    3.624436] ata2: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3f e881000180 irq 39
    [    3.624452] ata3: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3f e881000200 irq 39
    [    3.624468] ata4: SATA max UDMA/133 abar m2048@0x3fe881000000 port 0x3f e881000280 irq 39
    […]
    [    3.731966] ata3: SATA link down (SStatus 0 SControl 300)
    [    3.732069] ata4: SATA link down (SStatus 0 SControl 300)
    [    3.897448] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    [    3.897678] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    [    3.898140] ata1.00: ATA-10: ST1000NX0313         00LY266 00LY265IBM, BE33, max UDMA/133
    [    3.898175] ata2.00: ATA-10: ST1000NX0313         00LY266 00LY265IBM, BE33, max UDMA/133
    [    3.898287] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
    [    3.898349] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
    [    3.900070] ata1.00: configured for UDMA/133
    [    3.900166] ata2.00: configured for UDMA/133

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/ata/ahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ab5811ef5a53..edca4e8fd44e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -582,6 +582,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
+	  .driver_data = board_ahci_no_debounce_delay },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645), /* highpoint rocketraid 644L */
-- 
2.34.1

