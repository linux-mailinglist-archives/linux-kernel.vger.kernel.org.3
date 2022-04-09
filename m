Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802E34FA91C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242355AbiDIOyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbiDIOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DAA213D77
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 07:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649515918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=t/bg9kn7ROahCSJyzfOEtwvtDCZszZoWTbNGij2GrjE=;
        b=WIn2RwJ+6s6g0PgtqNJIaGlqmHd/zV8vIuqysfyp3wN8v4yqTnhbYNl4rxyxsexHjj4rNi
        ySzlTOcL5FngQ9aRexdNRkDJKcuhIZtcAMyYSMgal9804Ui99LfQeDelaoreM22JsdY4SW
        EqjbNtmV5HABmQUnNAqtHjLTmKEqvTs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-hSMJZus7NGuvlFYTGrM01g-1; Sat, 09 Apr 2022 10:51:56 -0400
X-MC-Unique: hSMJZus7NGuvlFYTGrM01g-1
Received: by mail-qt1-f198.google.com with SMTP id c19-20020ac85a93000000b002ed12018ec4so749934qtc.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 07:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t/bg9kn7ROahCSJyzfOEtwvtDCZszZoWTbNGij2GrjE=;
        b=vbcxOB0KWuONAO7UP2KcO2mQKFdpUBAftic0TbDaKb+LZzrRhiv1tE3Ngk1/yIrIDf
         l7dJECSdeakxlbOr0dAGT3Yd5w8OGxgN9Dqu8ZjlTCtW+x+OOMVqeCY2eOPCYO9WFZLF
         nL/ihAtEsj77bLs54mDWDq8FT7hTamDUTRecAjIizQ+cEvGFFMctzNDR9JkV0ufa19HO
         n70yOYcn+3psPuFwFW/s8UuZhqx9cjUm4jMd92bZebwg6E1cFaD/aSkDlcIk00j7/e4b
         Evky8eHFz/Dp5rH1DdvmkuMaQya1DQkBWMIm6mxkN+y7IQpE+9oKIDN+uL9fSN1agO2T
         94Tg==
X-Gm-Message-State: AOAM533YedFbJnr3Ck+Sxj6eFrGQuIbF6lIyIITZTkMy1O15tYgsOfz2
        7zKtD8vIILvx/eUwDpp+J4dkGkYwUmN9HXSU2MuoyEKrg2lTN4fV/85PeZJ++b6ioYhjq0uCCXa
        piY+9BZHAPiPz3FFpV90PTaP5
X-Received: by 2002:a05:620a:2544:b0:680:a53b:ec1a with SMTP id s4-20020a05620a254400b00680a53bec1amr16685995qko.544.1649515916289;
        Sat, 09 Apr 2022 07:51:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGn6fJ9jRuJMb+wl3Tw8IkHfFNGvG+cEzqACp3UVw8jPRAuuFK+9VOOBkb8ed4Kksz+lzgVw==
X-Received: by 2002:a05:620a:2544:b0:680:a53b:ec1a with SMTP id s4-20020a05620a254400b00680a53bec1amr16685978qko.544.1649515916047;
        Sat, 09 Apr 2022 07:51:56 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a23-20020a05620a16d700b0067e98304705sm14845602qkn.89.2022.04.09.07.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 07:51:55 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     tim@cyberelk.net, axboe@kernel.dk, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] security: do not leak information in ioctl
Date:   Sat,  9 Apr 2022 10:51:37 -0400
Message-Id: <20220409145137.67592-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang static analysis reports this representative issue
pcd.c:832:22: warning: Assigned value is garbage
  or undefined
  tochdr->cdth_trk0 = buffer[2];
                    ^ ~~~~~~~~~

If the call to pcd_atapi fails, buffer is an unknown
state.  Passing an unknown buffer back to the user
can leak information and is a security risk.

Check before returning this buffer to the user.

The per-case variables cmd and buffer are common.
Change their scope to function level.
Change colliding parameter name cmd to request.

Cleanup whitespace

pcd.c comment
/* the audio_ioctl stuff is adapted from sr_ioctl.c */

Shows there is a similar problem in sr_ioctl.c
sr_ioctl.c uses this pattern

  result = sr_do_ioctl(cd, &cgc);
  to-user = buffer[];
  kfree(buffer);
  return result;

Check result and jump over the use of buffer
if there is an error.

  result = sr_do_ioctl(cd, &cgc);
  if (result)
    goto err;
  to-user = buffer[];
err:
  kfree(buffer);
  return result;

Additionally initialize the buffer to zero.

This problem can be seen in the 2.4.0 kernel
However this scm only goes back as far as 2.6.12

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/block/paride/pcd.c | 87 +++++++++++++++++---------------------
 drivers/scsi/sr_ioctl.c    | 15 +++++--
 2 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index f462ad67931a..2315918e3647 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -810,67 +810,56 @@ static void do_pcd_read_drq(void)
 
 /* the audio_ioctl stuff is adapted from sr_ioctl.c */
 
-static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void *arg)
+static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int request, void *arg)
 {
 	struct pcd_unit *cd = cdi->handle;
+	char cmd[12] = { GPCMD_READ_TOC_PMA_ATIP, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0 };
+	char buffer[32] = {};
 
-	switch (cmd) {
-
+	switch (request) {
 	case CDROMREADTOCHDR:
+	{
+		struct cdrom_tochdr *tochdr =
+			(struct cdrom_tochdr *) arg;
 
-		{
-			char cmd[12] =
-			    { GPCMD_READ_TOC_PMA_ATIP, 0, 0, 0, 0, 0, 0, 0, 12,
-			 0, 0, 0 };
-			struct cdrom_tochdr *tochdr =
-			    (struct cdrom_tochdr *) arg;
-			char buffer[32];
-			int r;
-
-			r = pcd_atapi(cd, cmd, 12, buffer, "read toc header");
+		if (pcd_atapi(cd, cmd, 12, buffer, "read toc header"))
+			return -EIO;
 
-			tochdr->cdth_trk0 = buffer[2];
-			tochdr->cdth_trk1 = buffer[3];
+		tochdr->cdth_trk0 = buffer[2];
+		tochdr->cdth_trk1 = buffer[3];
 
-			return r ? -EIO : 0;
-		}
+		return 0;
+	}
 
 	case CDROMREADTOCENTRY:
-
-		{
-			char cmd[12] =
-			    { GPCMD_READ_TOC_PMA_ATIP, 0, 0, 0, 0, 0, 0, 0, 12,
-			 0, 0, 0 };
-
-			struct cdrom_tocentry *tocentry =
-			    (struct cdrom_tocentry *) arg;
-			unsigned char buffer[32];
-			int r;
-
-			cmd[1] =
-			    (tocentry->cdte_format == CDROM_MSF ? 0x02 : 0);
-			cmd[6] = tocentry->cdte_track;
-
-			r = pcd_atapi(cd, cmd, 12, buffer, "read toc entry");
-
-			tocentry->cdte_ctrl = buffer[5] & 0xf;
-			tocentry->cdte_adr = buffer[5] >> 4;
-			tocentry->cdte_datamode =
-			    (tocentry->cdte_ctrl & 0x04) ? 1 : 0;
-			if (tocentry->cdte_format == CDROM_MSF) {
-				tocentry->cdte_addr.msf.minute = buffer[9];
-				tocentry->cdte_addr.msf.second = buffer[10];
-				tocentry->cdte_addr.msf.frame = buffer[11];
-			} else
-				tocentry->cdte_addr.lba =
-				    (((((buffer[8] << 8) + buffer[9]) << 8)
-				      + buffer[10]) << 8) + buffer[11];
-
-			return r ? -EIO : 0;
+	{
+		struct cdrom_tocentry *tocentry =
+			(struct cdrom_tocentry *) arg;
+
+		cmd[1] = (tocentry->cdte_format == CDROM_MSF ? 0x02 : 0);
+		cmd[6] = tocentry->cdte_track;
+
+		if (pcd_atapi(cd, cmd, 12, buffer, "read toc entry"))
+			return -EIO;
+
+		tocentry->cdte_ctrl = buffer[5] & 0xf;
+		tocentry->cdte_adr = buffer[5] >> 4;
+		tocentry->cdte_datamode =
+			(tocentry->cdte_ctrl & 0x04) ? 1 : 0;
+		if (tocentry->cdte_format == CDROM_MSF) {
+			tocentry->cdte_addr.msf.minute = buffer[9];
+			tocentry->cdte_addr.msf.second = buffer[10];
+			tocentry->cdte_addr.msf.frame = buffer[11];
+		} else {
+			tocentry->cdte_addr.lba =
+				(((((buffer[8] << 8) + buffer[9]) << 8)
+				  + buffer[10]) << 8) + buffer[11];
 		}
 
-	default:
+		return 0;
+	}
 
+	default:
 		return -ENOSYS;
 	}
 }
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
-- 
2.27.0

