Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028DA4FC3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349001AbiDKRw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244848AbiDKRww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0134530F48
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649699436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jZr8+/3dMtuPdhdci07RfqKq5wNhW11aZAga7dGt9wM=;
        b=apfhV/3qSuZ3Gwosry5zqyXGXiDPQdg0sFjUSjntmXM5T6zuxvKMEqNDjvLFAXC7F0f9/a
        YHmv0C1Z0PCn3bGjQjfe9ImCQYl57mM2COAAHDzsQ0SZg8hYWR+SxfRA7FHG5LbtSXkg33
        mAAnvDwBhctLEzR9Ol0mkhkzdKLXRec=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-PeJLBn0BOO-H5o33o5Kgzw-1; Mon, 11 Apr 2022 13:50:34 -0400
X-MC-Unique: PeJLBn0BOO-H5o33o5Kgzw-1
Received: by mail-qv1-f72.google.com with SMTP id b9-20020a0cfe69000000b00443cff31dfaso16343301qvv.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZr8+/3dMtuPdhdci07RfqKq5wNhW11aZAga7dGt9wM=;
        b=5YOch3FwnCYY760+2clfF12qyqBH9Pi5mRDQq3C5EE72jUKdxXoiiDLn18AnEqJmHA
         sziFxqbwDYqJhrrKszXSgd9vKGWvsmLvAayu2YXXEaGsENzkEe2TEeZjr3kq2QCwbIRp
         YT3cSUP8V0wXyo6W+tf8EBlJD3UTVR1lKJM8+cK8YMy0VHzZgMNOkNaGFj1keL6QkOy3
         bGSBO4srdIxX8g8pip6X661mKKvmoMMbKfumcF0LVEEFeCKUIE2sh0CjS/g62O3k5KQk
         MQElEzZPjsRsztiqFzBuqp0GmUCxIKSeaaJBuQ+6gwylTYGxtnp/Fo7s+y/jZOVWWg7Y
         cOxw==
X-Gm-Message-State: AOAM532377E7slLiaSXz9KErOfI7F+tX8tJ5qlugqKX/bC1q/dayKv2/
        cxbTJ8pGiIvCZ2T67Co5RGCMmRzx12E6i/X77PJt7V1ipr/7/EC4UoQxn8HE2yjbd51Jieu3W7k
        NMdAtjFyliAyxMc72RkODaPR/
X-Received: by 2002:a05:620a:2944:b0:67e:c9bf:3f9b with SMTP id n4-20020a05620a294400b0067ec9bf3f9bmr421903qkp.144.1649699434290;
        Mon, 11 Apr 2022 10:50:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzia1Yr5YPgHPUPuyWMsagB0zFBS5Py6/T1HccII27aP7kxWSF8b6jjxJdrdf6VFG6mwt4eeg==
X-Received: by 2002:a05:620a:2944:b0:67e:c9bf:3f9b with SMTP id n4-20020a05620a294400b0067ec9bf3f9bmr421892qkp.144.1649699434061;
        Mon, 11 Apr 2022 10:50:34 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a24-20020a05620a067800b0069c233fa524sm1987715qkh.1.2022.04.11.10.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 10:50:33 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     tim@cyberelk.net, axboe@kernel.dk, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] pcd: do not leak information in ioctl
Date:   Mon, 11 Apr 2022 13:50:26 -0400
Message-Id: <20220411175026.2961880-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Additionally initialize the buffer to zero.

This problem can be seen in the 2.4.0 kernel
However this scm only goes back as far as 2.6.12

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: split from combined scsi,pcd patch

 drivers/block/paride/pcd.c | 87 +++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 49 deletions(-)

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
-- 
2.27.0

