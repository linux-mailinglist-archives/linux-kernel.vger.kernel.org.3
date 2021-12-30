Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E61481958
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 05:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhL3Eik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 23:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhL3Eij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 23:38:39 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54007C061574;
        Wed, 29 Dec 2021 20:38:38 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 7so7787570pgn.0;
        Wed, 29 Dec 2021 20:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPrFVoAT2ZfPoSOTkYfP4UPforP6W8SuPPAfw8/vF8o=;
        b=ezqchMgXSztu8RyJIX14AB7fkxqZlR4tIuqMSfo+882QJMogiqTtNntU+lKhrgFKY9
         mVNezdmIK4FSg5BEO9K6zk3mVRLjO2f7PBieMcp1dShBmlQWTwMPwhvB3BekregrcW1Y
         N2abnpGTmDYW/pfbfRtH2p+qjOebfPgj281lvF2V59Fh3xSu4Vg7PZdlWwpxtUW+rq1c
         7g7hLfzdjAr2Xq/y5HfcLU6pfcUocbrl/6eBLCkBBG6fuVZX5mStXDF0qIavj9Nr0Tpy
         1+5Y9R+eTR5YIoR014hAHxVK2wJrkOM/EEpTipsBaBJ/h+0ezUlDhAqf+3XrDKfFKHwI
         w/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPrFVoAT2ZfPoSOTkYfP4UPforP6W8SuPPAfw8/vF8o=;
        b=xiWNcAYV8honoQJrOJ2eNGuXiKji9MjPAInDjcZxrk3kPYHVOX1yzguSpSOE868j3g
         oVNe1SyIVHFEWHAn/YTWyM8bioYTqP4wT6gEtRtEz5QB3K7l7dj1gX+TP6BzE1Ue0zJO
         9zENrsJLu2UYu/MCdhlEJ2FFCdYnOq2Pi/2KpajnxEaPtD6+E++ZoaQ1Gwaeb6pZoFee
         PVM7R/HWqIu9iThsZr0fQ64Vp7fqzi94ln9AHx6GFmZELFh8ShofBL+EIqIYOx9Bodpe
         DA+TKDSD+lmsZrHFG9FbMlDmSE/YHqyd++QJjhvsgaIcgSkluyRWIIRxKmIn5SCFB8Ou
         w76g==
X-Gm-Message-State: AOAM533meH7pI8TWPWJ3tCyR5tU2IXchHqEHeai5Ail3620FUvkyZDJZ
        f+sOoawL7F+NVPH6mfpMGsU=
X-Google-Smtp-Source: ABdhPJwD8Pc7ndCC+aoUFPtSpdbplG9rYLJSF7lfaGu2loA5r/dkQ1T5YTSbgbFN3YUyuAqt4pFFrA==
X-Received: by 2002:a63:8042:: with SMTP id j63mr26587149pgd.292.1640839117891;
        Wed, 29 Dec 2021 20:38:37 -0800 (PST)
Received: from slim.das-security.cn ([103.84.139.53])
        by smtp.gmail.com with ESMTPSA id g16sm22828808pfv.159.2021.12.29.20.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 20:38:37 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        stern@rowland.harvard.edu, jj251510319013@gmail.com,
        dan.carpenter@oracle.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2 2/2] usb: gadget: clear related members when goto fail
Date:   Thu, 30 Dec 2021 12:38:15 +0800
Message-Id: <20211230043815.18899-3-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211230043815.18899-1-hbh25y@gmail.com>
References: <20211230043815.18899-1-hbh25y@gmail.com>
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
index 564352035ac1..c03ac0272e7d 100644
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
+		dev->dev = NULL
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

