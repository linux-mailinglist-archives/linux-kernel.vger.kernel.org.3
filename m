Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CEC577668
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiGQNjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGQNjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 09:39:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C370F62FE;
        Sun, 17 Jul 2022 06:39:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a5so13369502wrx.12;
        Sun, 17 Jul 2022 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9z2+HGjKgnMOda8ghxXHSV9Wvsj6zXH8Cq1q3me/Lxo=;
        b=oLXk2Bbmj92/7jc6QUtg5BZeZHCu2P7QX45JCzM/GfAruPkc04jqG/ZJql4LDF9rXw
         f6trarSn7g6jGty3+jRmGOJD0I31BFBjT/iu8skKk5fzqxVjcVDI5l7ud0x1qkIk2qTN
         0KkDD148TBBSQBSTkXVO36bhSKLhYNEfZ1lxx8FWGHdzzhIUrD1Ys2w3Q9sjImy/+RNK
         qMfsh2Jfe2vinlTyR5pR0EfmEfiKYbOINQGl39vkesMPe+T5vUilnpOw3434kaX7vrz9
         CBweRVvqL4rb0xpNXorcYQ0gkjZQg4f1NB0OzxBP0yUju2jyUWhgOdB5pQGX+R9qlZW8
         Np4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9z2+HGjKgnMOda8ghxXHSV9Wvsj6zXH8Cq1q3me/Lxo=;
        b=pCja9LpSk7xSyJFR8wTOZF1D8PDGFq7WvwEsz0jfs/+jekr6Vho23Tuvg2kkQkXdjL
         CdoygKOtUVxGbOH5j8swDki3UFhSdik2o3rvkVCK1rJq63meJvWt+RQtPZyYAM+uw/8D
         3hkEljHHBF6hpjdgkXyq8bHTcBhQOlJiwUhjkVa40beKaW1lNfvpN40KyTzVI8/WF2ow
         OaM+Dtb9eu6taNPZRlZM3lxIz6x9PT3s7l/Fvp/tQsHgtThQS3hkyQFZWY2ohNv+C4CI
         V76oJ1PIBJTe8Zc/EZRABl3ve/zl6sM69gHKdtl893n+512rQvr7N9XE6u5YNfkx/j1J
         jD+w==
X-Gm-Message-State: AJIora+g6dt9exUOeVpFhDLWrzGqtpi+EFXQCtPM8llezc6t8RPQMrAR
        TzHPBpQBDW1S0kmMVtwQZ3k=
X-Google-Smtp-Source: AGRyM1u1TaYEO/NnE1iPmYC4DnDynws17vSGPrLwkBDPot3L36VJHodvIYXYOWlTaHlQI2CprO776g==
X-Received: by 2002:a5d:414a:0:b0:21d:6be5:1765 with SMTP id c10-20020a5d414a000000b0021d6be51765mr19982420wrq.419.1658065141273;
        Sun, 17 Jul 2022 06:39:01 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id z26-20020a1c4c1a000000b003a31b00c216sm868881wmf.0.2022.07.17.06.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 06:39:00 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     laurent.pinchart@ideasonboard.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, ribalda@chromium.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3] media: uvcvideo: Fix memory leak in uvc_gpio_parse
Date:   Sun, 17 Jul 2022 15:38:47 +0200
Message-Id: <20220717133847.245703-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the unit buffer was allocated before checking the IRQ for
privacy GPIO.
In case of error, the unit buffer was leaked.

Allocate the unit buffer after the IRQ to avoid it.

Addresses-Coverity-ID: 1474639 ("Resource leak")
Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2: Add Fixes and Reviewed-by Ricardo Ribalda tags
v3: Add Reviewed-by Laurent Pinchart
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

