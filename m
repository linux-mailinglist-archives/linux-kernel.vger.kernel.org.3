Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691EC4CE4C6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiCEMdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 07:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiCEMcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 07:32:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C0024004C;
        Sat,  5 Mar 2022 04:32:05 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K9kb80KzXzdbH0;
        Sat,  5 Mar 2022 20:30:44 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 20:32:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jonathanh@nvidia.com>, <mperttunen@nvidia.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/tegra: vic: Fix build warning When CONFIG_PM=n
Date:   Sat, 5 Mar 2022 20:32:00 +0800
Message-ID: <20220305123200.16572-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/tegra/vic.c:326:12: error: ‘vic_runtime_suspend’ defined but not used [-Werror=unused-function]
 static int vic_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tegra/vic.c:292:12: error: ‘vic_runtime_resume’ defined but not used [-Werror=unused-function]
 static int vic_runtime_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~

Mark it as __maybe_unused.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/tegra/vic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index 1e342fa3d27b..b25a6c7127b3 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -289,7 +289,7 @@ static int vic_load_firmware(struct vic *vic)
 }
 
 
-static int vic_runtime_resume(struct device *dev)
+static int __maybe_unused vic_runtime_resume(struct device *dev)
 {
 	struct vic *vic = dev_get_drvdata(dev);
 	int err;
@@ -323,7 +323,7 @@ static int vic_runtime_resume(struct device *dev)
 	return err;
 }
 
-static int vic_runtime_suspend(struct device *dev)
+static int __maybe_unused vic_runtime_suspend(struct device *dev)
 {
 	struct vic *vic = dev_get_drvdata(dev);
 	int err;
-- 
2.17.1

