Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFD94753A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbhLOH0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhLOH03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:26:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0410DC061574;
        Tue, 14 Dec 2021 23:26:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so15357445wms.3;
        Tue, 14 Dec 2021 23:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0S+D/FQRGuVQki4kVkJvs2fOsfa72Dpr2oChnts0Ws=;
        b=WdvxT3AHJGP0FowpHfoyKjf86KJRfCJAo/ZMy1uiUGYvBdjJz1KMfHcZpwGLL02iDY
         LGQBRYY0VSUkJEoQzSxVYxpVBRtd1e/sBUegdImeVx0q4CJpoU6k6rUcdrq3SUcmQisw
         vw7hP0NS8pijMK5dor9haSYxpq9sbmZ0wlhtL9+Y0BxxX7UOV1wiFdHQyQIuFkBmc8pC
         b1mJ4svz1jKQ8KIsmrxneYddmK5bcBxfJfrt4GF/2TA/e76pwK7wi/kvk8/xHnSJGcVc
         eBc5+0SSDcblNb6RLcuZlVyqil5g0chWhrvys2q35nitr5GWVolEFRIk1qiNtOyz8AXk
         mczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0S+D/FQRGuVQki4kVkJvs2fOsfa72Dpr2oChnts0Ws=;
        b=oX1fXPm+s+VBjyX2aThWs1rEvsSoAn5uck1+FScpTPhJtu5+CbXNuwFVDqBw2y2jl6
         UP4wxYcFBqLO7KKnMJOsALMZpsLawFjRb3LYjHVGDy4FQM7Sl3CTHw1BcWSO3No9AuqS
         /zJk6svrQUeP/E0fdiXUBmJdaDd5gIqvj1RqtYEHTegEEwhaJ02T5ik+02jiVHsDzMpo
         kueqoK3NEN8JfBmMEzgQAc4agLvYJjAu8nhKDVWQz7agtdbUeiytop3vfI0A6RXoO0PB
         ddNyYt28QA0IB2jST7odzVOId1ZXfgpdqzAQwxOOTyHDiIcuJBYZ80rS4ZY+NDWk6RWw
         /brw==
X-Gm-Message-State: AOAM533jaOgv3YB3ul2nUFnVvz4rQ06bxAUtt/h+ZkP+5/hd0aWIZwVH
        lQ5d8vgQyeXPHVjETlCsTj0=
X-Google-Smtp-Source: ABdhPJy/GrSOOMdxeif45fSIo768/oWC9Ngyny3KxPbnBtG8e2Huth5hWJoCBpOteRbxOktqQt0SOA==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr3189608wmf.149.1639553187498;
        Tue, 14 Dec 2021 23:26:27 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id f7sm1283383wri.74.2021.12.14.23.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 23:26:26 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     laurent.pinchart@ideasonboard.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, ribalda@chromium.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2] media: uvcvideo: Fix memory leak in uvc_gpio_parse
Date:   Wed, 15 Dec 2021 08:26:18 +0100
Message-Id: <20211215072618.7646-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the unit buffer was allocated before checking the IRQ for
privacy GPIO.
In case of error, the unit buffer was leaked.

Allocate the unit buffer after the IRQ to avoid it.

Addresses-Coverity-ID: 1474639 ("Resource leak")
Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

---

v2: Add Fixes and Reviewed-by tags
---
 drivers/media/usb/uvc/uvc_driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 7c007426e082..9e83e2002710 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1533,10 +1533,6 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 	if (IS_ERR_OR_NULL(gpio_privacy))
 		return PTR_ERR_OR_ZERO(gpio_privacy);
 
-	unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
-	if (!unit)
-		return -ENOMEM;
-
 	irq = gpiod_to_irq(gpio_privacy);
 	if (irq < 0) {
 		if (irq != EPROBE_DEFER)
@@ -1545,6 +1541,10 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 		return irq;
 	}
 
+	unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
+	if (!unit)
+		return -ENOMEM;
+
 	unit->gpio.gpio_privacy = gpio_privacy;
 	unit->gpio.irq = irq;
 	unit->gpio.bControlSize = 1;
-- 
2.25.1

