Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BE94BA5E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbiBQQ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:27:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiBQQ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:37 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670C59A9A3;
        Thu, 17 Feb 2022 08:27:22 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p14so8492647ejf.11;
        Thu, 17 Feb 2022 08:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cugFVa2TaBWmSwBVtyXgkeptt7jXSE4VzCQ/5gV5rpU=;
        b=K12VJmHxzg8jBXj32woZbaXUplVy21O4g5lIYY3/ZUrVKXJFGJ0wpiGJDDyxA6K+px
         2nkqBN3FMK9cRSoUfaFUYUWCUPJfl2TlwzO9JSJHoCjmoqAoodTXYTm5K1QJFgIUxNuA
         +g0La8oP9nSOzVhjjUzoIYsA9b3X76g9SCHCCHxrrRzw59yPR52rJUOgZoAGgwndmAhk
         KdbiWXkvslm5lRuSfPTfqq5rR2sUfaCiLERT3Ko5NAWi072dqgpLSYSWgjB0c4jVS4iv
         5b7BZR7i3/2DeEPlzL26GIFRP7yFd2WBpYdo7P0N5ftIw0UnkuRMwtktqfL3cypggBP6
         MZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cugFVa2TaBWmSwBVtyXgkeptt7jXSE4VzCQ/5gV5rpU=;
        b=kT/lqVPwtDBq+PuXueGGr/4XCns+N/gkQ88t4LB3hK6g2q2eo8AITPV80AsWHXXtQY
         MAAuhnAMgQZ3pnASOplf3EOgVKiPCRlQ+rLy0935l7vH4oAiz5Ub0M7LBzj1X9C5G8ma
         gd8KedXq9VqPtgnsqymRQV086TxUH+0NF9Xy6Nk7vX54ZqhwKxU/wLsh6VlkNc5UiBQl
         8LOGxjyOEz0XPSpegK/OYQOQAl9Z8C4IQNDdHuGPo9YIJ6bj+uv3bH90thWBCi36lrfs
         yirxgs1dI4qyGLenpzxdzI9PcdZFd8lv+a3oeP+LyTRoLwb379+r54MI1P5dqY5PT+mc
         JXDQ==
X-Gm-Message-State: AOAM531APWFW/kKgtOSbrLR/u6wWFRf49gCn6oOVxyg6QuQ2Ijl8qZo5
        n1XMQXOOqAo0cjllDAf7ucw=
X-Google-Smtp-Source: ABdhPJxUGYugDqGuLtoRk3wPQVSl0L7gB4pxFZ1N2bp7NCtP3kt2Mr6jWtLNpduazYSbYkja5TEvcA==
X-Received: by 2002:a17:906:d298:b0:6cf:9baf:468 with SMTP id ay24-20020a170906d29800b006cf9baf0468mr2909703ejb.61.1645115240780;
        Thu, 17 Feb 2022 08:27:20 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id j13sm3653742edw.24.2022.02.17.08.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:27:20 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>
Subject: [v3 00/13] Add support for Bosch BNO055 IMU
Date:   Thu, 17 Feb 2022 17:26:57 +0100
Message-Id: <20220217162710.33615-1-andrea.merello@gmail.com>
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

This series (tries to) add support for Bosch BNO055 IMU to Linux IIO
subsystem. It is made up several patches:

  1/13 to 6/13: add some IIO modifiers, and their documentation, to the IIO
                core layer, in order to being able to expose the linear
                acceleration and Euler angles among standard attributes.
                Also update the IIO event monitor tool

  6/13 to 10/13: add the core IIO BNO055 driver documentation for sysfs
                 attributes and DT bindings

  11/13: adds serdev BNO055 driver to actually use the IMU via serial line

  12/13: adds I2C BNO055 driver to actually use the IMU via I2C wiring

  13/13: add a documentation file that describe the bno055 driver and
         specifically the calibration

Differences wrt v2:

 FIXES:
  - workaround: switching off and on fusion mode could cause IMU to
    misbehave (i.e. wrong anglvel data)
  - FIX sometimes driver failed to write attributes / manual settings
    were not honored
  - workaround: for IMU gyroscope unit bug (unit change by changing range)
  - Fixed some typos bosh->bosch
  - Fixed warning caught by kernel robot
  - Fix bursting was broken
  - Fix missing mutex unlock in exit path

 API:
  - rework sysfs attribute names
  - change linear acceleration modifiers names (e.g. ACCEL_LINEAR_MOD ->
    ACCEL_MOD)
  - 'unique_id' sysfs attribute become 'serial_number' and become
    non-bno055-specific
  - fix range units and sysfs names
  - fix gyro lpf available values were returned in twisted order
  - gyroscope no longer has the range attribute, the scale can now be
    changed instead

 Misc:
  - Dropped previous patch 01 (add find_closest_unsorted) as it is not
    needed anymore
  - Some trivial stuff (commas, newlines etc)
  - Added help section in Kconfig
  - reworked sysfs attribute code, to easier implement required API changes
    and above fixes
  - hopefully implement all reviewers advice (e.g. rid of macro helpers,
    kill useless devm primitive, simplify bno055_clk_disable, rework some
    bail-out code, conditions check, remove odd usage of ternary operator,
    move default clause at end of switch block, etc ..)
  - reorder patches so that DOC for a new thing come after patch that
    introduced that thing
  - linear acceleration DOC moved and cross-referenced to acceleration doc


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
  mode) just read zero (which is consistent WRT what you get when reading
  from a buffer with those attributes enabled).

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

Andrea Merello (13):
  iio: add modifiers for linear acceleration
  iio: document linear acceleration modifiers
  iio: event_monitor: add linear acceleration modifiers
  iio: add modifers for pitch, yaw, roll
  iio: document pitch, yaw, roll modifiers
  iio: event_monitor: add pitch, yaw and roll modifiers
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
 Documentation/iio/bno055.rst                  |   53 +
 drivers/iio/imu/Kconfig                       |    1 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/bno055/Kconfig                |   25 +
 drivers/iio/imu/bno055/Makefile               |    5 +
 drivers/iio/imu/bno055/bno055.c               | 1612 +++++++++++++++++
 drivers/iio/imu/bno055/bno055.h               |   12 +
 drivers/iio/imu/bno055/bno055_i2c.c           |   50 +
 drivers/iio/imu/bno055/bno055_sl.c            |  557 ++++++
 drivers/iio/industrialio-core.c               |    6 +
 include/uapi/linux/iio/types.h                |    7 +-
 tools/iio/iio_event_monitor.c                 |    6 +
 15 files changed, 2499 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
 create mode 100644 Documentation/iio/bno055.rst
 create mode 100644 drivers/iio/imu/bno055/Kconfig
 create mode 100644 drivers/iio/imu/bno055/Makefile
 create mode 100644 drivers/iio/imu/bno055/bno055.c
 create mode 100644 drivers/iio/imu/bno055/bno055.h
 create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
 create mode 100644 drivers/iio/imu/bno055/bno055_sl.c

--
2.17.1
