Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4FA574ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbiGNNSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiGNNSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:18:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEDC2723
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:18:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p9so2842984pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FICPOvskNZaVS6/YR3ZJCLElglUVHG4aUM/j9Ly4324=;
        b=ooP01MEqxBoJ6U5T/WcpBN+kmFOvE889VGqCywIGW92yZMj/tMHwMp6z6X+qBhSxhC
         /ZXjM3V3lGjRLGvunCkCSEAKBaTK7gGR0FNmTYEg871ZdLUVUYAzi0v/CrqtWubqr94w
         LUPJP23Wz9OQBRgJ1gJWSmPgvZMC0Gt07jR1LW3hT/MRhse+tXwoMMW6VzhpWz7DrWLX
         CRMrpHtfG22WVR/7YoPTfFSi7STDVIqt0MMk6Sw1HYvr1cAE+mhO29U0MbznaePoVYsG
         HSoCwV1PzTXD59wkE+RU82tTnZ5thvHXP3e/PaMjyBPpsUkgnPLWwsf9FQs4sjmkKsKb
         4xCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FICPOvskNZaVS6/YR3ZJCLElglUVHG4aUM/j9Ly4324=;
        b=BHHsBT3kp8guyMPKb5l97CbRDwdWlE8W6zbssNUv4s1Rxw1q9tVd1a99pHqXhylVsZ
         pDdie7O8V8pXV1diqnSJ9gN/wDZgW+Ur3cCLJjvUnVbC5j+dd0YCiCprUcR1nS28lSNs
         BwdLY3jCC32RcEP2GNYY03iAO39N2YK4NOqhWOLlQS25Lkwuqr/PWOkmV2JOWldY3yHo
         f+60zPoLkyArxo9RXRW/mgCEqI0sVX8obTXleZ3GQ6IpmMKnIae3zlkV6cASAnlXcYxA
         1iuXiY9HWmTZT9ndKoXZzSHfvmxPYUAbJbEK5zqL+4ZY3CW2hZ/zz+WR3aGI5AdT8UzG
         RuDA==
X-Gm-Message-State: AJIora+KcgUkU2BvM4/T9/ecMtK2VcZ0aYQSTVm9RpuPE1VZQZc436rF
        PncJ2/q6Ch2TbD9NUxxfWyQTeN0tCUH2RQ0=
X-Google-Smtp-Source: AGRyM1uAw2M8wcHabu7VBgr4Scn4GmEmyZCmDrjmoyrcS84dkCO6AijkpeVD5EJaAuvSiKtlKGjaJQ==
X-Received: by 2002:a17:90a:b117:b0:1ef:958f:e5b7 with SMTP id z23-20020a17090ab11700b001ef958fe5b7mr15947591pjq.107.1657804716264;
        Thu, 14 Jul 2022 06:18:36 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id c6-20020a63d146000000b0040d75537824sm1297573pgj.86.2022.07.14.06.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:18:35 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     eli.billauer@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v5 RESEND] char: xillybus: Check endpoint type at probe time
Date:   Thu, 14 Jul 2022 21:18:24 +0800
Message-Id: <20220714131824.919052-1-zheyuma97@gmail.com>
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

