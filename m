Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23F6484A28
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiADVnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:43:14 -0500
Received: from aposti.net ([89.234.176.197]:52174 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234908AbiADVnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:43:12 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 6/8] mmc: mxc: Make dev_pm_ops struct static
Date:   Tue,  4 Jan 2022 21:42:12 +0000
Message-Id: <20220104214214.198843-7-paul@crapouillou.net>
In-Reply-To: <20220104214214.198843-1-paul@crapouillou.net>
References: <20220104214214.198843-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new DEFINE_SIMPLE_DEV_PM_OPS() macro does not set the "static"
qualifier anymore, so we can add it here, as the underlying dev_pm_ops
struct is only used in this file.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mmc/host/mxcmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 98c218bd6669..40b6878bea6c 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1210,7 +1210,7 @@ static int mxcmci_resume(struct device *dev)
 	return ret;
 }
 
-DEFINE_SIMPLE_DEV_PM_OPS(mxcmci_pm_ops, mxcmci_suspend, mxcmci_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(mxcmci_pm_ops, mxcmci_suspend, mxcmci_resume);
 
 static struct platform_driver mxcmci_driver = {
 	.probe		= mxcmci_probe,
-- 
2.34.1

