Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C58E51E866
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446648AbiEGQGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353246AbiEGQGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:06:52 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B369E027;
        Sat,  7 May 2022 09:03:05 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e15so11077044iob.3;
        Sat, 07 May 2022 09:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k13S9ItPgALMrAugBtRUW1Wd2tO5SVJuffpkWGMdiQU=;
        b=lNw/fMvZYAjQ2FhqgMUV9FGl1DDNpME3hvxAzNiXMj4lygExl4U9PLgutCzIHl6QH9
         bgXKLbnm4dy5g1E0b0ztGT/RUkMhG050idq7aWDtsOuUtKJ+h9550ByP6uE250jPJgM1
         EjZ/7vY3XhU0zscmgv/XTHpkylStbMEy0m1xP1FlM6Y398lIy88QONWFltw83jrK1+yh
         o2jtn+sKMZYH0F5LIuYzULIVL0XSeufoWky615J25oZrDwqRTUpcMQtJJ5wHm+hQ0XC6
         fKZjCirn+XygdQsH2cQr4EvdLz6eKTrZKuIZQGVwaGNLrauwriMKEE3kmYyO4gqfDPnZ
         botg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k13S9ItPgALMrAugBtRUW1Wd2tO5SVJuffpkWGMdiQU=;
        b=tUd1mpyKDahchNxE/enpeyVvNa/DWmRb5snvj55iFHVfrh+swF1pS6OkjvkzjDXX1b
         Nd2A7I2TSMuwx/6cwF2aHOlj/6p5yNIBGg3ASmpd14yQTKU8nA8k+4YYbQrKlRcf4mWl
         8hOt50bLdicI9gPxGeOHajrzuOFVRBKeXb0Du0kRsbJz+8bDGVK086T6OthgH4YPlULG
         sIYXPU9vsUH2VNfWUFbOwi9xeETJuzB8uEdl/ys3lq8vZjeG4DuBq4WgEkBU99FKkf6g
         Uz/QrXWlxNJrkvofuWgG4YRX4wMZv7c05ILXqlc86Ecvea/z/VQ0ETarGRIfUQchDa6i
         cOGw==
X-Gm-Message-State: AOAM533dfThD3y4qgXOaatSTDl+9TDF/OZujKFI5qKayr6I/IWqsmOa6
        /nzRPlraVKmjtIBMVuCqQCE6dGL5xhvvoA==
X-Google-Smtp-Source: ABdhPJzbUlPrChDXRa67uDCom9wecXHf6gV5c9GpzNq4TXjQUk+Ss0FTgweOjyzOm3UrgFDZ9GRcqQ==
X-Received: by 2002:a05:6602:2c4c:b0:64f:a897:80cb with SMTP id x12-20020a0566022c4c00b0064fa89780cbmr3503289iov.139.1651939384781;
        Sat, 07 May 2022 09:03:04 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id k28-20020a02c77c000000b0032b3a78173fsm2200533jao.3.2022.05.07.09.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 09:03:04 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     schspa@gmail.com
Cc:     Julia.Lawall@inria.fr, andreyknvl@gmail.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, jannh@google.com,
        jj251510319013@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
Subject: [PATCH v2] usb: gadget: fix race when gadget driver register via ioctl
Date:   Sun,  8 May 2022 00:02:43 +0800
Message-Id: <20220507160243.35304-1-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <CAMA88TrcHZH7vw8W4Jh+NCQJvpe3wQM-4k46MnDQC9agna4XJg@mail.gmail.com>
References: <CAMA88TrcHZH7vw8W4Jh+NCQJvpe3wQM-4k46MnDQC9agna4XJg@mail.gmail.com>
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

The usb_gadget_register_driver can be called multi time by to
threads via USB_RAW_IOCTL_RUN ioctl syscall, which will lead
to multiple registrations.

Call trace:
  driver_register+0x220/0x3a0 drivers/base/driver.c:171
  usb_gadget_register_driver_owner+0xfb/0x1e0
    drivers/usb/gadget/udc/core.c:1546
  raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:513 [inline]
  raw_ioctl+0x1883/0x2730 drivers/usb/gadget/legacy/raw_gadget.c:1220
  ioctl USB_RAW_IOCTL_RUN

This routine allows two processes to register the same driver instance
via ioctl syscall. which lead to a race condition.

We can fix it by adding a new STATE_DEV_REGISTERING device state to
avoid double register.

Reported-by: syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000e66c2805de55b15a@google.com/

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/usb/gadget/legacy/raw_gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index b3be8db1ff63..b75f8f7b7b46 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -146,6 +146,7 @@ enum dev_state {
 	STATE_DEV_OPENED,
 	STATE_DEV_INITIALIZED,
 	STATE_DEV_RUNNING,
+	STATE_DEV_REGISTERING,
 	STATE_DEV_CLOSED,
 	STATE_DEV_FAILED
 };
@@ -508,6 +509,7 @@ static int raw_ioctl_run(struct raw_dev *dev, unsigned long value)
 		ret = -EINVAL;
 		goto out_unlock;
 	}
+	dev->state = STATE_DEV_REGISTERING;
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	ret = usb_gadget_register_driver(&dev->driver);
-- 
2.24.3 (Apple Git-128)

