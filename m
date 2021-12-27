Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB7248019C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhL0Q17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:27:59 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:51387 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229559AbhL0Q16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:27:58 -0500
Received: from handsomejack.molgen.mpg.de (handsomejack.molgen.mpg.de [141.14.17.248])
        by mx.molgen.mpg.de (Postfix) with ESMTP id A517C61EA1922;
        Mon, 27 Dec 2021 17:27:57 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <groeck@chromium.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ahci: AMD A85 FCH (Hudson D4): Skip 200 ms debounce delay in `sata_link_resume()`
Date:   Mon, 27 Dec 2021 17:26:59 +0100
Message-Id: <20211227162658.11314-3-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211227162658.11314-1-pmenzel@molgen.mpg.de>
References: <20211227162658.11314-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the first commit 1da177e4c3 (Linux-2.6.12-rc2) in the Linux git
repository, `sata_link_resume()` contains a 200 ms delay with the comment
below.

>    /*
>     * Some PHYs react badly if SStatus is pounded
>     * immediately after resuming.  Delay 200ms before
>     * debouncing.
>     */

A lot of PHYs do not have that problem though, so delaying 200 ms increases
the boot time by 30 percent unnecessarily for a lot of systems, making
“instant booting” quite hard.

As it’s unknown for what PHY the delay was added, create a new board
`board_ahci_nodbdelay` with the link flag `ATA_LFLAG_NO_DB_DELAY,`, and,
for now, configure the AMD A85 FCH (Hudson D4) to use it.

On the ASUS F2A85-M PRO it reduces the Linux kernel boot time by the
expected 200 ms from 787 ms to 585 ms.

Tested on ASUS F2A85-M PRO:

Without patch, i. e., with 200 ms debounce delay:

    […]
    [    0.000000] DMI: ASUS F2A85-M_PRO/F2A85-M_PRO, BIOS 4.15-671-g7b043ef855 12/27/2021
    […]
    [    0.404885] ahci 0000:00:11.0: version 3.0
    [    0.405466] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 8 ports 6 Gbps 0x40 impl SATA mode
    [    0.405470] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck led clo pio
    [    0.408036] scsi host0: ahci
    [    0.408537] scsi host1: ahci
    [    0.408932] scsi host2: ahci
    [    0.409444] scsi host3: ahci
    [    0.409841] scsi host4: ahci
    [    0.410266] scsi host5: ahci
    [    0.410661] scsi host6: ahci
    [    0.411052] scsi host7: ahci
    [    0.411284] ata1: DUMMY
    [    0.411286] ata2: DUMMY
    [    0.411286] ata3: DUMMY
    [    0.411287] ata4: DUMMY
    [    0.411288] ata5: DUMMY
    [    0.411289] ata6: DUMMY
    [    0.411291] ata7: SATA max UDMA/133 abar m2048@0xf01cc000 port 0xf01cc400 irq 19
    [    0.411292] ata8: DUMMY
    […]
    [    0.422362] Key type encrypted registered
    [    0.424903] PM:   Magic number: 1:28:636
    [    0.723979] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    [    0.724268] ata7.00: ATA-9: SanDisk SDSSDP064G, 2.0.0, max UDMA/133
    [    0.724271] ata7.00: 125045424 sectors, multi 1: LBA48 NCQ (depth 32)
    [    0.725537] ata7.00: configured for UDMA/133
    [    0.725898] scsi 6:0:0:0: Direct-Access     ATA      SanDisk SDSSDP06 0    PQ: 0 ANSI: 5
    [    0.726428] sd 6:0:0:0: [sda] 125045424 512-byte logical blocks: (64.0 GB/59.6 GiB)
    [    0.726442] sd 6:0:0:0: [sda] Write Protect is off
    [    0.726446] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
    [    0.726464] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
    [    0.727985]  sda: sda1 sda2 sda3
    [    0.728588] sd 6:0:0:0: [sda] Attached SCSI disk
    [    0.738495] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
    […]
    [    0.786812] Run /sbin/init as init process

With patch, i. e., skipping the debounce delay saves 200 ms from the boot
as expected.

    […]
    [    0.000000] DMI: ASUS F2A85-M_PRO/F2A85-M_PRO, BIOS 4.15-671-g7b043ef855 12/27/2021
    […]
    [    0.407372] ahci 0000:00:11.0: version 3.0
    [    0.407909] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 8 ports 6 Gbps 0x40 impl SATA mode
    [    0.407913] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck led clo pio
    [    0.410520] scsi host0: ahci
    [    0.411017] scsi host1: ahci
    [    0.411418] scsi host2: ahci
    [    0.411810] scsi host3: ahci
    [    0.412225] scsi host4: ahci
    [    0.412614] scsi host5: ahci
    [    0.413005] scsi host6: ahci
    [    0.413488] scsi host7: ahci
    [    0.413713] ata1: DUMMY
    [    0.413715] ata2: DUMMY
    [    0.413716] ata3: DUMMY
    [    0.413716] ata4: DUMMY
    [    0.413717] ata5: DUMMY
    [    0.413718] ata6: DUMMY
    [    0.413720] ata7: SATA max UDMA/133 abar m2048@0xf01cc000 port 0xf01cc400 irq 19
    [    0.413722] ata8: DUMMY
    […]
    [    0.425414] Key type encrypted registered
    [    0.427873] PM:   Magic number: 1:234:838
    [    0.522131] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    [    0.522415] ata7.00: ATA-9: SanDisk SDSSDP064G, 2.0.0, max UDMA/133
    [    0.522418] ata7.00: 125045424 sectors, multi 1: LBA48 NCQ (depth 32)
    [    0.523636] ata7.00: configured for UDMA/133
    [    0.523993] scsi 6:0:0:0: Direct-Access     ATA      SanDisk SDSSDP06 0    PQ: 0 ANSI: 5
    [    0.524497] sd 6:0:0:0: [sda] 125045424 512-byte logical blocks: (64.0 GB/59.6 GiB)
    [    0.524511] sd 6:0:0:0: [sda] Write Protect is off
    [    0.524515] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
    [    0.524534] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
    [    0.525953]  sda: sda1 sda2 sda3
    [    0.526541] sd 6:0:0:0: [sda] Attached SCSI disk
    [    0.536245] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
    […]
    [    0.585327] Run /sbin/init as init process

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Guenter Roeck <groeck@chromium.org>

---
 drivers/ata/ahci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

v2: Add new board to enum `board_ids`.

Add the two Chromium OS developers Dmitry and Guenter to Cc, as to my
knowledge Chromium/Chrome OS also tries to boot very fast, and the Chromium
project has some CI infrastructure.

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6a2432e4adda..4f3e0603864d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -51,6 +51,7 @@ enum board_ids {
 	board_ahci,
 	board_ahci_ign_iferr,
 	board_ahci_mobile,
+	board_ahci_nodbdelay,
 	board_ahci_nomsi,
 	board_ahci_noncq,
 	board_ahci_nosntf,
@@ -141,6 +142,13 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_nodbdelay] = {
+		.flags		= AHCI_FLAG_COMMON,
+		.link_flags	= ATA_LFLAG_NO_DB_DELAY,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_nomsi] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
 		.flags		= AHCI_FLAG_COMMON,
@@ -437,6 +445,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 		board_ahci_al },
 	/* AMD */
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE), board_ahci },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_AHCI), board_ahci_nodbdelay },
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
 	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
 	/* AMD is using RAID class only for ahci controllers */
-- 
2.30.2

