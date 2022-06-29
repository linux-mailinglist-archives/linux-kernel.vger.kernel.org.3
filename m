Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2705609F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiF2TGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiF2TGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:06:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F42D201A7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:06:11 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id x8so11582411pgj.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4iLjVUVD01Ec5lhezzfL4b6+r3st8AOk4JH6YYFpua4=;
        b=LjxdwGocB300LRlrR3clI8v8Q6E/VOBSmVpRm49ABnVrx64ZPtRJw6AYgvjQrC+zFP
         fnXrQCrsYOVOEJ/GV5LF/hPis5i67QMn6Qq6P7Qkc8gaMByE2H0BaG8PUJq2fAsw5Cqh
         io1ISaJDdagUxdEYmHYGp26m3cHHacY3Aa2M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4iLjVUVD01Ec5lhezzfL4b6+r3st8AOk4JH6YYFpua4=;
        b=RRyG9zsZlXFDpLSuNbuh2mN+GfqAlfMZIUgJdAr1oIIfgjMrY7nkfRhWSxYqYOGr6S
         CEFee3llHkInxn8rO4JPq4JyY4/Is1iwW6InpTgvd4e/mfsIAbtU5hefy6KhjO++AK/Y
         mC4UFMGj8cAvbiMyLcNMXvnfRtcs6Phvx8MjvbqLoiM6caaNEeFfa4JL8KcoqTUWwSZb
         RdgOYF4HLfTfmKOG0aun6cFbw/RzNrV/RLocriGKZI9aLBfaB6Bb5CYkV9SRX2yL7rNz
         zzlztZjOaBPK6TNtpPcp8RPMjrJFGBziTH7/SXy2PkZ6plHCjMq0/Iv645HjY9LFLUKv
         3lyA==
X-Gm-Message-State: AJIora989wXBiTlAmy7b/hlnYJ14uFBL3DJ1L7hzTyKh5S2vSTqLZtUA
        S3Y+iHw8sQqHW23fF/bP06DrnA==
X-Google-Smtp-Source: AGRyM1tdAZEaXsMXy4WDHw5pEvorBzaveQ/9uCKpadAq4lprCZEMl9Q/ZZY7m+ks6j6sgcZ+ER9EZw==
X-Received: by 2002:a62:82cb:0:b0:525:79d9:ddc4 with SMTP id w194-20020a6282cb000000b0052579d9ddc4mr10478560pfd.48.1656529570846;
        Wed, 29 Jun 2022 12:06:10 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:9841:721:7d8b:4502])
        by smtp.gmail.com with ESMTPSA id y11-20020a63de4b000000b0040c644e82efsm11572917pgi.43.2022.06.29.12.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:06:10 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mediatek: ensure bridge disable happends before suspend
Date:   Thu, 30 Jun 2022 03:05:46 +0800
Message-Id: <20220629190545.478113-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure bridge_disable will be called before suspend by calling
drm_mode_config_helper_suspend() in .prepare callback.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
The issue is found if suspend is called via VT2 in several MTK SoC (eg.
MT8173, MT8183, MT8186) chromebook boards with eDP bridge:
bridge disable is called through mtk-drm's suspend, and it needs to be
called before bridge pm runtime suspend.
So we move the hook to .prepare() and .complete().
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 13a1bbe7ead7f..a42812e490007 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -828,8 +828,7 @@ static int mtk_drm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mtk_drm_sys_suspend(struct device *dev)
+static int mtk_drm_sys_prepare(struct device *dev)
 {
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
 	struct drm_device *drm = private->drm;
@@ -840,20 +839,21 @@ static int mtk_drm_sys_suspend(struct device *dev)
 	return ret;
 }
 
-static int mtk_drm_sys_resume(struct device *dev)
+static void mtk_drm_sys_complete(struct device *dev)
 {
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
 	struct drm_device *drm = private->drm;
 	int ret;
 
 	ret = drm_mode_config_helper_resume(drm);
-
-	return ret;
+	if (ret)
+		dev_err(dev, "Failed to resume\n");
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
-			 mtk_drm_sys_resume);
+static const struct dev_pm_ops mtk_drm_pm_ops = {
+	.prepare = mtk_drm_sys_prepare,
+	.complete = mtk_drm_sys_complete,
+};
 
 static struct platform_driver mtk_drm_platform_driver = {
 	.probe	= mtk_drm_probe,
-- 
2.37.0.rc0.161.g10f37bed90-goog

