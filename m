Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500594F5B19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378675AbiDFJhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451058AbiDFJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:34:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A1722521;
        Tue,  5 Apr 2022 23:17:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso4878622pju.1;
        Tue, 05 Apr 2022 23:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nVbjX3Usy314kCEmgJkih9YlvsbX+haXG81Sqj35s8g=;
        b=ZvKow59G7wgedgEZP1PPqH1eXcP9OiV8Kd7FM5DnYblp7q42FVsXDbPGUNkImJCupb
         P/ezDSEztfmEuAJEdN1i0airGh3Ffws8BQDG1ZxhQUEYJtQ5HPmWl/4hqYDSiss+hZbs
         RIpHnsisnZk+CnvC71UbICJpHoHvCuNUQaehT+zvC7PnrNUXWJdq7aAS2YYJnr3V1lLb
         xWoUdlFV0nUgnLdNlyxT4yZfgFZPKfnk5xazNAiIDj7wcuiKNLXc8OzruKZu11c79v3S
         RUevlVZJr1MhqMlxJ7uXqqgIaw2Df/JKCqoB3c3o5wEfll1WbG91XAEGLEdJQ87STzO7
         /jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nVbjX3Usy314kCEmgJkih9YlvsbX+haXG81Sqj35s8g=;
        b=eBmXU3nzbRS1uFY6gUGlvBX3P0rQibTadcj6oqaLdwpNCUddbxBAcqxAsFcTdYUDWV
         8dCczj+s9e8N15rriZ88RnvCR5nkqp8aP0vJO5qdZJmNXVX7o3A1+UeGuHCi0w1vjxiO
         lKGC43KRU/2XRNGtmt3T5ICw4OalKBipjOukQIMZ7Kdty1G5L3EoJgQz+sVygnQGgRgX
         x3Dfwgrv3RdG4a1rhYNiZZaxREeZ7vBu4lvaUJOchyquvtc6/P98Nd6ecvtrKvTjXX/V
         TiCXLGvmv4CZDsjKYxWJozi0/FNIUjtksx6d8N2Ji2ysZUSgXNSPdtfNiAQWZTaJ+PFD
         bjtw==
X-Gm-Message-State: AOAM530h+67/K1Irp3JGHOkJh2Io/AGcdXvgHRd0gaf0P3CjsFVMLh+K
        iWXnHqf7WFT0tJn2BBqQHoY=
X-Google-Smtp-Source: ABdhPJzhUsmuDt8gnYBz+cRjQzbACyW9NzlTD9u/nSS8aqaAXwzOmfveWvgCAprpGMqd1HMc4ETXJA==
X-Received: by 2002:a17:902:8a95:b0:156:a40a:71e5 with SMTP id p21-20020a1709028a9500b00156a40a71e5mr7170857plo.144.1649225847168;
        Tue, 05 Apr 2022 23:17:27 -0700 (PDT)
Received: from slim.das-security.cn ([103.84.139.53])
        by smtp.gmail.com with ESMTPSA id l13-20020a056a00140d00b004e13da93eaasm17675683pfu.62.2022.04.05.23.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 23:17:26 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, khoroshilov@ispras.ru
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] usb: usbip: fix a refcount leak in stub_probe()
Date:   Wed,  6 Apr 2022 14:17:13 +0800
Message-Id: <20220406061713.18938-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
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

usb_get_dev is called in stub_device_alloc. When stub_probe fails after
that, usb_put_dev needs to be used.

Fix this by moving usb_put_dev to sdev_free.

Fixes: 3ff67445750a ("usbip: fix error handling in stub_probe()")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/usb/usbip/stub_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index d8d3892e5a69..3c6d452e3bf4 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -393,7 +393,6 @@ static int stub_probe(struct usb_device *udev)
 
 err_port:
 	dev_set_drvdata(&udev->dev, NULL);
-	usb_put_dev(udev);
 
 	/* we already have busid_priv, just lock busid_lock */
 	spin_lock(&busid_priv->busid_lock);
@@ -408,6 +407,7 @@ static int stub_probe(struct usb_device *udev)
 	put_busid_priv(busid_priv);
 
 sdev_free:
+	usb_put_dev(udev);
 	stub_device_free(sdev);
 
 	return rc;
-- 
2.25.1

