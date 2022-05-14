Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC525270E0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 13:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiENLsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 07:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiENLsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 07:48:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E2C2BF7
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 04:48:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c14so9931652pfn.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHUs8Z2XxXF+ED+4wuXHdG3gQbpYyVyNxihYHT4bnwY=;
        b=PenczdG3PvO5VyA/CIs+xeE3L1D7Pi7Im8lpV8jo1bz1CzVwK62hcvXQgnloyV8hEv
         7wZGA5MKoJbWYYwOUhZ+vaXCIEwHlyI3+a0MyjWxHfbc3ezF24hyWiB3wMTl73OIq/Yl
         veHixfqq339dRKgaw3nmdAdnSuYZ0hYEnPeGUZzOFrUkTudY0CdtoGEmCSkzE+wU1Hdh
         i6Opak0fCctMRCzEJN1l1DXIxqapEklGjbQ/r+fQlDwNXL/uJaxMeqr9ziUpdwCWVdym
         MmN6BIx2Cufe3hRUomDxuodHnhnNcsnJe0fwPZywio2LeNicRESRvYITkJkp8t9eqR9z
         1heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHUs8Z2XxXF+ED+4wuXHdG3gQbpYyVyNxihYHT4bnwY=;
        b=Ge9Rp6EWWShfKjv9kAv04Pp6QZTx3pVMadlOn0bkXxgvLh6CSKVl0Bv5xCCsR32mps
         0wfaxudNQw2f6HXKGOhyR39lCJ4g2HdK5esfirChvVzvZSn+g4YDNFdvsnBBFiVRNDq4
         y1H9j39kV5a6rGaIYbrd4Jxr6hbBwQ+hLKWP0inOFbz65uKKnQeoXySr9iBUHrcUkDcj
         uOOmtAlgMJNePLM79yoYZ/HyNqs4g7SsB0fb/ToPT8Wj0vZCxqM1j1WGBY7lrtEImdSD
         40VkasdXRt1xnhlmnsPQlUtfTRaRsEvf799YH50raYrfLKwwgScvYgWEeA6jYhBgFJo+
         sw0Q==
X-Gm-Message-State: AOAM531KWYZNEkBLllKJHq+SHZaml2Nlcz19yAD++G7R6jFiilqkJVwQ
        hiwHwxT13fzgfo5RGxwSyrv8AubWmvHR8zs=
X-Google-Smtp-Source: ABdhPJxlmwE1DUnR0XAHsmXsZRkdnCFCy97P82wWHF+CRr0pCzAWPfF2E8p1A9xOl7Adailhcm7G+g==
X-Received: by 2002:a05:6a00:238f:b0:4f7:78b1:2f6b with SMTP id f15-20020a056a00238f00b004f778b12f6bmr8607863pfc.17.1652528913405;
        Sat, 14 May 2022 04:48:33 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id fv7-20020a17090b0e8700b001cd4989fecfsm5115259pjb.27.2022.05.14.04.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 04:48:32 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     eli.billauer@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2] char: xillybus: Check endpoint type before allocing
Date:   Sat, 14 May 2022 19:48:19 +0800
Message-Id: <20220514114819.2773691-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Yn9XwHxWsLIJXlHu@kroah.com>
References: <Yn9XwHxWsLIJXlHu@kroah.com>
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

Add a check in endpoint_alloc() to fix the bug.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
    - Check the endpoint type at probe time
---
 drivers/char/xillybus/xillyusb.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index dc3551796e5e..4467f13993ef 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -167,6 +167,7 @@ struct xillyusb_dev {
 	struct device		*dev; /* For dev_err() and such */
 	struct kref		kref;
 	struct workqueue_struct	*workq;
+	struct usb_interface *intf;
 
 	int error;
 	spinlock_t error_lock; /* protect @error */
@@ -475,6 +476,25 @@ static void endpoint_dealloc(struct xillyusb_endpoint *ep)
 	kfree(ep);
 }
 
+static int xillyusb_check_endpoint(struct xillyusb_dev *xdev, u8 ep_num)
+{
+	struct usb_host_interface *if_desc = xdev->intf->altsetting;
+	int i;
+
+	for (i = 0; i < if_desc->desc.bNumEndpoints; i++) {
+		struct usb_endpoint_descriptor *ep = &if_desc->endpoint[i].desc;
+
+		if (ep->bEndpointAddress != ep_num)
+			continue;
+
+		if ((usb_pipein(ep_num) && usb_endpoint_is_bulk_in(ep)) ||
+			(usb_pipeout(ep_num) && usb_endpoint_is_bulk_out(ep)))
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
 static struct xillyusb_endpoint
 *endpoint_alloc(struct xillyusb_dev *xdev,
 		u8 ep_num,
@@ -482,10 +502,14 @@ static struct xillyusb_endpoint
 		unsigned int order,
 		int bufnum)
 {
-	int i;
+	int i, ret;
 
 	struct xillyusb_endpoint *ep;
 
+	ret = xillyusb_check_endpoint(xdev, ep_num);
+	if (ret)
+		return NULL;
+
 	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
 
 	if (!ep)
@@ -2125,6 +2149,7 @@ static int xillyusb_probe(struct usb_interface *interface,
 	mutex_init(&xdev->process_in_mutex);
 	mutex_init(&xdev->msg_mutex);
 
+	xdev->intf = interface;
 	xdev->udev = usb_get_dev(interface_to_usbdev(interface));
 	xdev->dev = &interface->dev;
 	xdev->error = 0;
-- 
2.25.1

