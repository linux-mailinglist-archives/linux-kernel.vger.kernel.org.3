Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93964532112
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiEXClS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiEXClO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:41:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA8FD100
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:41:13 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L6dht0mTlzjWyy;
        Tue, 24 May 2022 10:40:14 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 10:41:11 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 10:41:11 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] amba: fix refcount underflow if amba_device_add() fails
Date:   Tue, 24 May 2022 10:51:39 +0800
Message-ID: <20220524025139.40212-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"ARM: 9192/1: amba: fix memory leak in amba_device_try_add()" leads
to a refcount underflow if amba_device_add() fails, which called by
of_amba_device_create(), the of_amba_device_create() already exists
the error handling, so amba_put_device() only need to be added into
amba_deferred_retry().

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/amba/bus.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 0e3ed5eb367b..0cb20324da16 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -493,13 +493,8 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 		goto skip_probe;
 
 	ret = amba_read_periphid(dev);
-	if (ret) {
-		if (ret != -EPROBE_DEFER) {
-			amba_device_put(dev);
-			goto err_out;
-		}
+	if (ret)
 		goto err_release;
-	}
 
 skip_probe:
 	ret = device_add(&dev->dev);
@@ -546,6 +541,7 @@ static int amba_deferred_retry(void)
 			continue;
 
 		list_del_init(&ddev->node);
+		amba_device_put(ddev->dev);
 		kfree(ddev);
 	}
 
-- 
2.35.3

