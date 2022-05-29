Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1B55371C9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 18:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiE2Q3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 12:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE2Q3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 12:29:42 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C81F2F013;
        Sun, 29 May 2022 09:29:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x143so8553821pfc.11;
        Sun, 29 May 2022 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F0TmM8b9e274oJMvNvuPKJVM2spWHgnC/4XXZLIhTKc=;
        b=S1Us7OAbBJgnJ7Qc5yA9DRJFHDniqPlIsZgDysPoU6nRKRxSYGGySsj1QcYZeRV31C
         DjT6f51ghmir+RZJdqrAjQrWHq5AZ7TQWwqv2SL5tTkiIyy148ET+tgzqGxhJ+A7feEY
         F31etkjkP4rhcTxNg8nzhl+VbIJicF/dG8DbESw0z/oqJqnnbE+/4YvI4kuNQcHHmMMH
         x91V6YLrCvrBNzS0p98knuYHnVJZArBM9L22n7wBBTfEwRQxzTITCpEZdiEDXJ1W9DLR
         D5iQKNHU6MrS8MjC8GplZjNVs0tZ+jXm/aWlkEzEZuar/rQJkUV+sjosCFs9cWIogPrv
         2xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F0TmM8b9e274oJMvNvuPKJVM2spWHgnC/4XXZLIhTKc=;
        b=QYmAKmCBNidSStO8NbB2vfhpdIso0bu3FZq7yMLRFU+zd5139lKrjDDkiGUAEYvlBQ
         +YBL1AF5xcgwxb/OMLVMmhL7C3pJKMbnIki/XIayVvwl61HBTWIW2cSO3mKGl4bmMIfE
         8S3o7EioAP4uJxa2R5FbuGtGXN06fJQEUSEyTItTySF4TKBLblX8w9zmQGMcn7UH9C6d
         Cy8g7bYcH7/bB/XNxKWkILszzRiqlVOEFdus1BeU0J/AJCPk2Rnxr+ejVkIWW0ezTUDn
         4J+cVk7CtIwz8gbZxz42Bk0SjpSHf2HJvbrftgKbLsDUlAHLjbS1ksGbRGN/2kWoyHLo
         DgfQ==
X-Gm-Message-State: AOAM530S17dIwu0DoTT0N9wzGzsSX2Vme3e2TmQ5IxIRTI+jQ1vIsQ/g
        8xi3mpnXqlGCbRQMS1rWoQY=
X-Google-Smtp-Source: ABdhPJwiBkVL6vuI5goGhYdfMbEajG9cOJY8MXj2qEucMrXQYa65iBSazvTQHcgKUdnOCdriyfKu0g==
X-Received: by 2002:a65:4c44:0:b0:39c:e0b5:cd2a with SMTP id l4-20020a654c44000000b0039ce0b5cd2amr45230821pgr.481.1653841780062;
        Sun, 29 May 2022 09:29:40 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902ebc100b00163ad74fe4esm1207781plg.70.2022.05.29.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 09:29:38 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/prime: Ensure mmap offset is initialized
Date:   Sun, 29 May 2022 09:29:36 -0700
Message-Id: <20220529162936.2539901-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.3
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

From: Rob Clark <robdclark@chromium.org>

If a GEM object is allocated, and then exported as a dma-buf fd which is
mmap'd before or without the GEM buffer being directly mmap'd, the
vma_node could be unitialized.  This leads to a situation where the CPU
mapping is not correctly torn down in drm_vma_node_unmap().

Fixes: e5516553999f ("drm: call drm_gem_object_funcs.mmap with fake offset")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
Note, it's possible the issue existed in some related form prior to the
commit tagged with Fixes.

 drivers/gpu/drm/drm_prime.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index e3f09f18110c..849eea154dfc 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -716,6 +716,11 @@ int drm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 	struct file *fil;
 	int ret;
 
+	/* Ensure that the vma_node is initialized: */
+	ret = drm_gem_create_mmap_offset(obj);
+	if (ret)
+		return ret;
+
 	/* Add the fake offset */
 	vma->vm_pgoff += drm_vma_node_start(&obj->vma_node);
 
-- 
2.35.3

