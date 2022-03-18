Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5AF4DD342
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiCRCvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiCRCu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:50:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AC0B919A;
        Thu, 17 Mar 2022 19:49:41 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KKT2J5rH4z921w;
        Fri, 18 Mar 2022 10:47:36 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 10:49:39 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 10:49:38 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <liwei391@huawei.com>,
        <bobo.shaobowang@huawei.com>, <antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/2] iio:filter:admv8818: Fix missing clk_disable_unprepare() in admv8818_clk_setup
Date:   Fri, 18 Mar 2022 10:59:14 +0800
Message-ID: <20220318025914.2614812-3-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318025914.2614812-1-bobo.shaobowang@huawei.com>
References: <20220318025914.2614812-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missing clk_disable_unprepare() before return from admv8818_clk_setup
in the error handling cases.

Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/iio/filter/admv8818.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 68de45fe21b4..acb436efd8b5 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -590,14 +590,22 @@ static int admv8818_clk_setup(struct admv8818_state *st)
 
 	ret = devm_add_action_or_reset(&spi->dev, admv8818_clk_disable, st);
 	if (ret)
-		return ret;
+		goto out_clk_disable;
 
 	st->nb.notifier_call = admv8818_freq_change;
 	ret = clk_notifier_register(st->clkin, &st->nb);
 	if (ret < 0)
-		return ret;
+		goto out_clk_disable;
+
+	ret = devm_add_action_or_reset(&spi->dev, admv8818_clk_notifier_unreg, st);
+	if (ret)
+		goto out_clk_disable;
+
+	return 0;
 
-	return devm_add_action_or_reset(&spi->dev, admv8818_clk_notifier_unreg, st);
+out_clk_disable:
+	clk_disable_unprepare(st->clkin);
+	return ret;
 }
 
 static int admv8818_probe(struct spi_device *spi)
-- 
2.25.1

