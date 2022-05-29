Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6892B53701B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 09:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiE2G65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiE2G6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:58:54 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83D059339
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 23:58:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y1so7917424pfr.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 23:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58kX1OOtY+k2geYRZBJ22SUrbP3xr0N5heiBB7ymisg=;
        b=QQMkfSRbOmYduM5Gj4biKbbn7LR7LhEhyEBloajkNlmMzNs06FSxUARL6CIT97KyZi
         RI2jZOLuIPhRgdON7TtfzmTPVVdvH4AcFsRR4W8WI0gqsPE0CkZe74ZtuIA7v0nTELfV
         IUcPfhGyfQ2O/+mYEVsFLDuuhwr4XrwCvAlh1gj8gPi7t34VwMjGSAnxtXPoZgvndlwT
         sMw68riKbsqm/8kXgjrORiEQM3jpyxYHp5hfnVq/leWVXIg61LgFRzej10WDwxCwyYTw
         2DtetQY6/8VBzUqOj9FU5ShRECIiGN3kNRA2fZemvd0EmJjGvP8Vb2CaG8x2JdZmnG2x
         dEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58kX1OOtY+k2geYRZBJ22SUrbP3xr0N5heiBB7ymisg=;
        b=Tkt/XwsYbuye+O+ZxXGKRRkdiUw61LRhXuOmHcHwc8CtyDmym4GWYtaYmEoz8g1jv3
         iow43577WSA8z1YNGEjYJh1NISdClS08XwuDYwrSiGGsM3S2yHVuQ3CCKJZpz+whmpDH
         1KVcfTjY7ICQQAQGKD5ck4+sekbv4CJrkZjwCcmCh9Hv9TLzUy7jz+3XdhQh1uDmG1Lv
         yRFN/9QpWBipdWVnTKCqV6nW8ybNAH8HhsCrfU4uAK/jJ65RktCIsNTS2w98/FNDcU+n
         tI+fuXY36y2eXqIV5YpVUbtbWz7bZzl86wIqzn8paDdu5qCrsdMODmQXNlr0rq4QK4/c
         pjMA==
X-Gm-Message-State: AOAM532GHodbFjPaDEDwmX0ilzhVNVa+gBKl292HBZ6bqfJmoaKfnutB
        5jLxM2LJhqKUmkDalWlfTA==
X-Google-Smtp-Source: ABdhPJxEGR3dDy2jUScZ+pD2yimGgBZwPIYEaPeorkhSpd3ydXIIrp/EPekmnQ/VkNNClaX5+xrMUA==
X-Received: by 2002:a63:f518:0:b0:3fa:6f09:aac5 with SMTP id w24-20020a63f518000000b003fa6f09aac5mr26652616pgh.515.1653807532273;
        Sat, 28 May 2022 23:58:52 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7804c000000b00512d13016d0sm6353062pfm.159.2022.05.28.23.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 23:58:51 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     eli.billauer@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v3] char: xillybus: Check endpoint type at probe time
Date:   Sun, 29 May 2022 14:58:39 +0800
Message-Id: <20220529065839.3817434-1-zheyuma97@gmail.com>
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
Changes in v3:
    - Check the endpoint type more earlier
Changes in v2:
    - Check the endpoint type at probe time
---
 drivers/char/xillybus/xillyusb.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index dc3551796e5e..4ed19a2a04e3 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -167,6 +167,7 @@ struct xillyusb_dev {
 	struct device		*dev; /* For dev_err() and such */
 	struct kref		kref;
 	struct workqueue_struct	*workq;
+	struct usb_interface *intf;
 
 	int error;
 	spinlock_t error_lock; /* protect @error */
@@ -1891,6 +1892,17 @@ static const struct file_operations xillyusb_fops = {
 
 static int xillyusb_setup_base_eps(struct xillyusb_dev *xdev)
 {
+	int ret;
+	struct usb_endpoint_descriptor *in, *out;
+
+	ret = usb_find_common_endpoints(xdev->intf->cur_altsetting, &in, &out, NULL, NULL);
+	if (ret)
+		return ret;
+
+	if (in->bEndpointAddress != (IN_EP_NUM | USB_DIR_IN) ||
+		out->bEndpointAddress != (MSG_EP_NUM | USB_DIR_OUT))
+		return -EINVAL;
+
 	xdev->msg_ep = endpoint_alloc(xdev, MSG_EP_NUM | USB_DIR_OUT,
 				      bulk_out_work, 1, 2);
 	if (!xdev->msg_ep)
@@ -1916,6 +1928,21 @@ static int xillyusb_setup_base_eps(struct xillyusb_dev *xdev)
 	return -ENOMEM;
 }
 
+static int xillyusb_check_endpoint(struct xillyusb_dev *xdev, u8 addr)
+{
+	int i;
+	struct usb_host_interface *if_desc = xdev->intf->altsetting;
+
+	for (i = 0; i < if_desc->desc.bNumEndpoints; i++) {
+		struct usb_endpoint_descriptor *ep = &if_desc->endpoint[i].desc;
+
+		if (ep->bEndpointAddress == addr && usb_endpoint_is_bulk_out(ep))
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int setup_channels(struct xillyusb_dev *xdev,
 			  __le16 *chandesc,
 			  int num_channels)
@@ -1962,6 +1989,10 @@ static int setup_channels(struct xillyusb_dev *xdev,
 			chan->out_log2_element_size = out_desc & 0x0f;
 			chan->out_log2_fifo_size =
 				((out_desc >> 8) & 0x1f) + 16;
+			if (xillyusb_check_endpoint(xdev, (i+2) | USB_DIR_OUT)) {
+				kfree(xdev->channels);
+				return -EINVAL;
+			}
 		}
 	}
 
@@ -2125,6 +2156,7 @@ static int xillyusb_probe(struct usb_interface *interface,
 	mutex_init(&xdev->process_in_mutex);
 	mutex_init(&xdev->msg_mutex);
 
+	xdev->intf = interface;
 	xdev->udev = usb_get_dev(interface_to_usbdev(interface));
 	xdev->dev = &interface->dev;
 	xdev->error = 0;
-- 
2.25.1

