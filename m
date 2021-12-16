Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D976B477E79
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhLPVJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:09:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230214AbhLPVJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639688986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZozipTaNlxYu/i5GsMvqhEAEmKMoVSloRU/bzLKrGMg=;
        b=hLG2o8txU+WZxUgW2yemawuH1pgfTXw1NoECcA4tKNSZJom60CYNnVTQ57sC/M7cNQlOsK
        cI5Fde14kDEGB9jiR2SzmTLtgXsSH1b2SG7063K+WAHpXYfmZNt/j5piC+Qsb7+fEDjMEy
        /j/CXSDNZXW7RE++ryji5oXLY6YjI8I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-l2FDwJDWMY2BQ4dfJAxB1w-1; Thu, 16 Dec 2021 16:09:45 -0500
X-MC-Unique: l2FDwJDWMY2BQ4dfJAxB1w-1
Received: by mail-wm1-f70.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so208445wms.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 13:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZozipTaNlxYu/i5GsMvqhEAEmKMoVSloRU/bzLKrGMg=;
        b=kei2K+TF2m1K6ixGz4bT/dNAICks7rk+O6lGY3ywQpfpDlxAZysBiZCiUhLY1r4PIr
         DM+1X5QKnO0uGbmNHbPu6p5HeC2n+cg5oSPObDq9AgvriyrB3/agi9WvfL5JQTq9ljGi
         vy/JEO2tAnIzr8lz/GEvCbVJP45RVXs5/hqfmTABd9s8EzNZlRvqiEVkfldUvserM4O4
         qvSZe4UTcTZYqjbrfrNQrZz1KwM1iw83P3GrB6oGdA22Tc1CYKZViPzcbjKl5ollQ0D6
         hvgcs0NUqJLHUxJnww8yCzdxAi8bX9sqrRjt7WrFciVW7Xhqs9pINSN+7WxvgGEovrd2
         NK/w==
X-Gm-Message-State: AOAM530p2Wu7fJ+KmlnfDnkM8utCySELztkXEhAjDnm1zcpYbAOCdSvB
        ZdjRbZBwbGO06DMnuW4A6PYno1EWXQFw8y/Gt5J9HsP4y4mgp6QCOJ10RapZnoCDcPEfVuBi5Jx
        ESUsspW83XUQYYjAYBQ0833E+IaIpG8/lHM6S0laaEj2SaG3rswO8vaesOnlyu828Pt3hgfvnSy
        M=
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr6648452wmf.149.1639688984070;
        Thu, 16 Dec 2021 13:09:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxt3kWvvUkcQQUk45AwYXe5exDYrHelov6qN8vYzcBMNkC/jaUI9d+DI2qZzyzHI/0HC7piug==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr6648433wmf.149.1639688983802;
        Thu, 16 Dec 2021 13:09:43 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a10sm9977692wmq.27.2021.12.16.13.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:09:43 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        John Stultz <john.stultz@linaro.org>,
        Matthew Ruffell <matthew.ruffell@canonical.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/hisilicon/hibmc: Allow to be built if COMPILE_TEST is enabled
Date:   Thu, 16 Dec 2021 22:09:36 +0100
Message-Id: <20211216210936.3329977-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit feeb07d0ca5a ("drm/hisilicon/hibmc: Make CONFIG_DRM_HISI_HIBMC
depend on ARM64") made the driver Kconfig symbol to depend on ARM64 since
it only supports that architecture and loading the module on others would
lead to incorrect video modes being used.

But it also prevented the driver to be built on other architectures which
is useful to have compile test coverage when doing subsystem wide changes.

Make the dependency instead to be (ARM64 || COMPILE_TEST), so the driver
is buildable when the CONFIG_COMPILE_TEST option is enabled.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/hisilicon/hibmc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
index 43943e980203..073adfe438dd 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
+++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_HISI_HIBMC
 	tristate "DRM Support for Hisilicon Hibmc"
-	depends on DRM && PCI && ARM64
+	depends on DRM && PCI && (ARM64 || COMPILE_TEST)
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
 	select DRM_TTM
-- 
2.33.1

