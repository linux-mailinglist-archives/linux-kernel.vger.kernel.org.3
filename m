Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B9A553FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355409AbiFVBQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiFVBQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:16:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D331431513
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 18:16:31 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LSQRT21M1zkWbq;
        Wed, 22 Jun 2022 09:15:17 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 09:16:29 +0800
Received: from zelda.huawei.com (10.175.103.14) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 09:16:28 +0800
From:   Jin Xiaoyun <jinxiaoyun2@huawei.com>
To:     <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <khilman@baylibre.com>,
        <zhengbin13@huawei.com>, <gaochao49@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Jin Xiaoyun" <jinxiaoyun2@huawei.com>
Subject: [PATCH -next] soc: mediatek: SVS: Make svs_resume and svs_suspend defined when CONFIG_PM_SLEEP is y
Date:   Wed, 22 Jun 2022 09:34:10 +0800
Message-ID: <20220622013410.2786760-1-jinxiaoyun2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

The svs_resume and svs_suspend is defined through SIMPLE_DEV_PM_OPS. If CONFIG_PM_SLEEP
is not defined, SIMPLE_DEV_PM_OPS is equivalent to an empty function. In this case,
the defination of svs_resume and svs_suspend is meaningless.

Fix build error:
drivers/soc/mediatek/mtk-svs.c:1515:12: error: ‘svs_resume’ defined but not used [-Werror=unused-function]
drivers/soc/mediatek/mtk-svs.c:1481:12: error: ‘svs_suspend’ defined but not used [-Werror=unused-function]

Signed-off-by: Jin Xiaoyun <jinxiaoyun2@huawei.com>
---
 drivers/soc/mediatek/mtk-svs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 606a00a2e57d..8440058784dc 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1478,6 +1478,7 @@ static int svs_start(struct svs_platform *svsp)
 	return 0;
 }

+#ifdef CONFIG_PM_SLEEP
 static int svs_suspend(struct device *dev)
 {
 	struct svs_platform *svsp = dev_get_drvdata(dev);
@@ -1537,6 +1538,7 @@ static int svs_resume(struct device *dev)

 	return 0;
 }
+#endif

 static int svs_bank_resource_setup(struct svs_platform *svsp)
 {
--
2.25.1

