Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2567E5AFC47
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIGGSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiIGGSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:18:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A7999269
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:18:32 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMsRP4wGMzkYCn;
        Wed,  7 Sep 2022 14:14:41 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 14:18:30 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 7 Sep
 2022 14:18:29 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>, <olof@lixom.net>,
        <pavel@ucw.cz>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <chenlifu@huawei.com>
Subject: [PATCH -next] ARM: mmp: Add missing clk_disable_unprepare() in mmp_dt_init_timer()
Date:   Wed, 7 Sep 2022 14:14:54 +0800
Message-ID: <20220907061454.3800923-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmp_dt_init_timer() may have called clk_prepare_enable() before return
from failed branches, add missing clk_disable_unprepare() in these cases.

Fixes: f36797ee4380 ("ARM: mmp/mmp2: dt: enable the clock")
Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 arch/arm/mach-mmp/time.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 41b2e8abc9e6..6d2db1fea1be 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -207,16 +207,20 @@ static int __init mmp_dt_init_timer(struct device_node *np)
 	} else {
 		rate = 3250000;
 	}
 
 	irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
+	if (!irq) {
+		clk_disable_unprepare(clk);
 		return -EINVAL;
+	}
 
 	mmp_timer_base = of_iomap(np, 0);
-	if (!mmp_timer_base)
+	if (!mmp_timer_base) {
+		clk_disable_unprepare(clk);
 		return -ENOMEM;
+	}
 
 	mmp_timer_init(irq, rate);
 	return 0;
 }
 
-- 
2.37.1

