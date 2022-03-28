Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF874E95BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbiC1LxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242493AbiC1Lne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:43:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE119275C6;
        Mon, 28 Mar 2022 04:38:31 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KRrJ55RMMzfZWN;
        Mon, 28 Mar 2022 19:36:37 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Mar 2022 19:38:14 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 28 Mar
 2022 19:38:14 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <liwei391@huawei.com>, <cj.chengjian@huawei.com>,
        <bobo.shaobowang@huawei.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <s.nawrocki@samsung.com>,
        <mchehab@kernel.org>, <krzk@kernel.org>
Subject: [PATCH -next] media: platform: change clk_disable to clk_disable_unprepare
Date:   Mon, 28 Mar 2022 19:47:30 +0800
Message-ID: <20220328114730.3944817-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corresponding API pairs with clk_prepare_enable in fimc_is_enable_clocks()
is clk_disable_unprepare, fix this by changing clk_disable to
clk_disable_unprepare.

Fixes: 9a761e436843 ("[media] exynos4-is: Add Exynos4x12 FIMC-IS driver")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/media/platform/samsung/exynos4-is/fimc-is.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-is.c b/drivers/media/platform/samsung/exynos4-is/fimc-is.c
index e55e411038f4..8e88b0f6662d 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-is.c
@@ -140,7 +140,7 @@ static int fimc_is_enable_clocks(struct fimc_is *is)
 			dev_err(&is->pdev->dev, "clock %s enable failed\n",
 				fimc_is_clocks[i]);
 			for (--i; i >= 0; i--)
-				clk_disable(is->clocks[i]);
+				clk_disable_unprepare(is->clocks[i]);
 			return ret;
 		}
 		pr_debug("enabled clock: %s\n", fimc_is_clocks[i]);
-- 
2.25.1

