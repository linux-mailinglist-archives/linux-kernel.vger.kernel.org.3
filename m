Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6DE481988
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 06:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbhL3FMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 00:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhL3FLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 00:11:55 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15ACC061574;
        Wed, 29 Dec 2021 21:11:54 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so22155689pjp.0;
        Wed, 29 Dec 2021 21:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2qrH/Q7lBhgBs5n1zVO/B/67KzCmyY6Nm+oaWRXQUfQ=;
        b=HlD8egyoFHZ/+jS6QxT0P/ByOaMcnWZq/oyv7wctNgWnUTtPjFcSgGSoN65LtS2YJb
         FDPq147Eee2GpuoCuws+6HCODa8oi8MdSnJGXm++KDopoM6CKYK/3tsDHAzrWowAo0cO
         TCDbaQt+Ij6L9t8laCrvJLoLUsq3xIusWJ5VrbDaQtHr2Oln+lUKDDP8P3CsU5nEb4W3
         u2K+fXrkXDhHgIIoe22yvxPJmvqP4E8Jmj07yiF99ejYQgwS7n47U1Y6Vo39MR+yJud7
         evwVQmazSi+/KHtRBcPWMKkbBD6db8TqI+mSqLG2KX4UXDq2or2q+dkWfrDZsmaJJSso
         2PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2qrH/Q7lBhgBs5n1zVO/B/67KzCmyY6Nm+oaWRXQUfQ=;
        b=wE51ZOX3xp+dq8M/egmwJxVX0/lLIsdFLsVa86umI47RkCE6o/OiOVj/4NAjWOX1HY
         8jY1/5RqFKoP7oQohONHcsm8kj/d2ZBg5+olqlH+y3pT7RNlH5M4Dila1UGF771yDrOw
         UEeLmu9qdTsVkqLet3SPHx4Q/5iuitYj2K3XIpQWrVFM9DSnDjNn2QvNd/m+92fY3n21
         F5/Vm2zxfbkbi4KkgXXmhYRDs3ch8dQE0swnzjgY0bqInNlZYJPk+P9NCv6vtG1RsSHw
         xGRC1hUf4h9kabv2ou3N/pl9Z0EXMEdO9kezmxqZ2hcl8NJ/jWM+QDP3rpxVq2C7gH6l
         qU/Q==
X-Gm-Message-State: AOAM530DM/wd8F5eCvNrfXiGxiSrwJ/k4yiAp/Mms8XGl8GGKwxOt8cK
        8MrudNUGo8uC1Y9pgivsV/w=
X-Google-Smtp-Source: ABdhPJxtAwmczCvw5kzAiXwk4Avbf6mtvcOWKCOoVnJb5N/Ob2UW/+MTdAD8OznFSZbZcieKZRcm9Q==
X-Received: by 2002:a17:903:4094:b0:149:8070:1c1b with SMTP id z20-20020a170903409400b0014980701c1bmr17099176plc.152.1640841114381;
        Wed, 29 Dec 2021 21:11:54 -0800 (PST)
Received: from slim.das-security.cn ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id e21sm10365925pjr.4.2021.12.29.21.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 21:11:54 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        stern@rowland.harvard.edu, jj251510319013@gmail.com,
        dan.carpenter@oracle.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v3 2/2] usb: gadget: clear related members when goto fail
Date:   Thu, 30 Dec 2021 13:11:32 +0800
Message-Id: <20211230051132.21056-3-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211230051132.21056-1-hbh25y@gmail.com>
References: <20211230051132.21056-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev->config and dev->hs_config and dev->dev need to be cleaned if
dev_config fails to avoid UAF.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index eaad03c0252f..d2e88f3b9131 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1847,7 +1847,7 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 		total = le16_to_cpu(dev->hs_config->wTotalLength);
 		if (!is_valid_config(dev->hs_config, total) ||
 				total > length - USB_DT_DEVICE_SIZE)
-			goto fail;
+			goto fail1;
 		kbuf += total;
 		length -= total;
 	} else {
@@ -1858,12 +1858,12 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 
 	/* device descriptor (tweaked for paranoia) */
 	if (length != USB_DT_DEVICE_SIZE)
-		goto fail;
+		goto fail1;
 	dev->dev = (void *)kbuf;
 	if (dev->dev->bLength != USB_DT_DEVICE_SIZE
 			|| dev->dev->bDescriptorType != USB_DT_DEVICE
 			|| dev->dev->bNumConfigurations != 1)
-		goto fail;
+		goto fail2;
 	dev->dev->bcdUSB = cpu_to_le16 (0x0200);
 
 	/* triggers gadgetfs_bind(); then we can enumerate. */
@@ -1875,6 +1875,9 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 
 	value = usb_gadget_probe_driver(&gadgetfs_driver);
 	if (value != 0) {
+		dev->dev = NULL;
+		dev->hs_config = NULL;
+		dev->config = NULL;
 		kfree (dev->buf);
 		dev->buf = NULL;
 	} else {
@@ -1892,7 +1895,12 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	}
 	return value;
 
+fail2:
+	dev->dev = NULL;
+fail1:
+	dev->hs_config = NULL;
 fail:
+	dev->config = NULL;
 	spin_unlock_irq (&dev->lock);
 	pr_debug ("%s: %s fail %zd, %p\n", shortname, __func__, value, dev);
 	kfree (dev->buf);
-- 
2.25.1

