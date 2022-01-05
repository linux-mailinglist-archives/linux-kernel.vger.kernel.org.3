Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949E6485841
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242978AbiAESaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:30:24 -0500
Received: from aposti.net ([89.234.176.197]:41698 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242945AbiAESaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:30:05 -0500
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
        linux-pm@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 2/6] PM: core: Remove static qualifier in DEFINE_SIMPLE_DEV_PM_OPS macro
Date:   Wed,  5 Jan 2022 18:29:35 +0000
Message-Id: <20220105182939.106885-3-paul@crapouillou.net>
In-Reply-To: <20220105182939.106885-1-paul@crapouillou.net>
References: <20220105182939.106885-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep this macro in line with the other ones. This makes it possible to
use them in the cases where the underlying dev_pm_ops structure is
exported.

Restore the "static" qualifier in the two drivers where the
DEFINE_SIMPLE_DEV_PM_OPS macro was used.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

Notes:
    v2: Merge the driver changes to make the commit atomic

 drivers/mmc/host/jz4740_mmc.c | 4 ++--
 drivers/mmc/host/mxcmmc.c     | 2 +-
 include/linux/pm.h            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 7693236c946f..7ab1b38a7be5 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1128,8 +1128,8 @@ static int jz4740_mmc_resume(struct device *dev)
 	return pinctrl_select_default_state(dev);
 }
 
-DEFINE_SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
-	jz4740_mmc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
+				jz4740_mmc_resume);
 
 static struct platform_driver jz4740_mmc_driver = {
 	.probe = jz4740_mmc_probe,
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
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 31bbaafb06d2..389e600df233 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -362,7 +362,7 @@ struct dev_pm_ops {
  * to RAM and hibernation.
  */
 #define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-static const struct dev_pm_ops name = { \
+const struct dev_pm_ops name = { \
 	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 }
 
-- 
2.34.1

