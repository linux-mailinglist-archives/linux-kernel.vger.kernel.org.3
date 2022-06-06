Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0295253E694
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiFFLJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiFFLJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:09:12 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C31CF149
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 04:09:11 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q123so12627973pgq.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 04:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=65ZFtNVWUgEiF7UjYBW3wJFLdAL4nYqOOHa7JvHA8WU=;
        b=Px0ePYPnmtG7I5kdPgobkR76856+txRiHqnX/3R6oKLXI3ByaR3Yr+EzS59BDH5Xj2
         VVdinsihZmFgJpZAuzCgrO64PkKL0wdhAog5rJ8gObl/+CNPmS/bGFAaO1gwI4VRhfTk
         z9sJFXdZHIK06bPhicVEP7ViHFs7WNEg7bLrKWsoCr4ANseGp6JNPmFaGi+WWjigZRSb
         xGe+7YUg2/XOLI4CmG09u8ytF3Kq+fJTQdPT8mMT0hjJP+5qk5FGVs59uNtuV8MUar8k
         KBODMSo/8HBnFlTRVG3gwtyGN4rhrI+RreJR9p4iRtInCAvj0rC0o8JNx3lGqx5Qw/AL
         HBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=65ZFtNVWUgEiF7UjYBW3wJFLdAL4nYqOOHa7JvHA8WU=;
        b=TRyIHP8j8e0kIsIB0WXAnndB6r+/A8r68qz0gyL4vf6HSPPF6piB9o3wvsaqqPMH01
         tYbRFbFHSckdykdKdBE07Q0f3/FL7+EPDdTig4h2KRSZ95NeTQqL5aUvl7E/3WWosxGv
         fEz4LIwPhbIy6IJQi3ow9xlOoJc3buJgfKXgo5Wlx+iZwbUTmey/s3tJQ1R52WtKX3qr
         8bOvtLlbcG4mOvl4KwmmyU8qB/9DOL685VPGqNMVqkXAoCYa4QwE4Ze9GbaKo0KA+xm+
         t4/dD/l8GlmInrWMg687QVxVymHT3/KY0oBLH8gnAmkYRc70OhFb4aAYsY2uPezOE6ct
         zPNg==
X-Gm-Message-State: AOAM530577YucL65Wb3xVjysXKlI08QJ/xtjIQVWPqP0y1IJbjXcE9sz
        +MoV+Ifz4jsmcy02zmNGj1ZXVxnVgIG6YPQ=
X-Google-Smtp-Source: ABdhPJwZCbQ2c5TjAeigfOfiMddP8L3OM54QgRxAAxussvJ8m5BjFmpg/MQRgyFluzTBLW0uT/r76A==
X-Received: by 2002:a05:6a00:8ce:b0:510:9298:ea26 with SMTP id s14-20020a056a0008ce00b005109298ea26mr23735422pfu.55.1654513750693;
        Mon, 06 Jun 2022 04:09:10 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id h17-20020a62b411000000b004fa743ba3f9sm10469574pfn.2.2022.06.06.04.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 04:09:10 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     eli.billauer@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v5] char: xillybus: Check endpoint type at probe time
Date:   Mon,  6 Jun 2022 19:09:00 +0800
Message-Id: <20220606110900.789260-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver submits bulk urb without checking the endpoint type is
actually bulk.

[    3.108690] usb 1-1: BOGUS urb xfer, pipe 3 != type 1
[    3.108983] WARNING: CPU: 0 PID: 211 at drivers/usb/core/urb.c:503 usb_submit_urb+0xcd9/0x18b0
[    3.110976] RIP: 0010:usb_submit_urb+0xcd9/0x18b0
[    3.115318] Call Trace:
[    3.115452]  <TASK>
[    3.115570]  try_queue_bulk_in+0x43c/0x6e0 [xillyusb]
[    3.115838]  xillyusb_probe+0x488/0x1230 [xillyusb]

Add a check at probe time to fix the bug.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v5:
    - Delete the misused function kfree()
Changes in v4:
    - Use function xillyusb_check_endpoint() to check the endpoint in
      xillyusb_setup_base_eps()
Changes in v3:
    - Check the endpoint type more earlier
Changes in v2:
    - Check the endpoint type at probe time
---
 drivers/char/xillybus/xillyusb.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 39bcbfd908b4..b1bac2fdb42a 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -167,6 +167,7 @@ struct xillyusb_dev {
 	struct device		*dev; /* For dev_err() and such */
 	struct kref		kref;
 	struct workqueue_struct	*workq;
+	struct usb_interface *intf;
 
 	int error;
 	spinlock_t error_lock; /* protect @error */
@@ -1890,8 +1891,31 @@ static const struct file_operations xillyusb_fops = {
 	.poll       = xillyusb_poll,
 };
 
+static int xillyusb_check_endpoint(struct xillyusb_dev *xdev, u8 addr)
+{
+	int i;
+	struct usb_host_interface *if_desc = xdev->intf->altsetting;
+
+	for (i = 0; i < if_desc->desc.bNumEndpoints; i++) {
+		struct usb_endpoint_descriptor *ep = &if_desc->endpoint[i].desc;
+
+		if (ep->bEndpointAddress != addr)
+			continue;
+
+		if ((usb_pipein(addr) && usb_endpoint_is_bulk_in(ep)) ||
+			(usb_pipeout(addr) && usb_endpoint_is_bulk_out(ep)))
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int xillyusb_setup_base_eps(struct xillyusb_dev *xdev)
 {
+	if (xillyusb_check_endpoint(xdev, IN_EP_NUM | USB_DIR_IN) ||
+		xillyusb_check_endpoint(xdev, MSG_EP_NUM | USB_DIR_OUT))
+		return -EINVAL;
+
 	xdev->msg_ep = endpoint_alloc(xdev, MSG_EP_NUM | USB_DIR_OUT,
 				      bulk_out_work, 1, 2);
 	if (!xdev->msg_ep)
@@ -1963,6 +1987,8 @@ static int setup_channels(struct xillyusb_dev *xdev,
 			chan->out_log2_element_size = out_desc & 0x0f;
 			chan->out_log2_fifo_size =
 				((out_desc >> 8) & 0x1f) + 16;
+			if (xillyusb_check_endpoint(xdev, (i+2) | USB_DIR_OUT))
+				return -EINVAL;
 		}
 	}
 
@@ -2126,6 +2152,7 @@ static int xillyusb_probe(struct usb_interface *interface,
 	mutex_init(&xdev->process_in_mutex);
 	mutex_init(&xdev->msg_mutex);
 
+	xdev->intf = interface;
 	xdev->udev = usb_get_dev(interface_to_usbdev(interface));
 	xdev->dev = &interface->dev;
 	xdev->error = 0;
-- 
2.25.1

