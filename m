Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACD6595574
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiHPIlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiHPIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:40:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB7D102A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:45:26 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6M490cYmzXdgF;
        Tue, 16 Aug 2022 14:41:13 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 16 Aug
 2022 14:45:23 +0800
From:   Zhang Zekun <zhangzekun11@huawei.com>
To:     <andrzej.hajda@intel.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <dianders@chromium.org>,
        <briannorris@chromium.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <xuqiang36@huawei.com>
Subject: [PATCH -next] drm/bridge: Add missing clk_disable_unprepare() in analogix_dp_resume()
Date:   Tue, 16 Aug 2022 06:42:31 +0000
Message-ID: <20220816064231.60473-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing clk_disable_unprepare() before return from
analogix_dp_resume() in the error handling case.

Fixes: 211f276ed3d9 ("drm: bridge: analogix/dp: add panel prepare/unprepare in suspend/resume time")
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 8aadcc0aa90b..a0fd652547f5 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1887,6 +1887,7 @@ int analogix_dp_resume(struct analogix_dp_device *dp)
 	if (dp->plat_data->panel) {
 		if (drm_panel_prepare(dp->plat_data->panel)) {
 			DRM_ERROR("failed to setup the panel\n");
+			clk_disable_unprepare(dp->clock);
 			return -EBUSY;
 		}
 	}
-- 
2.17.1

