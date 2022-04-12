Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31114FCC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbiDLCFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiDLCFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:05:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3128C31507;
        Mon, 11 Apr 2022 19:03:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f3so16188349pfe.2;
        Mon, 11 Apr 2022 19:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSPq/f1fzEIxN+j0n/fpdsesVfU3t6cZSqHyG+8nEUw=;
        b=RcYztbCbPhBXbYovGgjFPRLBCJsHH6c1flVWzZH88rkHm/9Umin1lcC94mtpi/dFVC
         lr4yHI9oOQaWDTh5B3RIr6rjyTjIC0aKPjai6XDzubcYDW/HZWagEyrh+bx1UcF+yV14
         /VKQYxNnqiEblRGFI0TozfNnoUVE5oYX1AFsJjOfnbEZCil1NZnG/IUqZVSXbV5N/luq
         EzSk65bCPW0iQsIcTTWDgYGLx4nLsRrrdS/yTA5pXgmYTwP5LC52j+UvFaFImT7KFzEK
         TCxpXMM1gu7J/XtWEkw60AhuD/tb+GibGf1V91voqg6M5zxXF3DhmZFFOPbaXFIBJ6IX
         P1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSPq/f1fzEIxN+j0n/fpdsesVfU3t6cZSqHyG+8nEUw=;
        b=yFHQ8vJ7J77WMeaFiSyREtKVh7a/Bc86NbGMq02AIFFaN5L5IqHnRpq0zwk5FtIuts
         0Ucmr3bRc78XAApPMxHsJfD0HokpGr2SPUQO/Uy060B9hcymJDlsrYQwWb0gtYHFen0b
         DKRSPQUxHNThAeds/pUa/7sK2oh9H8citV2MBs0cgl6jmqOjqK4o/dsZSajljb9BEA1j
         +wWRZOdo3siT9PGpUOMKrtkAfDKI0UX9AgCTt5XugOv+eNrPzlKvFn2uoUEdU2VlI16d
         pYFg9g0yb2troqnYSYs20z+a0RvsKrwH9OrKyV9UHcEZTl2znjUnb8IzaMwDRZaM9MyG
         tqHw==
X-Gm-Message-State: AOAM530/ytmguP7F+b49jR5m8WLh04RhPLxzl25jOdMIVkCxC9KjNRHe
        KcF2ZbSPM8aW+qvE3qj4Q2o=
X-Google-Smtp-Source: ABdhPJxcGtGNDGExUYjmMBb9Ulvg9NSvIJc0BHvmswwX+/ZwbzhpxdEKSghq+Zv3Np6rG2vp10zy5A==
X-Received: by 2002:a05:6a00:891:b0:4fe:1262:9b4e with SMTP id q17-20020a056a00089100b004fe12629b4emr2204928pfj.21.1649728994725;
        Mon, 11 Apr 2022 19:03:14 -0700 (PDT)
Received: from slim.das-security.cn ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm749289pjl.39.2022.04.11.19.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 19:03:14 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, khoroshilov@ispras.ru,
        skhan@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v3] usb: usbip: fix a refcount leak in stub_probe()
Date:   Tue, 12 Apr 2022 10:02:57 +0800
Message-Id: <20220412020257.9767-1-hbh25y@gmail.com>
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

usb_get_dev() is called in stub_device_alloc(). When stub_probe() fails
after that, usb_put_dev() needs to be called to release the reference.

Fix this by moving usb_put_dev() to sdev_free error path handling.

Find this by code review.

Fixes: 3ff67445750a ("usbip: fix error handling in stub_probe()")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---

v2: add more description of this patch.

v3: add how to find the problem.

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

