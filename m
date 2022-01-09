Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571C0488965
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 13:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiAIMnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 07:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiAIMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 07:43:34 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77CEC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 04:43:33 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id k21so34588469lfu.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 04:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zS+GOM2GgfZqTIlRvOXKH0DkjoNYbxZ7xEpE/GZQZ44=;
        b=RXGEdyW4zm1ILI0BPGqO7w9GpwFhFGzCRY6wcqfHtDT5XUtDET/tloMfEiBJEqkfqD
         29KmXwppK1qdALDKrSREO3Zftpfui6qOFubb80Vr4RQOhQWjj7MgfS3YxnBW3NNE8bkL
         Jgbs+mCBQ4fDM3kcaFVrifI6F6KTRtWCdh6AUFE8/y6uDvaOcpd/tmBoJRZIdh+MJL/i
         /FZrxTWSe7qL+4y/AGZj6AP74EblPDLdcgY04uPxr5VmaaNXm6ikDt6Ix/FL57BFF4cB
         lNRGmyH7GlWxQ/SM9rN4Veq9IzJCrKZzGubDBMvNPr0Grvq9iKxl9Ydfwc1rK47RYiWj
         0U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zS+GOM2GgfZqTIlRvOXKH0DkjoNYbxZ7xEpE/GZQZ44=;
        b=MpteYywjnson9NBJbCWgTWpmUeNznDDzgXqEzvUHrhGkM6s1kHaiUnETK1njCMrAUa
         dSlyVQrTvJxQ8/bJ0DE2d4kcDAhZVdKMxVwUnct+qaQO2R/dZt5DCdpmdBW3dxp4mCFs
         4PSbt3nDkfeqIFIVtRVvmLlljB3kpPWv2afvysU/GhC7g525Kbd/WG3NcFoPnb9BSEXM
         4C9Cdhd3Oiw+5cqodBtFXO3YHLqScDhuZ5u5YczIQFNV8FUxCPqAmN5vSwcL9GJ7PWPu
         nnwpcPdaFjKyqLKhMRvW0mgxPRYSG9BtM4K9emfeLK8rhlzy4AeIPLWMgfRMEV9JNPKJ
         z30Q==
X-Gm-Message-State: AOAM5338cufVIvBVkaZ1nUugv+qD70wAqwyIGvATzSAPhexsLKpRiUnu
        6BQ+7Q3QmNn2J6iPuJ/rqVAzthhZ64GT9Ughdfw=
X-Google-Smtp-Source: ABdhPJyZ/E6b1O+7gv9RfL7sypbRpMWkwmaHNEVfg4wGdGZYVzW6hUAQUn5bepdbbqDtjF2FTRP8aw==
X-Received: by 2002:a2e:7005:: with SMTP id l5mr43666912ljc.393.1641732211628;
        Sun, 09 Jan 2022 04:43:31 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id y11sm614438lfe.252.2022.01.09.04.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 04:43:31 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <caihuoqing@baidu.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH v2] iio: stm: don't always auto-enable I2C and SPI interface drivers
Date:   Sun,  9 Jan 2022 15:43:26 +0300
Message-Id: <20220109124326.3696775-1-nikita.yoush@cogentembedded.com>
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
Changes since v1:
- use "default XXX" instead of "default y if XXX", per suggestion by
  Arnd Bergmann

 drivers/iio/accel/Kconfig             | 35 ++++++++++++++-----------
 drivers/iio/common/st_sensors/Kconfig |  2 --
 drivers/iio/gyro/Kconfig              | 37 ++++++++++++++++-----------
 drivers/iio/imu/st_lsm9ds0/Kconfig    | 28 +++++++++++++++-----
 drivers/iio/magnetometer/Kconfig      | 35 ++++++++++++++-----------
 drivers/iio/pressure/Kconfig          | 35 ++++++++++++++-----------
 6 files changed, 104 insertions(+), 68 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 49587c992a6d..eb17ca40e08a 100644
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
+	depends on I2C && IIO_ST_ACCEL_3AXIS
+	default I2C && IIO_ST_ACCEL_3AXIS
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
+	depends on SPI_MASTER && IIO_ST_ACCEL_3AXIS
+	default SPI_MASTER && IIO_ST_ACCEL_3AXIS
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
index a672f7d12bbb..97b86c4a53a6 100644
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
+	depends on I2C && IIO_ST_GYRO_3AXIS
+	default I2C && IIO_ST_GYRO_3AXIS
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
+	depends on SPI_MASTER && IIO_ST_GYRO_3AXIS
+	default SPI_MASTER && IIO_ST_GYRO_3AXIS
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
index 53b7017014f8..d29558edee60 100644
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
+	depends on I2C && IIO_ST_LSM9DS0
+	default I2C && IIO_ST_LSM9DS0
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
+	depends on SPI_MASTER && IIO_ST_LSM9DS0
+	default SPI_MASTER && IIO_ST_LSM9DS0
+	select IIO_ST_ACCEL_SPI_3AXIS
+	select IIO_ST_MAGN_SPI_3AXIS
 	select REGMAP_SPI
+	help
+	  Build support for STMicroelectronics LSM9DS0 IMU I2C interface.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called st_lsm9ds0_spi.
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 565ee41ccb3a..54445365c4bc 100644
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
+	depends on I2C && IIO_ST_MAGN_3AXIS
+	default I2C && IIO_ST_MAGN_3AXIS
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
+	depends on SPI_MASTER && IIO_ST_MAGN_3AXIS
+	default SPI_MASTER && IIO_ST_MAGN_3AXIS
+	select IIO_ST_SENSORS_SPI
+	help
+	  Build support for STMicroelectronics magnetometers SPI interface.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called st_magn_spi.
 
 config SENSORS_HMC5843
 	tristate
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index fc0d3cfca418..0ff756cea63a 100644
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
+	depends on I2C && IIO_ST_PRESS
+	default I2C && IIO_ST_PRESS
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
+	depends on SPI_MASTER && IIO_ST_PRESS
+	default SPI_MASTER && IIO_ST_PRESS
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

