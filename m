Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FB3487F93
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiAGXr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiAGXr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:47:57 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658EBC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:47:57 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id g5so818510vkg.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QmPviAS4MELSzWYPYeY4b8c+8wCn1tiv/ZwUCvvrRzU=;
        b=I/agVV8YWArMReVGCdEw86cgqjVxRTF7YfSCfiQRlfhCXxgp15LaAZrV60KjGe6Kcv
         Ux3eBlzvenynvpwGfl9mpA2novk5WDByg2LsaWtWTgFwxVALOPZBuuTCi6IItWHte4Fo
         hld1hWgFL1z2MT4nhN1OstHNgO4bQgLp+15YrPYeghJfMKmsHFUbLrMqH9Qf5vLEKIS7
         3Jw4DV4nP3nK2wACeVhcjMwXi1qvYww9MNBsJrCtxcAUDGrjC6IEF7IydltVhhuM29Wx
         oG6g5FxFVGYsPStHdsIewuqmHwr9o7B2CUa+tp5xvfMoGhfZPJEpZlO/nK91p1yIwIOX
         uQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmPviAS4MELSzWYPYeY4b8c+8wCn1tiv/ZwUCvvrRzU=;
        b=j4ty4e9BK4eIesNk2nGyerpsSBZFj74kPwUQwNtWw71SPsHJv6BRYwc9D3R2HC/mD1
         62t95RViMX/ia4EV5e3Uci/ODpQDzl8OEA8rcBKz8x9ZutGfx1gNMtrPnWRswQxex7N5
         wzcmXq6xdCnJazOmdU2K6IbsON3CHyuPQ3zlgQXgT+RUTlAj52qjHO4ZV652C81GiXBd
         rCGmFgOwF/R0shkUQf3AnwlJ1i1knBMZyGQdlOTLEaTNrHq8U4rV4DJVhx32ggB6WsMn
         ZmntRwfm8PEf/W1cfSsm4ta4aj5BgsQNxJpyc00zcMAmCT781f/0QThlR8qsmmHUeyUQ
         m92g==
X-Gm-Message-State: AOAM532nuquTKiZQ0mCEBvIqMHHysa/wqvpDdbIUhnpXyP8B0pVyauTq
        Q6zsy8JWbZ23Ja0kO6cT8nc=
X-Google-Smtp-Source: ABdhPJw8ygMqpuKGeVAvH6ofTselM3qHtHu42uVWXxIMgmqFtfJyXEIFp8OusTOet68bna4ZXKudmA==
X-Received: by 2002:a1f:1609:: with SMTP id 9mr23404329vkw.18.1641599276610;
        Fri, 07 Jan 2022 15:47:56 -0800 (PST)
Received: from localhost.localdomain ([181.23.94.152])
        by smtp.gmail.com with ESMTPSA id az22sm92911vkb.15.2022.01.07.15.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:47:56 -0800 (PST)
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
Subject: [PATCH 1/2] staging: vc04_services: remove unneeded MODULE_VERSION() usage
Date:   Fri,  7 Jan 2022 20:46:20 -0300
Message-Id: <20220107234620.49900-2-gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107234620.49900-1-gascoar@gmail.com>
References: <20220107234620.49900-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MODULE_VERSION() is useless for in-tree drivers given that only the kernel
version matters. Hence, remove it.

While at it, one realignment was made to improve readability.

Suggested by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../staging/vc04_services/bcm2835-camera/bcm2835-camera.c   | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 253d755e547f..35ac0fda6e14 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -33,7 +33,6 @@
 #include "mmal-parameters.h"
 #include "bcm2835-camera.h"
 
-#define BM2835_MMAL_VERSION "0.0.2"
 #define BM2835_MMAL_MODULE_NAME "bcm2835-v4l2"
 #define MIN_WIDTH 32
 #define MIN_HEIGHT 32
@@ -1954,9 +1953,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 			goto unreg_dev;
 		}
 
-		v4l2_info(&dev->v4l2_dev,
-			  "Broadcom 2835 MMAL video capture ver %s loaded.\n",
-			  BM2835_MMAL_VERSION);
+		v4l2_info(&dev->v4l2_dev, "Broadcom 2835 MMAL video capture loaded.\n");
 
 		gdev[camera] = dev;
 	}
@@ -2008,5 +2005,4 @@ module_platform_driver(bcm2835_camera_driver)
 MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
 MODULE_AUTHOR("Vincent Sanders");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(BM2835_MMAL_VERSION);
 MODULE_ALIAS("platform:bcm2835-camera");
-- 
2.34.1

