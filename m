Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666865B02D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIGLWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiIGLWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:22:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63FEABF00;
        Wed,  7 Sep 2022 04:22:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z187so14279822pfb.12;
        Wed, 07 Sep 2022 04:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7qyFZsGWwAuwHvfMqmiVvBZdSteXB+wapmc7uA04y2U=;
        b=aCuCAWxFeN2XStVyMev2Jg/wMpPXQzbod+1BUL+CsL6TeNeFwlL2OGZzojzPf4IEre
         KCLJVIVwlZnXcvwf/Xcx/uEdNKaP9PBK8t517FOGbBr5tjdxfmkYXK2dTvqe9x36EIUl
         hWErBzS4Az7h08NgRiUs8UL4aQULNa282IZZTIJehn2l4rqfsNkV9Dp5pYV+JMohAeFK
         fW8yQt10Uvm6YWWWY0AExVpln6r5TfURQUNIqZvK+IKpDBm8tslUI36LprSllRsw1M3k
         2cnvfp5zX7gfPCWCbmTV13GAyzEkSQ0USq5T44bv7OuJ77qdURNf4tn5opzsCkiBRby/
         xjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7qyFZsGWwAuwHvfMqmiVvBZdSteXB+wapmc7uA04y2U=;
        b=OPiw8rFmI2ckvLkN8YYQPWU4r9olBjZrZz0hT98zN3DTrzdNRZf+NMk4vUzx4PXpOI
         LJwfVD0Q8KOf2dUpkaEsRqQdg71h78Gvlis8+WborW95kBsQLyBnjX6PLBeCC0WUCG70
         GIpHPUFCjwTKIb9Wx66Ruvh1iad+2S+PEMwISI+zkacdyFvISBW+/buKvJL1DXCxFNHD
         OqRlDDLwY5Ovz8q72kqTvITmGoV8nMHgSQ4hIdNhFK0YXGqxmzldqraGjm8pJeEPkC6j
         KSwGn0za/OPHeLPb/qTyBE0XwSaLA20ezk7VXp8cEcItbgn8t9A9R3NnC9w7L1Cut4vS
         PZCQ==
X-Gm-Message-State: ACgBeo0cniGfAyMmmqLaeMpsZ+LeMu9K7oZASKKiShfyCCmDcjRVyE4A
        ZlPNnpmauh3ACh/meI+gGULWFmmfzKWzw9KBSoY=
X-Google-Smtp-Source: AA6agR4V+q0tr3YCrE+dwEu0P179tWT4sYYiIaGRaqNgxkVho/T+wWBfyIlASv5KAki7Go+UrvZ7uA==
X-Received: by 2002:a63:df56:0:b0:42c:2dee:87de with SMTP id h22-20020a63df56000000b0042c2dee87demr2999208pgj.202.1662549755401;
        Wed, 07 Sep 2022 04:22:35 -0700 (PDT)
Received: from yiru-pc.localdomain ([183.173.184.117])
        by smtp.gmail.com with ESMTPSA id n13-20020a17090a73cd00b0020071acaecasm5635657pjk.42.2022.09.07.04.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 04:22:35 -0700 (PDT)
From:   Rondreis <linhaoguo86@gmail.com>
To:     balbi@kernel.org, stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rondreis <linhaoguo86@gmail.com>
Subject: [PATCH] usb: gadget: Assign a unique name for each configfs driver
Date:   Wed,  7 Sep 2022 19:22:10 +0800
Message-Id: <20220907112210.11949-1-linhaoguo86@gmail.com>
X-Mailer: git-send-email 2.37.3
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

When fuzzing the kernel, I couldn't use configfs to attach more than one
gadget. When attaching the second gadget with a different UDC it always
failed and the kernel message said:

Error: Driver 'configfs-gadget' is already registered, aborting...
UDC core: g1: driver registration failed: -16

The problem is that when creating multiple gadgets with configfs and
binding them to different UDCs, the UDC drivers have the same name
"configfs-gadget". Because of the addition of the "gadget" bus,
naming conflicts will occur when more than one UDC drivers
registered to the bus.

It's not an isolated case, this patch refers to the commit f2d8c2606825
("usb: gadget: Fix non-unique driver names in raw-gadget driver").
Each configfs-gadget driver will be assigned a unique name
"configfs-gadget.N", with a different value of N for each driver instance.

Reported-and-tested-by: Rondreis <linhaoguo86@gmail.com>
Signed-off-by: Rondreis <linhaoguo86@gmail.com>
---
 drivers/usb/gadget/configfs.c | 39 ++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 3a6b4926193e..7e7ff94dbaab 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -4,12 +4,18 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/nls.h>
+#include <linux/idr.h>
 #include <linux/usb/composite.h>
 #include <linux/usb/gadget_configfs.h>
 #include "configfs.h"
 #include "u_f.h"
 #include "u_os_desc.h"
 
+#define DRIVER_NAME "configfs-gadget"
+
+static DEFINE_IDA(driver_id_numbers);
+#define DRIVER_DRIVER_NAME_LENGTH_MAX 32
+
 int check_user_usb_string(const char *name,
 		struct usb_gadget_strings *stringtab_dev)
 {
@@ -46,6 +52,7 @@ struct gadget_info {
 
 	struct usb_composite_driver composite;
 	struct usb_composite_dev cdev;
+	int driver_id_number;
 	bool use_os_desc;
 	char b_vendor_code;
 	char qw_sign[OS_STRING_QW_SIGN_LEN];
@@ -252,6 +259,11 @@ static int unregister_gadget(struct gadget_info *gi)
 		return ret;
 	kfree(gi->composite.gadget_driver.udc_name);
 	gi->composite.gadget_driver.udc_name = NULL;
+
+	kfree(gi->composite.gadget_driver.driver.name);
+	if (gi->driver_id_number >= 0)
+		ida_free(&driver_id_numbers, gi->driver_id_number);
+
 	return 0;
 }
 
@@ -1571,7 +1583,6 @@ static const struct usb_gadget_driver configfs_driver_template = {
 	.max_speed	= USB_SPEED_SUPER_PLUS,
 	.driver = {
 		.owner          = THIS_MODULE,
-		.name		= "configfs-gadget",
 	},
 	.match_existing_only = 1,
 };
@@ -1580,6 +1591,8 @@ static struct config_group *gadgets_make(
 		struct config_group *group,
 		const char *name)
 {
+	int ret = 0;
+	char *driver_driver_name;
 	struct gadget_info *gi;
 
 	gi = kzalloc(sizeof(*gi), GFP_KERNEL);
@@ -1609,6 +1622,7 @@ static struct config_group *gadgets_make(
 	gi->composite.suspend = NULL;
 	gi->composite.resume = NULL;
 	gi->composite.max_speed = USB_SPEED_SUPER_PLUS;
+	gi->driver_id_number = -1;
 
 	spin_lock_init(&gi->spinlock);
 	mutex_init(&gi->lock);
@@ -1622,16 +1636,35 @@ static struct config_group *gadgets_make(
 
 	gi->composite.gadget_driver = configfs_driver_template;
 
+	ret = ida_alloc(&driver_id_numbers, GFP_KERNEL);
+	if (ret < 0)
+		goto err;
+	gi->driver_id_number = ret;
+
+	driver_driver_name = kmalloc(DRIVER_DRIVER_NAME_LENGTH_MAX, GFP_KERNEL);
+	if (!driver_driver_name) {
+		ret = -ENOMEM;
+		goto err_free_driver_id_number;
+	}
+	snprintf(driver_driver_name, DRIVER_DRIVER_NAME_LENGTH_MAX,
+			DRIVER_NAME ".%d", gi->driver_id_number);
+	gi->composite.gadget_driver.driver.name = driver_driver_name;
+
 	gi->composite.gadget_driver.function = kstrdup(name, GFP_KERNEL);
 	gi->composite.name = gi->composite.gadget_driver.function;
 
-	if (!gi->composite.gadget_driver.function)
+	if (!gi->composite.gadget_driver.function) {
+		ret = -ENOMEM;
 		goto err;
+	}
 
 	return &gi->group;
+
+err_free_driver_id_number:
+	ida_free(&driver_id_numbers, gi->driver_id_number);
 err:
 	kfree(gi);
-	return ERR_PTR(-ENOMEM);
+	return ERR_PTR(ret);
 }
 
 static void gadgets_drop(struct config_group *group, struct config_item *item)
-- 
2.37.3

