Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1E484273
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiADN25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:28:57 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17324 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiADN2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:28:55 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JSthm4g5Jz9s3P;
        Tue,  4 Jan 2022 21:27:52 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 21:28:54 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 4 Jan
 2022 21:28:53 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>
CC:     <tsbogend@alpha.franken.de>, <zhangqing@loongson.cn>
Subject: [PATCH -next] MIPS: Loongson64: Add missing of_node_put() in ls2k_reset_init()
Date:   Tue, 4 Jan 2022 21:34:15 +0800
Message-ID: <20220104133415.805209-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This node pointer is returned by of_find_compatible_node() with
refcount incremented in ls2k_reset_init(). Calling of_node_put()
to aovid the refcount leak.

Fixes: 7eb7819a2e12 ("MIPS: Loongson64: Add Loongson-2K1000 reset platform driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/platform/mips/ls2k-reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mips/ls2k-reset.c b/drivers/platform/mips/ls2k-reset.c
index b70e7b8a092c..8f42d5d16480 100644
--- a/drivers/platform/mips/ls2k-reset.c
+++ b/drivers/platform/mips/ls2k-reset.c
@@ -38,6 +38,7 @@ static int ls2k_reset_init(void)
 	}
 
 	base = of_iomap(np, 0);
+	of_node_put(np);
 	if (!base) {
 		pr_info("Failed to map PM register base address\n");
 		return -ENOMEM;
@@ -46,7 +47,6 @@ static int ls2k_reset_init(void)
 	_machine_restart = ls2k_restart;
 	pm_power_off = ls2k_poweroff;
 
-	of_node_put(np);
 	return 0;
 }
 
-- 
2.25.1

