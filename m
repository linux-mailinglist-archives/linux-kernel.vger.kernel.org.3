Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FCA48648F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbiAFMrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239012AbiAFMrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:47:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A045DC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 04:47:04 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d10-20020a17090a498a00b001b33bc40d01so1187426pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 04:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KC71YFeX/q04GJdG17HRfq7w1PJzIDF05zCtW/8mUOM=;
        b=bMDvI1kcrkJ3iJg0CGOv2rdlnLJnTBwb4NtL6IQwgw5bGEe9T++vt2HuqCJwFP4Cvs
         jphp29b2+sg1wef2muOM2Zu8t0np4Sez61/xnBIYygcs60/7rQZe/BciDtqNYvgxh+M4
         ENZRiEgWPAx11hfXmIb2GomZzD2zivpf1d5/rgeu/4fhyjRUAJtwhcFlYL72iJFArxy+
         YrwX1GhJLgMJrJxxgGU9qDHz3brDt666/o8XUseGlZMhc01BQ4WCWxZUSGp2uN4BC8jO
         /3/u5fU0lnZuvyruxHbxIX39mYRX5RE8HSRbzQTFU2aWTWDOUeqU7h22Lw0KdoLHXEUm
         eg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KC71YFeX/q04GJdG17HRfq7w1PJzIDF05zCtW/8mUOM=;
        b=ffyf2qr9JSVF97HuU2bMejhbIPksaEyhmXP9/4NRzIqTMkjk6FiFnyasDEyOsGoePF
         gCS8+JWuKGou3ZneEBZocb6F5KaO75Ms6jDkIs3bjrc17NsIfUjWM5IRsTAiPkptIUzK
         KqmgwosSH/joxEyB0hgk0aHv6NQwqT00fpqeZg2DqNT+iR1cHhc0QleOPokx59UikDTv
         UUcvIL2kFt9cHgeYXUvh4uBMwerWVz9ck+e7xbki0mNf6YXCkkgrwJuxMKe4ITE6W5r0
         rvek+9YNIvI+zyVQTf0QtpTq5bNJrtQtWZg/KaB0xCDO3zFFc7a5xzUGvIHw2sfO+EM3
         /W3Q==
X-Gm-Message-State: AOAM531BzFPbffihlUPXa6XyibYfaXESNeHPNLOQknG68gVpv2xmMEaI
        q80ZAix7jObOdEotx4gRoeU=
X-Google-Smtp-Source: ABdhPJzwNEzZRoPa0ZqQQ22MGbHsrSeP/vhR18csyuIzZMnAb9nSDti1FixA+AbzoStGlKdJUYigoQ==
X-Received: by 2002:a17:903:120a:b0:149:8b16:ee19 with SMTP id l10-20020a170903120a00b001498b16ee19mr43022958plh.11.1641473224231;
        Thu, 06 Jan 2022 04:47:04 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id a17sm2214409pjh.11.2022.01.06.04.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 04:47:04 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     dave.stevenson@raspberrypi.com
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org, emma@anholt.net,
        eric@anholt.net, linmq006@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/v3d: Fix PM disable depth imbalance in v3d_platform_drm_probe
Date:   Thu,  6 Jan 2022 12:46:57 +0000
Message-Id: <20220106124657.32737-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAPY8ntAdknutH=OmV1dWPbez1ZqLgaOj-BoQQkZAu0WbhbE6nQ@mail.gmail.com>
References: <CAPY8ntAdknutH=OmV1dWPbez1ZqLgaOj-BoQQkZAu0WbhbE6nQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: 57692c9 ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2
- put pm_runtime_disable before dma_free_wc
- rename dma_free to pm_disable
---
 drivers/gpu/drm/v3d/v3d_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index bd46396a1ae0..7d500dd5314e 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -282,7 +282,7 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 
 	ret = v3d_gem_init(drm);
 	if (ret)
-		goto dma_free;
+		goto pm_disable;
 
 	ret = v3d_irq_init(v3d);
 	if (ret)
@@ -298,7 +298,8 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	v3d_irq_disable(v3d);
 gem_destroy:
 	v3d_gem_destroy(drm);
-dma_free:
+pm_disable:
+	pm_runtime_disable(dev);
 	dma_free_wc(dev, 4096, v3d->mmu_scratch, v3d->mmu_scratch_paddr);
 	return ret;
 }
-- 
2.17.1

