Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5200C482D3B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 00:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiABXdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 18:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiABXcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 18:32:55 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EA04C061761;
        Sun,  2 Jan 2022 15:32:54 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id F3BE192009E; Mon,  3 Jan 2022 00:23:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id ECFF792009B;
        Sun,  2 Jan 2022 23:23:51 +0000 (GMT)
Date:   Sun, 2 Jan 2022 23:23:51 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] scsi: Avoid using reserved length byte with VPD
 inquiries
In-Reply-To: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2201020027270.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in a previous workaround for a BusLogic BT-958 problem with 
VPD inquiries with an allocation length of 512 bytes as requested before 
commit af73623f5f10 ("[SCSI] sd: Reduce buffer size for vpd request") 
are rejected outright as invalid at least by some SCSI target devices as 
are any requests with a non-zero value in byte #3:

scsi host0: BusLogic BT-958
scsi 0:0:0:0: Direct-Access     IBM      DDYS-T18350M     SA5A PQ: 0 ANSI: 3
scsi 0:0:1:0: Direct-Access     SEAGATE  ST336607LW       0006 PQ: 0 ANSI: 3
scsi 0:0:5:0: Direct-Access     IOMEGA   ZIP 100          E.08 PQ: 0 ANSI: 2
[...]
scsi0: CCB #36 Target 0: Result 2 Host Adapter Status 00 Target Status 02
scsi0: CDB    12 01 00 01 06 00
scsi0: Sense  70 00 05 00 00 00 00 18 00 00 00 00 24 00 00 C0 00 03 00 [...]
sd 0:0:0:0: scsi_vpd_inquiry(0): buf[262] => -5
scsi0: CCB #37 Target 1: Result 2 Host Adapter Status 00 Target Status 02
scsi0: CDB    12 01 00 01 06 00
scsi0: Sense  70 00 05 00 00 00 00 0A 00 00 00 00 24 00 01 C8 00 03 00 [...]
sd 0:0:1:0: scsi_vpd_inquiry(0): buf[262] => -5

(here with the buffer size tweaked to 262 so as to verify if a bit in 
byte #3 of the INQUIRY command is ignored and the length of 6 assumed or 
tripped over, the `BusLogic=TraceErrors' parameter and trailing sense 
data zeros trimmed for brevity).  Note the sense key of 0x5 denoting an 
illegal request.

For the record with the buffer size of 6 requests for page 0 complete 
successfully and due to page truncation `scsi_get_vpd_page' proceeds 
with an attempt to get inexistent page 0x89:

sd 0:0:0:0: scsi_vpd_inquiry(0): buf[6] => 7
sd 0:0:1:0: scsi_vpd_inquiry(0): buf[6] => 13
sd 0:0:0:0: scsi_vpd_inquiry(137): buf[6] => -5
sd 0:0:1:0: scsi_vpd_inquiry(137): buf[6] => -5

Upon a further investigation it has turned out at least SCSI-2 considers 
byte #3 of the INQUIRY command[1] as well as byte #2 of vital product 
data pages[2] reserved and expects a value of zero there.  The response 
from SCSI-3 devices shown above indicates the same expectation.

Therefore it is unsafe to issue INQUIRY requests unconditionally with 
the allocation length beyond 255, as they may fail with an otherwise 
supported request or cause undefined behaviour with some hardware.

Now we actually never do that as all our callers of `scsi_get_vpd_page' 
either hardcode the buffer size to a value between 8 and 255 or 
calculate it from a structure size, of which the largest is:

struct c2_inquiry {
	u8                         peripheral_info;      /*     0     1 */
	u8                         page_code;            /*     1     1 */
	u8                         reserved1;            /*     2     1 */
	u8                         page_len;             /*     3     1 */
	u8                         page_id[4];           /*     4     4 */
	u8                         sw_version[3];        /*     8     3 */
	u8                         sw_date[3];           /*    11     3 */
	u8                         features_enabled;     /*    14     1 */
	u8                         max_lun_supported;    /*    15     1 */
	u8                         partitions[239];      /*    16   239 */

	/* size: 255, cachelines: 2, members: 10 */
	/* last cacheline: 127 bytes */
};

As from commit b3ae8780b429 ("[SCSI] Add EVPD page 0x83 and 0x80 to sysfs")
we now also have the SCSI_VPD_PG_LEN macro that reflects the limitation.

However for the sake of a possible future requirement to support VPD 
pages that do have a length exceeding 255 bytes and now that the danger 
of using the formerly reserved byte #3 of the INQUIRY command has been 
identified execute calls to `scsi_get_vpd_page' with a request size 
exceeding 255 bytes in two stages, by determining the actual length of 
data to be returned first and only then issuing the intended request for 
full data.

References:

[1] "Information technology - Small Computer System Interface - 2", 
    WORKING DRAFT, X3T9.2, Project 375D, Revision 10L, 7-SEP-93, Section 
    8.2.5 "INQUIRY command", pp.104-108

[2] same, Section 8.3.4 "Vital product data parameters", pp.154-159

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 881a256d84e6 ("[SCSI] Add VPD helper")
---
No changes from v2.

No changes from v1.
---
 drivers/scsi/scsi.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

linux-scsi-vpd-inquiry-buffer.diff
Index: linux-macro/drivers/scsi/scsi.c
===================================================================
--- linux-macro.orig/drivers/scsi/scsi.c
+++ linux-macro/drivers/scsi/scsi.c
@@ -346,10 +346,15 @@ int scsi_get_vpd_page(struct scsi_device
 
 	/*
 	 * Ask for all the pages supported by this device.  Determine the
-	 * actual data length first if so required by the host, e.g.
-	 * BusLogic BT-958.
+	 * actual data length first if the length requested is beyond 255
+	 * bytes as the high order length byte used to be reserved with
+	 * older SCSI standard revisions and a non-zero value there may
+	 * cause either such an INQUIRY command to be rejected by a target
+	 * or undefined behaviour to occur.  Also do so if so required by
+	 * the host, e.g. BusLogic BT-958.
 	 */
-	if (sdev->host->no_trailing_allocation_length) {
+	if (buf_len > SCSI_VPD_PG_LEN ||
+	    sdev->host->no_trailing_allocation_length) {
 		result = scsi_vpd_inquiry(sdev, buf, 0, min(4, buf_len));
 		if (result < 4)
 			goto fail;
@@ -375,7 +380,8 @@ int scsi_get_vpd_page(struct scsi_device
 	goto fail;
 
  found:
-	if (sdev->host->no_trailing_allocation_length) {
+	if (buf_len > SCSI_VPD_PG_LEN ||
+	    sdev->host->no_trailing_allocation_length) {
 		result = scsi_vpd_inquiry(sdev, buf, page, min(4, buf_len));
 		if (result < 4)
 			goto fail;
