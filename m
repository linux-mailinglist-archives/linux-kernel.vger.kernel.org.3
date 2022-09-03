Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7255ABD32
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 07:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiICFLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 01:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiICFL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 01:11:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A3869F77;
        Fri,  2 Sep 2022 22:11:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p8-20020a17090ad30800b001fdfc8c7567so8891200pju.1;
        Fri, 02 Sep 2022 22:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0Gk7K6h0F1Pk4vJgzfMCBtymIV9nhuvTUp/dFq59Lg4=;
        b=atE+sw0GKhRf+Pk/s70pLvpfj5p/irVbjosPzsHJcmZ678VYHXaYRzitSLmyOi+MTA
         EVs80+i666t2vb/Wsmr+CXQbchSbPc1mMQO7wHV15tgclU3SW09+d36o/AcBuoueLVLQ
         jU2olKhTV51x7e/4Yn/7LF1fp6RVmMR3cMK74Ykq4CAVHafRFrmBl/FYPVR+FMUFSnP1
         SBmnpacYr9Wo67HZKbcpYO99sgL4X/EJp2ag0J/gNPZJEdmw8J/Iyzeh2EPixUAEwiCl
         mtmu6wWESMuXNlymckTr2BWy7vB0rnEi2t5yB6Zx+au432kscGak7cZiyQHBSxILw2ny
         +uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0Gk7K6h0F1Pk4vJgzfMCBtymIV9nhuvTUp/dFq59Lg4=;
        b=i6rGZ2qM0Bx2yJrD2mWymEwVaj0Xm590sUNe0KAcf6R05zrDyNjJ4jLcB7f9Gq1b2D
         DgI0AX0EXBA+Gyqp7+Ph2wsLb/sVhPapW59svT7iLdvd6sMh/Zo7TOSdvVHaTsjjpCNJ
         vwz2xtIuOuy2tYzXMEwE8fIq6LLD85cLDn4N5WQydPdr7ot6ETipdRo6kcNeTx5ZRQX0
         dz71OdseDwCge7E48NjWrV/ZPYPj/LYJnosPfVZCtj1iHck7aZCqxl0Nf1YryGuO47wG
         47a0zxwuGe7FFmktTWEZGXJs+up+Gyz8tDM6ZE2oAyWkXPAlP/jbYeeQIWO1cVWjyI+s
         YE1Q==
X-Gm-Message-State: ACgBeo2UltdYeExClxKZPX9jC4BQz0K92EJiafrKLxqjgzJbIvIdXgmB
        SorHEVlbUlIFzVGHMd65m3kp8aG3AI4=
X-Google-Smtp-Source: AA6agR5cKSdQCZByMJ4ARb66v/KR8SoCVwS9rRrDXNBKO43uAFlYA1zPpqWOPfVwZfAPbj/Wb8mLMQ==
X-Received: by 2002:a17:90b:1d84:b0:1f5:b66:7460 with SMTP id pf4-20020a17090b1d8400b001f50b667460mr8572762pjb.50.1662181885180;
        Fri, 02 Sep 2022 22:11:25 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:ea21:afd4:e65e:539c])
        by smtp.gmail.com with ESMTPSA id u1-20020a632341000000b0042a6dde1d66sm719571pgm.43.2022.09.02.22.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 22:11:24 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Input: aiptek - switch to using dev_groups for driver-specific attributes
Date:   Fri,  2 Sep 2022 22:11:19 -0700
Message-Id: <20220903051119.1332808-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220903051119.1332808-1-dmitry.torokhov@gmail.com>
References: <20220903051119.1332808-1-dmitry.torokhov@gmail.com>
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

The driver core now has the ability to handle the creation and removal
of device-specific sysfs files, let's use it instead of registering and
unregistering attributes by hand.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/tablet/aiptek.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 24ec4844a5c3..baabc51547b8 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -1617,7 +1617,7 @@ static ssize_t show_firmwareCode(struct device *dev, struct device_attribute *at
 
 static DEVICE_ATTR(firmware_code, S_IRUGO, show_firmwareCode, NULL);
 
-static struct attribute *aiptek_attributes[] = {
+static struct attribute *aiptek_dev_attrs[] = {
 	&dev_attr_size.attr,
 	&dev_attr_pointer_mode.attr,
 	&dev_attr_coordinate_mode.attr,
@@ -1641,9 +1641,7 @@ static struct attribute *aiptek_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group aiptek_attribute_group = {
-	.attrs	= aiptek_attributes,
-};
+ATTRIBUTE_GROUPS(aiptek_dev);
 
 /***********************************************************************
  * This routine is called when a tablet has been identified. It basically
@@ -1842,26 +1840,16 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	 */
 	usb_set_intfdata(intf, aiptek);
 
-	/* Set up the sysfs files
-	 */
-	err = sysfs_create_group(&intf->dev.kobj, &aiptek_attribute_group);
-	if (err) {
-		dev_warn(&intf->dev, "cannot create sysfs group err: %d\n",
-			 err);
-		goto fail3;
-        }
-
 	/* Register the tablet as an Input Device
 	 */
 	err = input_register_device(aiptek->inputdev);
 	if (err) {
 		dev_warn(&intf->dev,
 			 "input_register_device returned err: %d\n", err);
-		goto fail4;
+		goto fail3;
         }
 	return 0;
 
- fail4:	sysfs_remove_group(&intf->dev.kobj, &aiptek_attribute_group);
  fail3: usb_free_urb(aiptek->urb);
  fail2:	usb_free_coherent(usbdev, AIPTEK_PACKET_LENGTH, aiptek->data,
 			  aiptek->data_dma);
@@ -1886,7 +1874,6 @@ static void aiptek_disconnect(struct usb_interface *intf)
 		 */
 		usb_kill_urb(aiptek->urb);
 		input_unregister_device(aiptek->inputdev);
-		sysfs_remove_group(&intf->dev.kobj, &aiptek_attribute_group);
 		usb_free_urb(aiptek->urb);
 		usb_free_coherent(interface_to_usbdev(intf),
 				  AIPTEK_PACKET_LENGTH,
@@ -1900,6 +1887,7 @@ static struct usb_driver aiptek_driver = {
 	.probe = aiptek_probe,
 	.disconnect = aiptek_disconnect,
 	.id_table = aiptek_ids,
+	.dev_groups = aiptek_dev_groups,
 };
 
 module_usb_driver(aiptek_driver);
-- 
2.37.2.789.g6183377224-goog

