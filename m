Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84799482D3A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 00:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiABXdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 18:33:03 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:38430 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiABXcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 18:32:55 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 6D8829200B3; Mon,  3 Jan 2022 00:23:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 69AB092009B;
        Sun,  2 Jan 2022 23:23:57 +0000 (GMT)
Date:   Sun, 2 Jan 2022 23:23:57 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] scsi: Set allocation length to 255 for ATA Information
 VPD page
In-Reply-To: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the allocation length to 255 for the ATA Information VPD page 
requested in the WRITE SAME handler, so as not to limit information 
examined by `scsi_get_vpd_page' in the supported vital product data 
pages unnecessarily.

Originally it was thought that Areca hardware may have issues with a 
valid allocation length supplied for a VPD inquiry, however older SCSI 
standard revisions[1] consider 255 the maximum length allowed and what 
has later become the high order byte is considered reserved and must be 
zero with the INQUIRY command.  Therefore it was unnecessary to reduce 
the amount of data requested from 512 as far down as to 64, arbitrarily 
chosen, and 255 would as well do.

With commit b3ae8780b429 ("[SCSI] Add EVPD page 0x83 and 0x80 to sysfs") 
we have since got the SCSI_VPD_PG_LEN macro, so use that instead.

References:

[1] "Information technology - Small Computer System Interface - 2",
    WORKING DRAFT, X3T9.2, Project 375D, Revision 10L, 7-SEP-93, Section
    8.2.5 "INQUIRY command", pp.104-108

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: af73623f5f10 ("[SCSI] sd: Reduce buffer size for vpd request")
Tested-by: Nick Alcock <nick.alcock@oracle.com>
---
Changes from v2:

- Add Nick's Tested-by annotation. 

No changes from v1.
---
 drivers/scsi/sd.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

linux-scsi-write-same-vpd-buffer.diff
Index: linux-macro/drivers/scsi/sd.c
===================================================================
--- linux-macro.orig/drivers/scsi/sd.c
+++ linux-macro/drivers/scsi/sd.c
@@ -3101,16 +3101,13 @@ static void sd_read_write_same(struct sc
 	}
 
 	if (scsi_report_opcode(sdev, buffer, SD_BUF_SIZE, INQUIRY) < 0) {
-		/* too large values might cause issues with arcmsr */
-		int vpd_buf_len = 64;
-
 		sdev->no_report_opcodes = 1;
 
 		/* Disable WRITE SAME if REPORT SUPPORTED OPERATION
 		 * CODES is unsupported and the device has an ATA
 		 * Information VPD page (SAT).
 		 */
-		if (!scsi_get_vpd_page(sdev, 0x89, buffer, vpd_buf_len))
+		if (!scsi_get_vpd_page(sdev, 0x89, buffer, SCSI_VPD_PG_LEN))
 			sdev->no_write_same = 1;
 	}
 
