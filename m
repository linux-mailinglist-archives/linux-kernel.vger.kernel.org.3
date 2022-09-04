Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267E75AC727
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbiIDVoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiIDVnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:43:32 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607BC2F3A7
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:41 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id c4so5673419iof.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8gwyhoydIHSfwTTFYi0xd/UEVRo5zT1WMZJS4KZ9ukE=;
        b=Oj7Ixl6oj9kg3JhT5hX2YNpqFWBWrRAemLR9ZyRiH8YKxlEL1JbyYUePKaIrZAL5jf
         1WolreEcW4UQ85oE8rIFcQKM9Y8DgXov3VdkOuxIChkt3b8QQ86vavL7yfZdfnG1GXrG
         DieSrzFFZkksP5SG7xHoU2NUtwtLwxXiHtZdjYdGp0A0SfFIYvtv5K3SHQproh7ZaK9g
         fFJF5WVYv4z4A9NBf1N+h/WwX6chGYIEj2Ni0q0zS2lPBsAWNrYRKNiDRgERv8ZCLA+5
         CocXeZEZ1Rn3EM+S6VnFtLemc62uByDMdXXT71Ilig4RAz83otTF0UG6qgEF5wkzDQpI
         548g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8gwyhoydIHSfwTTFYi0xd/UEVRo5zT1WMZJS4KZ9ukE=;
        b=5AKnx3tJwf+5Cr/5s8yg1wyq4FoZEqblv1raDWhp5S0i+mW1/KMzUAmq14xFclkbzr
         956d5G/EJer3cKssjy6Cen32ePDr5DjzWQP+bygvCcqorjj+uMUzqfO0ZJ2G+CdHf0o/
         llX5DRj+4EmyCKlKI+xM8EPHYCPdlheoZRtRoGvPh6N8fkrE4tnKkNXSTLzc4xqc9hkE
         MhniZYgz9v4V15ovrcNlLw5MIkDrr3pKM3BKqPc2Xcgl1pL5KPhEmYDfiD9v+BtysL1v
         XupMHEPO4vo7qFXciXoSS3+jcqeTwA6imd+IK1cmXvpPqPIUGTyoo7RbOndV1YiXptFA
         qG+Q==
X-Gm-Message-State: ACgBeo0DngHIfu5/4E/2nsx1nw6mu2cQezj3W1XkPdZa/6bt3bNk3uqd
        /UujTYmImLSFaaGOr5dA0dU=
X-Google-Smtp-Source: AA6agR7YcRBN9eLsdX3bzp79/kQqCn5Cue7Lw5y+W0FC6PDyqlsmvwF4ziOCRLDCU+BO8di3xE1W6A==
X-Received: by 2002:a05:6638:d06:b0:350:a613:f7ec with SMTP id q6-20020a0566380d0600b00350a613f7ecmr3859829jaj.169.1662327760724;
        Sun, 04 Sep 2022 14:42:40 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:40 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 32/57] nouveau: adapt NV_DEBUG, NV_ATOMIC to use DRM.debug
Date:   Sun,  4 Sep 2022 15:41:09 -0600
Message-Id: <20220904214134.408619-33-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
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
index 84df5ddae4d0..3b8a76004b57 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -39,6 +39,7 @@
  */
 
 #include <linux/notifier.h>
+#include <linux/dynamic_debug.h>
 
 #include <nvif/client.h>
 #include <nvif/device.h>
@@ -263,13 +264,16 @@ void nouveau_drm_device_remove(struct drm_device *dev);
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
2.37.2

