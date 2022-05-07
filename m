Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEAC51E6CD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446334AbiEGMM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 08:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442217AbiEGMMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:12:53 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2274C165B6;
        Sat,  7 May 2022 05:09:07 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id eq14so7238432qvb.4;
        Sat, 07 May 2022 05:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FjD7dBxRajVTH5OXTLo8selNWenA3RGdBp07nHbxqs=;
        b=e2i9n38TU8cOjMhYnzNbfr5CyU+YEjlOUOQDZ/weGx5sHMxrUsJn1PP64UW2rtGqb9
         eg/f0bwgZlDBEC3lykGfX06ak2la11MLxRJTfHsyL9T8vGg10O0Ym/KWyPk86z/q7ua4
         8qkkd/09aM8pXgSKiq8YgkfdaVTZE4SfkqqCuMDsyLiXa6DviwwYCYI6oyo+Z66/uL7x
         kGCjqx252r4VDRI8WJNHSI5FsK4QJilD+QxVsR629+9inpXMcwrCdDBg/QG1MXRMsdqt
         VYQtLKFgEMkncH69EoX5/bdJtEhdER60g0tgiZYXvuyi4l+7oy9gbxGB76iFouiJgIZc
         SCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FjD7dBxRajVTH5OXTLo8selNWenA3RGdBp07nHbxqs=;
        b=YILZnCiOscLR9L3BPUhRCmGOBja3Kr5/0YztOE5fAI9KJWsZj9CV0abh+/i+HyOpy7
         4I8eecj1S55mcqsD7QYcXuFNACg6JNPzAOcNDKDT1cdpwNeBtD9f8Dqjt1NTZ5ayJJZl
         /m/Wt1JxKC2dyrNIkvuJ6fslab/sJwOu0YjPKaIamgDebBCX1BaG9Y+lO9b1DxHF5/ht
         S0h0K6WpDozbYr01N02nT45gWlKDOvP+sFTZ35696a1UJ2xKjenje8IiseYpYPRVwXs0
         xpQI9X47RhtNcokBzdGqfgaVoebRCiJRvh1Mf+EVJg19I/gBFvhhhgPxjfzisG6WR7KU
         gg3w==
X-Gm-Message-State: AOAM532jVBp+KOl9abXflKZpDTbO1apZgvvppZ5JYGvMoUR1hoX5ASpY
        y3Iud5hPe0DGFZdLnNNKTTMP/eQWhRh+b+bl
X-Google-Smtp-Source: ABdhPJxcllSwbxdQCOPEhNU+xY+h+UlnNDwbx7l+LDgflho+ay7ILhCvsfqGhZzaJk/ppkZnVNNmiA==
X-Received: by 2002:ad4:5762:0:b0:45a:7b14:e252 with SMTP id r2-20020ad45762000000b0045a7b14e252mr6058792qvx.79.1651925346218;
        Sat, 07 May 2022 05:09:06 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id w24-20020ac87198000000b002f39b99f697sm4094533qto.49.2022.05.07.05.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 05:09:05 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andreyknvl@gmail.com, balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     jj251510319013@gmail.com, stern@rowland.harvard.edu,
        jannh@google.com, Julia.Lawall@inria.fr, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, schspa@gmail.com,
        syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
Subject: [PATCH] usb: gadget: fix race when gadget driver register via ioctl
Date:   Sat,  7 May 2022 20:08:51 +0800
Message-Id: <20220507120851.29948-1-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb_gadget_register_driver doesn't have inside locks to protect the
driver, and If there is two threads are registered at the same time via
the ioctl syscall, the system will crash as syzbot reported.

Call trace as:
  driver_register+0x220/0x3a0 drivers/base/driver.c:171
  usb_gadget_register_driver_owner+0xfb/0x1e0
    drivers/usb/gadget/udc/core.c:1546
  raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:513 [inline]
  raw_ioctl+0x1883/0x2730 drivers/usb/gadget/legacy/raw_gadget.c:1220

This routine allows two processes to register the same driver instance
via ioctl syscall. which lead to a race condition.

We can fix it by adding a driver_lock to avoid double register.

Reported-by: syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000e66c2805de55b15a@google.com/

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/usb/gadget/legacy/raw_gadget.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index b3be8db1ff63..d7ff9c2b5397 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -155,7 +155,9 @@ struct raw_dev {
 	spinlock_t			lock;
 
 	const char			*udc_name;
+	/* Protected by driver_lock for reentrant registration */
 	struct usb_gadget_driver	driver;
+	struct mutex			driver_lock;
 
 	/* Reference to misc device: */
 	struct device			*dev;
@@ -188,6 +190,8 @@ static struct raw_dev *dev_new(void)
 	spin_lock_init(&dev->lock);
 	init_completion(&dev->ep0_done);
 	raw_event_queue_init(&dev->queue);
+	mutex_init(&dev->driver_lock);
+
 	return dev;
 }
 
@@ -398,7 +402,9 @@ static int raw_release(struct inode *inode, struct file *fd)
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	if (unregister) {
+		mutex_lock(&dev->driver_lock);
 		ret = usb_gadget_unregister_driver(&dev->driver);
+		mutex_unlock(&dev->driver_lock);
 		if (ret != 0)
 			dev_err(dev->dev,
 				"usb_gadget_unregister_driver() failed with %d\n",
@@ -510,7 +516,9 @@ static int raw_ioctl_run(struct raw_dev *dev, unsigned long value)
 	}
 	spin_unlock_irqrestore(&dev->lock, flags);
 
+	mutex_lock(&dev->driver_lock);
 	ret = usb_gadget_register_driver(&dev->driver);
+	mutex_unlock(&dev->driver_lock);
 
 	spin_lock_irqsave(&dev->lock, flags);
 	if (ret) {
-- 
2.29.0

