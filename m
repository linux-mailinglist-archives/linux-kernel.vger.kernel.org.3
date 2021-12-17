Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1D547819E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhLQAi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231207AbhLQAi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xJGxstYh658sLcbhjOZMkUVQl2qU4zGeFPPJuAgTKA=;
        b=jUll1Reecu00cVmFQs9eVlPMrhG7niEHwtQbSePwKst1rj48kQ9dkVxA5y5CCA5+7IpAB4
        GpJb+gCYWLx7qbyZGmI+Hr8fTHfqKO7P6MqjnzzFplPSwSh+8nySD/PPeBYJXxQBt8FzK3
        NQ/8gjmi0dXnTkhkePx8WhI9ezVci9w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-OWmRx8efPYOupLqpGO4juQ-1; Thu, 16 Dec 2021 19:38:27 -0500
X-MC-Unique: OWmRx8efPYOupLqpGO4juQ-1
Received: by mail-wr1-f71.google.com with SMTP id p17-20020adff211000000b0017b902a7701so141984wro.19
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1xJGxstYh658sLcbhjOZMkUVQl2qU4zGeFPPJuAgTKA=;
        b=iWxsGyLITbrzGVk+WD1ebmHtadH3z8OllJViDFXnRLUVJ82YRlW+CBkjzhcwaCGin9
         xbIGpH+XtFrEVPwrJ+aof9u0D9ol9U792gpnl/BLcyPRpMNlCqLE2rEPzmZC3naj1VkT
         qmtmt9JjNSl/n4dMiYk81VS6F0X8y5AVtszu6IOmKpouFuBrcv60M4Pv88btxCQXRfYz
         ukapkTvA0lYj3vk+2IdbCYcK4amsd9k4k9gS8BlG26N0HW3+YmfC00wOPguONmkLkatM
         xg1Sg9shN3iuwqM5s4tadJqW9A4FseonOUgOIfdvg1Z5PV30kh8ISTrPmiHSogI7ppqr
         P+wg==
X-Gm-Message-State: AOAM531Fg61xkbXdkaWNhoVqZXw1yw7JAkLLONp1HADyPri/UNCSbJ+D
        aCnrS4d6AtKaeQ9b48pGteImi5iCjZ4yU36MUwjAP3nlOQsZHxhWqEsOLGw7bkCsrxcP3Ez+o8O
        T6/G7igKjmy0+QSopcI0Hf47rp2qMIu2w5QPbjNYlVTPYhCryKnflK5vnZQdrV/c+dLmR4CYdwP
        g=
X-Received: by 2002:a5d:4312:: with SMTP id h18mr381765wrq.626.1639701505937;
        Thu, 16 Dec 2021 16:38:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEIOm8kdWiRiTiM2JW5349vi2plrCWlI3WzuseYR6JiCR9/kDlRsHPmiv0nYevzGRXYeknBA==
X-Received: by 2002:a5d:4312:: with SMTP id h18mr381745wrq.626.1639701505593;
        Thu, 16 Dec 2021 16:38:25 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:25 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 28/37] drm/mediatek: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:43 +0100
Message-Id: <20211217003752.3946210-29-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to disable Documentation/admin-guide/kernel-parameters.txt, this
parameter can be used to disable kernel modesetting.

DRM drivers will not perform display-mode changes or accelerated rendering
and only the system framebuffer will be available if it was set-up.

But only a few DRM drivers currently check for nomodeset, make this driver
to also support the command line parameter.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index aec39724ebeb..e336358fee20 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -210,6 +210,9 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	struct device *dma_dev;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	if (!iommu_present(&platform_bus_type))
 		return -EPROBE_DEFER;
 
-- 
2.33.1

