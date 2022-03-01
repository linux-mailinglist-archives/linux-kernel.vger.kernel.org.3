Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5241C4C8BE2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbiCAMoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiCAMo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:44:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D88454693
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646138627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x+dwhD93YTqhMx+pdHPzeUKn3G2GSBR27WYaSq1Zfio=;
        b=XiTsJ4SwfM70JbGNymAwdLQ39e0+9kHPDUGnXFfbnN0dsx/ZivPm6XtXtaz33BN8XPaEbV
        m5XMSONkLoUKxJKROspekg0icjOvkK/icGuiRy59o5fPqfZeXRsdUf2gJVd14tJQTZlpeI
        nmJJ7tYqjBCBkn6dmnmcu6fBxykyBE8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-JEz_jmwJPe-TFKAK70zmTg-1; Tue, 01 Mar 2022 07:43:46 -0500
X-MC-Unique: JEz_jmwJPe-TFKAK70zmTg-1
Received: by mail-qv1-f72.google.com with SMTP id z8-20020a0cda88000000b00432946b4c84so14179021qvj.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 04:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x+dwhD93YTqhMx+pdHPzeUKn3G2GSBR27WYaSq1Zfio=;
        b=PRJeMjbzK75THuK+MvVrX6PgspDPhXdPzwqbwPhUbNg9wQNQWWmRovK2PnfPrax72B
         M3QRcWjzhaX9A6x4wu1nuAmaK1Hpe3xsQVCoXQ6QmMhnzMnuQYU+8l6Mj+kOpDdmaDrx
         ElMbQb6JHvY05cDjYRKkJnQya0dIM4JTPnj2K9TPsLFBxBeSbA5lip/lgTm1EcndXuMy
         jDOZE2u6h/h3qg5a235kIZ1M8ft56Z1/5d4SzSUBJxiJcbB9WAAJUOYMzKVNPvlZm6Nj
         EHdovmkzRjsZGhX1HSfh+qli3trNO6CUolrkqyFF5D1oa8h3gP6NwTXa4o8940NaSFKm
         i0dg==
X-Gm-Message-State: AOAM533EVPvYkxsKO56P9kaIC6llMYyUxggXjbnS7vikGv162z4UZPjZ
        cde4ss+eOOi6eK26tVzGJh3Sd+ADVXSwqBWxlijAhmbQpFrld4vpQvflQbbAp8p+zmmXBnBd8B7
        6hVPEUhmFcuA6WFFIElOPLhOS
X-Received: by 2002:a0c:ab51:0:b0:432:4db3:f52e with SMTP id i17-20020a0cab51000000b004324db3f52emr16853845qvb.114.1646138625117;
        Tue, 01 Mar 2022 04:43:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJya9fDvbWL7dgsZMQta2Ro8omYh2gW3GOBowplvGXvSGHYOmq0OdB3+A33jeMwm4KZqJa+XyA==
X-Received: by 2002:a0c:ab51:0:b0:432:4db3:f52e with SMTP id i17-20020a0cab51000000b004324db3f52emr16853825qvb.114.1646138624820;
        Tue, 01 Mar 2022 04:43:44 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id r2-20020a05620a03c200b00477981c7129sm6435799qkm.17.2022.03.01.04.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 04:43:44 -0800 (PST)
From:   trix@redhat.com
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/panfrost: cleanup comments
Date:   Tue,  1 Mar 2022 04:43:39 -0800
Message-Id: <20220301124339.264544-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

For spdx
change tab to space delimiter
Use // for *.c

Replacements
commited to committed, use multiline comment style
regsiters to registers
initialze to initialize

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c          | 2 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c | 2 +-
 drivers/gpu/drm/panfrost/panfrost_issues.h       | 6 ++++--
 drivers/gpu/drm/panfrost/panfrost_mmu.c          | 2 +-
 drivers/gpu/drm/panfrost/panfrost_regs.h         | 2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 96bb5a4656278..94b6f0a19c83a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -562,7 +562,7 @@ static int panfrost_probe(struct platform_device *pdev)
 
 	pfdev->coherent = device_get_dma_attr(&pdev->dev) == DEV_DMA_COHERENT;
 
-	/* Allocate and initialze the DRM device. */
+	/* Allocate and initialize the DRM device. */
 	ddev = drm_dev_alloc(&panfrost_drm_driver, &pdev->dev);
 	if (IS_ERR(ddev))
 		return PTR_ERR(ddev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
index b0142341e2235..77e7cb6d1ae3b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2019 Arm Ltd.
  *
  * Based on msm_gem_freedreno.c:
diff --git a/drivers/gpu/drm/panfrost/panfrost_issues.h b/drivers/gpu/drm/panfrost/panfrost_issues.h
index 8e59d765bf19f..4e7cf979ee67a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_issues.h
+++ b/drivers/gpu/drm/panfrost/panfrost_issues.h
@@ -13,8 +13,10 @@
  * to care about.
  */
 enum panfrost_hw_issue {
-	/* Need way to guarantee that all previously-translated memory accesses
-	 * are commited */
+	/*
+	 * Need way to guarantee that all previously-translated memory accesses
+	 * are committed
+	 */
 	HW_ISSUE_6367,
 
 	/* On job complete with non-done the cache is not flushed */
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 39562f2d11a47..d3f82b26a631d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier:	GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
 
 #include <drm/panfrost_drm.h>
diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
index 6c5a11ef1ee87..efe4b75149d35 100644
--- a/drivers/gpu/drm/panfrost/panfrost_regs.h
+++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
@@ -292,7 +292,7 @@
 #define AS_FAULTADDRESS_LO(as)		(MMU_AS(as) + 0x20) /* (RO) Fault Address for address space n, low word */
 #define AS_FAULTADDRESS_HI(as)		(MMU_AS(as) + 0x24) /* (RO) Fault Address for address space n, high word */
 #define AS_STATUS(as)			(MMU_AS(as) + 0x28) /* (RO) Status flags for address space n */
-/* Additional Bifrost AS regsiters */
+/* Additional Bifrost AS registers */
 #define AS_TRANSCFG_LO(as)		(MMU_AS(as) + 0x30) /* (RW) Translation table configuration for address space n, low word */
 #define AS_TRANSCFG_HI(as)		(MMU_AS(as) + 0x34) /* (RW) Translation table configuration for address space n, high word */
 #define AS_FAULTEXTRA_LO(as)		(MMU_AS(as) + 0x38) /* (RO) Secondary fault address for address space n, low word */
-- 
2.26.3

