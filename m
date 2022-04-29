Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5D551450B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356252AbiD2JGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356145AbiD2JGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:06:34 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEDEC44FE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:03:17 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 1so4920716qvs.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qoxSXQJ9/dxQQK4MVZhhkXxfBiLYXcuDgG7pQcSbp24=;
        b=qwYRTKhQT/k6kRH/sIvie4o3m09yMCZ0af+PONrrDG4vjbZgGBVZIlqkSCyJIJbm4L
         Za3E7j8wM3DvURSzIFVADYcRS7YRyZefkdx9DxC/f8sHSn+vZhxWBhkyaLl49l3cUf9F
         NMDASElKrvx3w7dCZ0jZ1PdzhrNwzr/ecS6b8bpQznlo0CRse27sxu39b7wIw0bEp0v3
         67zffhdAMXD6ifrRlWDSLt5ZIzzCdkSU+WBf4Lv1JYRO2DT9xnIIisXCADiCrWktMlTk
         zwwJTDIshEN/uyLpfDzug5GqrE2L4CnP4GKroovL6eLRDzzvZjnnsttvTpLZqYvlq0DY
         iCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qoxSXQJ9/dxQQK4MVZhhkXxfBiLYXcuDgG7pQcSbp24=;
        b=JoFiqBAKWX3Gom5+W8HQej57Ruyc3UVhoNiTyGdgl4Yhx0iS5jM3fvgMiKrVRpDhiS
         A83cPIUFUiOBFJZ9A/WygLMtzQ1kE0egfBfo6ki6QtSzzHqjreC04w2gdKSgsuEa9YPF
         v9IGJz9bsZc8bcXdCmObNyV6ITvRxwZmXJMeinet7AqhRTRgaHg/5OmFRaHYeT52LD3B
         7dMN0n+zZpTD80wC6HOiPvTgvJ+QoR6Jzh+EtbX8XvC14WJ1aNfQopaaMLyY/PR4iK98
         HEfAIbhwVrkbWH7+A9usYJBY7gwAVmJmxjlkHWTQGm3vc6jk9q/k84LV1CazzqaoiMQ0
         SnbA==
X-Gm-Message-State: AOAM532Ac5KHDF05QZcnx+Qs57Wcbwusy7fQY+o60hZonAYySCdQtwkg
        yhAPbKu4I7gDUB6tFO/Z2ykjEWG+Jas=
X-Google-Smtp-Source: ABdhPJyp7C79PxBF7uZn3lregSoa281RnSLQCXE+KUZc7B+ARBEKAZjda80oBT+xOEEB9jnpuieyQA==
X-Received: by 2002:a05:6214:238e:b0:435:3700:d65 with SMTP id fw14-20020a056214238e00b0043537000d65mr26126189qvb.65.1651222995596;
        Fri, 29 Apr 2022 02:03:15 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p14-20020a05622a13ce00b002f20a695972sm1556709qtk.14.2022.04.29.02.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 02:03:15 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     bskeggs@redhat.com
Cc:     kherbst@redhat.com, lyude@redhat.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/nouveau: simplify the return expression of nouveau_debugfs_init()
Date:   Fri, 29 Apr 2022 09:03:09 +0000
Message-Id: <20220429090309.3853003-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 1cbe01048b93..76b621f99916 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -255,19 +255,13 @@ nouveau_drm_debugfs_init(struct drm_minor *minor)
 int
 nouveau_debugfs_init(struct nouveau_drm *drm)
 {
-	int ret;
-
 	drm->debugfs = kzalloc(sizeof(*drm->debugfs), GFP_KERNEL);
 	if (!drm->debugfs)
 		return -ENOMEM;
 
-	ret = nvif_object_ctor(&drm->client.device.object, "debugfsCtrl", 0,
+	return nvif_object_ctor(&drm->client.device.object, "debugfsCtrl", 0,
 			       NVIF_CLASS_CONTROL, NULL, 0,
 			       &drm->debugfs->ctrl);
-	if (ret)
-		return ret;
-
-	return 0;
 }
 
 void
-- 
2.25.1


