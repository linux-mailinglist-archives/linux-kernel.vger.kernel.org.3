Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DB84DDBC8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiCROir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbiCROip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:38:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7DB2E5757;
        Fri, 18 Mar 2022 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647614246; x=1679150246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/yZ/P03h5rF3YtpbYM9N0CmHsvjo/p2i9Cd9LXIPX8s=;
  b=iNJ+RRMtj9RQJg0Ojuc1ceMQSv+CfwaCxIZEWAhzz5Sekwy861RFaZ7z
   r2qg7KsNDOGEK6FRcBquXiVspv/Ycrgs90QEE2lfo3F0uWdVgG4xFB02z
   ZMBR+NtCMA4EFpePXxvxmbcE3TutozqAJw4bJMepokQ2thRtzFy5X6Yhf
   Aq0q29sy8p8Dg3OoxD/8C0/Nh/vcqlGylrsF58ZiYdWtCJcGbXaTxEuAl
   rDg4n0rrtK1pt962ANhgXj7+Fsqy1xSpybq7iz3mszFpO/kFphgN2kAsN
   /3ZaifbQIANQDJcFkl3TsdqAf4gK+QpGmenTEhy0F0VN2fP1zd3jeLONH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="281956835"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208,223";a="281956835"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:37:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208,223";a="691338172"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 18 Mar 2022 07:37:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 18 Mar 2022 16:37:21 +0200
Date:   Fri, 18 Mar 2022 16:37:21 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dell.Client.Kernel@dell.com
Subject: Re: ucsi_acpi: probe of USBC000:00 fails with ioremap error
Message-ID: <YjSZIT6p/QL5T1QJ@kuha.fi.intel.com>
References: <b9b00e0e-9182-783d-ae30-d67d778ae060@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="H9PO/VHIdYJy1kEU"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9b00e0e-9182-783d-ae30-d67d778ae060@molgen.mpg.de>
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H9PO/VHIdYJy1kEU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Paul,

On Fri, Mar 18, 2022 at 01:36:37PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a Dell Precision 3540, Linux 5.16.12 reports an ioremap error:
> 
>     [    0.000000] Linux version 5.16.0-4-amd64
> (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.2.0-18) 11.2.0, GNU ld
> (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT Debian 5.16.12-1 (2022-03-08)
>     [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.16.0-4-amd64
> root=UUID=c9342a55-b747-4442-b2f4-bc03eb7a51cf ro quiet noisapnp
> log_buf_len=2M cryptomgr.notests btusb.enable_autosuspend=y
> random.trust_cpu=on
>     […]
>     [    0.000000] DMI: Dell Inc. Precision 3540/0M14W7, BIOS 1.15.0
> 12/08/2021
>     […]
>     [   24.230968] videodev: Linux video capture interface: v2.00
>     [   24.237747] ioremap error for 0x78e31000-0x78e32000, requested 0x2,
> got 0x0
>     [   24.238100] ucsi_acpi: probe of USBC000:00 failed with error -12
>     […]
>     $ sudo more /proc/iomem
>     […]
>     78a04000-78ea2fff : ACPI Non-volatile Storage
>       78e31000-78e31fff : USBC000:00
>     […]
> 
> This seems to happen on a lot of Dell devices, cf. bug 199741 (ioremap error
> on Dell XPS 9370) [1].

I'm not sure if this helps, but I'm going to change the ioremap() call
to memremap() soon in any case in this driver. Can you test the
attached patch?

thanks,

-- 
heikki

--H9PO/VHIdYJy1kEU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-usb-typec-ucsi-acpi-Map-the-mailbox-with-memremap.patch"

From be67ec57a68e28877e4d379d7624d30141e324ab Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Fri, 18 Mar 2022 17:23:09 +0300
Subject: [PATCH] usb: typec: ucsi: acpi: Map the mailbox with memremap()

Interim.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 6771f05e32c29..7455e3aff2be0 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -19,7 +19,7 @@
 struct ucsi_acpi {
 	struct device *dev;
 	struct ucsi *ucsi;
-	void __iomem *base;
+	void *base;
 	struct completion complete;
 	unsigned long flags;
 	guid_t guid;
@@ -51,7 +51,7 @@ static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
 	if (ret)
 		return ret;
 
-	memcpy(val, (const void __force *)(ua->base + offset), val_len);
+	memcpy(val, ua->base + offset, val_len);
 
 	return 0;
 }
@@ -61,7 +61,7 @@ static int ucsi_acpi_async_write(struct ucsi *ucsi, unsigned int offset,
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 
-	memcpy((void __force *)(ua->base + offset), val, val_len);
+	memcpy(ua->base + offset, val, val_len);
 
 	return ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_WRITE);
 }
@@ -132,18 +132,7 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	/* This will make sure we can use ioremap() */
-	status = acpi_release_memory(ACPI_HANDLE(&pdev->dev), res, 1);
-	if (ACPI_FAILURE(status))
-		return -ENOMEM;
-
-	/*
-	 * NOTE: The memory region for the data structures is used also in an
-	 * operation region, which means ACPI has already reserved it. Therefore
-	 * it can not be requested here, and we can not use
-	 * devm_ioremap_resource().
-	 */
-	ua->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	ua->base = devm_memremap(&pdev->dev, res->start, resource_size(res), MEMREMAP_WB);
 	if (!ua->base)
 		return -ENOMEM;
 
-- 
2.35.1


--H9PO/VHIdYJy1kEU--
