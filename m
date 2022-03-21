Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2FF4E3307
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiCUWsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiCUWs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:48:27 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930EE32BC2B;
        Mon, 21 Mar 2022 15:45:19 -0700 (PDT)
Received: from handsomejack.molgen.mpg.de (handsomejack.molgen.mpg.de [141.14.17.248])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 0DD6261E6478B;
        Mon, 21 Mar 2022 22:26:53 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ata: ahci: Skip 200 ms debounce delay for AMD FCH SATA Controller
Date:   Mon, 21 Mar 2022 22:24:32 +0100
Message-Id: <20220321212431.13717-2-pmenzel@molgen.mpg.de>
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
MSI MS-7A37/B350M MORTAR (MS-7A37):

    12:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 300 Series Chipset SATA Controller [1022:43b7] (rev 02)
    27:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 61)

The FCH SATA Controller [0x1022:0x7901] does not need the 200 ms delay
before debouncing the PHY in `sata_link_resume()`, so skip it by mapping it
to the board with no debounce delay.

Tested on the MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.MW 11/01/2021 with
Linux 5.17-rc2.

Currently, without this patch (with 200 ms delay), device probe for ata9
takes 320 ms (= 0.526 s - 0.206 s):

    [    0.193682] ahci 0000:12:00.1: version 3.0
    [    0.193797] ahci 0000:12:00.1: SSS flag set, parallel bus scan disabled
    [    0.193847] ahci 0000:12:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
    [    0.193850] ahci 0000:12:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst
    [    0.194429] scsi host0: ahci
    [    0.194584] scsi host1: ahci
    [    0.194718] scsi host2: ahci
    [    0.194848] scsi host3: ahci
    [    0.194942] scsi host4: ahci
    [    0.195009] scsi host5: ahci
    [    0.195091] scsi host6: ahci
    [    0.195150] scsi host7: ahci
    [    0.195177] ata1: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80100 irq 35
    [    0.195180] ata2: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80180 irq 35
    [    0.195181] ata3: DUMMY
    [    0.195181] ata4: DUMMY
    [    0.195183] ata5: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80300 irq 35
    [    0.195184] ata6: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80380 irq 35
    [    0.195185] ata7: DUMMY
    [    0.195186] ata8: DUMMY
    [    0.206256] ahci 0000:27:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
    [    0.206260] ahci 0000:27:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part
    [    0.206450] scsi host8: ahci
    [    0.206490] ata9: SATA max UDMA/133 abar m2048@0xfcf00000 port 0xfcf00100 irq 37
    […]
    [    0.508879] ata1: SATA link down (SStatus 0 SControl 300)
    [    0.525832] ata9: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    [    0.526199] ata9.00: supports DRM functions and may not be fully accessible (TPM)
    [    0.526200] ata9.00: ATA-10: CT1000MX500SSD4, M3CR020, max UDMA/133
    [    0.526262] ata9.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth 32), AA
    [    0.527510] ata9.00: Features: Trust Dev-Sleep
    [    0.527678] ata9.00: supports DRM functions and may not be fully accessible (TPM)
    [    0.528866] ata9.00: configured for UDMA/133
    [    0.822402] ata2: SATA link down (SStatus 0 SControl 300)
    [    1.133517] ata5: SATA link down (SStatus 0 SControl 300)
    [    1.445124] ata6: SATA link down (SStatus 0 SControl 300)

With this patch (no delay) device probe for ata9 takes 117 ms
(= 0.323 s - 0.206 s):

    [    0.193600] ahci 0000:12:00.1: version 3.0
    [    0.193718] ahci 0000:12:00.1: SSS flag set, parallel bus scan disabled
    [    0.193768] ahci 0000:12:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
    [    0.193770] ahci 0000:12:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst
    [    0.194328] scsi host0: ahci
    [    0.194477] scsi host1: ahci
    [    0.194611] scsi host2: ahci
    [    0.194739] scsi host3: ahci
    [    0.194824] scsi host4: ahci
    [    0.194903] scsi host5: ahci
    [    0.194978] scsi host6: ahci
    [    0.195042] scsi host7: ahci
    [    0.195068] ata1: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80100 irq 35
    [    0.195070] ata2: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80180 irq 35
    [    0.195071] ata3: DUMMY
    [    0.195072] ata4: DUMMY
    [    0.195073] ata5: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80300 irq 35
    [    0.195075] ata6: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80380 irq 35
    [    0.195076] ata7: DUMMY
    [    0.195077] ata8: DUMMY
    [    0.206113] ahci 0000:27:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
    [    0.206117] ahci 0000:27:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part
    [    0.206306] scsi host8: ahci
    [    0.206346] ata9: SATA max UDMA/133 abar m2048@0xfcf00000 port 0xfcf00100 irq 37
    […]
    [    0.323002] ata9: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    [    0.323142] ata9.00: supports DRM functions and may not be fully accessible (TPM)
    [    0.323145] ata9.00: ATA-10: CT1000MX500SSD4, M3CR020, max UDMA/133
    [    0.323205] ata9.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth 32), AA
    [    0.324470] ata9.00: Features: Trust Dev-Sleep
    [    0.324657] ata9.00: supports DRM functions and may not be fully accessible (TPM)
    [    0.325886] ata9.00: configured for UDMA/133
    [    0.508257] ata1: SATA link down (SStatus 0 SControl 300)
    [    0.820604] ata2: SATA link down (SStatus 0 SControl 300)
    [    1.132695] ata5: SATA link down (SStatus 0 SControl 300)
    [    1.445037] ata6: SATA link down (SStatus 0 SControl 300)

Tested on the Dell OptiPlex 5055 Ryzen CPU/0P03DX, BIOS 1.1.50 07/28/2021
with Linux 5.17 and nothing connected to the port.

Currently, without this patch (with 200 ms delay), device probe for ata9
takes 306 ms (= 0.734 s - 0.428 s):

    [    0.427489] ahci 0000:07:00.2: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
    [    0.427495] ahci 0000:07:00.2: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part
    [    0.427623] scsi host8: ahci
    [    0.427650] ata9: SATA max UDMA/133 abar m4096@0xf0108000 port 0xf0108100 irq 38
    […]
    [    0.734155] ata9: SATA link down (SStatus 0 SControl 300)

With this patch (no delay) device probe for ata9 takes 103 ms
(= 0.532 s - 0.429 s):

    [    0.428481] ahci 0000:07:00.2: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
    [    0.428486] ahci 0000:07:00.2: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part
    [    0.428611] scsi host8: ahci
    [    0.428639] ata9: SATA max UDMA/133 abar m4096@0xf0108000 port 0xf0108100 irq 38
    […]
    [    0.531949] ata9: SATA link down (SStatus 0 SControl 300)

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
---
v2: Add test details and data

 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0fc09b86a5590..44b79fe43d13d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -456,7 +456,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
 	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
-	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sardine */
+	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power_no_debounce_delay }, /* AMD Green Sardine */
 	/* AMD is using RAID class only for ahci controllers */
 	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
-- 
2.30.2

