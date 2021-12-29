Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5FD480EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 03:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbhL2CiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 21:38:22 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:55848 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229620AbhL2CiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 21:38:21 -0500
X-UUID: bd344db2d63d438e9d36202654b4aaca-20211229
X-UUID: bd344db2d63d438e9d36202654b4aaca-20211229
X-User: wenzhiwei@kylinos.cn
Received: from localhost.localdomain.localdomain [(172.17.127.26)] by nksmu.kylinos.cn
        (envelope-from <wenzhiwei@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1198162419; Wed, 29 Dec 2021 10:50:48 +0800
From:   Wen Zhiwei <wenzhiwei@kylinos.cn>
To:     jh80.chung@samsung.com, ulf.hansson@linaro.org,
        p.zabel@pengutronix.de, wenzhiwei@kylinos.cn
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc: Fix potential null pointer risk
Date:   Wed, 29 Dec 2021 10:38:14 +0800
Message-Id: <20211229023814.53372-1-wenzhiwei@kylinos.cn>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we previously assumed 'host->slot' could be null,
null pointer judgment should be added

Signed-off-by: Wen Zhiwei <wenzhiwei@kylinos.cn>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d977f34f6b55..c9dc8c168efb 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3518,7 +3518,7 @@ int dw_mci_runtime_resume(struct device *dev)
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
 
-	if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
+	if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
 		dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
 
 	/* Force setup bus to guarantee available clock output */
-- 
2.30.0

