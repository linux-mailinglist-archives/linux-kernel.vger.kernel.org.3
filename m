Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA7047FD48
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhL0NPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhL0NPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:15:47 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F0EC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:15:47 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id j13so11394478plx.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=u+uGmmp1/FPnqLm3iQ1rOAyet9yHGJXkvFtvlVuUEdw=;
        b=J//+r+J/HmtE5ynr8CcgDqXkNxeu3CswRW8IBaWnRsGuwUL3iE1nE9jNwqT2u7svMG
         MYWb0CWtTYaSo1j5ti1u25cx+5FGqy3HAknOmhI8E0T2cJRCI0Dor7kfiip5/CbWGcNL
         P9r40IISRhmUBfxQD9+axdvsoQNmFxsPL5nDkflqLSCavfB4BvXmeVuW35hgetjpTaxq
         pYcrfZMNAuO1jKUM9L36xIDpoX8N4R2ge3rc03CHgu7seZ8Dbgmwoq9ibKkj12+kFi8Y
         7pNHRZILqFMxaCL+IJ59JVjke8LmAZwHpxAci+qrgJfe1tBQQvitu1gptqNk2orVHmdD
         ckuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u+uGmmp1/FPnqLm3iQ1rOAyet9yHGJXkvFtvlVuUEdw=;
        b=u/cJCJdOj2jRaVzgf5FDDEjl4c2Zqcx8vkybzyCKI/xVqygiu4su+xR/EPpLm0LVbG
         YAJbP2zn97FaQB7BYqa9hcPk5V2ONJdlvsa49E1iONQeiwZrLs3xmUNNuHR1gAAAJz8c
         LrCYrAj4Z8vvoUGUzMWm6hvReEcl2A6P6ZxV/v6lvltjT4jlK7b0Gij434T0BuF4qPko
         tYx5rw2IXc5hVAQ868XgaU/YHLRliL/wvrsr3v9gJ5cy38+/K/YlONq5rBGh1vmNmW4v
         sdYf/zFzGoSBFfGWrf1YGfqJhhYPugYYipOrJSpesmXGb2hAqwAn5X+iuNmvQx4827Vy
         HwpA==
X-Gm-Message-State: AOAM532qVd55om5SBYtaCD2dCg5B+uk5NTvKHGfO8n7lIITLMztJxRZz
        hGQquVsycz9ENZNWR0N0pI8=
X-Google-Smtp-Source: ABdhPJxEoh1kTKRJ6SNXhMXFgTGSrJ/Q41Rg5/Dku4WEHTm1nP9Z9FH4Qp5POr78B1XdWo2mGoS2AA==
X-Received: by 2002:a17:90b:1c86:: with SMTP id oo6mr20662990pjb.165.1640610946425;
        Mon, 27 Dec 2021 05:15:46 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q9sm18006033pfj.114.2021.12.27.05.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:15:46 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mipi-dsi: Fix error handling in mipi_dsi_device_register_full
Date:   Mon, 27 Dec 2021 13:15:40 +0000
Message-Id: <20211227131541.9742-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
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
index 18cef04df2f2..609bd9fc1bc5 100644
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
2.17.1

