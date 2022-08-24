Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B28959F631
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiHXJ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiHXJ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:29:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFAB844CA;
        Wed, 24 Aug 2022 02:29:22 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MCLLk3lYZzQwNg;
        Wed, 24 Aug 2022 17:26:06 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 17:29:20 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 17:29:20 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-parisc@vger.kernel.org>
CC:     <liqiong@nfschina.com>, <deller@gmx.de>
Subject: [PATCH -next] parisc: ccio-dma: Add missing iounmap in error path in ccio_probe()
Date:   Wed, 24 Aug 2022 17:36:57 +0800
Message-ID: <20220824093657.3365027-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing iounmap() before return from ccio_probe(), if ccio_init_resources()
fails.

Fixes: d46c742f827f ("parisc: ccio-dma: Handle kmalloc failure in ccio_init_resources()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/parisc/ccio-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index f223afe47d10..a66386043aa6 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -1546,6 +1546,7 @@ static int __init ccio_probe(struct parisc_device *dev)
 	}
 	ccio_ioc_init(ioc);
 	if (ccio_init_resources(ioc)) {
+		iounmap(ioc->ioc_regs);
 		kfree(ioc);
 		return -ENOMEM;
 	}
-- 
2.25.1

