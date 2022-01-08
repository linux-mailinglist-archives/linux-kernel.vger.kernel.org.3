Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358434884C7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbiAHREo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiAHREo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:04:44 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B87C06173F;
        Sat,  8 Jan 2022 09:04:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e9so16141985wra.2;
        Sat, 08 Jan 2022 09:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0S+D/FQRGuVQki4kVkJvs2fOsfa72Dpr2oChnts0Ws=;
        b=ReWSbFnVM+asKsJH7t3pVj9MX+erLTHsb5AizEdt6MprV9Ez3Dk2sloGNYQc4QMEZJ
         uyAWXuIUVxj2T5YPvWceQsp6/jAejpvj+UuaHH3B8dXewNkxpuC3ZC1BY2vB1cDq2rC2
         GEb2t8LDeO+ZvpAcIohyyl0+eu3Db6qN3N6SD3zQD51OJDXAzN/ZAPm5ykwHqjdVTzqa
         ipIeY61+Uqr9g+bUipWws92I8p7lVrxgjPqPODm7lNx3wmO7fYDilw/INXuJ30T7P0om
         D9M2E5av6BUFQhKiVgsJfg+/JFcTyFUEjVNT2fkPoQtrqUnMP0LNNW/QLxfp4mVCbw2t
         HEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0S+D/FQRGuVQki4kVkJvs2fOsfa72Dpr2oChnts0Ws=;
        b=Dxu2ctGrkkmkESTnfXvFtKAfVlXwjhBBClPXD4ZDJV411dCsaFevI5ybr6ZgNnXGYj
         hXLemEFJvi3e7niaFLnPI761T5C0LlEr8LuJLUMismIPtS4wdi72hsW080ePffHrHTrw
         nrNSFCRrnOEyRRE7Gg9jWNckm4w3dxaZ6SIz0eslU0eU972aezAvupaAjiHpE+MaZzxW
         9WBDHdgf65GKsvO8dBaS1qbpBaVSbqf4COFUosjpRdhykI6Ctp0/dqWsJOhZtTS8qypQ
         frHDx3db6MdGgwxEj3I18WGoqU2xVE2UrLFvqEipZ/52+ANQ5lJGazCMP0xzgRE0eHwV
         EHag==
X-Gm-Message-State: AOAM5327vzlC6WKPhLUHDQbrWjgp0pyJogRj29SEqVHEeOFAHTXCOI8V
        metP0QxO3Rx3eVJ/pKodylk5CiJoFkIIWQ==
X-Google-Smtp-Source: ABdhPJy0wEyg+On4sfjTIHisEZxONTaD+blK8YcC2BhPE2gEa/aGuUPNG3VD6DN+a2niO7vwxOmWpA==
X-Received: by 2002:adf:d1e5:: with SMTP id g5mr58250673wrd.94.1641661482190;
        Sat, 08 Jan 2022 09:04:42 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id n15sm2455935wmc.0.2022.01.08.09.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 09:04:41 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     laurent.pinchart@ideasonboard.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, ribalda@chromium.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH RESEND v2] media: uvcvideo: Fix memory leak in uvc_gpio_parse
Date:   Sat,  8 Jan 2022 18:04:39 +0100
Message-Id: <20220108170439.49984-1-jose.exposito89@gmail.com>
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

