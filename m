Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527925732D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbiGMJcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiGMJc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:32:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EADEF6BB5;
        Wed, 13 Jul 2022 02:31:05 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LjXPH6T39zkWrM;
        Wed, 13 Jul 2022 17:28:51 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 17:31:03 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Jul
 2022 17:31:03 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <broonie@kernel.org>, <digetx@gmail.com>
Subject: [PATCH] spi: tegra20-slink: fix UAF in tegra_slink_remove()
Date:   Wed, 13 Jul 2022 17:40:23 +0800
Message-ID: <20220713094024.1508869-1-yangyingliang@huawei.com>
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

After calling spi_unregister_master(), the refcount of master will
be decrease to 0, and it will be freed in spi_controller_release(),
the device data also will be freed, so it will lead a UAF when using
'tspi'. To fix this, get the master before unregister and put it when
finish using it.

Fixes: 26c863418221 ("spi: tegra20-slink: Don't use resource-managed spi_register helper")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-tegra20-slink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 38360434d6e9..148043d0c2b8 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1136,7 +1136,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
 
 static int tegra_slink_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct tegra_slink_data	*tspi = spi_master_get_devdata(master);
 
 	spi_unregister_master(master);
@@ -1151,6 +1151,7 @@ static int tegra_slink_remove(struct platform_device *pdev)
 	if (tspi->rx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, true);
 
+	spi_master_put(master);
 	return 0;
 }
 
-- 
2.25.1

