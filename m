Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F8B5ABD30
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 07:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiICFLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 01:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiICFL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 01:11:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0724F647FE;
        Fri,  2 Sep 2022 22:11:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d12so3737076plr.6;
        Fri, 02 Sep 2022 22:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8uldbUkLZ5Arz8WmU1um7lfSedbFH8vdo+1QvNJr590=;
        b=ldmOkXekBEtH0b9zzQtlC9LfYTmFd0+FhzRkCOnrCnSTIJdmqQK5/9W7sNawXTyCKF
         GiL4reOLAoB4riO/G2nzfsnPLCO/dTIxV8IosO8C0cOATsH3pkPErc+tUlVVPkkAy2BR
         3Eeow2YEoOzd2qvl+eu5bnIuz9ZU1Lfv3/d29NkK5PJ0AveyCpQY1qcBcc7i0erOSMv7
         iE67JI69jH72+6jHogX9qrXkI2RSdGO0Vp+SwECuX+FerpJ37V1gS2WxSWtrW/JkDt15
         7KZVYYmkNW15X0H9kQyiCjyPs7ddD0Xw8zIMmXzJBDLIWo2XQ4ncdU0o/q4BR7hGuDjk
         MvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8uldbUkLZ5Arz8WmU1um7lfSedbFH8vdo+1QvNJr590=;
        b=wLdVwpr4itiCygpnkJ275yJ4jQwHMxvq+nTR6KRa6Rc1G0jClk6ss7h7a1aoZDRWkG
         scNi5d3kZOK7TNMuhV/HeiWsNmMCAOM70j5jGKdhJHv2tBlCUTGGMtAP5oAGezpm15Hd
         L3iKis2hrsLEJwCDTbSsPwN5+ryp9OSEym4/zksijdViz+AkxBfxID69pe2iBxMphOw7
         RPhg1xdfO6vWYY8Ey+kFMZATW/WDNdivuK8z1B9LvvdQRtJsW4kmBl2chfjPztDXR0TD
         qn9th3VZWhJorY6jJTsOA6Y0g4/RWY0EAs/LsC8bNUzYILl5VkxMOPpzV9iaYpHwwstG
         o6Qw==
X-Gm-Message-State: ACgBeo2AhJ8OGVSj0m+fdko2tL8lKMkSR8DMhL0y40z2ydSfL8Zp4Qxd
        zVmv/REEWR69FVlgY3Rav7dAjplJuAE=
X-Google-Smtp-Source: AA6agR7lSU7bspUSBcG6wr7WTUx5qUq9cm4rdNwUTpDDGSXLxNg8KLfkB/2xN2qaFm6ZQ2wt/o1Prw==
X-Received: by 2002:a17:902:6b07:b0:172:a76d:7cc5 with SMTP id o7-20020a1709026b0700b00172a76d7cc5mr38744601plk.128.1662181884027;
        Fri, 02 Sep 2022 22:11:24 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:ea21:afd4:e65e:539c])
        by smtp.gmail.com with ESMTPSA id u1-20020a632341000000b0042a6dde1d66sm719571pgm.43.2022.09.02.22.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 22:11:23 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Input: psmouse - switch to using dev_groups for driver-specific attributes
Date:   Fri,  2 Sep 2022 22:11:18 -0700
Message-Id: <20220903051119.1332808-2-dmitry.torokhov@gmail.com>
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
 drivers/input/mouse/psmouse-base.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 0b4a3039f312..c9a7e87b273e 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -94,7 +94,7 @@ PSMOUSE_DEFINE_ATTR(resync_time, S_IWUSR | S_IRUGO,
 			(void *) offsetof(struct psmouse, resync_time),
 			psmouse_show_int_attr, psmouse_set_int_attr);
 
-static struct attribute *psmouse_attributes[] = {
+static struct attribute *psmouse_dev_attrs[] = {
 	&psmouse_attr_protocol.dattr.attr,
 	&psmouse_attr_rate.dattr.attr,
 	&psmouse_attr_resolution.dattr.attr,
@@ -103,9 +103,7 @@ static struct attribute *psmouse_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group psmouse_attribute_group = {
-	.attrs	= psmouse_attributes,
-};
+ATTRIBUTE_GROUPS(psmouse_dev);
 
 /*
  * psmouse_mutex protects all operations changing state of mouse
@@ -1481,8 +1479,6 @@ static void psmouse_disconnect(struct serio *serio)
 	struct psmouse *psmouse = serio_get_drvdata(serio);
 	struct psmouse *parent = NULL;
 
-	sysfs_remove_group(&serio->dev.kobj, &psmouse_attribute_group);
-
 	mutex_lock(&psmouse_mutex);
 
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
@@ -1647,10 +1643,6 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 	if (parent && parent->pt_activate)
 		parent->pt_activate(parent);
 
-	error = sysfs_create_group(&serio->dev.kobj, &psmouse_attribute_group);
-	if (error)
-		goto err_pt_deactivate;
-
 	/*
 	 * PS/2 devices having SMBus companions should stay disabled
 	 * on PS/2 side, in order to have SMBus part operable.
@@ -1666,13 +1658,6 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 	mutex_unlock(&psmouse_mutex);
 	return retval;
 
- err_pt_deactivate:
-	if (parent && parent->pt_deactivate)
-		parent->pt_deactivate(parent);
-	if (input_dev) {
-		input_unregister_device(input_dev);
-		input_dev = NULL; /* so we don't try to free it below */
-	}
  err_protocol_disconnect:
 	if (psmouse->disconnect)
 		psmouse->disconnect(psmouse);
@@ -1791,7 +1776,8 @@ MODULE_DEVICE_TABLE(serio, psmouse_serio_ids);
 
 static struct serio_driver psmouse_drv = {
 	.driver		= {
-		.name	= "psmouse",
+		.name		= "psmouse",
+		.dev_groups	= psmouse_dev_groups,
 	},
 	.description	= DRIVER_DESC,
 	.id_table	= psmouse_serio_ids,
-- 
2.37.2.789.g6183377224-goog

