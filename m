Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8884810AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 08:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbhL2HaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 02:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbhL2H3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:29:45 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94045C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 23:29:44 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g11so46363683lfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 23:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgBTf5plP79VIndWD6ZWEfv0rRM/la1tNQapTNXhPKo=;
        b=cnnvo1RqsljWunkdDBG68I94j1wpuCMp58WtZLGI2Nnr93XkLwB2JJMFzjC5A8Z7aP
         Ief7ceVlKYmKayk75coXmuAObTHHNL7nR4ZIBYH2/+Tqi6AM8laUNSmUjqXWn0/2zUWN
         ct+pc6Qf3Z2cd4AQxGXmBmqFCzQHz312vReIQNBwsITsOKh22Mc0KPWURRLcyzNxjDfZ
         LK3vIitV/ntL8k6NqrWs7sQysfuln53TiAoux/cadnFTtaGJ3Cua6KAOyzcLj5TLbqXZ
         pnTosOYGLMF6NSYHWNXpRa6wl4qrMyjWGKi9GzEIeTV7jCR5q61HP2jf3+yHCsoM/1vf
         rs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgBTf5plP79VIndWD6ZWEfv0rRM/la1tNQapTNXhPKo=;
        b=GRKJFFKOU3HhLapHu29x8jX2KgsuP2EZHs6op/0hOPDxVS7cKbJLSSRnzFWoXUoym7
         8zatDb3FHjb5cnPUsgee+HUhDrFaTciqrop/XoBh6syBNQ+RmlcX8Y8W7Ho4hp9LNbUr
         wt1krOprlxrKnQLkpxeYyXT9qKkgM4aoeZon3PoEyGxbT5yvLK2WI8yXmwbCdgzh63M5
         h44T1JQKVd5YCW2vxYy1oa7cyRzdfv9llQYJpQxtNiF+Y4Zy6urmh7zexTfr9shikBpA
         64uyqGQf3WS/D/shhyo+7jsTDB90TPf5L2l2g9U0sehAbMlh2dhMW6RF7l9OmIC9xVJN
         lOIg==
X-Gm-Message-State: AOAM532R+RBQ5oLQ6P3IQf7vXuMgCHff2JmO6pydxqCua6UUpdtAv0w1
        xN4xh2P8BzHrpzPcvEWjW74RAg==
X-Google-Smtp-Source: ABdhPJxos3ulsfoxDrm8ESaxuI0eJO9PA2/9aHYB3gvdGvT30+VZ6o0Q2H/qQquzhHehRmFsM2rRLg==
X-Received: by 2002:a05:6512:1590:: with SMTP id bp16mr21848763lfb.407.1640762982294;
        Tue, 28 Dec 2021 23:29:42 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id p12sm1530218ljc.139.2021.12.28.23.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 23:29:41 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <caihuoqing@baidu.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] iio: stm: don't always auto-enable I2C and SPI interface drivers
Date:   Wed, 29 Dec 2021 10:29:16 +0300
Message-Id: <20211229072916.2567155-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes I2C and SPI interface drivers for STMicroelectronics
sensor chips individually selectable via Kconfig.

The default is kept unchanged - I2C and SPI interface drivers are still
selected by default if the corresponding bus support is available.

However, the patch makes it is possible to explicitly disable drivers
that are not needed for particular target.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/iio/accel/Kconfig             | 35 ++++++++++++++-----------
 drivers/iio/common/st_sensors/Kconfig |  2 --
 drivers/iio/gyro/Kconfig              | 37 ++++++++++++++++-----------
 drivers/iio/imu/st_lsm9ds0/Kconfig    | 28 +++++++++++++++-----
 drivers/iio/magnetometer/Kconfig      | 35 ++++++++++++++-----------
 drivers/iio/pressure/Kconfig          | 35 ++++++++++++++-----------
 6 files changed, 104 insertions(+), 68 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 49587c992a6d..fee33dda4ee4 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -349,8 +349,6 @@ config IIO_ST_ACCEL_3AXIS
 	depends on !SENSORS_LIS3_I2C
 	depends on !SENSORS_LIS3_SPI
 	select IIO_ST_SENSORS_CORE
-	select IIO_ST_ACCEL_I2C_3AXIS if (I2C)
-	select IIO_ST_ACCEL_SPI_3AXIS if (SPI_MASTER)
 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
 	help
 	  Say yes here to build support for STMicroelectronics accelerometers:
@@ -358,23 +356,30 @@ config IIO_ST_ACCEL_3AXIS
 	  LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12, H3LIS331DL,
 	  LNG2DM, LIS3DE, LIS2DE12, LIS2HH12
 
-	  This driver can also be built as a module. If so, these modules
-	  will be created:
-	  - st_accel (core functions for the driver [it is mandatory]);
-	  - st_accel_i2c (necessary for the I2C devices [optional*]);
-	  - st_accel_spi (necessary for the SPI devices [optional*]);
-
-	  (*) one of these is necessary to do something.
+	  Also need to enable at least one of I2C and SPI interface drivers
+	  below.
 
 config IIO_ST_ACCEL_I2C_3AXIS
-	tristate
-	depends on IIO_ST_ACCEL_3AXIS
-	depends on IIO_ST_SENSORS_I2C
+	tristate "STMicroelectronics accelerometers 3-Axis I2C Interface"
+	depends on (I2C && IIO_ST_ACCEL_3AXIS)
+	default y if (I2C && IIO_ST_ACCEL_3AXIS)
+	select IIO_ST_SENSORS_I2C
+	help
+	  Build support for STMicroelectronics accelerometers I2C interface.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called st_accel_i2c.
 
 config IIO_ST_ACCEL_SPI_3AXIS
-	tristate
-	depends on IIO_ST_ACCEL_3AXIS
-	depends on IIO_ST_SENSORS_SPI
+	tristate "STMicroelectronics accelerometers 3-Axis SPI Interface"
+	depends on (SPI_MASTER && IIO_ST_ACCEL_3AXIS)
+	default y if (SPI_MASTER && IIO_ST_ACCEL_3AXIS)
+	select IIO_ST_SENSORS_SPI
+	help
+	  Build support for STMicroelectronics accelerometers SPI interface.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called st_accel_spi.
 
 config KXSD9
 	tristate "Kionix KXSD9 Accelerometer Driver"
diff --git a/drivers/iio/common/st_sensors/Kconfig b/drivers/iio/common/st_sensors/Kconfig
index 9364ec7a811f..eda8f347fda5 100644
--- a/drivers/iio/common/st_sensors/Kconfig
+++ b/drivers/iio/common/st_sensors/Kconfig
@@ -13,5 +13,3 @@ config IIO_ST_SENSORS_SPI
 
 config IIO_ST_SENSORS_CORE
 	tristate
-	select IIO_ST_SENSORS_I2C if I2C
-	select IIO_ST_SENSORS_SPI if SPI_MASTER
diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index a672f7d12bbb..9af15bed7550 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -139,30 +139,37 @@ config IIO_ST_GYRO_3AXIS
 	tristate "STMicroelectronics gyroscopes 3-Axis Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
 	select IIO_ST_SENSORS_CORE
-	select IIO_ST_GYRO_I2C_3AXIS if (I2C)
-	select IIO_ST_GYRO_SPI_3AXIS if (SPI_MASTER)
 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
 	help
 	  Say yes here to build support for STMicroelectronics gyroscopes:
 	  L3G4200D, LSM330DL, L3GD20, LSM330DLC, L3G4IS, LSM330, LSM9DS0.
 
-	  This driver can also be built as a module. If so, these modules
-	  will be created:
-	  - st_gyro (core functions for the driver [it is mandatory]);
-	  - st_gyro_i2c (necessary for the I2C devices [optional*]);
-	  - st_gyro_spi (necessary for the SPI devices [optional*]);
-
-	  (*) one of these is necessary to do something.
+	  Also need to enable at least one of I2C and SPI interface drivers
+	  below.
 
 config IIO_ST_GYRO_I2C_3AXIS
-	tristate
-	depends on IIO_ST_GYRO_3AXIS
-	depends on IIO_ST_SENSORS_I2C
+	tristate "STMicroelectronics gyroscopes 3-Axis I2C Interface"
+	depends on (I2C && IIO_ST_GYRO_3AXIS)
+	default y if (I2C && IIO_ST_GYRO_3AXIS)
+	select IIO_ST_SENSORS_I2C
+	help
+	  Build support for STMicroelectronics gyroscopes I2C interface.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called st_gyro_i2c.
+
 
 config IIO_ST_GYRO_SPI_3AXIS
-	tristate
-	depends on IIO_ST_GYRO_3AXIS
-	depends on IIO_ST_SENSORS_SPI
+	tristate "STMicroelectronics gyroscopes 3-Axis SPI Interface"
+	depends on (SPI_MASTER && IIO_ST_GYRO_3AXIS)
+	default y if (SPI_MASTER && IIO_ST_GYRO_3AXIS)
+	select IIO_ST_SENSORS_SPI
+	help
+	  Build support for STMicroelectronics gyroscopes SPI interface.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called st_gyro_spi.
+
 
 config ITG3200
 	tristate "InvenSense ITG3200 Digital 3-Axis Gyroscope I2C driver"
diff --git a/drivers/iio/imu/st_lsm9ds0/Kconfig b/drivers/iio/imu/st_lsm9ds0/Kconfig
index 53b7017014f8..1f6e7365048a 100644
--- a/drivers/iio/imu/st_lsm9ds0/Kconfig
+++ b/drivers/iio/imu/st_lsm9ds0/Kconfig
@@ -5,8 +5,6 @@ config IIO_ST_LSM9DS0
 	depends on (I2C || SPI_MASTER) && SYSFS
 	depends on !SENSORS_LIS3_I2C
 	depends on !SENSORS_LIS3_SPI
-	select IIO_ST_LSM9DS0_I2C if I2C
-	select IIO_ST_LSM9DS0_SPI if SPI_MASTER
 	select IIO_ST_ACCEL_3AXIS
 	select IIO_ST_MAGN_3AXIS
 
@@ -17,12 +15,30 @@ config IIO_ST_LSM9DS0
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm9ds0.
 
+	  Also need to enable at least one of I2C and SPI interface drivers
+
 config IIO_ST_LSM9DS0_I2C
-	tristate
-	depends on IIO_ST_LSM9DS0
+	tristate "STMicroelectronics LSM9DS0 IMU I2C interface"
+	depends on (I2C && IIO_ST_LSM9DS0)
+	default y if (I2C && IIO_ST_LSM9DS0)
+	select IIO_ST_ACCEL_I2C_3AXIS
+	select IIO_ST_MAGN_I2C_3AXIS
 	select REGMAP_I2C
+	help
+	  Build support for STMicroelectronics LSM9DS0 IMU I2C interface.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called st_lsm9ds0_i2c.
 
 config IIO_ST_LSM9DS0_SPI
-	tristate
-	depends on IIO_ST_LSM9DS0
+	tristate "STMicroelectronics LSM9DS0 IMU SPI interface"
+	depends on (SPI_MASTER && IIO_ST_LSM9DS0)
+	default y if (SPI_MASTER && IIO_ST_LSM9DS0)
+	select IIO_ST_ACCEL_SPI_3AXIS
+	select IIO_ST_MAGN_SPI_3AXIS
 	select REGMAP_SPI
+	help
+	  Build support for STMicroelectronics LSM9DS0 IMU I2C interface.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called st_lsm9ds0_spi.
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 565ee41ccb3a..caec46b93564 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -117,30 +117,35 @@ config IIO_ST_MAGN_3AXIS
 	tristate "STMicroelectronics magnetometers 3-Axis Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
 	select IIO_ST_SENSORS_CORE
-	select IIO_ST_MAGN_I2C_3AXIS if (I2C)
-	select IIO_ST_MAGN_SPI_3AXIS if (SPI_MASTER)
 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
 	help
 	  Say yes here to build support for STMicroelectronics magnetometers:
 	  LSM303DLHC, LSM303DLM, LIS3MDL.
 
-	  This driver can also be built as a module. If so, these modules
-	  will be created:
-	  - st_magn (core functions for the driver [it is mandatory]);
-	  - st_magn_i2c (necessary for the I2C devices [optional*]);
-	  - st_magn_spi (necessary for the SPI devices [optional*]);
-
-	  (*) one of these is necessary to do something.
+	  Also need to enable at least one of I2C and SPI interface drivers
+	  below.
 
 config IIO_ST_MAGN_I2C_3AXIS
-	tristate
-	depends on IIO_ST_MAGN_3AXIS
-	depends on IIO_ST_SENSORS_I2C
+	tristate "STMicroelectronics magnetometers 3-Axis I2C Interface"
+	depends on (I2C && IIO_ST_MAGN_3AXIS)
+	default y if (I2C && IIO_ST_MAGN_3AXIS)
+	select IIO_ST_SENSORS_I2C
+	help
+	  Build support for STMicroelectronics magnetometers I2C interface.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called st_magn_i2c.
 
 config IIO_ST_MAGN_SPI_3AXIS
-	tristate
-	depends on IIO_ST_MAGN_3AXIS
-	depends on IIO_ST_SENSORS_SPI
+	tristate "STMicroelectronics magnetometers 3-Axis SPI Interface"
+	depends on (SPI_MASTER && IIO_ST_MAGN_3AXIS)
+	default y if (SPI_MASTER && IIO_ST_MAGN_3AXIS)
+	select IIO_ST_SENSORS_SPI
+	help
+	  Build support for STMicroelectronics magnetometers SPI interface.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called st_magn_spi.
 
 config SENSORS_HMC5843
 	tristate
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index fc0d3cfca418..962e45e29142 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -194,30 +194,35 @@ config IIO_ST_PRESS
 	tristate "STMicroelectronics pressure sensor Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
 	select IIO_ST_SENSORS_CORE
-	select IIO_ST_PRESS_I2C if (I2C)
-	select IIO_ST_PRESS_SPI if (SPI_MASTER)
 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
 	help
 	  Say yes here to build support for STMicroelectronics pressure
 	  sensors: LPS001WP, LPS25H, LPS331AP, LPS22HB, LPS22HH.
 
-	  This driver can also be built as a module. If so, these modules
-	  will be created:
-	  - st_pressure (core functions for the driver [it is mandatory]);
-	  - st_pressure_i2c (necessary for the I2C devices [optional*]);
-	  - st_pressure_spi (necessary for the SPI devices [optional*]);
-
-	  (*) one of these is necessary to do something.
+	  Also need to enable at least one of I2C and SPI interface drivers
+	  below.
 
 config IIO_ST_PRESS_I2C
-	tristate
-	depends on IIO_ST_PRESS
-	depends on IIO_ST_SENSORS_I2C
+	tristate "STMicroelectronics pressure sensor I2C Interface"
+	depends on (I2C && IIO_ST_PRESS)
+	default y if (I2C && IIO_ST_PRESS)
+	select IIO_ST_SENSORS_I2C
+	help
+	  Build support for STMicroelectronics pressure sensor I2C interface.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called st_pressure_i2c.
 
 config IIO_ST_PRESS_SPI
-	tristate
-	depends on IIO_ST_PRESS
-	depends on IIO_ST_SENSORS_SPI
+	tristate "STMicroelectronics pressure sensor SPI Interface"
+	depends on (SPI_MASTER && IIO_ST_PRESS)
+	default y if (SPI_MASTER && IIO_ST_PRESS)
+	select IIO_ST_SENSORS_SPI
+	help
+	  Build support for STMicroelectronics pressure sensor SPI interface.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called st_pressure_spi.
 
 config T5403
 	tristate "EPCOS T5403 digital barometric pressure sensor driver"
-- 
2.30.2

