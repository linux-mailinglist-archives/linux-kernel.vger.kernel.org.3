Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE93E482EFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 09:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiACIXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 03:23:44 -0500
Received: from verein.lst.de ([213.95.11.211]:45886 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbiACIXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 03:23:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7AA0C68AA6; Mon,  3 Jan 2022 09:23:38 +0100 (CET)
Date:   Mon, 3 Jan 2022 09:23:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] scsi: Provide for avoiding trailing allocation
 length with VPD inquiries
Message-ID: <20220103082338.GA28606@lst.de>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk> <alpine.DEB.2.21.2201020021000.56863@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2201020021000.56863@angie.orcam.me.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 11:23:45PM +0000, Maciej W. Rozycki wrote:
> Allow SCSI hosts to request avoiding trailing allocation length with VPD 
> inquiries, and use the mechanism to work around an issue with at least 
> some BusLogic MultiMaster host bus adapters and observed with the BT-958 
> model specifically where issuing commands that return less data than 
> provided for causes fatal failures:

Wouldn't it make more sesnse to hide this quirk insde of
scsi_vpd_inquiry to also handle the scsi_get_vpd_buf case?  Something
like:


diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 211aace69c22c..194a51f772aaa 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -289,8 +289,8 @@ EXPORT_SYMBOL(scsi_track_queue_full);
  *
  * Returns size of the vpd page on success or a negative error number.
  */
-static int scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
-							u8 page, unsigned len)
+static int __scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
+		u8 page, unsigned len)
 {
 	int result;
 	unsigned char cmd[16];
@@ -321,6 +321,20 @@ static int scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
 	return get_unaligned_be16(&buffer[2]) + 4;
 }
 
+static int scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
+		u8 page, unsigned len)
+{
+	if (sdev->host->no_trailing_allocation_length) {
+		int ret = __scsi_vpd_inquiry(sdev, buffer, page, min(4U, len));
+
+		if (ret < 4)
+			return ret;
+		len = min_t(unsigned int, ret, len);
+	}
+
+	return __scsi_vpd_inquiry(sdev, buffer, page, len);
+}
+
 /**
  * scsi_get_vpd_page - Get Vital Product Data from a SCSI device
  * @sdev: The device to ask
