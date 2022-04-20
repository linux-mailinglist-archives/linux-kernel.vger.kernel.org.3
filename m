Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1683F5089CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379071AbiDTNxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379263AbiDTNxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:53:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0939D1A061
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:50:14 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ll10so1976439pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hwpE4P0PAK++IoF87d4GxulRADSGpUtTFQUdjv5LNcw=;
        b=H45VCtXdf6GfWkzyk5L6TRFXA93Hkt+3Qy+nVISRnNytt384I4SE2Fa1cJNV6flsae
         5bScYbioWdXQKuRDQICsrEfAWOx7e4txX64dN9pS9F8QqrFiG2e+oVchSv5vEelq8011
         gIABJAVN6Udx4mJ7uUArgP3/6lP8Q5TXh2besSwyX5ngw2VyMaSiQE6vxGcr6HNAyW5c
         g9ap4MsFPYuKnMCL6spP2RSFcM0UueI9jc+5r+6USDigMexmWADzq0TaoKKfzCKnAfpp
         weelRWGALLBQTs+e3YWi7mTRS9IuB5POun0yDQp/SA4N/fqVqXFD1klEptXWJSs4RAdl
         cNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hwpE4P0PAK++IoF87d4GxulRADSGpUtTFQUdjv5LNcw=;
        b=kpZlIKBC5f7BvPToe3loNigI3+RxEcKVldOv3AuWGsZGYAYCQM0Iy0+yuYAFZ6rhvJ
         JJf/BA706oJEK+L1uQFR2R7D01RDwlyhxiAJtHG/hmsEbWiMOs+MSLDOOIPeKxONiaaB
         o2izlf0p4jMMujf63GCy2roZt7yXrcz3vn6xaYo1wcz2IndGGkPCPhJYin8PIGCfxEq1
         EVxygiR7RQ4cmqN8mJHj0CqeAbamtfmIoWEmb5h822bA8fb6i3LSYRyfhXsSDD1G4w2Q
         XTK9cwCx2sywePds3hZjaxel+tDBVuMoMV2vo3dV6Vk7Yq2QoVGaXhJCmYXcAisi7Znl
         T80g==
X-Gm-Message-State: AOAM532wTIIxoIU7MOVrxyat4TIM7nkyohBQxsmuWvvLeEQk5UGDBGxQ
        OF2ULPuj3d1N1/Nh8bV3tLg=
X-Google-Smtp-Source: ABdhPJwzRIaufinLodvQbo05m+YRV47g8bGZU9n2OpavHyOuPdouIljKB/BGuDv28AzfQiqjzEaTMQ==
X-Received: by 2002:a17:90b:1e01:b0:1cf:573c:5625 with SMTP id pg1-20020a17090b1e0100b001cf573c5625mr4558482pjb.75.1650462613605;
        Wed, 20 Apr 2022 06:50:13 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id c30-20020a631c1e000000b003aa66be569csm2487949pgc.32.2022.04.20.06.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:50:13 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v3] drm/vc4: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage
Date:   Wed, 20 Apr 2022 21:50:07 +0800
Message-Id: <20220420135008.2757-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420132814.3sy2ojw3dxnd5tcz@houat>
References: <20220420132814.3sy2ojw3dxnd5tcz@houat>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device is already in a runtime PM enabled state
pm_runtime_get_sync() will return 1.

Also, we need to call pm_runtime_put_noidle() when pm_runtime_get_sync()
fails, so use pm_runtime_resume_and_get() instead. this function
will handle this.

Fixes: 4078f5757144 ("drm/vc4: Add DSI driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
change in v2:
- switch to pm_runtime_resume_and_get() to fix refcount leak.
changes in v3:
- keep the original checking way for retval.
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 752f921735c6..98308a17e4ed 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -846,7 +846,7 @@ static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
 	unsigned long phy_clock;
 	int ret;
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret) {
 		DRM_ERROR("Failed to runtime PM enable on DSI%d\n", dsi->variant->port);
 		return;
-- 
2.17.1

