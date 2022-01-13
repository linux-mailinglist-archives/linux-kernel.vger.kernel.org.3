Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDD048DAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiAMPrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:47:03 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:40095 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236244AbiAMPq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:46:56 -0500
Received: from handsomejack.molgen.mpg.de (handsomejack.molgen.mpg.de [141.14.17.248])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 45E6161EA191E;
        Thu, 13 Jan 2022 16:46:55 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-ide@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ata: Add module parameter `debounce_delay_ms`
Date:   Thu, 13 Jan 2022 16:46:34 +0100
Message-Id: <20220113154635.17581-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113154635.17581-1-pmenzel@molgen.mpg.de>
References: <20220113154635.17581-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 200 ms delay in `sata_resume_lin()` is probably only needed for a
few old controllers, so allow users to test this by setting the delay
time (preferrably 0). To be able to track defaults, make it a signed
integer with negative values being the default, which currently stays at
200 ms.

This parameter could also be made boolean, but making the delay
configurable adds more flexibility, but also does not directly match the
existing boolean flag `ATA_LFLAG_NO_DEBOUNCE_DELAY`.

Note, if that flag is set for a board, then the parameter is ignored.

History:

Commit 4effb658a0 from October 2003 [1, historical git archive] with the
commit message

> [libata] Merge Serial ATA core, and drivers for:
>
> Intel ICH5 (production)
> ServerWorks / Apple K2 (beta)
> VIA (beta)
> Silicon Image 3112 (broken!)
> Various Promise (alpha/beta)

adds the code below:

    void sata_phy_reset(struct ata_port *ap)
    {
    […]
        /* wait for phy to become ready, if necessary */
        do {
            msleep(200);
            sstatus = scr_read(ap, SCR_STATUS);
            if ((sstatus & 0xf) != 1)
                break;
        } while (time_before(jiffies, timeout));
    […]
    }

Later on in commit d7bb4cc75759 ([PATCH] libata-hp-prep: implement
sata_phy_debounce()) the commit is refactored [2], and the comment
clarified.

     /*
      * Writes to SControl sometimes get ignored under certain
      * controllers (ata_piix SIDPR).  Make sure DET actually is
      * cleared.
      */
     do {
             scontrol = (scontrol & 0x0f0) | 0x300;
             if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
                     return rc;
             /*
              * Some PHYs react badly if SStatus is pounded
              * immediately after resuming.  Delay 200ms before
              * debouncing.
              */
             if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY))
                     ata_msleep(link->ap, 200);

             /* is SControl restored correctly? */
             if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
                     return rc;
     } while ((scontrol & 0xf0f) != 0x300 && --tries);

A lot of PHYs do not need a delay though, so delaying 200 ms increases
the boot time by 30 percent unnecessarily for a lot of systems, making
“instant booting” quite hard.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=4effb658a0f800e159c29a2d881cac76c326087a
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7bb4cc7575929a60b0a718daa1bce87bea9a9cc

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 drivers/ata/libata-core.c                       | 4 ++++
 drivers/ata/libata-sata.c                       | 6 ++++--
 drivers/ata/libata.h                            | 1 +
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2fba82431efbe..8cc0e790f49d6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2548,6 +2548,12 @@
 	lapic_timer_c2_ok	[X86,APIC] trust the local apic timer
 			in C2 power state.
 
+	libata.libata_debounce_delay_ms=	[LIBATA] Set debounce delay in
+			ms
+
+			libata.dma<0	  Use default value from code
+			libata.dma>1	  Debounce delay in milliseconds
+
 	libata.dma=	[LIBATA] DMA control
 			libata.dma=0	  Disable all PATA and SATA DMA
 			libata.dma=1	  PATA and SATA Disk DMA only
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 67f88027680ac..b0d76cb8a7531 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -154,6 +154,10 @@ static int atapi_an;
 module_param(atapi_an, int, 0444);
 MODULE_PARM_DESC(atapi_an, "Enable ATAPI AN media presence notification (0=0ff [default], 1=on)");
 
+int debounce_delay_ms = -1;
+module_param_named(debounce_delay_ms, libata_debounce_delay_ms, int, 0644);
+MODULE_PARM_DESC(debounce_delay_ms, "Delay amount milliseconds in sata_link_resume() to work around controller issues (negative values mean default value in code (200 ms)");
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 071158c0c44c1..29a815e2b7248 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -315,10 +315,12 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 		/*
 		 * Some PHYs react badly if SStatus is pounded
 		 * immediately after resuming.  Delay 200ms before
-		 * debouncing.
+		 * debouncing. Duration can be configured with module
+		 * parameter debounce_delay_ms.
 		 */
 		if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY))
-			ata_msleep(link->ap, 200);
+			ata_msleep(link->ap,
+					(libata_debounce_delay_ms < 0) ? 200 : libata_debounce_delay_ms);
 
 		/* is SControl restored correctly? */
 		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 51e01acdd2410..a26e77ee25aa2 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -35,6 +35,7 @@ extern int atapi_passthru16;
 extern int libata_fua;
 extern int libata_noacpi;
 extern int libata_allow_tpm;
+extern int libata_debounce_delay_ms;
 extern const struct device_type ata_port_type;
 extern struct ata_link *ata_dev_phys_link(struct ata_device *dev);
 #ifdef CONFIG_ATA_FORCE
-- 
2.30.2

