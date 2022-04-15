Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EEA502AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353869AbiDONC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbiDONCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:02:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0D0366B4;
        Fri, 15 Apr 2022 06:00:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u15so15207422ejf.11;
        Fri, 15 Apr 2022 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hh8aUORptuQqZGj8/5dvM/IwZQS9vQck/p7Lq6tz0Lk=;
        b=dTGFAGmnt3rMrb5qdHGUDcklsvKcTlrNP1GTGMvG5Tu4qMjpXfIVZByMq7FmYhV1p+
         PcwRmhOOPScEIC/MvZRMWc7K8CroM1hG1p04cxqMfnk6FIZvQwXZjQG1msZHYQs+w+9n
         xBVTuej+6C4bnVMKC3FXmLHboAIiy7LOLqFk8MN921fWCd+jbdA1jDDxTpsXxSgUbfXu
         YpOP2f5o3SdICnjY14qS+dqq/rbY7SzZgKflyZxO2K2MkOdqNHqHKbPaUueqNLSyfXXe
         EDOCzlbh5i74gyqvGO/bsDBqLcukJzm/cebKG9SQJ+FeE+S515l4arUMpvxRAvdZlUCg
         UKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hh8aUORptuQqZGj8/5dvM/IwZQS9vQck/p7Lq6tz0Lk=;
        b=u6CS8FpA86rwt8RotMcZfoHsd4gzB0aDPYZPl17bT2q9+rbLRhi6aHBzlzyQ3BOZO7
         6aqVaaQRmFY2SFSdmGzAVPo8Hp4+wAAaHGls1Su1RagvEN10YIViVykBN2XIU6RK1loS
         WcwXnGoWgw0SqDOvMH17ufKps8yOYiPDB8F+P3KWfQdCxS/a3UP5Jlu3qCK/IvSSe7+d
         eVLdGANa2MFyTCGfq5Sd1ppUsLByHrz6XPPeOH+83ntD2dhnXyh/Wi8iSQduG9W463e2
         gdgISZsu4dhbMZr1CSk2qSIs9VlRRBXBzqNflbayVOWMxVjui6y2u8JCO8yWek6z4LHy
         bqHQ==
X-Gm-Message-State: AOAM533wnHa3lnaJoTXkSP1L67tpS3jE3o7VmMbPD99hPBb/0r7hokAJ
        Lm4jACibg14j6QKnl1im0XU=
X-Google-Smtp-Source: ABdhPJztOR7Z1Axp41mIvCP08KkVO4e4Zai0v8x5ZZxxbSeLDMxlDB+pmQPrQIXBS9kxu7exEjso6g==
X-Received: by 2002:a17:907:6088:b0:6e8:cbcb:9a0b with SMTP id ht8-20020a170907608800b006e8cbcb9a0bmr6135514ejc.671.1650027623159;
        Fri, 15 Apr 2022 06:00:23 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm2704715edj.0.2022.04.15.06.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:00:22 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v4 00/14] Add support for Bosch BNO055 IMU
Date:   Fri, 15 Apr 2022 14:59:51 +0200
Message-Id: <20220415130005.85879-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

This series (tries to) add support for Bosch BNO055 IMU to Linux IIO
subsystem. It is made up several patches:

  1/13 to 7/12: add some IIO modifiers, and their documentation, to the IIO
                core layer, in order to being able to expose the linear
                acceleration and Euler angles among standard attributes.
                Also update the IIO event monitor tool

  7/13: fix binary attributes didn't work with IIO

  8/13 to 11/13: add the core IIO BNO055 driver and documentation for sysfs
                 attributes and DT bindings

  12/13: adds serdev BNO055 driver to actually use the IMU via serial line

  13/13: adds I2C BNO055 driver to actually use the IMU via I2C wiring

  14/13: add a documentation file that describe the bno055 driver and
         specifically the calibration

Differences wrt v3:

- use binary attribute for calibration data
- introduce trace events (instead of dev_dbg()) for bno055 serial driver
- changed serial driver name bno055_sl -> bno055_ser
- fix quaternion unit
- make the driver return error, instead of reading zeroes, when trying to
  access fusion data, but fusion is disabled
- make serial driver code more readable and use more kernel helpers when
  possible
- address issues found by 0day
- fix accel range unit in doc
- fix debugfs directory was not ever removed
- add of_device_id table in I2C driver
- use probe_new() instead of probe in I2C driver
- some other trivial improvements and fixes

Differences wrt other BNO055 drivers:

  Previously at least another driver for the very same chip has been posted
  to the Linux ML [0], but it has been never merged, and it seems no one
  cared of it since quite a long time.

  This driver differs from the above driver on the following aspects:

  - This driver supports also serial access (to be reliable, reset pin is
    required to be wired)

  - The above driver tried to support all IMU HW modes by allowing to
    choose one in the DT, and adapting IIO attributes accordingly. This
    driver does not rely on DT for this, instead settings are done via
    sysfs attributes.  All IIO attributes are always exposed; more on this
    later on. This driver however supports only a subset of the
    HW-supported modes.

  - This driver has some support for managing the IMU calibration

Supported operation modes:

  - AMG (accelerometer, magnetometer and gyroscope) mode, which provides
    raw (uncalibrated) measurements from the said sensors, and allows for
    setting some parameters about them (e.g. filter cut-off frequency, max
    sensor ranges, etc).

  - Fusion mode, which still provides AMG measures, while it also provides
    other data calculated by the IMU (e.g. rotation angles, linear
    acceleration, etc). In this mode user has no freedom to set any sensor
    parameter, since the HW locks them. Autocalibration and correction is
    performed by the IMU.

  IIO attributes exposing sensors parameters are always present, but in
  fusion modes the available values are constrained to just the one used by
  the HW. This is reflected in the '*_available' IIO attributes.

  Trying to set a not-supported value always falls back to the closest
  supported one, which in this case is just the one in use by the HW.

  IIO attributes for unavailable measurements (e.g. Euler angles in AMG
  mode) can't be read (return -EBUSY, or refuse to enable buffer).

IMU calibration:

  The IMU supports for two sets of calibration parameters:

  - SIC matrix. user-provided; this driver doesn't currently support it

  - Offset and radius parameters. The IMU automatically finds out them when
    it is running in fusion mode; supported by this driver.

  The driver provides access to autocalibration flags (i.e. you can known
  if the IMU has successfully autocalibrated) and to calibration data blob.
  The user can save this blob in a "firmware" file (i.e. in /lib/firmware)
  that the driver looks for at probe time. If found, then the IMU is
  initialized with this calibration data. This saves the user from
  performing the calibration procedure every time (which consist of moving
  the IMU in various way).

  The driver looks for calibration data file using two different names:
  first a file whose name is suffixed with the IMU unique ID is searched
  for; this is useful when there is more than one IMU instance. If this
  file is not found, then a "generic" calibration file is searched for
  (which can be used when only one IMU is present, without struggling with
  fancy names, that changes on each device).

  In AMG mode the IIO 'offset' attributes provide access to the offsets
  from calibration data (if any), so that the user can apply them to the
  accel, angvel and magn IIO attributes. In fusion mode they are not needed
  and read as zero.


Access protocols and serdev module:

  The serial protocol is quite simple, but there are tricks to make it
  really works. Those tricks and workarounds are documented in the driver
  source file.

  The core BNO055 driver tries to group readings in burst when appropriate,
  in order to optimize triggered buffer operation. The threshold for
  splitting a burst (i.e. max number of unused bytes in the middle of a
  burst that will be throw away) is provided to the core driver by the
  lowlevel access driver (either serdev or I2C) at probe time.

[0] https://www.spinics.net/lists/linux-iio/msg25508.html

Andrea Merello (14):
  iio: add modifiers for linear acceleration
  iio: document linear acceleration modifiers
  iio: event_monitor: add linear acceleration modifiers
  iio: add modifers for pitch, yaw, roll
  iio: document pitch, yaw, roll modifiers
  iio: event_monitor: add pitch, yaw and roll modifiers
  iio: add support for binary attributes
  iio: imu: add Bosch Sensortec BNO055 core driver
  iio: document bno055 private sysfs attributes
  iio: document "serial_number" sysfs attribute
  dt-bindings: iio: imu: add documentation for Bosch BNO055 bindings
  iio: imu: add BNO055 serdev driver
  iio: imu: add BNO055 I2C driver
  docs: iio: add documentation for BNO055 driver

 Documentation/ABI/testing/sysfs-bus-iio       |   25 +
 .../ABI/testing/sysfs-bus-iio-bno055          |   81 +
 .../bindings/iio/imu/bosch,bno055.yaml        |   59 +
 Documentation/iio/bno055.rst                  |   50 +
 Documentation/iio/index.rst                   |    2 +
 drivers/iio/imu/Kconfig                       |    1 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/bno055/Kconfig                |   31 +
 drivers/iio/imu/bno055/Makefile               |    7 +
 drivers/iio/imu/bno055/bno055.c               | 1715 +++++++++++++++++
 drivers/iio/imu/bno055/bno055.h               |   12 +
 drivers/iio/imu/bno055/bno055_i2c.c           |   56 +
 drivers/iio/imu/bno055/bno055_ser.c           |  556 ++++++
 drivers/iio/imu/bno055/bno055_ser_trace.h     |  114 ++
 drivers/iio/industrialio-core.c               |   10 +-
 include/uapi/linux/iio/types.h                |    7 +-
 tools/iio/iio_event_monitor.c                 |    6 +
 17 files changed, 2731 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
 create mode 100644 Documentation/iio/bno055.rst
 create mode 100644 drivers/iio/imu/bno055/Kconfig
 create mode 100644 drivers/iio/imu/bno055/Makefile
 create mode 100644 drivers/iio/imu/bno055/bno055.c
 create mode 100644 drivers/iio/imu/bno055/bno055.h
 create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_trace.h

--
2.17.1
