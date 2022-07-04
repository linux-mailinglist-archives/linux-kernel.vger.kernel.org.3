Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A21564BDF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiGDCub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGDCu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:50:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B3E2ADA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 19:50:26 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lbqvb13Y4zTgSg;
        Mon,  4 Jul 2022 10:46:51 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Jul
 2022 10:50:22 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <yuancan@huawei.com>
Subject: [PATCH -next] mfd: tc6393xb: Add missing clk_disable_unprepare() in tc6393xb_resume()
Date:   Mon, 4 Jul 2022 02:48:22 +0000
Message-ID: <20220704024822.70716-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clk_disable_unprepare() on error path in tc6393xb_resume().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/mfd/tc6393xb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index 0be5731685b4..1f1aa76292d2 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -850,8 +850,10 @@ static int tc6393xb_resume(struct platform_device *dev)
 		return ret;
 
 	ret = tcpd->resume(dev);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(tc6393xb->clk);
 		return ret;
+	}
 
 	if (!tcpd->resume_restore)
 		return 0;
-- 
2.17.1

