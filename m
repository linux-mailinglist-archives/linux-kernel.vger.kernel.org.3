Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A404B9319
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 22:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiBPVXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 16:23:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiBPVXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 16:23:50 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3D613C9E1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 13:23:37 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s16so3181989pgs.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 13:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bhyx85Ca7umL5T1Nrqz7zYLAww0aRrYBOsgYjkr5azs=;
        b=ZW83r9mM7J8/oeItG+y2jfxuOY268F8XJh+BZ/RgY1WtiSP4Ij78sxH/K66N+JjFx5
         EiDVRl41mAerXMb+6xRLJCgkxQkIGXwl6uTcqz3fqdwF0wngzAbW5kSWi9ZvBmSf+f9k
         w/dohA9ZNU/iod9vrv1nVhDWGLT0OCK9Gnc6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bhyx85Ca7umL5T1Nrqz7zYLAww0aRrYBOsgYjkr5azs=;
        b=3ySe6x4lHaIs/AK/q0gMnVIHSTW6jYBb3xuQgLeCtqnSCXNpkESlYPiXQ4z813V70u
         DvFUh9m3WIrkdSrXyqsADIMDK1d+GpKZS4GymFbyFv7vuMU44aMjhAEGbGiW/BWOUSND
         w4KJ0MA/75M+cZtOZfaPvMY44gFcKw6ahrEjG5qChaHapXoUlVsCNE+573LH9BI9LEi0
         BZjSHmjnMuC9SH9HjBRdzAj1m0xXJDYxaiHFIZHntkrcEkRSErlp4cT+LpGZtSkXPz65
         c5AMNw04DR9KfrKzfu5M64KAd6ZsmXOG/T9UHIj5ggN5M5rxr6P1We2E0OBMg9lAemDq
         WuoQ==
X-Gm-Message-State: AOAM533DAedplVYdwdnxi8mOD1yVgrPVi+61H04XBdnNtHdaxiVBhqGn
        ZfiUDLaF9oY44tNsW6Vq0hrpww==
X-Google-Smtp-Source: ABdhPJyErMSSPQ88stDwh/VDox08HE1ZOSRQ6VLWUYZgYHX+FcRZ/cGbahCxHj7lhUyYpKMGGM/34w==
X-Received: by 2002:a05:6a00:a8f:b0:4e1:2619:11a2 with SMTP id b15-20020a056a000a8f00b004e1261911a2mr852154pfl.53.1645046616730;
        Wed, 16 Feb 2022 13:23:36 -0800 (PST)
Received: from f76f9da41d2d.heitbaum.com ([203.221.136.13])
        by smtp.googlemail.com with ESMTPSA id s9sm9091624pjk.1.2022.02.16.13.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 13:23:35 -0800 (PST)
From:   Rudi Heitbaum <rudi@heitbaum.com>
Cc:     Rudi Heitbaum <rudi@heitbaum.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/imx/dcss: i.MX8MQ DCSS select DRM_GEM_CMA_HELPER
Date:   Wed, 16 Feb 2022 21:22:28 +0000
Message-Id: <20220216212228.1217831-1-rudi@heitbaum.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without DRM_GEM_CMA_HELPER i.MX8MQ DCSS won't build. This needs to be
there.

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 drivers/gpu/drm/imx/dcss/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imx/dcss/Kconfig b/drivers/gpu/drm/imx/dcss/Kconfig
index 7374f1952762..5c2b2277afbf 100644
--- a/drivers/gpu/drm/imx/dcss/Kconfig
+++ b/drivers/gpu/drm/imx/dcss/Kconfig
@@ -2,6 +2,7 @@ config DRM_IMX_DCSS
 	tristate "i.MX8MQ DCSS"
 	select IMX_IRQSTEER
 	select DRM_KMS_HELPER
+	select DRM_GEM_CMA_HELPER
 	select VIDEOMODE_HELPERS
 	depends on DRM && ARCH_MXC && ARM64
 	help
-- 
2.25.1

