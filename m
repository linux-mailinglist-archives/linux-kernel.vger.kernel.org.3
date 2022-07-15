Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86186575883
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241066AbiGOAHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241063AbiGOAHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:07:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9410B735B7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:07:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id r1so1821764plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=65ZFtNVWUgEiF7UjYBW3wJFLdAL4nYqOOHa7JvHA8WU=;
        b=Cx+YWv/0WnqJlHWBJO4ViQ7pmcAB0a4hbQ+/CkHGRwYpsJx9jaiq0vzjKM8lHE/63m
         iwuX07fFLDTSFmCTGyKuMeses4pJ7kxDi8jqgL7QmmOAmxOa0Soadz57SCcwDkwoZ/5Q
         +ny4PUYcNNaeRozeqGWOFCh2oLurbJrHPhJYJdfRXDuPiFJ5CBgXlYcJBuK77gfKOr9u
         iljHPkUBt7QEoT21x1/i9QZ6BUr650/AM6F3m2W6WCJV7wKFfjrAbh8InrO7p+Pb+QS0
         fqcNPvUTJlMxmFB3E9wMFZBGNTqB46mZY0EA6fkbPUy/5ktlNQT7Xsf2Ldt89d3/5nMt
         t44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=65ZFtNVWUgEiF7UjYBW3wJFLdAL4nYqOOHa7JvHA8WU=;
        b=rzbas1P0/Vbhd53MUHxyaVwNm7KW0twCiOWRNF1jbtiPbdhh7PoLiN/VbO6RtK/qbY
         y/w8bflCZji6DJuLgc0fxXfYr8AEPLVtb3XmGncswR8cJxN1OzjsybaFC2syV2a3w3XL
         RAZZfEGXgMEOgxFzCyZoNqSCcOEUeFSXpsm51iNOG3a5QDJXKpODN3QGN11gq9wQnpEM
         vzXB7Yhx/WE3rKYtyW0dg9I+Gi978osIALkILVvMtb6ss7PnWrWXAwI6eoEWVRCjymQj
         Ck4ZvNVgRepIJRIkNOdQ3vEEykvrBx8n+ggAcUpS+3zi8iUpBIf2YJs04OFCHVWEOZJQ
         893w==
X-Gm-Message-State: AJIora/rKuVAYqtsAne2JMETvhy8I/mouixXwn23xQBKY4iwIuYlGMoK
        JPNwiK2knZfEC7fYvk+C7h/4f4o2YBqjvFE=
X-Google-Smtp-Source: AGRyM1synz6vvMtc0xIeREFmxNLc/HRvNgN5GbyzFF97yB0fCjIby07rgYyEt4zAn0f6REg01IAiow==
X-Received: by 2002:a17:90b:1a8b:b0:1f0:817:3afc with SMTP id ng11-20020a17090b1a8b00b001f008173afcmr19051698pjb.213.1657843661109;
        Thu, 14 Jul 2022 17:07:41 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id 64-20020a621543000000b005289753448fsm2297208pfv.123.2022.07.14.17.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 17:07:40 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     eli.billauer@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v5 RESEND] char: xillybus: Check endpoint type at probe time
Date:   Fri, 15 Jul 2022 08:07:30 +0800
Message-Id: <20220715000730.1875055-1-zheyuma97@gmail.com>
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

