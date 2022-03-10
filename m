Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0D14D416A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 07:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbiCJG4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 01:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbiCJG4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:56:42 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4D512F146
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:55:41 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KDfqx2c5yz9sZt;
        Thu, 10 Mar 2022 14:51:57 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 10 Mar
 2022 14:55:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <bbhushan2@marvell.com>,
        <bbudiredla@marvell.com>, <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] perf/marvell: cn10k Fix build error without CONFIG_OF
Date:   Thu, 10 Mar 2022 14:50:45 +0800
Message-ID: <20220310065045.24772-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/perf/marvell_cn10k_ddr_pmu.c:723:21: error: ‘cn10k_ddr_pmu_of_match’ undeclared here (not in a function); did you mean ‘cn10k_ddr_pmu_driver’?
    	 .of_match_table = cn10k_ddr_pmu_of_match,
      	                   ^~~~~~~~~~~~~~~~~~~~~~

Remove the #ifdef around the match table, because CONFIG_OF is always enabled on arm64.

Fixes: 7cf83e222bce ("perf/marvell: CN10k DDR performance monitor support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: Remove the #ifdef macro as Arnd suggested
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 7f3146e71f99..bef0cee3a46a 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -709,13 +709,11 @@ static int cn10k_ddr_perf_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id cn10k_ddr_pmu_of_match[] = {
 	{ .compatible = "marvell,cn10k-ddr-pmu", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
-#endif
 
 static struct platform_driver cn10k_ddr_pmu_driver = {
 	.driver	= {
-- 
2.17.1

