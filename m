Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8067A51E2E6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 03:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445147AbiEGBFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 21:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445137AbiEGBFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 21:05:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A222156226
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 18:01:50 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kw8Ht0GYbzfbMG;
        Sat,  7 May 2022 09:00:42 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 09:01:48 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 7 May
 2022 09:01:48 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <hjc@rock-chips.com>, <heiko@sntech.de>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <lyude@redhat.com>, <tzimmermann@suse.de>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Ren Zhijie" <renzhijie2@huawei.com>
Subject: [PATCH -next] drm/rockchip: Fix Kconfig dependencies
Date:   Sat, 7 May 2022 09:00:39 +0800
Message-ID: <20220507010039.117310-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

If CONFIG_ROCKCHIP_ANALOGIX_DP is not set, the rockchip drm driver
will fail to link:

drivers/gpu/drm/rockchip/cdn-dp-core.o: In function `cdn_dp_connector_mode_valid':
cdn-dp-core.c:(.text+0x1e1): undefined reference to `drm_dp_bw_code_to_link_rate'
cdn-dp-core.c:(.text+0x1f4): undefined reference to `drm_dp_bw_code_to_link_rate'
drivers/gpu/drm/rockchip/cdn-dp-core.o: In function `cdn_dp_pd_event_work':
cdn-dp-core.c:(.text+0x138e): undefined reference to `drm_dp_channel_eq_ok'
drivers/gpu/drm/rockchip/cdn-dp-reg.o: In function `cdn_dp_train_link':
cdn-dp-reg.c:(.text+0xd5a): undefined reference to `drm_dp_bw_code_to_link_rate'

The problem is that the DP-helper module has been replaced by the display-helper module.
So the driver have to select it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 1e0f66420b13("drm/display: Introduce a DRM display-helper module")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/gpu/drm/rockchip/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 5afab49dc4f2..eb9ffa9e357d 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
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

