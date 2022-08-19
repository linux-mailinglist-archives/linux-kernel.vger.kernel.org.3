Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83EA59A787
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352235AbiHSVUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352423AbiHSVUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C9104454
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660944022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69RvVGMWC6PWcztw+ehBzvKOoAq86yIaOh4KmWH1rn8=;
        b=TMuOF4XlXWqPB4mKpztfrLnlsMoGOoRC7cdxanDLErbyBLOYRyNc28HdSyyWMCI1JvCX3f
        +Y70wZLgUfvi/iouh4wEWaWWebt++PXTQ4Dv6WVRrpluGCRBUyAIMG+rl+zY5c19fT9e00
        fRtD5C7DXTQmt8G2nc5YQaq6udV9WGc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-gusxv841PEO29FuaEP8B-Q-1; Fri, 19 Aug 2022 17:20:20 -0400
X-MC-Unique: gusxv841PEO29FuaEP8B-Q-1
Received: by mail-ej1-f69.google.com with SMTP id hr32-20020a1709073fa000b00730a39f36ddso1897939ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=69RvVGMWC6PWcztw+ehBzvKOoAq86yIaOh4KmWH1rn8=;
        b=UbxcYHxIhcUi4FhZxJSc0DalAjV2ETcL5TJzMjtBucD19jW65Q/RoBYGZoTg/YWEEp
         B2ERKyeEohZp0Arv1SbtwB5jrgw2C/SDkzoK3uAIb79qJ7N+LyS7bgRsbquHsstS2ilu
         7D4ScvcPwi1LBv7FPMgNOoYokIt0p6B7BqI0n7Li9pidBOUpS8UK+gvns+Ioni++9FX0
         0JdKdVv33B0Yhj+9ul/XwIBfgBCgGpLoufbFCHBgcRIiUMlzlY3n0uQnYFKcIFqjdhFo
         Cjn7HJ5qut4ShxYISdJBqUACECVGTt5Jp1DASB+yAMcNPa/+28/yaCNy2Gj7q6b6BrBO
         Oybw==
X-Gm-Message-State: ACgBeo0+YTWJnqXPCho5/7BgfPXzF/bdUB+jzWnrYbQNj+loBm+PGyWi
        WXoKLQuKgVjuVo1rLahrdyNEo0ahtZJKjf423VIJOC4t7luetSgtIqAnR0h+3zuIC/RovnVjSVe
        RzDcMV8I5HIrWTXlw2/4MDZRP
X-Received: by 2002:a05:6402:1d4e:b0:43d:9822:b4d1 with SMTP id dz14-20020a0564021d4e00b0043d9822b4d1mr7554030edb.212.1660944019757;
        Fri, 19 Aug 2022 14:20:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5dFXgAXxrRicMIg3tcN2kRGkCFPbbgLp6c8l7TyVrDiXaHWuT6VnRsLgQQrd2FZHWq8dN9SQ==
X-Received: by 2002:a05:6402:1d4e:b0:43d:9822:b4d1 with SMTP id dz14-20020a0564021d4e00b0043d9822b4d1mr7554018edb.212.1660944019625;
        Fri, 19 Aug 2022 14:20:19 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm2777029ejd.101.2022.08.19.14.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:20:19 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 1/8] drm/arm/malidp: use drmm_* to allocate driver structures
Date:   Fri, 19 Aug 2022 23:20:08 +0200
Message-Id: <20220819212015.556220-2-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819212015.556220-1-dakr@redhat.com>
References: <20220819212015.556220-1-dakr@redhat.com>
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

