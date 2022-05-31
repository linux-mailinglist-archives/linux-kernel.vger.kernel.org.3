Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5AA538AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbiEaFon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbiEaFom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:44:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F58682176
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:44:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c2so11953726plh.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tnMlE7W8rlv8PT/b+7vBwkMTUrrkrYGsBQW0iZJ+Rzc=;
        b=ScYS60OzNAfwBUR0KcV7uOhW+I3O72L/8L9QJMIm9ToCPvltiTCO0ZclEVoZHR9fCJ
         YtGj2uSfxFDtOkV/IVJNq2itrJ3uQljsy8SB5ZctsGKYxs25E2wvMpTStchTJxlEW4Sv
         sLx+IvhXA2wLui5B21BR5uMGn494/NpAaYNmfq+GSvXbnUadb1Fcw8sJZkg3IEMFs5+8
         4tZKavQyxiAHkTURvAo/g5UvXs5aKgItQwBAJ9kKAW9gwAoHlKM/X/LrSLyTikJtEG1C
         fL/eFUE5mcRS4J2NL8wNTDkwVMeiu03aSa3UMfKOKQPfG+nHwcZ3bM9S/wlp4aq8gLZD
         Ukzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tnMlE7W8rlv8PT/b+7vBwkMTUrrkrYGsBQW0iZJ+Rzc=;
        b=pkki7yNueyVOMroFICxC6sne2loz64xcXjTpAz+SGJo+wcIfvjAlZCG/n7bCUIy89A
         5gbAejNc9EgFIwVFSC1963zSe3avE+Ot5NPO7fTWZWtN3Hik3TPA1ogYScunhawRD6fZ
         tQiMvq2MMx4ZhNG643wo7Gz80FOTkGCKYwxKh3jBh3VJXq1oZ5ahdByKCSTzrdOF879C
         lgK+2HtXy226ZriFchgwVK6SQzJbiN//8wqgHRi4yLLHz3gGExvoov9n5MjPUkJkbhK1
         YaAyS8NOQPp//izPa078vNPedtrksSaHmrfwZBIsPNSN+2AEaV5pA8PkXrcp38iDtPfA
         0gPw==
X-Gm-Message-State: AOAM530Dph/WwJsM3XyGL9uxI3fx9g/nojoMIWuAK9g3XDB/3M95Hytb
        REf+JwVj6M+dFkUpWpczxw==
X-Google-Smtp-Source: ABdhPJwRRJNUs+FZz/IZrjPRC5MbcCS9kziaqY95klk0U9EY+VlZWee8LdAKKvDNuHdEatOU6yl/xA==
X-Received: by 2002:a17:902:8501:b0:15c:ea4b:1398 with SMTP id bj1-20020a170902850100b0015cea4b1398mr60022634plb.109.1653975880832;
        Mon, 30 May 2022 22:44:40 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id f6-20020aa782c6000000b00518327b7d23sm9740126pfn.46.2022.05.30.22.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 22:44:40 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     eli.billauer@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v4] char: xillybus: Check endpoint type at probe time
Date:   Tue, 31 May 2022 13:44:31 +0800
Message-Id: <20220531054431.3978424-1-zheyuma97@gmail.com>
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
Changes in v4:
    - Use function xillyusb_check_endpoint() to check the endpoint in
      xillyusb_setup_base_eps()
Changes in v3:
    - Check the endpoint type more earlier
Changes in v2:
    - Check the endpoint type at probe time
---
 drivers/char/xillybus/xillyusb.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index dc3551796e5e..596964e65891 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -167,6 +167,7 @@ struct xillyusb_dev {
 	struct device		*dev; /* For dev_err() and such */
 	struct kref		kref;
 	struct workqueue_struct	*workq;
+	struct usb_interface *intf;
 
 	int error;
 	spinlock_t error_lock; /* protect @error */
@@ -1889,8 +1890,31 @@ static const struct file_operations xillyusb_fops = {
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
@@ -1962,6 +1986,10 @@ static int setup_channels(struct xillyusb_dev *xdev,
 			chan->out_log2_element_size = out_desc & 0x0f;
 			chan->out_log2_fifo_size =
 				((out_desc >> 8) & 0x1f) + 16;
+			if (xillyusb_check_endpoint(xdev, (i+2) | USB_DIR_OUT)) {
+				kfree(xdev->channels);
+				return -EINVAL;
+			}
 		}
 	}
 
@@ -2125,6 +2153,7 @@ static int xillyusb_probe(struct usb_interface *interface,
 	mutex_init(&xdev->process_in_mutex);
 	mutex_init(&xdev->msg_mutex);
 
+	xdev->intf = interface;
 	xdev->udev = usb_get_dev(interface_to_usbdev(interface));
 	xdev->dev = &interface->dev;
 	xdev->error = 0;
-- 
2.25.1

