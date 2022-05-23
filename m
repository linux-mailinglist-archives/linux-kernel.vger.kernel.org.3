Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BFC530AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiEWHw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiEWHww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:52:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93631BE8F;
        Mon, 23 May 2022 00:52:49 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L66GV4dQ7zQk2C;
        Mon, 23 May 2022 14:04:02 +0800 (CST)
Received: from kwepemm600018.china.huawei.com (7.193.23.140) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 14:07:01 +0800
Received: from huawei.com (10.174.176.88) by kwepemm600018.china.huawei.com
 (7.193.23.140) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 14:07:00 +0800
From:   gaochao <gaochao49@huawei.com>
To:     <alexs@kernel.org>, <corbet@lwn.net>
CC:     <siyanteng01@gmail.com>, <bobwxc@email.cn>, <src.res@email.cn>,
        <wanjiabing@vivo.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhengbin13@huawei.com>
Subject: [PATCH -next] drm/panel: Fix build error when CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y && CONFIG_DRM_DISPLAY_HELPER=m
Date:   Mon, 23 May 2022 14:06:58 +0800
Message-ID: <20220523060658.737-1-gaochao49@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600018.china.huawei.com (7.193.23.140)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y && CONFIG_DRM_DISPLAY_HELPER=m,
bulding fails:

drivers/gpu/drm/panel/panel-samsung-atna33xc20.o: In function `atana33xc20_probe':
panel-samsung-atna33xc20.c:(.text+0x744): undefined reference to
 `drm_panel_dp_aux_backlight'
make: *** [vmlinux] Error 1

Let CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 select DRM_DISPLAY_DP_HELPER and
CONFIG_DRM_DISPLAY_HELPER to fix this error.

Fixes: 32ce3b320343 ("drm/panel: atna33xc20: Introduce the Samsung ATNA33XC20 panel")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: gaochao <gaochao49@huawei.com>
---
 drivers/gpu/drm/panel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 38799effd00a..4f1f004b3c54 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -438,6 +438,8 @@ config DRM_PANEL_SAMSUNG_ATNA33XC20
 	depends on OF
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on PM
+	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_HELPER
 	select DRM_DP_AUX_BUS
 	help
 	  DRM panel driver for the Samsung ATNA33XC20 panel. This panel can't
--
2.17.1

