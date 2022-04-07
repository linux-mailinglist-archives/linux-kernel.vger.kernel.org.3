Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757594F7207
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbiDGCYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiDGCYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:24:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20362133D92;
        Wed,  6 Apr 2022 19:22:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n18so3634930plg.5;
        Wed, 06 Apr 2022 19:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PT2+6h3Z7LL18dILG70CDaDDS1P956FJu0P0TdT2+Ds=;
        b=GclcoK1d9Bj08EvCcuxxwoNGyIhWAzM7p9KQhaYzX55q8V9v7RfMVaTa3qrHX43VUS
         D0lSL8YyRUYbhiKNBZLsAzoev4EIb5ub2ueAtu+CHleS+GFl85lMdKQJXi0JmSE9PwgJ
         Cw8LZMBcr+CaGG7I4xY0DRNM+5gA8LX5daj1nKyeIrTyg8oQOFZPer2ejv9t740XSZwB
         5kvgZc82foSi+/19giPQF1hw9NSqiht9skkxmwj+5HOpX+mqymb4+/8H1GyPRsP+02+U
         WceQ2UcU8KuSmznUIEfDA2FdJFgNvftxARQQatNjiTYdRIc4LSa0yEMU+Vy+8qFkxQJD
         vKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PT2+6h3Z7LL18dILG70CDaDDS1P956FJu0P0TdT2+Ds=;
        b=OdvgTruUqOD41tYVI/7fpSgmqEUA+VehQM+2M1V8UgnYt8oRfPnJ1M6IMzp1uxyjEl
         3ApE29dDnphqF6K/gWIsJaAqs5FRIV6Sl1EWL78XAR4DXYJhsIY+tCQS9NjRAycwJjfS
         r5edCZT+c8c29pZ3TQZN3D6JGzdJxms98UXCgsJCSwfye64N1IFycFjvrsj0RHeLBxrh
         2rM+769gmpnWsEMfF89SP6ExbdvU0Xt0LHRm//T2d67CHXiXiw9gh5ABW9tDAGpv2rYq
         9Dx3UC4ZLq+c79lC3JDK6dDYO7vXPtaGaIT7nDgx8xQsJllVtnj0izIyxnfnxf20FN4q
         1jVg==
X-Gm-Message-State: AOAM532Da80rkkJDXsCA0T+zZbsDHoIG7V+6+IbhmftbXGlnc1d5GlgB
        OtrzRn5MaVFGYEXpF7if9Tw=
X-Google-Smtp-Source: ABdhPJwMTQExK8XAvWiC+fyo/Evg+fV9vj0Z2tl+ht3PZb5NaB9DgdPjo1wYrlVnMo2rZNb1Wk5yWQ==
X-Received: by 2002:a17:90a:6402:b0:1c9:9377:dd0e with SMTP id g2-20020a17090a640200b001c99377dd0emr12949103pjj.211.1649298155639;
        Wed, 06 Apr 2022 19:22:35 -0700 (PDT)
Received: from slim.das-security.cn ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id z8-20020a6553c8000000b0039cc5c3e284sm386409pgr.48.2022.04.06.19.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 19:22:35 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, khoroshilov@ispras.ru,
        skhan@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2] usb: usbip: fix a refcount leak in stub_probe()
Date:   Thu,  7 Apr 2022 10:22:04 +0800
Message-Id: <20220407022204.10730-1-hbh25y@gmail.com>
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

Fixes: 3ff67445750a ("usbip: fix error handling in stub_probe()")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---

v2: add more description of this patch.

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

