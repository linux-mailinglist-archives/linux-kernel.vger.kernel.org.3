Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324E049E1A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbiA0Lxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:53:31 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:32067 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbiA0Lxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:53:30 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JkzQj19W6z1FD0P;
        Thu, 27 Jan 2022 19:49:33 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 19:53:28 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 27 Jan
 2022 19:53:28 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     <p.zabel@pengutronix.de>, <broonie@kernel.org>,
        <lhjeff911@gmail.com>
Subject: [PATCH -next] spi: Fix missing unlock on error in sp7021_spi_master_transfer_one()
Date:   Thu, 27 Jan 2022 19:58:15 +0800
Message-ID: <20220127115815.3148950-1-yangyingliang@huawei.com>
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

Add the missing unlock before return from sp7021_spi_master_transfer_one()
in the error handling case.

Fixes: f62ca4e2a863 ("spi: Add spi driver for Sunplus SP7021")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-sunplus-sp7021.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index 627b9c3024e9..cbbb1664017e 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -351,6 +351,7 @@ static int sp7021_spi_master_transfer_one(struct spi_controller *ctlr, struct sp
 
 		if (!wait_for_completion_interruptible_timeout(&pspim->isr_done, timeout)) {
 			dev_err(&spi->dev, "wait_for_completion err\n");
+			mutex_unlock(&pspim->buf_lock);
 			return -ETIMEDOUT;
 		}
 
-- 
2.25.1

