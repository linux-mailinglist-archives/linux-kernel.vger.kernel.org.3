Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEB059CE5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbiHWCPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239583AbiHWCPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:15:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA415142F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:15:46 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MBXpk0m6qzGphy;
        Tue, 23 Aug 2022 10:14:06 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 10:15:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
        <jstultz@google.com>, <kong.kongxinwei@hisilicon.com>,
        <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <javierm@redhat.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/hisilicon/hibmc: Fix COMPILE_TEST building without MMU
Date:   Tue, 23 Aug 2022 10:09:20 +0800
Message-ID: <20220823020920.11008-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: unmet direct dependencies detected for DRM_TTM
  Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]
  Selected by [y]:
  - DRM_TTM_HELPER [=y] && HAS_IOMEM [=y] && DRM [=y]
  - DRM_HISI_HIBMC [=y] && HAS_IOMEM [=y] && DRM [=y] && PCI [=y] && (ARM64 || COMPILE_TEST [=y])

Add missing MMU dependency to fix this.

Fixes: a0f25a6bb319 ("drm/hisilicon/hibmc: Allow to be built if COMPILE_TEST is enabled")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
index 073adfe438dd..e5ef1b573732 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
+++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_HISI_HIBMC
 	tristate "DRM Support for Hisilicon Hibmc"
-	depends on DRM && PCI && (ARM64 || COMPILE_TEST)
+	depends on DRM && PCI && (ARM64 || COMPILE_TEST) && MMU
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
 	select DRM_TTM
-- 
2.17.1

