Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B4D4807C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 10:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhL1JVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 04:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhL1JVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 04:21:44 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51665C061574;
        Tue, 28 Dec 2021 01:21:44 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id i8so7026566pgt.13;
        Tue, 28 Dec 2021 01:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNVkEBxdCwv9W9cWRCtxiTjMYvuTdmDdbez6QkpuIPw=;
        b=QtYrwol/m+R+wxzXQCU6VdqoKr5ajQhSV15jR3EDMpMeWcgSZPO3Y5msreu52UIP6b
         cxjcCs8emkjFa+ehM43Vh82EVoVSkHdW21PdAVhqmSnLitGV1c2AOXepDCVDcofBRoib
         jM5ABNQnxDdL5XSqaFu5o/7Ew1JsWb61+V6Ypx4BoZ/UeQdkTp2ja3sXgrFZapeaxVnc
         dYZixApOzkKpnHKbhJAMS8EqrA4o79dmhUYoCIx6TnWgmHDpn2LV9NNwfTe82U/exO2h
         5G4coSV84rEOgVCNDx64TpQRc+HZ9dCRfzmZRz+V7YjinLHexIhLRIXe3eyBur0PFH17
         uY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNVkEBxdCwv9W9cWRCtxiTjMYvuTdmDdbez6QkpuIPw=;
        b=DxIRJ+YeBjIm5cGt+DVlBIjge/mVNSbILAOgplTn5k7aDzndnenShmW/ofV8Ohj3F+
         B3iIjBeun0++BpsuDgTyHOkS9vkbAtsPT8aQkyQH9/vMHDZ4Ma9LpUNsXI3P4OL0Wmdp
         vWWZkBWJ+QR2b/YusFe67ge5NRNED8UkBDSafS/YYkEFPrm5vS00cNmURZzucIp9qjVc
         XmhziF1QjN5p8xWclG4hAH8X0qJdsZvUq+REB17GOqFOlr3glsbZsO+QcImYuxkcRdKQ
         kSSL8n7cUaiLBFcNuDlCkSRXV5OM4gjRYyxQt8/ntsA3CQH84llKlQij4dNwSWKPb39R
         hNVw==
X-Gm-Message-State: AOAM530QnVDXOLLeQKAR8P1sLI+H1RfFdDw5uMMGA8Oazh6Rcb+YNsk6
        /9IzzLHPLe4zDIF56opj6rYEeLl07kf3QyJ7uxk=
X-Google-Smtp-Source: ABdhPJwgqghqxT+STHVjcpwykm34579nTmVZX96ctHNWtDSg6MlM3nxm1bQybOVaM6RwqOLd1maxiQ==
X-Received: by 2002:a63:2c06:: with SMTP id s6mr18244960pgs.55.1640683303908;
        Tue, 28 Dec 2021 01:21:43 -0800 (PST)
Received: from slim.das-security.cn ([103.84.139.53])
        by smtp.gmail.com with ESMTPSA id s3sm19226347pfm.0.2021.12.28.01.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 01:21:43 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        dan.carpenter@oracle.com, jj251510319013@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] usb: gadget: use after free in dev_config
Date:   Tue, 28 Dec 2021 17:21:26 +0800
Message-Id: <20211228092126.29510-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two bugs:
dev->buf does not need to be released if it already exists before
executing dev_config.
dev->config and dev->hs_config and dev->dev need to be cleaned if
dev_config fails to avoid UAF.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 3b58f4fc0a80..2ea02887025b 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1826,8 +1826,9 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	spin_lock_irq (&dev->lock);
 	value = -EINVAL;
 	if (dev->buf) {
+		spin_unlock_irq(&dev->lock);
 		kfree(kbuf);
-		goto fail;
+		return value;
 	}
 	dev->buf = kbuf;
 
@@ -1835,8 +1836,10 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	dev->config = (void *) kbuf;
 	total = le16_to_cpu(dev->config->wTotalLength);
 	if (!is_valid_config(dev->config, total) ||
-			total > length - USB_DT_DEVICE_SIZE)
+			total > length - USB_DT_DEVICE_SIZE) {
+		dev->config = NULL;
 		goto fail;
+	}
 	kbuf += total;
 	length -= total;
 
@@ -1845,8 +1848,11 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 		dev->hs_config = (void *) kbuf;
 		total = le16_to_cpu(dev->hs_config->wTotalLength);
 		if (!is_valid_config(dev->hs_config, total) ||
-				total > length - USB_DT_DEVICE_SIZE)
+				total > length - USB_DT_DEVICE_SIZE) {
+			dev->config = NULL;
+			dev->hs_config = NULL;
 			goto fail;
+		}
 		kbuf += total;
 		length -= total;
 	} else {
@@ -1856,13 +1862,20 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	/* could support multiple configs, using another encoding! */
 
 	/* device descriptor (tweaked for paranoia) */
-	if (length != USB_DT_DEVICE_SIZE)
+	if (length != USB_DT_DEVICE_SIZE) {
+		dev->config = NULL;
+		dev->hs_config = NULL;
 		goto fail;
+	}
 	dev->dev = (void *)kbuf;
 	if (dev->dev->bLength != USB_DT_DEVICE_SIZE
 			|| dev->dev->bDescriptorType != USB_DT_DEVICE
-			|| dev->dev->bNumConfigurations != 1)
+			|| dev->dev->bNumConfigurations != 1) {
+		dev->config = NULL;
+		dev->hs_config = NULL;
+		dev->dev = NULL;
 		goto fail;
+	}
 	dev->dev->bcdUSB = cpu_to_le16 (0x0200);
 
 	/* triggers gadgetfs_bind(); then we can enumerate. */
-- 
2.25.1

