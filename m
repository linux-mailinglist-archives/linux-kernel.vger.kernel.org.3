Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7756486129
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 08:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiAFHvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 02:51:44 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30258 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiAFHvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 02:51:43 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JTz7G5m9Hzbhxp;
        Thu,  6 Jan 2022 15:51:06 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 15:51:41 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 6 Jan
 2022 15:51:41 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>
CC:     <vincent.sunplus@gmail.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>
Subject: [PATCH -next] rtc: rtc-sunplus: fix return value in sp_rtc_probe()
Date:   Thu, 6 Jan 2022 15:57:11 +0800
Message-ID: <20220106075711.3216468-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_ioremap_resource() fails, it should return error
code from sp_rtc->reg_base in sp_rtc_probe().

Fixes: fad6cbe9b2b4 ("rtc: Add driver for RTC in Sunplus SP7021")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/rtc/rtc-sunplus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sunplus.c b/drivers/rtc/rtc-sunplus.c
index 0b3873204f5c..e8e2ab1103fc 100644
--- a/drivers/rtc/rtc-sunplus.c
+++ b/drivers/rtc/rtc-sunplus.c
@@ -238,7 +238,7 @@ static int sp_rtc_probe(struct platform_device *plat_dev)
 	sp_rtc->res = platform_get_resource_byname(plat_dev, IORESOURCE_MEM, RTC_REG_NAME);
 	sp_rtc->reg_base = devm_ioremap_resource(&plat_dev->dev, sp_rtc->res);
 	if (IS_ERR(sp_rtc->reg_base))
-		return dev_err_probe(&plat_dev->dev, PTR_ERR(sp_rtc->res),
+		return dev_err_probe(&plat_dev->dev, PTR_ERR(sp_rtc->reg_base),
 					    "%s devm_ioremap_resource fail\n", RTC_REG_NAME);
 	dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",
 		sp_rtc->res->start, (unsigned long)sp_rtc->reg_base);
-- 
2.25.1

