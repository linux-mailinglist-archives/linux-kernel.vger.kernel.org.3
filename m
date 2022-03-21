Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E934E4E341D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiCUXRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiCUXRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:17:10 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2B03C8AFD;
        Mon, 21 Mar 2022 16:05:20 -0700 (PDT)
Received: from handsomejack.molgen.mpg.de (handsomejack.molgen.mpg.de [141.14.17.248])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 8E77E61E64846;
        Mon, 21 Mar 2022 22:27:36 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300 Series Chipset SATA Controller
Date:   Mon, 21 Mar 2022 22:24:34 +0100
Message-Id: <20220321212431.13717-3-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220321212431.13717-1-pmenzel@molgen.mpg.de>
References: <20220321212431.13717-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD chipsets for AMD Ryzen contain two SATA controllers, for example on the
Dell OptiPlex 5055 Ryzen CPU/0P03DX:

    01:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 300 Series Chipset SATA Controller [1022:43b7] (rev 02)
    07:00.2 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)

The 300 Series Chipset SATA Controller [1022:43b7] does not need the 200 ms
delay before debouncing the PHY in `sata_link_resume()`, so skip it by
mapping it to the board with no debounce delay.

Tested on the Dell OptiPlex 5055 Ryzen CPU/0P03DX, BIOS 1.1.50 07/28/2021
Linux 5.17 with an HDD connected to ata1 connected to 01:00.1, and no other
storage devices. (Only ata9 is connected to 07:00.2.)

Currently, without this patch (with 200 ms delay), device probe for ata1
takes 468 ms (= 0.896 s - 0.428 s), ata2 takes 840 ms, ata5 takes 1,125 ms,
and ata6 takes 1,464 ms:

    [    0.427251] calling  ahci_pci_driver_init+0x0/0x1a @ 1
    [    0.427271] ahci 0000:01:00.1: version 3.0
    [    0.427371] ahci 0000:01:00.1: SSS flag set, parallel bus scan disabled
    [    0.427405] ahci 0000:01:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
    [    0.427409] ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst
    [    0.427814] scsi host0: ahci
    [    0.427895] scsi host1: ahci
    [    0.427968] scsi host2: ahci
    [    0.428038] scsi host3: ahci
    [    0.428113] scsi host4: ahci
    [    0.428184] scsi host5: ahci
    [    0.428255] scsi host6: ahci
    [    0.428325] scsi host7: ahci
    [    0.428352] ata1: SATA max UDMA/133 abar m131072@0xf0600000 port 0xf0600100 irq 36
    [    0.428356] ata2: SATA max UDMA/133 abar m131072@0xf0600000 port 0xf0600180 irq 36
    [    0.428359] ata3: DUMMY
    [    0.428360] ata4: DUMMY
    [    0.428362] ata5: SATA max UDMA/133 abar m131072@0xf0600000 port 0xf0600300 irq 36
    [    0.428365] ata6: SATA max UDMA/133 abar m131072@0xf0600000 port 0xf0600380 irq 36
    [    0.428368] ata7: DUMMY
    [    0.428369] ata8: DUMMY
    [    0.428481] ahci 0000:07:00.2: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
    [    0.428486] ahci 0000:07:00.2: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part
    [    0.428611] scsi host8: ahci
    [    0.428639] ata9: SATA max UDMA/133 abar m4096@0xf0108000 port 0xf0108100 irq 38
    [    0.428653] initcall ahci_pci_driver_init+0x0/0x1a returned 0 after 1367 usecs
    […]
    [    0.531949] ata9: SATA link down (SStatus 0 SControl 300)
    [    0.895730] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    [    0.924392] ata1.00: ATA-8: ST500LM021-1KJ152, 0005SDM1, max UDMA/133
    [    0.924410] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32)
    [    0.963276] ata1.00: configured for UDMA/133
    [    0.963355] scsi 0:0:0:0: Direct-Access     ATA      ST500LM021-1KJ15 SDM1 PQ: 0 ANSI: 5
    [    0.963478] sd 0:0:0:0: Attached scsi generic sg0 type 0
    [    0.963568] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
    [    0.963594] sd 0:0:0:0: [sda] 4096-byte physical blocks
    [    0.963616] sd 0:0:0:0: [sda] Write Protect is off
    [    0.963631] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
    [    0.963644] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
    [    0.974119]  sda: sda1 sda2 sda3
    [    0.974299] sd 0:0:0:0: [sda] Attached SCSI disk
    [    1.268377] ata2: SATA link down (SStatus 0 SControl 300)
    [    1.580394] ata5: SATA link down (SStatus 0 SControl 300)
    [    1.892390] ata6: SATA link down (SStatus 0 SControl 300)

With this patch (no delay) device probe for ata1 takes 268 ms
(= 0.696 s - 0.428 s), ata2 takes 440 ms, ata5 takes 545 ms, and ata6 takes
650 ms:

    [    0.426850] calling  ahci_pci_driver_init+0x0/0x1a @ 1
    [    0.426869] ahci 0000:01:00.1: version 3.0
    [    0.426970] ahci 0000:01:00.1: SSS flag set, parallel bus scan disabled
    [    0.427004] ahci 0000:01:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
    [    0.427008] ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst
    [    0.427412] scsi host0: ahci
    [    0.427493] scsi host1: ahci
    [    0.427569] scsi host2: ahci
    [    0.427653] scsi host3: ahci
    [    0.427728] scsi host4: ahci
    [    0.427801] scsi host5: ahci
    [    0.427876] scsi host6: ahci
    [    0.427950] scsi host7: ahci
    [    0.427978] ata1: SATA max UDMA/133 abar m131072@0xf0600000 port 0xf0600100 irq 36
    [    0.427982] ata2: SATA max UDMA/133 abar m131072@0xf0600000 port 0xf0600180 irq 36
    [    0.427985] ata3: DUMMY
    [    0.427986] ata4: DUMMY
    [    0.427988] ata5: SATA max UDMA/133 abar m131072@0xf0600000 port 0xf0600300 irq 36
    [    0.427991] ata6: SATA max UDMA/133 abar m131072@0xf0600000 port 0xf0600380 irq 36
    [    0.427994] ata7: DUMMY
    [    0.427995] ata8: DUMMY
    [    0.428116] ahci 0000:07:00.2: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
    [    0.428124] ahci 0000:07:00.2: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part
    [    0.428250] scsi host8: ahci
    [    0.428278] ata9: SATA max UDMA/133 abar m4096@0xf0108000 port 0xf0108100 irq 38
    [    0.428295] initcall ahci_pci_driver_init+0x0/0x1a returned 0 after 1409 usecs
    […]
    [    0.532308] ata9: SATA link down (SStatus 0 SControl 300)
    […]
    [    0.696316] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    [    0.725963] ata1.00: ATA-8: ST500LM021-1KJ152, 0005SDM1, max UDMA/133
    [    0.725982] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32)
    [    0.764845] ata1.00: configured for UDMA/133
    [    0.764932] scsi 0:0:0:0: Direct-Access     ATA      ST500LM021-1KJ15 SDM1 PQ: 0 ANSI: 5
    [    0.765056] sd 0:0:0:0: Attached scsi generic sg0 type 0
    [    0.765120] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
    [    0.765147] sd 0:0:0:0: [sda] 4096-byte physical blocks
    [    0.765175] sd 0:0:0:0: [sda] Write Protect is off
    [    0.765189] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
    [    0.765198] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
    [    0.866546]  sda: sda1 sda2 sda3
    [    0.867239] sd 0:0:0:0: [sda] Attached SCSI disk
    [    0.868330] ata2: SATA link down (SStatus 0 SControl 300)
    [    0.973337] ata5: SATA link down (SStatus 0 SControl 300)
    [    1.077832] ata6: SATA link down (SStatus 0 SControl 300)

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
---
v2: New patch for second SATA controller in Ryzen systems

 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 44b79fe43d13d..ac7f230c12ebc 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -453,6 +453,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 		.class_mask = 0xffffff,
 		board_ahci_al },
 	/* AMD */
+	{ PCI_VDEVICE(AMD, 0x43b7), board_ahci_low_power_no_debounce_delay }, /* AMD 300 Series Chipset SATA Controller */
 	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
 	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
-- 
2.30.2

