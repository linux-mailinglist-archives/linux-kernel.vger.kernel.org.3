Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B53516660
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352808AbiEARAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352480AbiEAQ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:59:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5C846663;
        Sun,  1 May 2022 09:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2D1CB80E91;
        Sun,  1 May 2022 16:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EF5C385AA;
        Sun,  1 May 2022 16:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651424089;
        bh=PN5Dbo/Y9eUiJsd8pMaaffUc29jZ4YY32wTLRQPYnwA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ANW4zjqijJ3H4TKRg+CQ4HSVODzA8d/iUNrNQQTMeuk9cN2Q+KyJVbihTZtKPEEY6
         mwvO8oyewt1VoQTxWNPR0Mh2gAv1EgFIGjcpdej6W86dOxK/bstTJXAAn8t8pjmeo0
         XNZl7xHTgQM5QcbTQFlspeHcsLIAAM2EPVY9MMX1LTBc+5Ka2nWkpldEbvjd3vZnWN
         spR6h3wgBEZA4P2mjbdbAblt3OJqqGwy0COkcMwyO/dwHle+KVDfcEZ9BGIF0Y3pxE
         at8Ca6O/HcaVixotrvS8ZftLn25csecrULhFCzK7w2BDVSBSljeP2sLrSM3drA310n
         8SI2O2qifW4GA==
Date:   Sun, 1 May 2022 18:03:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v5 00/14] Add support for Bosch BNO055 IMU
Message-ID: <20220501180303.75a0d0a5@jic23-huawei>
In-Reply-To: <CAHp75VcoXu=0yvxmTwGAzexV_MgACXg-Cufkigt_kCEvbnwq_Q@mail.gmail.com>
References: <20220426131102.23966-1-andrea.merello@gmail.com>
        <CAHp75VcoXu=0yvxmTwGAzexV_MgACXg-Cufkigt_kCEvbnwq_Q@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 15:42:49 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Apr 26, 2022 at 3:11 PM Andrea Merello <andrea.merello@gmail.com> wrote:
> >
> > From: Andrea Merello <andrea.merello@iit.it>
> >
> > This series (tries to) add support for Bosch BNO055 IMU to Linux IIO
> > subsystem. It is made up several patches:
> >
> >   1/14 to 6/14: add some IIO modifiers, and their documentation, to the IIO
> >                 core layer, in order to being able to expose the linear
> >                 acceleration and Euler angles among standard attributes.
> >                 Also update the IIO event monitor tool
> >
> >   7/14: fix binary attributes didn't work with IIO
> >
> >   8/14 to 11/14: add the core IIO BNO055 driver and documentation for sysfs
> >                  attributes and DT bindings
> >
> >   12/14: adds serdev BNO055 driver to actually use the IMU via serial line
> >
> >   13/14: adds I2C BNO055 driver to actually use the IMU via I2C wiring
> >
> >   14/14: add a documentation file that describe the bno055 driver and
> >          specifically the calibration  
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> for non-commented patches (12 out of 14 AFAICS).
> 
FWIW I'm fine with the series once you've tidied up the stuff Andy picked up
on.

Thanks Andy for the detailed reviewing btw.

Jonathan

> > Differences wrt v4:
> > - be more tolerant wrt unrecognized chip IDs
> > - rename 'serial_number' attribute in 'serialnumber'
> > - fix missing NULL variable initialization
> > - use sign_extend32() instead of s16 casting where appropriate
> > - fix quaternion unit
> > - minor stuff (e.g. comments..)
> > - reduce (slightly) locking in serdev driver
> > - rework tracepoint support (e.g. remove dedicated config option)
> >
> > Differences wrt other BNO055 drivers:
> >
> >   Previously at least another driver for the very same chip has been posted
> >   to the Linux ML [0], but it has been never merged, and it seems no one
> >   cared of it since quite a long time.
> >
> >   This driver differs from the above driver on the following aspects:
> >
> >   - This driver supports also serial access (to be reliable, reset pin is
> >     required to be wired)
> >
> >   - The above driver tried to support all IMU HW modes by allowing to
> >     choose one in the DT, and adapting IIO attributes accordingly. This
> >     driver does not rely on DT for this, instead settings are done via
> >     sysfs attributes.  All IIO attributes are always exposed; more on this
> >     later on. This driver however supports only a subset of the
> >     HW-supported modes.
> >
> >   - This driver has some support for managing the IMU calibration
> >
> > Supported operation modes:
> >
> >   - AMG (accelerometer, magnetometer and gyroscope) mode, which provides
> >     raw (uncalibrated) measurements from the said sensors, and allows for
> >     setting some parameters about them (e.g. filter cut-off frequency, max
> >     sensor ranges, etc).
> >
> >   - Fusion mode, which still provides AMG measures, while it also provides
> >     other data calculated by the IMU (e.g. rotation angles, linear
> >     acceleration, etc). In this mode user has no freedom to set any sensor
> >     parameter, since the HW locks them. Autocalibration and correction is
> >     performed by the IMU.
> >
> >   IIO attributes exposing sensors parameters are always present, but in
> >   fusion modes the available values are constrained to just the one used by
> >   the HW. This is reflected in the '*_available' IIO attributes.
> >
> >   Trying to set a not-supported value always falls back to the closest
> >   supported one, which in this case is just the one in use by the HW.
> >
> >   IIO attributes for unavailable measurements (e.g. Euler angles in AMG
> >   mode) can't be read (return -EBUSY, or refuse to enable buffer).
> >
> > IMU calibration:
> >
> >   The IMU supports for two sets of calibration parameters:
> >
> >   - SIC matrix. user-provided; this driver doesn't currently support it
> >
> >   - Offset and radius parameters. The IMU automatically finds out them when
> >     it is running in fusion mode; supported by this driver.
> >
> >   The driver provides access to autocalibration flags (i.e. you can known
> >   if the IMU has successfully autocalibrated) and to calibration data blob.
> >   The user can save this blob in a "firmware" file (i.e. in /lib/firmware)
> >   that the driver looks for at probe time. If found, then the IMU is
> >   initialized with this calibration data. This saves the user from
> >   performing the calibration procedure every time (which consist of moving
> >   the IMU in various way).
> >
> >   The driver looks for calibration data file using two different names:
> >   first a file whose name is suffixed with the IMU unique ID is searched
> >   for; this is useful when there is more than one IMU instance. If this
> >   file is not found, then a "generic" calibration file is searched for
> >   (which can be used when only one IMU is present, without struggling with
> >   fancy names, that changes on each device).
> >
> >   In AMG mode the IIO 'offset' attributes provide access to the offsets
> >   from calibration data (if any), so that the user can apply them to the
> >   accel, angvel and magn IIO attributes. In fusion mode they are not needed
> >   and read as zero.
> >
> >
> > Access protocols and serdev module:
> >
> >   The serial protocol is quite simple, but there are tricks to make it
> >   really works. Those tricks and workarounds are documented in the driver
> >   source file.
> >
> >   The core BNO055 driver tries to group readings in burst when appropriate,
> >   in order to optimize triggered buffer operation. The threshold for
> >   splitting a burst (i.e. max number of unused bytes in the middle of a
> >   burst that will be throw away) is provided to the core driver by the
> >   lowlevel access driver (either serdev or I2C) at probe time.
> >
> > [0] https://www.spinics.net/lists/linux-iio/msg25508.html
> >
> > Andrea Merello (14):
> >   iio: add modifiers for linear acceleration
> >   iio: document linear acceleration modifiers
> >   iio: event_monitor: add linear acceleration modifiers
> >   iio: add modifers for pitch, yaw, roll
> >   iio: document pitch, yaw, roll modifiers
> >   iio: event_monitor: add pitch, yaw and roll modifiers
> >   iio: add support for binary attributes
> >   iio: imu: add Bosch Sensortec BNO055 core driver
> >   iio: document bno055 private sysfs attributes
> >   iio: document "serialnumber" sysfs attribute
> >   dt-bindings: iio/imu: Add Bosch BNO055
> >   iio: imu: add BNO055 serdev driver
> >   iio: imu: add BNO055 I2C driver
> >   docs: iio: add documentation for BNO055 driver
> >
> >  Documentation/ABI/testing/sysfs-bus-iio       |   25 +
> >  .../ABI/testing/sysfs-bus-iio-bno055          |   81 +
> >  .../bindings/iio/imu/bosch,bno055.yaml        |   59 +
> >  Documentation/iio/bno055.rst                  |   50 +
> >  Documentation/iio/index.rst                   |    2 +
> >  drivers/iio/imu/Kconfig                       |    1 +
> >  drivers/iio/imu/Makefile                      |    1 +
> >  drivers/iio/imu/bno055/Kconfig                |   25 +
> >  drivers/iio/imu/bno055/Makefile               |   10 +
> >  drivers/iio/imu/bno055/bno055.c               | 1710 +++++++++++++++++
> >  drivers/iio/imu/bno055/bno055.h               |   12 +
> >  drivers/iio/imu/bno055/bno055_i2c.c           |   57 +
> >  drivers/iio/imu/bno055/bno055_ser_core.c      |  560 ++++++
> >  drivers/iio/imu/bno055/bno055_ser_trace.h     |  104 +
> >  drivers/iio/industrialio-core.c               |   10 +-
> >  include/uapi/linux/iio/types.h                |    7 +-
> >  tools/iio/iio_event_monitor.c                 |    6 +
> >  17 files changed, 2718 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
> >  create mode 100644 Documentation/iio/bno055.rst
> >  create mode 100644 drivers/iio/imu/bno055/Kconfig
> >  create mode 100644 drivers/iio/imu/bno055/Makefile
> >  create mode 100644 drivers/iio/imu/bno055/bno055.c
> >  create mode 100644 drivers/iio/imu/bno055/bno055.h
> >  create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
> >  create mode 100644 drivers/iio/imu/bno055/bno055_ser_core.c
> >  create mode 100644 drivers/iio/imu/bno055/bno055_ser_trace.h
> >
> > --
> > 2.17.1  
> 
> 
> 

