Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEED357F1B6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 23:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiGWVJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 17:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiGWVJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 17:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19AA515FFE
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658610541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9KeV3b2L++kC1oJ9l6Py5QcKGf/q+aaG3Cox8NYOjJ4=;
        b=MyTE+YQaqWP8BqJ48FPZN56RdLLIfN64Z4lrePAStuooi8nJsPNGzCc1AqGy6+m6+lWztY
        uHGaytQI4ewNBnXtKfhdD2Lsu+1sx/+ZcqgSFqCTvzndJ7juE4UZsDf2PlgmXWIweZijlx
        8IaLjH3E1vKc2q+7uqdi4NEpc9qtP6w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-CDkA5aDaOauTWUCusmiBZQ-1; Sat, 23 Jul 2022 17:08:59 -0400
X-MC-Unique: CDkA5aDaOauTWUCusmiBZQ-1
Received: by mail-wm1-f69.google.com with SMTP id p2-20020a05600c1d8200b003a3262d9c51so6287765wms.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 14:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KeV3b2L++kC1oJ9l6Py5QcKGf/q+aaG3Cox8NYOjJ4=;
        b=78MIdOksnfU4T/08UEnEiiUrK9CyRY+LOqxtzv2KmO2WGHDrdfH0K2+p9mJmW0tiqs
         R7TEO9Kc5dTp2ILT/KKNd2PJMcIertC8fCnytHnnvGRMSLaUvunCmW5ebmF5CcjT9uwc
         sqlYanQemCcCDU984EXRd7njZmyIkHFQ/1Xv0b/B5EINFjshuAnobsNDCao2HY5ohbP0
         I1p4i8mHkzQl5YerH93qOQcyjo38nQ2W1eTiNPSPvqMxXNBGDaR5dIHhhnvK1omJI1Cg
         M6I/9C00d0H7vIJn23kv/prd5uNL80hGrTmiANfUa1EKxQJb/qwlmmGxZ8GGHzw/9w0m
         YU3Q==
X-Gm-Message-State: AJIora9xcJOBRHJfk7Bzl3Mp1pzLFBxOpn1xHycu2U+kKGpOTPVsL03B
        ua7OT1zyU+8IlZvGsX2+GLhDNNlx47tqN3IKq4+LUQBFecbIbaSmZf6+86QEGZnZzcJVxBqDpRj
        0l+IfEY9HpJGGzIFjblfkX6TwD69jybVOkXh/KT98Z8aLq6MQi+jg1RmZTnUrGMtb2m6X31mrfd
        Q=
X-Received: by 2002:adf:f90f:0:b0:21e:7e3d:6af6 with SMTP id b15-20020adff90f000000b0021e7e3d6af6mr1780666wrr.183.1658610538095;
        Sat, 23 Jul 2022 14:08:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tScx1EViU35wGKRbd11AAdwaQ2ZMMsBGJoIAt1Cxrb2NeGSD2oe3BbzTHgx6jv08s5IYWO2Q==
X-Received: by 2002:adf:f90f:0:b0:21e:7e3d:6af6 with SMTP id b15-20020adff90f000000b0021e7e3d6af6mr1780646wrr.183.1658610537607;
        Sat, 23 Jul 2022 14:08:57 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j14-20020adfd20e000000b0021e40019ae7sm7643643wrh.48.2022.07.23.14.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 14:08:57 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] drm/msm: Make .remove and .shutdown HW shutdown consistent
Date:   Sat, 23 Jul 2022 23:08:25 +0200
Message-Id: <20220723210825.564922-1-javierm@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers' .remove and .shutdown callbacks are executed on different code
paths. The former is called when a device is removed from the bus, while
the latter is called at system shutdown time to quiesce the device.

This means that some overlap exists between the two, because both have to
take care of properly shutting down the hardware. But currently the logic
used in these two callbacks isn't consistent in msm drivers, which could
lead to kernel oops.

For example, on .remove the component is deleted and its .unbind callback
leads to the hardware being shutdown but only if the DRM device has been
marked as registered.

That check doesn't exist in the .shutdown logic and this can lead to the
driver calling drm_atomic_helper_shutdown() for a DRM device that hasn't
been properly initialized.

A situation when this can happen is when a driver for an expected device
fails to probe, since the .bind callback will never be executed.

This bug was attempted to be fixed in commit 623f279c7781 ("drm/msm: fix
shutdown hook in case GPU components failed to bind"), but unfortunately
it still happens in some cases.

Rather than trying to keep fixing in both places, let's unify in a single
helper function that could be used for the two callbacks.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/msm/msm_drv.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 1ed4cd09dbf8..669891bd6f09 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -190,14 +190,8 @@ static int vblank_ctrl_queue_work(struct msm_drm_private *priv,
 	return 0;
 }
 
-static int msm_drm_uninit(struct device *dev)
+static void msm_shutdown_hw(struct drm_device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_drm_private *priv = platform_get_drvdata(pdev);
-	struct drm_device *ddev = priv->dev;
-	struct msm_kms *kms = priv->kms;
-	int i;
-
 	/*
 	 * Shutdown the hw if we're far enough along where things might be on.
 	 * If we run this too early, we'll end up panicking in any variety of
@@ -205,10 +199,21 @@ static int msm_drm_uninit(struct device *dev)
 	 * msm_drm_init, drm_dev->registered is used as an indicator that the
 	 * shutdown will be successful.
 	 */
-	if (ddev->registered) {
+	if (dev->registered)
+		drm_atomic_helper_shutdown(dev);
+}
+
+static int msm_drm_uninit(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct drm_device *ddev = priv->dev;
+	struct msm_kms *kms = priv->kms;
+	int i;
+
+	if (ddev->registered)
 		drm_dev_unregister(ddev);
-		drm_atomic_helper_shutdown(ddev);
-	}
+	msm_shutdown_hw(ddev);
 
 	/* We must cancel and cleanup any pending vblank enable/disable
 	 * work before msm_irq_uninstall() to avoid work re-enabling an
@@ -1242,10 +1247,8 @@ void msm_drv_shutdown(struct platform_device *pdev)
 	struct msm_drm_private *priv = platform_get_drvdata(pdev);
 	struct drm_device *drm = priv ? priv->dev : NULL;
 
-	if (!priv || !priv->kms)
-		return;
-
-	drm_atomic_helper_shutdown(drm);
+	if (drm)
+		msm_shutdown_hw(drm);
 }
 
 static struct platform_driver msm_platform_driver = {
-- 
2.37.1

