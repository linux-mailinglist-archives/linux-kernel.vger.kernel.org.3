Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9772654713C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 04:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347609AbiFKCQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 22:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244605AbiFKCQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 22:16:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7572FE60E;
        Fri, 10 Jun 2022 19:16:50 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LKhHw0qD0zjX7G;
        Sat, 11 Jun 2022 10:15:24 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 11 Jun
 2022 10:16:47 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <lewis.hanly@microchip.com>, <conor.dooley@microchip.com>,
        <broonie@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liwei391@huawei.com>,
        <wupeng58@huawei.com>
Subject: [PATCH] spi: micro: fix unreasonable clk_prepare_enable() on error in mchp_corespi_probe()
Date:   Sat, 11 Jun 2022 02:11:17 +0000
Message-ID: <20220611021117.40494-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the unreasonable clk_prepare_enable() with clk_disable_unprepare()
before return from mchp_corespi_probe() in the error handling case.

Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
 drivers/spi/spi-microchip-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 5b2aee30fa04..bf6847d95fe3 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -580,7 +580,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 
 error_release_hardware:
 	mchp_corespi_disable(spi);
-	clk_prepare_enable(spi->clk);
+	clk_disable_unprepare(spi->clk);
 error_release_master:
 	spi_master_put(master);
 
-- 
2.17.1

