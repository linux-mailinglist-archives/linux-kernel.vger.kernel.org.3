Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B9A50FE69
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350683AbiDZNOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242086AbiDZNOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:14:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD04606E8;
        Tue, 26 Apr 2022 06:11:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j15so12162549wrb.2;
        Tue, 26 Apr 2022 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JdXp87KaGsiEpJ1EDInf7X2cXj3S0vlXKm/Aq90mZkc=;
        b=ENTwO/jKeVNxPEIwHYlQJG+UKLPlZ+vkdvALjbw1kVoL2pQvU4QzKlfkO6jXAyL4w6
         q9EyYt0ANi9iH4ZufTofhhq+jz6lng4ClZ+823eKr2sdqPrjrcldX4qFI3ZPr5ZA6YBn
         SW4eLdYqvDWPbyZi2wVaKoEaVf7JH9GSh+ZMOrKDo+axmHDJwAGAfPvaFNSA9kX1fUsv
         S73jgWqqgjdyIJ+s4mgvYs60XCMjlUqKIbQhme5q+97v3PX+iGmiVVEBtSJKDZBqDJUC
         HXvUN7QMUIKXPEPOuXAP9XixC48c77ETr/yPInQCwS+LuvUTER14+Qr47bDsed9gukYo
         Jbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JdXp87KaGsiEpJ1EDInf7X2cXj3S0vlXKm/Aq90mZkc=;
        b=ohB5JjbUGLYMnxNhqHJ1gXEwPNIdkrHBkeEHFopIq79MRmqJ65Pj7AemCzFUqwBBE4
         L2vw/QO/UlMBUbHgCiVji2k2jZhQyDZi+XbVBXOwdXR4meFSOgURspnQtOJIJl+0fQZD
         21a4yoR5Zs0bVSOhkex/Qw+N5LtsG70AEVGLRxJtzGKdro2svhcFQypxKHsgPE6+ogK1
         YezfePekfQRK0K1b88ARJBTw/QFkot8LFmqnxfK5sDFPdIP2QdqhN+hCq8YTN7UwzV0D
         OeIxZLuPeZhF8uhIltV8ec6vAMYsyiUjkSNS4eiMcT6HcWmM8Xe/Lq6XRcSCIHMpWEZy
         CjwA==
X-Gm-Message-State: AOAM5316bll13iDKQjJEyuHSkX1g4X358Be8w9dHEWnwNXqk2/vjblVR
        ShchZpz12qedc1/sxmijiS/eVg9zEoZ2hnYl0Ww=
X-Google-Smtp-Source: ABdhPJy8tvumeV1YxxBjlWbhcswDUcjAOqKl7SvzB48ENszgmcd5NCqmatzUrICwC8nrw+BsRC9o+Q==
X-Received: by 2002:adf:f745:0:b0:20a:c43b:3dfe with SMTP id z5-20020adff745000000b0020ac43b3dfemr17458315wrp.117.1650978667637;
        Tue, 26 Apr 2022 06:11:07 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00393f01c8f00sm3262910wmq.47.2022.04.26.06.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:11:07 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v5 00/14] Add support for Bosch BNO055 IMU
Date:   Tue, 26 Apr 2022 15:10:48 +0200
Message-Id: <20220426131102.23966-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

This series (tries to) add support for Bosch BNO055 IMU to Linux IIO
subsystem. It is made up several patches:

  1/14 to 6/14: add some IIO modifiers, and their documentation, to the IIO
                core layer, in order to being able to expose the linear
                acceleration and Euler angles among standard attributes.
                Also update the IIO event monitor tool

  7/14: fix binary attributes didn't work with IIO

  8/14 to 11/14: add the core IIO BNO055 driver and documentation for sysfs
                 attributes and DT bindings

  12/14: adds serdev BNO055 driver to actually use the IMU via serial line

  13/14: adds I2C BNO055 driver to actually use the IMU via I2C wiring

  14/14: add a documentation file that describe the bno055 driver and
         specifically the calibration

Differences wrt v4:
- be more tolerant wrt unrecognized chip IDs
- rename 'serial_number' attribute in 'serialnumber'
- fix missing NULL variable initialization
- use sign_extend32() instead of s16 casting where appropriate
- fix quaternion unit
- minor stuff (e.g. comments..)
- reduce (slightly) locking in serdev driver
- rework tracepoint support (e.g. remove dedicated config option)

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
  iio: document "serialnumber" sysfs attribute
  dt-bindings: iio/imu: Add Bosch BNO055
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
 drivers/iio/imu/bno055/Kconfig                |   25 +
 drivers/iio/imu/bno055/Makefile               |   10 +
 drivers/iio/imu/bno055/bno055.c               | 1710 +++++++++++++++++
 drivers/iio/imu/bno055/bno055.h               |   12 +
 drivers/iio/imu/bno055/bno055_i2c.c           |   57 +
 drivers/iio/imu/bno055/bno055_ser_core.c      |  560 ++++++
 drivers/iio/imu/bno055/bno055_ser_trace.h     |  104 +
 drivers/iio/industrialio-core.c               |   10 +-
 include/uapi/linux/iio/types.h                |    7 +-
 tools/iio/iio_event_monitor.c                 |    6 +
 17 files changed, 2718 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
 create mode 100644 Documentation/iio/bno055.rst
 create mode 100644 drivers/iio/imu/bno055/Kconfig
 create mode 100644 drivers/iio/imu/bno055/Makefile
 create mode 100644 drivers/iio/imu/bno055/bno055.c
 create mode 100644 drivers/iio/imu/bno055/bno055.h
 create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_core.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_trace.h

--
2.17.1
