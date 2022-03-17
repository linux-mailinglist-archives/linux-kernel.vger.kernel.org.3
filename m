Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD1C4DBF9C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiCQGrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiCQGrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:47:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9C4E1B53
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 23:46:26 -0700 (PDT)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KJyLc0p2yzfYsK;
        Thu, 17 Mar 2022 14:44:56 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.21; Thu, 17
 Mar 2022 14:46:24 +0800
From:   Lu Wei <luwei32@huawei.com>
To:     <thierry.reding@gmail.com>, <sam@ravnborg.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/panel: Fix return value check in nt35950_probe()
Date:   Thu, 17 Mar 2022 14:49:42 +0800
Message-ID: <20220317064942.156205-1-luwei32@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function nt35950_probe(), mipi_dsi_device_register_full() is called
to create a MIPI DSI device. If it fails, a pointer encoded with an error
will be returned, so use IS_ERR() to check the return value. Besides, use
PTR_ERR to return the actual errno.

Signed-off-by: Lu Wei <luwei32@huawei.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index 288c7fa83ecc..d252e5e56228 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -579,9 +579,9 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 		}
 
 		nt->dsi[1] = mipi_dsi_device_register_full(dsi_r_host, info);
-		if (!nt->dsi[1]) {
+		if (IS_ERR(nt->dsi[1])) {
 			dev_err(dev, "Cannot get secondary DSI node\n");
-			return -ENODEV;
+			return PTR_ERR(nt->dsi[1]);
 		}
 		num_dsis++;
 	}
-- 
2.17.1

