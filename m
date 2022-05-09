Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E032451F445
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiEIF7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiEIFuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:50:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB55111B95
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 22:46:20 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n8so12886234plh.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 22:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cicmyo9fma3vroeKIGErP7E3mBkjABO4msZ5eM9hcRo=;
        b=LVuNP+WYky7iLeP1k2Esgi1WbqIrqsoqJLN6SppMoRPjnzlapPl5j2vLCaTAASNGCj
         0BOozjxdYFgAjuO8gs2O0SS28UuL2UAFIEQuZPy4GVVRgKu0sIGcOeTAfd10TdwhX8or
         mUt362oP7ewMTSS3xbLVpPWei4pi5tDmfoK03tedVoYoIDNLGVXv3tIMe166REfQ07oY
         b7mS9azClsKeSWK8A/KfX5Tx16wgkZ4NdnuwbHnnO0r8OyXSFC3QShWCAbhgWkWFuJ2Z
         CDPizlVVXkIXMnq6Z/gsquiQnheCm+X3DLIEVuDJflkWQQSbwh9S96e4IuLu/Z7db/Mp
         EJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cicmyo9fma3vroeKIGErP7E3mBkjABO4msZ5eM9hcRo=;
        b=YEiKhdF/2Fd+cRKwC/fWCh+sIxwNe9u/ozZQNnpRj+j40SgGyVwglc/gqVMf9G0LfI
         +OrP9A6nTR67Zt3j3lLmkwaCwBrNeZDqH8sUhTK5hfXNMYDvXmMqmqGeG3E/BH9yIF8Z
         QxcxyiC/pLaMnn7+y80DsWEBY1DAW3HSm021IjRfPxAvK2utsW17A4d/qXAvuV/H10ZC
         Q48QSXUO5DCLPIMXWZgn/qHIRAI/4OhIUryTnKiCo3DwDOu9fWw+tVR3VObIyG/Jy/sv
         sH3D593uzHlIif0y9+IDWaYCJRZPFrj4Lt04sOLuyZHZmUseFe7bIq6BSo2T5Sq10T+a
         9L3Q==
X-Gm-Message-State: AOAM530tbQ1pus1shtWDQzze3Svc9GzTrGR0pAyaef0t/ShyyuiqHjvJ
        IpKsBN8auuPU4/oDvsxh97U=
X-Google-Smtp-Source: ABdhPJyJ+woJlVxbxcdZeoB6A4Umfd4irv65r3VsB2dDgLLtgfytcJ3dvk3bMS/Al4nrzrpFvAfIxA==
X-Received: by 2002:a17:90b:694:b0:1d9:6a2e:bc9 with SMTP id m20-20020a17090b069400b001d96a2e0bc9mr24621202pjz.169.1652075119609;
        Sun, 08 May 2022 22:45:19 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902db0d00b0015eb200cc00sm6104625plx.138.2022.05.08.22.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 22:45:19 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] gpu: drm: fix possible memory leak in drm_addmap_core()
Date:   Mon,  9 May 2022 13:44:41 +0800
Message-Id: <20220509054441.17282-1-hbh25y@gmail.com>
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

map->handle need to be handled correctly when map->type is _DRM_SHM or
_DRM_CONSISTENT just like map->type is _DRM_REGISTERS.

Fixes: 8d153f7107ff ("drm: update user token hashing and map handles")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/gpu/drm/drm_bufs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index fcca21e8efac..2b3f504c5f9c 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -344,6 +344,15 @@ static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
 	if (!list) {
 		if (map->type == _DRM_REGISTERS)
 			iounmap(map->handle);
+		else if (map->type == _DRM_SHM) {
+			dev->sigdata.lock = dev->master->lock.hw_lock = NULL;
+			vfree(map->handle);
+		} else if (map->type == _DRM_CONSISTENT) {
+			dma_free_coherent(dev->dev,
+					  map->size,
+					  map->handle,
+					  map->offset);
+		}
 		kfree(map);
 		return -EINVAL;
 	}
@@ -361,6 +370,15 @@ static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
 	if (ret) {
 		if (map->type == _DRM_REGISTERS)
 			iounmap(map->handle);
+		else if (map->type == _DRM_SHM) {
+			dev->sigdata.lock = dev->master->lock.hw_lock = NULL;
+			vfree(map->handle);
+		} else if (map->type == _DRM_CONSISTENT) {
+			dma_free_coherent(dev->dev,
+					  map->size,
+					  map->handle,
+					  map->offset);
+		}
 		kfree(map);
 		kfree(list);
 		mutex_unlock(&dev->struct_mutex);
-- 
2.25.1

