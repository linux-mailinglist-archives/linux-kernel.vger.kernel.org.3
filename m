Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE77551E663
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 12:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383063AbiEGKOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 06:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351004AbiEGKOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 06:14:34 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ACE1D316
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 03:10:47 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KwNP65mKGzXdlv;
        Sat,  7 May 2022 18:06:02 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 18:10:23 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 7 May
 2022 18:10:22 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <hjc@rock-chips.com>, <heiko@sntech.de>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <lyude@redhat.com>, <tzimmermann@suse.de>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Ren Zhijie" <renzhijie2@huawei.com>
Subject: [PATCH v2 -next] drm/rockchip: Fix Kconfig dependencies
Date:   Sat, 7 May 2022 18:09:10 +0800
Message-ID: <20220507100910.93705-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/rockchip/cdn-dp-core.o: In function `cdn_dp_connector_mode_valid':
cdn-dp-core.c:(.text+0x1e1): undefined reference to `drm_dp_bw_code_to_link_rate'
cdn-dp-core.c:(.text+0x1f4): undefined reference to `drm_dp_bw_code_to_link_rate'
drivers/gpu/drm/rockchip/cdn-dp-core.o: In function `cdn_dp_pd_event_work':
cdn-dp-core.c:(.text+0x138e): undefined reference to `drm_dp_channel_eq_ok'
drivers/gpu/drm/rockchip/cdn-dp-reg.o: In function `cdn_dp_train_link':
cdn-dp-reg.c:(.text+0xd5a): undefined reference to `drm_dp_bw_code_to_link_rate'

The DP-helper module has been replaced by the display-helper module.
So the driver have to select it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 1e0f66420b13("drm/display: Introduce a DRM display-helper module")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
v2: remove "select DRM_DISPLAY_HELPER if ROCKCHIP_ANALOGIX_DP" under DRM_ROCKCHIP at the head,
and separately add the select for ROCKCHIP_ANALOGIX_DP and ROCKCHIP_CDN_DP, which Andy suggested.
---
---
 drivers/gpu/drm/rockchip/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 5afab49dc4f2..53c2d9980d48 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -2,7 +2,6 @@
 config DRM_ROCKCHIP
 	tristate "DRM Support for Rockchip"
 	depends on DRM && ROCKCHIP_IOMMU
-	select DRM_DISPLAY_HELPER if ROCKCHIP_ANALOGIX_DP
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_HELPER
 	select DRM_PANEL
@@ -38,6 +37,7 @@ config ROCKCHIP_VOP2
 config ROCKCHIP_ANALOGIX_DP
 	bool "Rockchip specific extensions for Analogix DP driver"
 	depends on ROCKCHIP_VOP
+	select DRM_DISPLAY_HELPER
 	select DRM_DISPLAY_DP_HELPER
 	help
 	  This selects support for Rockchip SoC specific extensions
@@ -47,6 +47,8 @@ config ROCKCHIP_ANALOGIX_DP
 config ROCKCHIP_CDN_DP
 	bool "Rockchip cdn DP"
 	depends on EXTCON=y || (EXTCON=m && DRM_ROCKCHIP=m)
+	select DRM_DISPLAY_HELPER
+	select DRM_DISPLAY_DP_HELPER
 	help
 	  This selects support for Rockchip SoC specific extensions
 	  for the cdn DP driver. If you want to enable Dp on
-- 
2.17.1

