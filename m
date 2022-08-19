Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1038059A920
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243587AbiHSXLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbiHSXLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56D7B8A42
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660950665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FE6F/FaZU56VVek/ild/rdOe20eLgXYTWVytxZbV5OU=;
        b=YWNqS+qF22ppNcRD7PZeCE1EQwAnvVpXlcIo1O3Hxjb4UofMfaEWYZcQliN65UUiFrhj4x
        QWrIz6LLDJmeZynvz6tjabIAe7hnXBRWPdgOygS4DW6zq3LTQIo6e2RFxlTDwnOTdkLCM1
        dtn9wCnu7e3hVAvu6LaT5IG7oXGnUQA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-148-I3M3MW3BPhqp92R5sMOPZw-1; Fri, 19 Aug 2022 19:11:04 -0400
X-MC-Unique: I3M3MW3BPhqp92R5sMOPZw-1
Received: by mail-ej1-f69.google.com with SMTP id qw34-20020a1709066a2200b00730ca5a94bfso1952183ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FE6F/FaZU56VVek/ild/rdOe20eLgXYTWVytxZbV5OU=;
        b=uW9NnN7KPB2Wa4xBqYxCBpvZvY7l5KcrydVxfVQKU9aZKFN+Y0xgbQhrrcjP9rhPLN
         cmHxHYBkWCwOZYbHTVUsYg+2p6BmeSDaw/5JQyxlfTuawBOAQVW6Fbqro1Y/v/AyVgAx
         rx42Y6uO1xSuUONqQaXesc6+VQJRo5Kb+Q50G4PlKXpfy/vxEN5WXnSXxxmfiAXcW6bi
         Gul7te2p26lQkekTATZrrcN9oMhNwo2qZ4RqWSXES8TtS1fZABukNu6VNkMFyr7nADE0
         bMuTlg2dj3+S1S3nM7vXq+RJ5P9PmiHRcfOkEbMpxogr7I0yKRJhRywRy0Y7AqTac3k0
         SQrA==
X-Gm-Message-State: ACgBeo3Kq6Qh5I9twv8wsuHqcWEOreQCXMVLyR08fuFiMAQtlOgi9Nhq
        26kKZt+xWv4PqoEa7ZB0/j+uIovuVNIrvXczdcszxrNYW40Invq8K2CjzccRWqgI1T+bPnvO9xH
        +OZQDUWmwzFmh5zgvKZ1FPq/C
X-Received: by 2002:a05:6402:26c9:b0:446:354a:ede4 with SMTP id x9-20020a05640226c900b00446354aede4mr4448973edd.424.1660950663414;
        Fri, 19 Aug 2022 16:11:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6BLVr1Yg+PkMQqjnyOamsS7c3J30OI7E+eQHw0nlsYqnq4YTHzerFj8CavCvwWsievdP/amQ==
X-Received: by 2002:a05:6402:26c9:b0:446:354a:ede4 with SMTP id x9-20020a05640226c900b00446354aede4mr4448960edd.424.1660950663264;
        Fri, 19 Aug 2022 16:11:03 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id ss28-20020a170907c01c00b00730a18a8b68sm2887088ejc.130.2022.08.19.16.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:11:02 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 1/7] drm/arm/hdlcd: use drmm_* to allocate driver structures
Date:   Sat, 20 Aug 2022 01:10:52 +0200
Message-Id: <20220819231058.647658-2-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819231058.647658-1-dakr@redhat.com>
References: <20220819231058.647658-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm managed resources to allocate driver structures and get rid of
the deprecated drm_dev_alloc() call and replace it with
devm_drm_dev_alloc().

This also serves as preparation to get rid of drm_device->dev_private
and to fix use-after-free issues on driver unload.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 12 ++++--------
 drivers/gpu/drm/arm/hdlcd_drv.h |  1 +
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index a032003c340c..463381d11cff 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -247,13 +247,11 @@ static int hdlcd_drm_bind(struct device *dev)
 	struct hdlcd_drm_private *hdlcd;
 	int ret;
 
-	hdlcd = devm_kzalloc(dev, sizeof(*hdlcd), GFP_KERNEL);
-	if (!hdlcd)
-		return -ENOMEM;
+	hdlcd = devm_drm_dev_alloc(dev, &hdlcd_driver, typeof(*hdlcd), base);
+	if (IS_ERR(hdlcd))
+		return PTR_ERR(hdlcd);
 
-	drm = drm_dev_alloc(&hdlcd_driver, dev);
-	if (IS_ERR(drm))
-		return PTR_ERR(drm);
+	drm = &hdlcd->base;
 
 	drm->dev_private = hdlcd;
 	dev_set_drvdata(dev, drm);
@@ -319,7 +317,6 @@ static int hdlcd_drm_bind(struct device *dev)
 err_free:
 	drm_mode_config_cleanup(drm);
 	dev_set_drvdata(dev, NULL);
-	drm_dev_put(drm);
 
 	return ret;
 }
@@ -344,7 +341,6 @@ static void hdlcd_drm_unbind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 	drm->dev_private = NULL;
 	dev_set_drvdata(dev, NULL);
-	drm_dev_put(drm);
 }
 
 static const struct component_master_ops hdlcd_master_ops = {
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.h b/drivers/gpu/drm/arm/hdlcd_drv.h
index 909c39c28487..3892b36767ac 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.h
+++ b/drivers/gpu/drm/arm/hdlcd_drv.h
@@ -7,6 +7,7 @@
 #define __HDLCD_DRV_H__
 
 struct hdlcd_drm_private {
+	struct drm_device		base;
 	void __iomem			*mmio;
 	struct clk			*clk;
 	struct drm_crtc			crtc;
-- 
2.37.2

