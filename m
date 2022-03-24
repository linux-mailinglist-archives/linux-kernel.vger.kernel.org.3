Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18B34E65B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347598AbiCXOzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbiCXOzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:55:03 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BE172E1F;
        Thu, 24 Mar 2022 07:53:31 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t2so4000560qtw.9;
        Thu, 24 Mar 2022 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uca/bYsYM+8uc58DJlLIYUvlXu7JrHCcisWQnLTb2FE=;
        b=VEvphlhMQxh4J8iQGTlWM9takLna6FJ4uFbbHs6d4e1n1R5O7WSyX63G2zRze0CQaZ
         VxOU6mXzC+48RwzBAXqjHTNNcrIi+OEx4uxGqjgBrKLRzAEfec9+6s2i+JBy+haPkUiL
         zDE7D7NlIXvUgYv6vGRdv0ztaLQDR2Hr2WpuUYVMP+BKAMj5bzsN2eD673a+BxWVoIed
         PSkx2DknZZgJYRazRM/ZfF4hYwb6TQCMkGwbyihvko9mczVbnY6ESk4HB11VWbE3Bvw4
         2hn1wLEyFMKsT8AfbGWf3QMnRDKkcenN4toANi3nmICeXGuIjBEjdjuEIKhgXQZSXm0y
         aOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uca/bYsYM+8uc58DJlLIYUvlXu7JrHCcisWQnLTb2FE=;
        b=Cp+EDaPH4lX5Nrgb3SfNBXI2KquH5UOq0EjV4iuFHm9e5aeDhuvRKeOszRW1Rqvro9
         4jp2nrx5b1vGuhIQEyw/VjwVlwhYA+3wNwVkfjXQUE8pOpeCYyC4h3GlRH3ydgBgyKUF
         BcQY5Rq4kLdgbkrQoVEJ59VsRvunEPM6Qdj0xG0AAzRLBANN/QfvWD9AYUJqc7epfPZW
         0nkaFgcQbKxYvl5eRC1bMK2fMn92mxIS+k+S65NCog3WPr96A5B57hbT+PEm62ovyp0G
         myBZ0KLV6iAAvrHC8YcOvvd2sZtpyXpdi656gOIo1IF3l7vEY8AKF1eIKYwaxu1c8Vg/
         VhCQ==
X-Gm-Message-State: AOAM5338FukS5w0tQSdR2UKJ19wLKiDh8srRCrjess4aSbc9MqjNKmra
        MBRxVyvI8dhq9k6dYxOQ15TSpTcpT/8=
X-Google-Smtp-Source: ABdhPJyAXke0R7Bv6Cv1B1ohnhR4dyg3t05kVCQnfuzxCgW0K1z02SNo08lSIGYnWl3EEGD/Fn5iwA==
X-Received: by 2002:a05:622a:1899:b0:2e1:b3d2:138d with SMTP id v25-20020a05622a189900b002e1b3d2138dmr4799373qtc.331.1648133610109;
        Thu, 24 Mar 2022 07:53:30 -0700 (PDT)
Received: from localhost.localdomain (c-73-171-102-37.hsd1.va.comcast.net. [73.171.102.37])
        by smtp.gmail.com with ESMTPSA id x5-20020ae9e645000000b0067b122fae88sm1637926qkl.2.2022.03.24.07.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:53:29 -0700 (PDT)
From:   Stephen Douthit <stephen.douthit@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Stephen Douthit <stephen.douthit@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: xpad - Turn off wireless controllers on shutdown
Date:   Thu, 24 Mar 2022 10:53:08 -0400
Message-Id: <20220324145308.2372-1-stephen.douthit@gmail.com>
X-Mailer: git-send-email 2.35.1
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

We already do this on suspend, makes sense for shutdown as well

Signed-off-by: Stephen Douthit <stephen.douthit@gmail.com>
---
 drivers/input/joystick/xpad.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 18190b529bca..8be79f91ba56 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1738,6 +1738,16 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	return error;
 }
 
+static void xpad360w_shutdown(struct device *dev)
+{
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct usb_xpad *xpad = usb_get_intfdata(intf);
+
+	xpad360w_stop_input(xpad);
+	if (xpad->pad_present)
+		xpad360w_poweroff_controller(xpad);
+}
+
 static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
@@ -1863,6 +1873,12 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		 * here in this driver and in usb core.
 		 */
 		udev->quirks |= USB_QUIRK_RESET_RESUME;
+
+		/*
+		 * Populate shutdown callback so wireless controllers turn off
+		 * when the machine turns off
+		 */
+		intf->dev.driver->shutdown = xpad360w_shutdown;
 	} else {
 		error = xpad_init_input(xpad);
 		if (error)
-- 
2.35.1

