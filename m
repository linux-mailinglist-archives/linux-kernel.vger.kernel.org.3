Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EED57A11B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbiGSOSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238325AbiGSOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:18:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F7B499
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:53:57 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LnKxC5bM6z1M7vb;
        Tue, 19 Jul 2022 21:51:11 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 21:53:54 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 21:53:54 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <dinguyen@kernel.org>
Subject: [PATCH -next 2/3] firmware: stratix10-svc: fix memory leak when platform_device_alloc/add() fails
Date:   Tue, 19 Jul 2022 22:02:56 +0800
Message-ID: <20220719140257.3499657-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719140257.3499657-1-yangyingliang@huawei.com>
References: <20220719140257.3499657-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If platform_device_alloc/add() failed in stratix10_svc_drv_probe(),
'svc_fifo' and 'genpool' should be freed.

Fixes: e6281c26674e ("firmware: stratix10-svc: Add support for FCS")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/firmware/stratix10-svc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 1a5640b3ab42..cb824f63faa8 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1202,19 +1202,20 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	ret = platform_device_add(svc->stratix10_svc_rsu);
 	if (ret) {
 		platform_device_put(svc->stratix10_svc_rsu);
-		return ret;
+		goto err_free_kfifo;
 	}
 
 	svc->intel_svc_fcs = platform_device_alloc(INTEL_FCS, 1);
 	if (!svc->intel_svc_fcs) {
 		dev_err(dev, "failed to allocate %s device\n", INTEL_FCS);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_free_kfifo;
 	}
 
 	ret = platform_device_add(svc->intel_svc_fcs);
 	if (ret) {
 		platform_device_put(svc->intel_svc_fcs);
-		return ret;
+		goto err_free_kfifo;
 	}
 
 	dev_set_drvdata(dev, svc);
-- 
2.25.1

