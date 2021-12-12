Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847824719E5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 12:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhLLLtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 06:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhLLLtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 06:49:51 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC2C061714;
        Sun, 12 Dec 2021 03:49:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso12187308wmr.4;
        Sun, 12 Dec 2021 03:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzxe8Re5dkGc5HAZ8xQodsn0WXrPFcMV1CfaTBnWvsA=;
        b=kKaDIX6yqYhVPE5od0/O0AKwG7NdSxydD1JJuvZPDH5+ZFCHyofEmd6tgu1SSAOhFz
         TdZ+YLVVpKc7wHLVCS1Qkvl0uDpuIWWK5Yd8Wp2Z2HKu6JxXvWRnXkutYBUm8SJvBjDD
         kJf3bwe/iI5oXlvphQgemdZ8WXWDTF2v57ZIz+XRxyeYVRQeGuaXCdA5MsgPn+sF1HAV
         GjtXH4T1aH4AH3ce0nTJNyzmwzKeh5kZSLrynudBOaTYG7o/QOHpZbzZ3pIG/+9agf/O
         nrmipNzrgnfv4MdK3DWpVz8Y86esyCVTmuF6ljexOxq4ctvgLWC0qj+EQUFpjBxSXM0F
         GVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzxe8Re5dkGc5HAZ8xQodsn0WXrPFcMV1CfaTBnWvsA=;
        b=GeCRHwtVdomJKQKEo+jRJp6TE71FMQhmL99Y5PzCzWZsc0rECrP//BM4LSZYRzBi1u
         pkHFSoQq++rFKwHcY7lp6op1xLprIQ5iCTb95hhudsswSn/3VR0xnRgz0belOKsSNZAl
         hAcyoqzhQ5ny9hjUb5vlIp4IBWVGlRmwKUs9mj9Z/CY9YtWOKzwrtarvw+fbbkJUQysc
         NCZzUgfEqNRHmkyCqxl9eaUfH6b/oEOG31NopXumwpRI73jErnW+IdPpusLhagR6fJDt
         HO8r7Wyh448TZQYS2B3d+UOUNuNmM4KIdIUNS0uBoWdbF/wfFSLTr+H8vZmrg7CLNk27
         YOsA==
X-Gm-Message-State: AOAM532upo/Jzdi7C9QUfPPwXW3Rw05nbpjm5BoLWdN1T6lYOJtoN59M
        W+L8SlX8itKrLIplniFJ1Wk=
X-Google-Smtp-Source: ABdhPJx+VEYet6QHWn4eK6qiJvnMorn8TTKQ8tkKyLTTMsqSDkm3Nya0YAohSBzJbeU0lct/ZJfJRA==
X-Received: by 2002:a7b:c256:: with SMTP id b22mr29895368wmj.176.1639309789956;
        Sun, 12 Dec 2021 03:49:49 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g16sm4336837wmq.20.2021.12.12.03.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 03:49:49 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     laurent.pinchart@ideasonboard.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, ribalda@chromium.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] media: uvcvideo: Fix memory leak in uvc_gpio_parse
Date:   Sun, 12 Dec 2021 12:49:30 +0100
Message-Id: <20211212114929.264905-1-jose.exposito89@gmail.com>
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
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
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

