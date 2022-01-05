Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DEC485A17
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244152AbiAEUh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244091AbiAEUhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:37:02 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15BEC061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 12:37:01 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id s144so384094vkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 12:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KryD1Tl4pz4bryw9HstBOCtF+w+P5fB9bwLkC/bWiN4=;
        b=EzFZZCOcqu47YWlPxyWloqUhnXhBHkzNud9oApmsxTR5gEwY+MdHJodVtinVV/tFKR
         B0K3yGExKPNVNmhnB+3MVzd4MTfS/JYT95XVBnxv0/By6zd4EZrxI88txVrS1MOUfzgZ
         40MkCvMZDNZRBzXDqqBnP67PegVsz/eo06SWfsRBXCIf/5nObawnvUmAG732L8SMLBQf
         H34Cbkvqw2or1LKXgqPy79TLdPZyGQb7bXjkv/4jV+Tg+FYNzAdt8t5hjQAJvayFQwQB
         f2+Mz077GxH3ZEhovFoqjSobiW2BTRj/HrFiFIJ96BAaOMtjzSjtNV8g94PN1aDv139w
         dYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KryD1Tl4pz4bryw9HstBOCtF+w+P5fB9bwLkC/bWiN4=;
        b=ahTGxL7m8l0ZDxx4yHx+PdK2+UWBPlppdM7l97rrsnrphZkHAPT5N2xLt39OJVwjZm
         6wuZqxagv5HWQ/7jnjHZqNODfIvgL6iJ+GxguMqQjD836rqWMOG4l+59MrAQ9BKghXZ5
         Jg+i9gvbGO3hu2pmYsMo0T+8reKaggulerhePuYSVy4LbbVsweMoNatw+BM+4VcBano5
         WRkCvQfHsWZBQg2JeYzLwuTfdhecihDJAPskqSE9CbtrzQ+qLJu2WRYnfuOLqnbEY8zw
         3IqQJXw2I6uCcbibuYi55fmIkImG0HuCuxJfEqWNMEJT27QjlixI4EOk1Xjc+7DXZ/gh
         OM1w==
X-Gm-Message-State: AOAM530RkpcO4eOv/eJutD2TkoOA0LWDHIkCzM0+S+SADdQ71y6cakMC
        mf6AapEPF4+zDPKUTv+mogI=
X-Google-Smtp-Source: ABdhPJzh6vlJ1UUpbhGlxH4d5ijjrmyFqAgWJh8jBQzLMTaS+R7qaF/7mZV+RahkDhpqG+nJ4I8eXw==
X-Received: by 2002:a05:6122:d07:: with SMTP id az7mr19249968vkb.9.1641415020584;
        Wed, 05 Jan 2022 12:37:00 -0800 (PST)
Received: from localhost.localdomain ([181.22.170.52])
        by smtp.gmail.com with ESMTPSA id t130sm7860vkc.32.2022.01.05.12.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:37:00 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, len.baker@gmx.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 5/6] staging: vc04_services: rename macros BM2835_MMAL_VERSION and BM2835_MMAL_MODULE_NAME
Date:   Wed,  5 Jan 2022 17:35:47 -0300
Message-Id: <d450b9e22e5ab335a61591dbf0d2104031c9fc46.1641414449.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641414449.git.gascoar@gmail.com>
References: <cover.1641414449.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the kernel, all names related to the chip BCM2835 are always named
bcm2835_*. To avoid confusion, and to make things more consistent,
rename the macros BM2835_MMAL_VERSION and BM2835_MMAL_MODULE_NAME
accordingly.

While at it, some realignments were made to improve readability.

Suggested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index aaf529f2186c..c729b1b7de71 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -33,8 +33,8 @@
 #include "mmal-parameters.h"
 #include "bcm2835-camera.h"
 
-#define BM2835_MMAL_VERSION "0.0.2"
-#define BM2835_MMAL_MODULE_NAME "bcm2835-v4l2"
+#define BCM2835_MMAL_VERSION "0.0.2"
+#define BCM2835_MMAL_MODULE_NAME "bcm2835-v4l2"
 #define MIN_WIDTH 32
 #define MIN_HEIGHT 32
 #define MIN_BUFFER_SIZE (80 * 1024)
@@ -1894,8 +1894,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 		dev->capture.fmt = &formats[3]; /* JPEG */
 
 		/* v4l device registration */
-		dev->camera_num = v4l2_device_set_name(&dev->v4l2_dev,
-						       BM2835_MMAL_MODULE_NAME,
+		dev->camera_num = v4l2_device_set_name(&dev->v4l2_dev, BCM2835_MMAL_MODULE_NAME,
 						       &camera_instance);
 		ret = v4l2_device_register(NULL, &dev->v4l2_dev);
 		if (ret) {
@@ -1954,9 +1953,8 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 			goto unreg_dev;
 		}
 
-		v4l2_info(&dev->v4l2_dev,
-			  "Broadcom 2835 MMAL video capture ver %s loaded.\n",
-			  BM2835_MMAL_VERSION);
+		v4l2_info(&dev->v4l2_dev, "Broadcom 2835 MMAL video capture ver %s loaded.\n",
+			  BCM2835_MMAL_VERSION);
 
 		gdev[camera] = dev;
 	}
@@ -2008,5 +2006,5 @@ module_platform_driver(bcm2835_camera_driver)
 MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
 MODULE_AUTHOR("Vincent Sanders");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(BM2835_MMAL_VERSION);
+MODULE_VERSION(BCM2835_MMAL_VERSION);
 MODULE_ALIAS("platform:bcm2835-camera");
-- 
2.34.1

