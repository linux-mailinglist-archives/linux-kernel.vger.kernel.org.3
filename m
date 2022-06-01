Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0910653A53A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348181AbiFAMkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243050AbiFAMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:40:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333426FA00
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:40:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z17so1871262pff.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZLseM0j1fIYmiOxZxbQaK6URNKftcTa3kMSVl2a+08=;
        b=HkCOxiwD+gJhf/bA0w4IRDoAeEudGlKGDNflidFMyLb70xIffJkQ4YdCkpimkLe+m5
         ySGwHVqVjs/T1zoFZSmri0o9u2GfZQxEovs2axeW778HNe6NYUxUeZqjBqFHTATbJcEM
         jboGEljpibBsvjYgprNWVbKq9oLO1lNQOyTfKmuSxdnjaL1UFcD8tvfWl3sNK9gEzjCa
         B8MxrbmmCh9RsRbs2rCxHlKDH+sTHEYywyw7K+MPjmrIvMyq/OPV1U3ykoWuHJkn/dJd
         NS1AcISsPA8DNo5X9orN9YO2nez3qF6vUXUEJjxnpVSONIG90jwqP+lRcFvza83slJIh
         +swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZLseM0j1fIYmiOxZxbQaK6URNKftcTa3kMSVl2a+08=;
        b=aoEd123d0VGhrWvba1LljBJsaG6roNjMBJHsvIqQNweY2t5Li58Cf4t1+EYWnQsuYY
         vkWHruNFokA4+d/ObLRuGRN/TJOpFlHdPkxIhiA4VJdyexTVuz/kHGVSx6j74E4hR58G
         wA8kDXCOCgu6y4dpnMj57ZvqCJLtgNJdjj2YUgd5aQeLcgv5iXmcEQJTJnXSuStlgGVG
         A7RFWY9bkYjJNuO6P0vIkUE3E8jaeE1n46EIlUb+fm3KingG1bUMKE0KhLLy6henha0m
         mcMtGoSEHvp5qJDDj+K9pWi8caK/RSo9vDQZ4uF8Dgw3t4+tbd76pzYYnPg5jObHnCVf
         I31g==
X-Gm-Message-State: AOAM530cggF+GZhoTEqXcFPx+5uftX31kjdj8Jmcw+uiWAJPuZmKQW6I
        QdaXsQGN9TgGgIBTPtzgMSU=
X-Google-Smtp-Source: ABdhPJwTibucRxg8FEek4gEW3OiZSKSClrefo8JkcxM3tZB7HJ/KB4r230ulhju0vXmbkj5YKS8WGA==
X-Received: by 2002:a65:508c:0:b0:3fb:882c:85ef with SMTP id r12-20020a65508c000000b003fb882c85efmr24066613pgp.39.1654087235696;
        Wed, 01 Jun 2022 05:40:35 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id s6-20020a170902ea0600b0016232dbd01fsm1423539plg.292.2022.06.01.05.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 05:40:35 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [RESEND PATCH] drm/mipi-dsi: Fix error handling in mipi_dsi_device_register_full
Date:   Wed,  1 Jun 2022 16:40:24 +0400
Message-Id: <20220601124024.10137-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mipi_dsi_device_alloc(), it calls device_initialize(&dsi->dev);
We need to use put_device() instead freeing directly.

Fixes: 068a002 ("drm: Add MIPI DSI bus support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index c40bde96cfdf..8cc8deca006f 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -228,7 +228,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 	ret = mipi_dsi_device_add(dsi);
 	if (ret) {
 		drm_err(host, "failed to add DSI device %d\n", ret);
-		kfree(dsi);
+		put_device(&dsi->dev);
 		return ERR_PTR(ret);
 	}
 
-- 
2.25.1

