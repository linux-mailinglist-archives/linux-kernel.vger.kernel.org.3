Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9114855F4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbiAEPg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:36:27 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:45297 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241518AbiAEPgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:36:25 -0500
Received: from handsomejack.molgen.mpg.de (handsomejack.molgen.mpg.de [141.14.17.248])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 9774A61EA192C;
        Wed,  5 Jan 2022 16:36:22 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] ahci: Rename flag `ATA_LFLAG_NO_DB_DELAY` to `ATA_LFLAG_NO_DEBOUNCE_DELAY`
Date:   Wed,  5 Jan 2022 16:36:16 +0100
Message-Id: <20220105153618.2395-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new name is longer, but clearer.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/ata/ahci_brcm.c   | 2 +-
 drivers/ata/libata-sata.c | 2 +-
 include/linux/libata.h    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 6e9c5ade4c2ea..649815c196ed0 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -333,7 +333,7 @@ static struct ata_port_operations ahci_brcm_platform_ops = {
 
 static const struct ata_port_info ahci_brcm_port_info = {
 	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
-	.link_flags	= ATA_LFLAG_NO_DB_DELAY,
+	.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &ahci_brcm_platform_ops,
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index b9c77885b8726..67b2e7cf3cc4e 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -317,7 +317,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 		 * immediately after resuming.  Delay 200ms before
 		 * debouncing.
 		 */
-		if (!(link->flags & ATA_LFLAG_NO_DB_DELAY))
+		if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY))
 			ata_msleep(link->ap, 200);
 
 		/* is SControl restored correctly? */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2a8404b26083c..15802e644962d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -191,7 +191,7 @@ enum {
 	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
 	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
 	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
-	ATA_LFLAG_NO_DB_DELAY	= (1 << 11), /* no debounce delay on link resume */
+	ATA_LFLAG_NO_DEBOUNCE_DELAY = (1 << 11), /* no debounce delay on link resume */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
-- 
2.30.2

