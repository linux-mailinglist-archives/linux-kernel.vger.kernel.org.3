Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C7551D383
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390202AbiEFIld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390187AbiEFIl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:41:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9051E3B7;
        Fri,  6 May 2022 01:37:41 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KvkSP6TxHzhYtX;
        Fri,  6 May 2022 16:36:37 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 16:37:09 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 16:37:09 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <dipenp@nvidia.com>
Subject: [PATCH -next] hte: fix possible use-after-free in tegra_hte_test_remove()
Date:   Fri, 6 May 2022 16:48:51 +0800
Message-ID: <20220506084851.3503635-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

del_timer() does not wait until the timer handler finishing.
This means that the timer handler may still be running after
the driver's remove function has finished, which would result
in a use-after-free.
Fix it by calling del_timer_sync(), which makes sure the timer
handler has finished.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/hte/hte-tegra194-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
index bc3ab18dfdc5..f69a274a7d8d 100644
--- a/drivers/hte/hte-tegra194-test.c
+++ b/drivers/hte/hte-tegra194-test.c
@@ -220,7 +220,7 @@ static int tegra_hte_test_remove(struct platform_device *pdev)
 	free_irq(hte.gpio_in_irq, &hte);
 	gpiod_put(hte.gpio_in);
 	gpiod_put(hte.gpio_out);
-	del_timer(&hte.timer);
+	del_timer_sync(&hte.timer);
 
 	return 0;
 }
-- 
2.25.1

