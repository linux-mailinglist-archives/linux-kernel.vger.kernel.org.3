Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589B750DB4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiDYIkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiDYIkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:40:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC5689BB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:36:56 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c12so25395392plr.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6a9DJnLZoyjSQqOJbXpXtPYv+DY5RZMT8ENRg4/RRI=;
        b=g5zrZirvfr2sxgv+XDrJRRRSZcWaqfvFpzLqxrmEp7xkC39qL/RVOOXr69CMvQCGeV
         /gIrCbN+uEgn37C7qiUE3SHKxyg+dJk9odyEDO/Lakj7Pveh9RzJuNqUnzg/wQxFDw6E
         uaY6v7d9oJ+k3czUhRDUAGkU18PJd2xrPWA4gzHMn1zxjBdoiHDtfO3Up8fcpBGQhrlj
         tD2XyqZW1SiX90hLF/xqG9Rwgc8BZbPTaNGdtMAgkOoBzD+ug/+7AyZhStq7X6BE5Y0C
         klb7pyBiFLprePXeABQy1IT53YaY+r9Xqr2g1xCWAy3+eT8SHStdUuA6dzu0dcc1WG/L
         LFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6a9DJnLZoyjSQqOJbXpXtPYv+DY5RZMT8ENRg4/RRI=;
        b=5fIVsvPB5rypMwrg1QjUTHDvajWGMWk+1J6z74Svwm/5KR7SI8uH+7RruQKZci8zX3
         PTu9NhNitL1hNY8sWHuzLkc0LVIeslkWuTJi9LewTbiWKULNeMIevixKjToq+ELhgrne
         13jjeTT3ztL9upqFprYlmYsUDqLW4YP2GbaSYytY1QkRpwLsCpflyYo/q/dCUzm9bmVD
         a9CS0egXBPNMKRwrpeRsWFZQv3DTga4KD2v5C6zwAN15nSk1bzxB2ZYvBrpL5VCw8deL
         RhV41wFgnT455KbKvfRCxV1GESxs7GCmh4f1+0/S50BM+UxkmIUtaS2i5tsWMw6XR0x5
         9IEA==
X-Gm-Message-State: AOAM531o80wvWcc5Te7c1R/cMmIuKLpjOBWco80rPTrzFbt2J5+YSSfQ
        8X+UElEeG0y4D+NOzb4i+yI=
X-Google-Smtp-Source: ABdhPJxghzCfW0thhWYjfw24Amn1z8l+dauqX8/znkFHaiZCi6E5K5+kGscszYD9cjDbVz42ddGOVA==
X-Received: by 2002:a17:902:7d83:b0:158:c7e9:1ff3 with SMTP id a3-20020a1709027d8300b00158c7e91ff3mr17117826plm.55.1650875816320;
        Mon, 25 Apr 2022 01:36:56 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id b7-20020a056a00114700b004f7be3231d6sm10826176pfm.7.2022.04.25.01.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 01:36:55 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     yuq825@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        andrey.grodzovsky@amd.com
Cc:     dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] gpu: drm: remove redundant dma_fence_put() when drm_sched_job_add_dependency() fails
Date:   Mon, 25 Apr 2022 16:36:45 +0800
Message-Id: <20220425083645.25922-1-hbh25y@gmail.com>
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

When drm_sched_job_add_dependency() fails, dma_fence_put() will be called
internally. Calling it again after drm_sched_job_add_dependency() finishes
may result in a dangling pointer.

Fix this by removing redundant dma_fence_put().

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/gpu/drm/lima/lima_gem.c        | 1 -
 drivers/gpu/drm/scheduler/sched_main.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 55bb1ec3c4f7..99c8e7f6bb1c 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -291,7 +291,6 @@ static int lima_gem_add_deps(struct drm_file *file, struct lima_submit *submit)
 
 		err = drm_sched_job_add_dependency(&submit->task->base, fence);
 		if (err) {
-			dma_fence_put(fence);
 			return err;
 		}
 	}
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index b81fceb0b8a2..ebab9eca37a8 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -708,7 +708,6 @@ int drm_sched_job_add_implicit_dependencies(struct drm_sched_job *job,
 		dma_fence_get(fence);
 		ret = drm_sched_job_add_dependency(job, fence);
 		if (ret) {
-			dma_fence_put(fence);
 			return ret;
 		}
 	}
-- 
2.25.1

