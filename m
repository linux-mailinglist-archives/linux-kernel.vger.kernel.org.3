Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8A54CA51E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbiCBMqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiCBMq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:46:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 496417807D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646225144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QOqtk8N28P4LW85N0QCWUUhlLsc+6PwvTIzB1n1peR4=;
        b=VosV3MsOb0rsuAx61l9aOFalCKxSNArbdqT46kzk4o4p+U84aB5ksLuOa/Fw0sjgA5F8/j
        0k8ktvIIbmdBC3b1A/tSr37fG5Br5frRDdHJ/8PDf8EVZeOzLoCRhaSo3iCS/8uYNgpje1
        CH0ZXtk/M9A7f2McAgka/9TAorM7iS0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-AYHmq5BsNj22B7-Xtu17-A-1; Wed, 02 Mar 2022 07:45:41 -0500
X-MC-Unique: AYHmq5BsNj22B7-Xtu17-A-1
Received: by mail-oi1-f199.google.com with SMTP id t34-20020a05680815a200b002d51d9e681dso980112oiw.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 04:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOqtk8N28P4LW85N0QCWUUhlLsc+6PwvTIzB1n1peR4=;
        b=h6u5uQ7F5hp6HuYsaV8vh31IeS5P+6jlLO3FOn9Wam7nOg2P9y2yJ+rlLpF7bwzqMn
         MSqmNWE2y7RLm9NGaQYSN7RezJju9tyFnbbj5apzP1zMiyu1D1V2FPzAMXTcE+wc+hhI
         z2dUVfzDwdW/Z0WQvi6MI/+zTjai9RuTzr0xRItNp9+YIpsTYQTXSOkeSiBNy68A6tGI
         +yJmksID8d2dtyy9B4iCxXi5N/wMpCMSfxwSenBhREfMkwNWJZkUknWa1LCdyGHgJgyS
         BI4rvSwE2f6dKH7RKdLloR8IWpR8dm8tYWTHZbdOlBy3uSmUokVjYjN2Yux5QDwuKs/h
         O4Zw==
X-Gm-Message-State: AOAM533M1cdHXhB+6oPUQrJafh/ZTDK44Soh13NDdkzek7wN0Ic2Bhh+
        m0VxiZcGIS86beo7DhWsm2SUPsN81ZjV60HoFGsim24jS28/kg11k27JYoclzaOQCQ2AoohPg72
        iw3hz8xyPQzV1u3d5LTOusrL0
X-Received: by 2002:a05:6830:19c8:b0:5b0:298f:42fa with SMTP id p8-20020a05683019c800b005b0298f42famr6537987otp.167.1646225140340;
        Wed, 02 Mar 2022 04:45:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnDPc+2WvUOGatFtOiVPEE5LXJGFam8aUb+jqjAchdLIWMbnsYv+rv/jMkNL9HI/Eoo4PdeA==
X-Received: by 2002:a05:6830:19c8:b0:5b0:298f:42fa with SMTP id p8-20020a05683019c800b005b0298f42famr6537973otp.167.1646225140110;
        Wed, 02 Mar 2022 04:45:40 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id y28-20020a4aea3c000000b0031c0cddfbf9sm7743217ood.20.2022.03.02.04.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:45:39 -0800 (PST)
From:   trix@redhat.com
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] drm/panfrost: cleanup comments
Date:   Wed,  2 Mar 2022 04:45:35 -0800
Message-Id: <20220302124535.358060-1-trix@redhat.com>
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
commited to committed
regsiters to registers
initialze to initialize

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: remove multiline comment change

 drivers/gpu/drm/panfrost/panfrost_drv.c          | 2 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c | 2 +-
 drivers/gpu/drm/panfrost/panfrost_issues.h       | 2 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c          | 2 +-
 drivers/gpu/drm/panfrost/panfrost_regs.h         | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

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
index 8e59d765bf19f..501a76c5e95ff 100644
--- a/drivers/gpu/drm/panfrost/panfrost_issues.h
+++ b/drivers/gpu/drm/panfrost/panfrost_issues.h
@@ -14,7 +14,7 @@
  */
 enum panfrost_hw_issue {
 	/* Need way to guarantee that all previously-translated memory accesses
-	 * are commited */
+	 * are committed */
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

