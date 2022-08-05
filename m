Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E073358B1E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbiHEV51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbiHEVzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:55:41 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD257D78D;
        Fri,  5 Aug 2022 14:54:57 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p82so2865397iod.2;
        Fri, 05 Aug 2022 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=biCdDG3hgO3jLiBuVTkyAcrTfguva6XGgr+3k3kyQtA=;
        b=pHnMQq3haUq9GMLZ0ynr5l3syQtI6afCrVEI6lsWXN81GTRcVJy5Cn5+BSQeHOJ4o2
         9gZqTfnSpDehgvg/rGF5irUFyjyxfzLmZUR+Eha8hJBP9DuHTmPK6X+ndg4HKd15q1JS
         sCS+iaTIxAIBXM/d/yqQOcV2Wic1kg1qjTsLdnMCK4uUQ46j9b2c41zHAShKJKRC7/8Q
         0/bJav19LeFkkifQi2og+BnCOWIRgDfFEVmcyRgFXmKHggODr+d4k1vSrxLtT5YN9D9D
         8xTVooc+6ro8Kz6O+2CSLdhD+hk1I2lefgilIfI61+huZYmAOZXha4ZiAn5QO/KRv+fP
         Q9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=biCdDG3hgO3jLiBuVTkyAcrTfguva6XGgr+3k3kyQtA=;
        b=Q55JDGihTnFpwmHs0wZRuQpim7md60q7eAcN8SaNR/Yf23v1WtcBcSbwV3JfusNxD0
         NSyPrDXGIubGMlKw1SbDdSSBWn/v8qbpJx4OuSCYVUKjguZ3HEp1XsK3oOClTvSRvOnX
         lgsU8oMHXZ/BW32fY4LGe20uqpyf6b6fa+PiFPrfeb005EJOhKvjv7tJKxr64Phe0diZ
         ST3QsfRl7R6CXQJRD1CSJclnodUtx5DHum8DAvgsT8SbPQgX/CFTcjMwXNqGhB8EOtmI
         74E1rPYPbHHbHttFkPU8FalHoLmNPQc7P1oAf5qkqSbifX9qyjTb/Tpw82pNV2OzJZlz
         9BHg==
X-Gm-Message-State: ACgBeo1nfExEDb2FOFosZwdSwrvlz6Kr9ZfFzNPx9ITNiKMf1n5HzBpt
        QsQqWJT40TgO8tfOOCtQfrH1Ffyuh/k7lQ==
X-Google-Smtp-Source: AA6agR7o9yyEcyXzO2ABPft0K9eQpztTLUpOdyg5+NkeVd4bjtaZXLFgtityexVYW5cT+1534AxQqQ==
X-Received: by 2002:a6b:5f03:0:b0:67b:ef4d:e3ed with SMTP id t3-20020a6b5f03000000b0067bef4de3edmr3759281iob.45.1659736496145;
        Fri, 05 Aug 2022 14:54:56 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:55 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 32/33] nouveau: adapt NV_DEBUG, NV_ATOMIC to use DRM.debug
Date:   Fri,  5 Aug 2022 15:53:54 -0600
Message-Id: <20220805215355.3509287-33-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805215355.3509287-1-jim.cromie@gmail.com>
References: <20220805215355.3509287-1-jim.cromie@gmail.com>
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

These 2 macros used drm_debug_enabled() on DRM_UT_{DRIVER,ATOMIC}
respectively, replace those with drm_dbg_##cat invocations.

this results in new class'd prdbg callsites:

:#> grep nouveau /proc/dynamic_debug/control | grep class | wc
    116    1130   15584
:#> grep nouveau /proc/dynamic_debug/control | grep class | grep DRIVER | wc
     74     704    9709
:#> grep nouveau /proc/dynamic_debug/control | grep class | grep ATOMIC | wc
     31     307    4237
:#> grep nouveau /proc/dynamic_debug/control | grep class | grep KMS | wc
     11     119    1638

the KMS entries are due to existing uses of drm_dbg_kms().

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drv.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index b2a970aa9bf4..f266cd6b0405 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -39,6 +39,7 @@
  */
 
 #include <linux/notifier.h>
+#include <linux/dynamic_debug.h>
 
 #include <nvif/client.h>
 #include <nvif/device.h>
@@ -264,13 +265,16 @@ void nouveau_drm_device_remove(struct drm_device *dev);
 #define NV_WARN(drm,f,a...) NV_PRINTK(warn, &(drm)->client, f, ##a)
 #define NV_INFO(drm,f,a...) NV_PRINTK(info, &(drm)->client, f, ##a)
 
-#define NV_DEBUG(drm,f,a...) do {                                              \
-	if (drm_debug_enabled(DRM_UT_DRIVER))                                  \
-		NV_PRINTK(info, &(drm)->client, f, ##a);                       \
+#define NV_DRMDBG(cat,c,f,a...) do {				\
+	struct nouveau_cli *_cli = (c);				\
+	drm_dbg_##cat(_cli->drm->dev, "%s: "f, _cli->name, ##a); \
 } while(0)
-#define NV_ATOMIC(drm,f,a...) do {                                             \
-	if (drm_debug_enabled(DRM_UT_ATOMIC))                                  \
-		NV_PRINTK(info, &(drm)->client, f, ##a);                       \
+
+#define NV_DEBUG(drm,f,a...) do {					\
+	NV_DRMDBG(driver, &(drm)->client, f, ##a);			\
+} while(0)
+#define NV_ATOMIC(drm,f,a...) do {					\
+	NV_DRMDBG(atomic, &(drm)->client, f, ##a);			\
 } while(0)
 
 #define NV_PRINTK_ONCE(l,c,f,a...) NV_PRINTK(l##_once,c,f, ##a)
-- 
2.37.1

