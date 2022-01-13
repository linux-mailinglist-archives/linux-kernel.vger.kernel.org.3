Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6696E48DAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiAMPrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:47:05 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:48617 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236355AbiAMPrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:47:02 -0500
Received: from handsomejack.molgen.mpg.de (handsomejack.molgen.mpg.de [141.14.17.248])
        by mx.molgen.mpg.de (Postfix) with ESMTP id E9E6D61EA1922;
        Thu, 13 Jan 2022 16:47:00 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ata: Warn about removal of debounce delay in Linux 5.19
Date:   Thu, 13 Jan 2022 16:46:35 +0100
Message-Id: <20220113154635.17581-3-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113154635.17581-1-pmenzel@molgen.mpg.de>
References: <20220113154635.17581-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The delay is only needed for a few buggy chipsets (PHYs(?)). As 200 ms
is quite a lot in today times, announce the change of the default in
Linux 5.19, and call for tests and reports.
---
 drivers/ata/libata-sata.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 29a815e2b7248..026ffcfaeaf26 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -318,9 +318,13 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 		 * debouncing. Duration can be configured with module
 		 * parameter debounce_delay_ms.
 		 */
-		if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY))
+		if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY)) {
 			ata_msleep(link->ap,
 					(libata_debounce_delay_ms < 0) ? 200 : libata_debounce_delay_ms);
+			if (libata_debounce_delay_ms < 0)
+				/* negative values are default */
+				ata_link_warn(link, "Due to historical reasons a 200 ms delay is applied in sata_link_resume(). Most controllers do not need that, so the default will change to 0 ms in Linux 5.19. Please test with lower values using libata.debounce_delay_ms and report the results <linux-ide@vger.kernel.org>.\n");
+		}
 
 		/* is SControl restored correctly? */
 		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
-- 
2.30.2

