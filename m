Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43D25AD629
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbiIEPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238711AbiIEPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF1BD70
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662391161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69RvVGMWC6PWcztw+ehBzvKOoAq86yIaOh4KmWH1rn8=;
        b=GOpP/n8449VXMNusMMyuCf3IdA+cbU/GNaYDQMHzp1kGHrgQVFmJlNGTQra39RiHkPPDOo
        VioAPIHc5NQ88wAWVRn9lDyPAS76Gtwz2ooa9xWMAdwqd03Uygjx67qtcSw6r3JpP0Oo0B
        OnEhS1kj4jBEtSDhHuXvwcOisW+Pk70=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-0-MVMkfwPB2voV01w2ORTQ-1; Mon, 05 Sep 2022 11:19:20 -0400
X-MC-Unique: 0-MVMkfwPB2voV01w2ORTQ-1
Received: by mail-ej1-f69.google.com with SMTP id hr32-20020a1709073fa000b00730a39f36ddso2429280ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=69RvVGMWC6PWcztw+ehBzvKOoAq86yIaOh4KmWH1rn8=;
        b=qZJIq92u98t3iOxjLwHC3UzcabBtck8J5SS1Z4a674dknL4UN+yOzZrdONveclDFfz
         TBhpR85NJMU1/0fpeJnHsWZiBZdD7zu5PkzZym26qNvZ+nn19rc+6mTsoYENGbg7VdKN
         TiTb5e/QSaNfIZkJfkq0PZlwya91Q29DncualMqHZ/XqmjA58sKiLZqCbzUPQmEfWoI4
         vKBJt47biuUpgH3HG3vuy1PmJWdtjRCaQFWp6q+QdZ2pJ8MMimHlaZYgm5gpvMAPVqPf
         pl8wdHLGdNbMUVjaXYYbuWB24p4oUmGNh68xCsNTXTSkxP05kxFyu5jXLV0Ht8yTQHJA
         6LGQ==
X-Gm-Message-State: ACgBeo2uaG7+gtQi1/sk8jY5/navVMix3AS5oCuC9KFjFzqJOcv86LmN
        8YWzbSkLE9mx5FLlY0HOYYuIibesYGh9r6ZsZld0oKwf/EzPT3ke0VfQFkDjX57gMajBDNKZoEZ
        DTfz/R99pjKcl2xXjWXRe4q2c
X-Received: by 2002:a17:907:7628:b0:73d:e0eb:2e51 with SMTP id jy8-20020a170907762800b0073de0eb2e51mr33667192ejc.237.1662391158773;
        Mon, 05 Sep 2022 08:19:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6kcCtmJ0UuqvCPq50MTZD4S71/b8ch7tlxDuf+WGjPZhKl45DuBotJUWEhskX/YbPZg45ZIg==
X-Received: by 2002:a17:907:7628:b0:73d:e0eb:2e51 with SMTP id jy8-20020a170907762800b0073de0eb2e51mr33667181ejc.237.1662391158606;
        Mon, 05 Sep 2022 08:19:18 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id n12-20020aa7d04c000000b0044e702cd712sm2741485edo.41.2022.09.05.08.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:19:18 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND drm-misc-next 1/8] drm/arm/malidp: use drmm_* to allocate driver structures
Date:   Mon,  5 Sep 2022 17:19:03 +0200
Message-Id: <20220905151910.98279-2-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905151910.98279-1-dakr@redhat.com>
References: <20220905151910.98279-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
 drivers/gpu/drm/arm/malidp_drv.c | 20 +++++++-------------
 drivers/gpu/drm/arm/malidp_drv.h |  1 +
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 1d0b0c54ccc7..41c80e905991 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -23,6 +23,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_module.h>
 #include <drm/drm_of.h>
@@ -716,11 +717,13 @@ static int malidp_bind(struct device *dev)
 	int ret = 0, i;
 	u32 version, out_depth = 0;
 
-	malidp = devm_kzalloc(dev, sizeof(*malidp), GFP_KERNEL);
-	if (!malidp)
-		return -ENOMEM;
+	malidp = devm_drm_dev_alloc(dev, &malidp_driver, typeof(*malidp), base);
+	if (IS_ERR(malidp))
+		return PTR_ERR(malidp);
+
+	drm = &malidp->base;
 
-	hwdev = devm_kzalloc(dev, sizeof(*hwdev), GFP_KERNEL);
+	hwdev = drmm_kzalloc(drm, sizeof(*hwdev), GFP_KERNEL);
 	if (!hwdev)
 		return -ENOMEM;
 
@@ -753,12 +756,6 @@ static int malidp_bind(struct device *dev)
 	if (ret && ret != -ENODEV)
 		return ret;
 
-	drm = drm_dev_alloc(&malidp_driver, dev);
-	if (IS_ERR(drm)) {
-		ret = PTR_ERR(drm);
-		goto alloc_fail;
-	}
-
 	drm->dev_private = malidp;
 	dev_set_drvdata(dev, drm);
 
@@ -887,8 +884,6 @@ static int malidp_bind(struct device *dev)
 		malidp_runtime_pm_suspend(dev);
 	drm->dev_private = NULL;
 	dev_set_drvdata(dev, NULL);
-	drm_dev_put(drm);
-alloc_fail:
 	of_reserved_mem_device_release(dev);
 
 	return ret;
@@ -917,7 +912,6 @@ static void malidp_unbind(struct device *dev)
 		malidp_runtime_pm_suspend(dev);
 	drm->dev_private = NULL;
 	dev_set_drvdata(dev, NULL);
-	drm_dev_put(drm);
 	of_reserved_mem_device_release(dev);
 }
 
diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/malidp_drv.h
index cdfddfabf2d1..00be369b28f1 100644
--- a/drivers/gpu/drm/arm/malidp_drv.h
+++ b/drivers/gpu/drm/arm/malidp_drv.h
@@ -29,6 +29,7 @@ struct malidp_error_stats {
 };
 
 struct malidp_drm {
+	struct drm_device base;
 	struct malidp_hw_device *dev;
 	struct drm_crtc crtc;
 	struct drm_writeback_connector mw_connector;
-- 
2.37.2

