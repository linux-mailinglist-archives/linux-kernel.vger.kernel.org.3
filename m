Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2272250CD2C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 21:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbiDWTWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 15:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiDWTWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 15:22:21 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BDA1DA401
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1650741561;
        bh=/RKB2jRgAU16VoNM+zrBlmdZGZchtI/lZWSgcosPGv0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=Gyk8pm46wmYR0N4nk0lEnMA6k4Tsqvc81v+4gQa+unWZJHCakGfWRWMvFyr6C4728
         s3vXls3mHR2Sng4A0lzishLQM1SM3lJlnkJUbqEaC85DqmuGrGmMUM4146S3bki37J
         5qREEHzgWAEpBRi223LSjd65DCdyl8pLhn87xo5Y=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 113D71280E1D;
        Sat, 23 Apr 2022 15:19:21 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CzsH_sy5tZhX; Sat, 23 Apr 2022 15:19:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1650741560;
        bh=/RKB2jRgAU16VoNM+zrBlmdZGZchtI/lZWSgcosPGv0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=eYSp0gDLABNLMzlkpOrFPLsYZ/YorM+/msyNLC1xCbh2TycDRsdzI8WSTN9kjC0br
         M6jvSa/zSs6rITkQmP/OAAdtOxLQXCIueyfFDTX+5kHZhA+O4HgG49VU1zk2gYZ599
         gqv8sK5y8UDjza+85vlpbQpT6e/5nlrhvH0JS2Ns=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 750051280DC6;
        Sat, 23 Apr 2022 15:19:20 -0400 (EDT)
Message-ID: <a661ff2bab4959b2b9759c537e3c1e5c1b7ce3a9.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.18-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 23 Apr 2022 15:19:19 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One fix for an information leak caused by copying a buffer to userspace
without checking for error first in the sr driver.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Tom Rix (1):
      scsi: sr: Do not leak information in ioctl

And the diffstat:

 drivers/scsi/sr_ioctl.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
index ddd00efc4882..fbdb5124d7f7 100644
--- a/drivers/scsi/sr_ioctl.c
+++ b/drivers/scsi/sr_ioctl.c
@@ -41,7 +41,7 @@ static int sr_read_tochdr(struct cdrom_device_info *cdi,
 	int result;
 	unsigned char *buffer;
 
-	buffer = kmalloc(32, GFP_KERNEL);
+	buffer = kzalloc(32, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -55,10 +55,13 @@ static int sr_read_tochdr(struct cdrom_device_info *cdi,
 	cgc.data_direction = DMA_FROM_DEVICE;
 
 	result = sr_do_ioctl(cd, &cgc);
+	if (result)
+		goto err;
 
 	tochdr->cdth_trk0 = buffer[2];
 	tochdr->cdth_trk1 = buffer[3];
 
+err:
 	kfree(buffer);
 	return result;
 }
@@ -71,7 +74,7 @@ static int sr_read_tocentry(struct cdrom_device_info *cdi,
 	int result;
 	unsigned char *buffer;
 
-	buffer = kmalloc(32, GFP_KERNEL);
+	buffer = kzalloc(32, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -86,6 +89,8 @@ static int sr_read_tocentry(struct cdrom_device_info *cdi,
 	cgc.data_direction = DMA_FROM_DEVICE;
 
 	result = sr_do_ioctl(cd, &cgc);
+	if (result)
+		goto err;
 
 	tocentry->cdte_ctrl = buffer[5] & 0xf;
 	tocentry->cdte_adr = buffer[5] >> 4;
@@ -98,6 +103,7 @@ static int sr_read_tocentry(struct cdrom_device_info *cdi,
 		tocentry->cdte_addr.lba = (((((buffer[8] << 8) + buffer[9]) << 8)
 			+ buffer[10]) << 8) + buffer[11];
 
+err:
 	kfree(buffer);
 	return result;
 }
@@ -384,7 +390,7 @@ int sr_get_mcn(struct cdrom_device_info *cdi, struct cdrom_mcn *mcn)
 {
 	Scsi_CD *cd = cdi->handle;
 	struct packet_command cgc;
-	char *buffer = kmalloc(32, GFP_KERNEL);
+	char *buffer = kzalloc(32, GFP_KERNEL);
 	int result;
 
 	if (!buffer)
@@ -400,10 +406,13 @@ int sr_get_mcn(struct cdrom_device_info *cdi, struct cdrom_mcn *mcn)
 	cgc.data_direction = DMA_FROM_DEVICE;
 	cgc.timeout = IOCTL_TIMEOUT;
 	result = sr_do_ioctl(cd, &cgc);
+	if (result)
+		goto err;
 
 	memcpy(mcn->medium_catalog_number, buffer + 9, 13);
 	mcn->medium_catalog_number[13] = 0;
 
+err:
 	kfree(buffer);
 	return result;
 }

