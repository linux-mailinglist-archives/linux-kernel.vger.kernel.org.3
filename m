Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E208D51EE6E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiEHPGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 11:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiEHPGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 11:06:52 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31227DEFD;
        Sun,  8 May 2022 08:03:01 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id i20so12894122ion.0;
        Sun, 08 May 2022 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kfre6/ygIE35uySKLnPsy2RBut+ZLxAp1S9dwQFPHzQ=;
        b=gE9+S5xVAj8TG6zihR6U+ec6I+JIqqkXGGEYtVqn7MyB22aoWPNZQR2QwDUIjBTcrR
         B0EsrGqnj8DFLwflOqWf+vBMKhGeDsBwsVMbh8Mknj366//20o4rR4zRoonMA/q2qpiw
         EwfBsRW58WEb5BkWA/80KJK5ordO2yuUt4kPHXcWaBe1bTQwTlHec7uro0gXhrBYs8Hk
         6XeduX3jc7oElVM0w+mOu7W0zMFLhh0Mg5FkANVV3rJE+jeCSzpv8yz4KEZti8kS8I43
         W1dQe3hUaI/BTapKVqt45RjTfbDkEBG4gNiBazFGtQaXj5QP6hyTcgOn3NCYSOEssjZw
         lHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kfre6/ygIE35uySKLnPsy2RBut+ZLxAp1S9dwQFPHzQ=;
        b=0GX/v3nT2v+na9d/C4HdwynY0l/IFClGcXvC2J0CtxWbwW7Tb4j/kzEplKjCRHKrN7
         b0BaMKQGJXBlaH/Bl6DPCqU+p7zR9p9dHwiBBkx4HthKzNvcOod2FTnMHwRfgqNy0ewo
         /hP9gnKtuyPrDZZ77ymM/B4yYuWjys9ozw/Fu5ndGfjqZk8yv21iQuPyZJTNMxnySYzc
         b+djC8DXEWvzjt3gsi+0TmFh38o5/U4x1itwsSQPVVEZIj1jHsYAKuQo3IIhrfe9k1iu
         0+KXFNmFvY2FpDbD/ZowH+shejHvzAYywwkahFWdvSOkbVtUqyYSwW0rTzpae/BphkZq
         T21Q==
X-Gm-Message-State: AOAM5320TpEgvcRRGTgUMJW/MxIwwrAb6KVEyC2xQHV7oT9SPdzCbRrT
        +DCJUlZrcX+5Cgr5M8QlYPs=
X-Google-Smtp-Source: ABdhPJznPal23yTCfnh+9+pc9egS3/BDIL0Y0RRA1TNzmaJzoRndcGF8oSYQ8aPNQZWDmLb1xpBiPg==
X-Received: by 2002:a05:6602:2f06:b0:65a:cfe5:1778 with SMTP id q6-20020a0566022f0600b0065acfe51778mr2642842iow.192.1652022180478;
        Sun, 08 May 2022 08:03:00 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id y25-20020a02bb19000000b0032b3a7817e7sm2890894jan.171.2022.05.08.08.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 08:03:00 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     stern@rowland.harvard.edu
Cc:     Julia.Lawall@inria.fr, andreyknvl@gmail.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, jannh@google.com,
        jj251510319013@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, schspa@gmail.com,
        syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
Subject: [PATCH v3] usb: gadget: fix race when gadget driver register via ioctl
Date:   Sun,  8 May 2022 23:02:47 +0800
Message-Id: <20220508150247.38204-1-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <YnfVEcOWO63uIGs5@rowland.harvard.edu>
References: <YnfVEcOWO63uIGs5@rowland.harvard.edu>
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

Please refer to the following scenarios.

           T1                                  T2
------------------------------------------------------------------
usb_gadget_register_driver_owner
  driver_register                    driver_register
    driver_find                       driver_find
    bus_add_driver                    bus_add_driver
      priv alloced                     <context switch>
      drv->p = priv;
      <schedule out>
      kobject_init_and_add // refcount = 1;
   //couldn't find an available UDC or it's busy
   <context switch>
                                       priv alloced
                                       drv->priv = priv;
                                       kobject_init_and_add
                                         ---> refcount = 1 <------
                                       // register success
                                       <context switch>
===================== another ioctl/process ======================
                                      driver_register
                                       driver_find
                                        k = kset_find_obj()
                                         ---> refcount = 2 <------
                                        <context out>
   driver_unregister
   // drv->p become T2's priv
   ---> refcount = 1 <------
   <context switch>
                                        kobject_put(k)
                                         ---> refcount = 0 <------
                                        return priv->driver;
                                        --------UAF here----------

There will be UAF in this scenario.

We can fix it by adding a new STATE_DEV_REGISTERING device state to
avoid double register.

Reported-by: syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000e66c2805de55b15a@google.com/

Signed-off-by: Schspa Shi <schspa@gmail.com>

---

Changelog:
v1 -> v2:
        - Add a STATE_DEV_REGISTERING as Alan Stern suggested.
v2 -> v3:
        - Adjust STATE_DEV_REGISTERING position to reflect the actual
          order in which the states occur.
        - Add the fault scenarios to comments.
---
 drivers/usb/gadget/legacy/raw_gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index b3be8db1ff63..241740024c50 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -145,6 +145,7 @@ enum dev_state {
 	STATE_DEV_INVALID = 0,
 	STATE_DEV_OPENED,
 	STATE_DEV_INITIALIZED,
+	STATE_DEV_REGISTERING,
 	STATE_DEV_RUNNING,
 	STATE_DEV_CLOSED,
 	STATE_DEV_FAILED
@@ -508,6 +509,7 @@ static int raw_ioctl_run(struct raw_dev *dev, unsigned long value)
 		ret = -EINVAL;
 		goto out_unlock;
 	}
+	dev->state = STATE_DEV_REGISTERING;
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	ret = usb_gadget_register_driver(&dev->driver);
-- 
2.24.3 (Apple Git-128)

