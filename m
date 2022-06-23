Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B1557131
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377899AbiFWCws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377757AbiFWCwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:52:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA7443488
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:52:06 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LT4VD4hzZz1KC7y;
        Thu, 23 Jun 2022 10:49:56 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 10:52:04 +0800
Received: from zelda.huawei.com (10.175.103.14) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 10:52:03 +0800
From:   Jin Xiaoyun <jinxiaoyun2@huawei.com>
To:     <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <khilman@baylibre.com>,
        <zhengbin13@huawei.com>, <gaochao49@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Jin Xiaoyun" <jinxiaoyun2@huawei.com>
Subject: [PATCH v2 -next] soc: mediatek: SVS: Use the new PM macros
Date:   Thu, 23 Jun 2022 11:09:31 +0800
Message-ID: <20220623030931.2816013-1-jinxiaoyun2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220622013410.2786760-1-jinxiaoyun2@huawei.com>
References: <20220622013410.2786760-1-jinxiaoyun2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SIMPLE_DEV_PM_OPS() instead of the SIMPLE_DEV_PM_OPS()
macro, along with using pm_sleep_ptr() as this driver doesn't handle
runtime PM.

Fix build error:
drivers/soc/mediatek/mtk-svs.c:1515:12: error: ‘svs_resume’ defined but not used [-Werror=unused-function]
drivers/soc/mediatek/mtk-svs.c:1481:12: error: ‘svs_suspend’ defined but not used [-Werror=unused-function]

Signed-off-by: Jin Xiaoyun <jinxiaoyun2@huawei.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
v1->v2:
- Remove the #ifdef CONFIG_PM guard around the suspend/resume functions
- Use DEFINE_SIMPLE_DEV_PM_OPS along with using pm_sleep_ptr()
---
 drivers/soc/mediatek/mtk-svs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 606a00a2e57d..fae7376bd083 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2381,13 +2381,13 @@ static int svs_probe(struct platform_device *pdev)
 	return ret;
 }

-static SIMPLE_DEV_PM_OPS(svs_pm_ops, svs_suspend, svs_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(svs_pm_ops, svs_suspend, svs_resume);

 static struct platform_driver svs_driver = {
 	.probe	= svs_probe,
 	.driver	= {
 		.name		= "mtk-svs",
-		.pm		= &svs_pm_ops,
+		.pm		= pm_sleep_ptr(&svs_pm_ops),
 		.of_match_table	= of_match_ptr(svs_of_match),
 	},
 };
--
2.25.1

