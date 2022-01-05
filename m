Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36B248585C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242985AbiAESbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:31:45 -0500
Received: from aposti.net ([89.234.176.197]:41922 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243023AbiAESbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:31:17 -0500
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
Subject: [PATCH v2 6/6] iio: pressure: bmp280: Use new PM macros
Date:   Wed,  5 Jan 2022 18:29:39 +0000
Message-Id: <20220105182939.106885-7-paul@crapouillou.net>
In-Reply-To: <20220105182939.106885-1-paul@crapouillou.net>
References: <20220105182939.106885-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new EXPORT_RUNTIME_DEV_PM_OPS() macro. It allows the underlying
dev_pm_ops struct as well as the suspend/resume callbacks to be detected
as dead code in the case where CONFIG_PM is disabled, without having to
wrap everything inside #ifdef CONFIG_PM guards.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch

 drivers/iio/pressure/bmp280-core.c | 11 ++---------
 drivers/iio/pressure/bmp280-i2c.c  |  2 +-
 drivers/iio/pressure/bmp280-spi.c  |  2 +-
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6b7da40f99c8..bf8167f43c56 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1138,7 +1138,6 @@ int bmp280_common_probe(struct device *dev,
 }
 EXPORT_SYMBOL(bmp280_common_probe);
 
-#ifdef CONFIG_PM
 static int bmp280_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -1159,15 +1158,9 @@ static int bmp280_runtime_resume(struct device *dev)
 	usleep_range(data->start_up_time, data->start_up_time + 100);
 	return data->chip_info->chip_config(data);
 }
-#endif /* CONFIG_PM */
 
-const struct dev_pm_ops bmp280_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(bmp280_runtime_suspend,
-			   bmp280_runtime_resume, NULL)
-};
-EXPORT_SYMBOL(bmp280_dev_pm_ops);
+EXPORT_RUNTIME_DEV_PM_OPS(bmp280_dev_pm_ops, bmp280_runtime_suspend,
+			  bmp280_runtime_resume, NULL);
 
 MODULE_AUTHOR("Vlad Dogaru <vlad.dogaru@intel.com>");
 MODULE_DESCRIPTION("Driver for Bosch Sensortec BMP180/BMP280 pressure and temperature sensor");
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 8b03ea15c0d0..35045bd92846 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -58,7 +58,7 @@ static struct i2c_driver bmp280_i2c_driver = {
 	.driver = {
 		.name	= "bmp280",
 		.of_match_table = bmp280_of_i2c_match,
-		.pm = &bmp280_dev_pm_ops,
+		.pm = pm_ptr(&bmp280_dev_pm_ops),
 	},
 	.probe		= bmp280_i2c_probe,
 	.id_table	= bmp280_i2c_id,
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 625b86878ad8..41f6cc56d229 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -109,7 +109,7 @@ static struct spi_driver bmp280_spi_driver = {
 	.driver = {
 		.name = "bmp280",
 		.of_match_table = bmp280_of_spi_match,
-		.pm = &bmp280_dev_pm_ops,
+		.pm = pm_ptr(&bmp280_dev_pm_ops),
 	},
 	.id_table = bmp280_spi_id,
 	.probe = bmp280_spi_probe,
-- 
2.34.1

