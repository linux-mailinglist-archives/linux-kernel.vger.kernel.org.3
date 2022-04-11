Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462894FC3A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348975AbiDKRug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiDKRue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D0E86353
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649699293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UM/pY0B56ZIojYfpBYET4rQaf0XG/Qm0KUr3TRSmnlw=;
        b=iqjhiSYHB8RsxNiJ6PRZqEBLaD10+59eLHQ7uEsZviOgcUbcE+EUHPd2o8TZRJiabpfPnG
        AIexu1rfaN4PT9sYOuPHkrHKw3gyhKeBFenSbAwbEE71hVAgMOQzL/ilJisRddrMVGFAq2
        5HbUjJW6COOQsv+KxIGSJcQQ6TK0x8s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-SZqkqnxeOHiCK1XNMiY6Eg-1; Mon, 11 Apr 2022 13:48:12 -0400
X-MC-Unique: SZqkqnxeOHiCK1XNMiY6Eg-1
Received: by mail-qk1-f200.google.com with SMTP id bk23-20020a05620a1a1700b0067b32f93b90so7993515qkb.16
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UM/pY0B56ZIojYfpBYET4rQaf0XG/Qm0KUr3TRSmnlw=;
        b=J2AA6+fy8i3JqCyO9TCtCXxPs2UFCelk9PO4gNencsucJP0hRfHJ+s3UdJhRb4KAsm
         6CZiqTsW8AAmeZytaO9s0hIjpPBgRNh2XrDoqy2x7fn0htAMiNlwLtUXGo5mTGhX2kL1
         cEWu3CBcq+5knK2/CH7RcxR3oFyPi9JBHAaH/pvxpV2DB68ar1qsHb5RS4MmPyV+bein
         M12yYf1deQyMgMoPP2zCYnBhCF/2rjS0/hVhJmnIEChtGzuPyHc6HUq7xpLz98zvaqlF
         aqBJ0jvASOAM76keFSMkBhgBx8MNhJNNhVqn/3ZcAnuq2pS0oEJbRw0O2eYmgScH1JA1
         qP5g==
X-Gm-Message-State: AOAM531W7cjO3SlTXRkw8rsE1p3F6jiIPcfEnWOH5Mab++HWhINFFlcp
        7BuSLWXcfpXL2PLMomwkJXv8RlN3Mz4ZrnNEQKjhnxMK0MTOQyzCqnCddc+DZLequ0wwYIrOkQO
        866QspSPW/UVFQKh7WzOD175p
X-Received: by 2002:a05:620a:29cb:b0:699:fee3:265a with SMTP id s11-20020a05620a29cb00b00699fee3265amr344681qkp.513.1649699291479;
        Mon, 11 Apr 2022 10:48:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQkJp+3hI9ThPxyj8PrJe1MP+oIxpg2KccPU8Yg1TBKGUS0YRlwQnXFHru9URmxPBM9smFrQ==
X-Received: by 2002:a05:620a:29cb:b0:699:fee3:265a with SMTP id s11-20020a05620a29cb00b00699fee3265amr344671qkp.513.1649699291276;
        Mon, 11 Apr 2022 10:48:11 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h27-20020ac8777b000000b002eff87a2c42sm380858qtu.4.2022.04.11.10.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 10:48:10 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] scsi: do not leak information in ioctl
Date:   Mon, 11 Apr 2022 13:47:56 -0400
Message-Id: <20220411174756.2418435-1-trix@redhat.com>
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

sr_ioctl.c uses this pattern

  result = sr_do_ioctl(cd, &cgc);
  to-user = buffer[];
  kfree(buffer);
  return result;

Use a buffer without checking leaks information.
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
v2 : split from combined pcd,scsi patch

 drivers/scsi/sr_ioctl.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

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

