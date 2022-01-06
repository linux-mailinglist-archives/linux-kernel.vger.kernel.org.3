Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC9B486121
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 08:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiAFHtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 02:49:22 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34880 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbiAFHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 02:49:21 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JTz4Y2tM2zcbq2;
        Thu,  6 Jan 2022 15:48:45 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 15:49:19 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 6 Jan
 2022 15:49:19 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <yu.c.chen@intel.com>
Subject: [PATCH -next] ACPI: pfr_update: Fix return value check in pfru_write()
Date:   Thu, 6 Jan 2022 15:54:48 +0800
Message-ID: <20220106075448.3215141-1-yangyingliang@huawei.com>
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

In case of error, memremap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update device driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/acpi/pfr_update.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 149b5b2530b9..6bb0b778b5da 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -460,8 +460,8 @@ static ssize_t pfru_write(struct file *file, const char __user *buf,
 	/* map the communication buffer */
 	phy_addr = (phys_addr_t)((buf_info.addr_hi << 32) | buf_info.addr_lo);
 	buf_ptr = memremap(phy_addr, buf_info.buf_size, MEMREMAP_WB);
-	if (IS_ERR(buf_ptr))
-		return PTR_ERR(buf_ptr);
+	if (!buf_ptr)
+		return -ENOMEM;
 
 	if (!copy_from_iter_full(buf_ptr, len, &iter)) {
 		ret = -EINVAL;
-- 
2.25.1

