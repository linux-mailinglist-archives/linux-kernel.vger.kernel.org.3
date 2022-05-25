Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCAD5342C2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbiEYSPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiEYSPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:15:46 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D48A7765;
        Wed, 25 May 2022 11:15:44 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 2BF795FD08;
        Wed, 25 May 2022 21:15:42 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653502542;
        bh=riIFQqNoW+ACkc2C9IIrpMgADs2behUZv7YE7/IUt7A=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=Ybw255Y4637YhACItAVip4ZpkdwQK+jSUQuP49M5y+xVeVCMEYy7Y3/yqiMipkHGl
         0b6vCGu8hGkiVHMeW8Vb3sqwUz0KndEL+Njj225HEdyv/BkKn7jcxQyeb9f2/NMOsU
         5MQ2yiPzIDbZ7oO6l2Ov3Nv3XZKyR7k9l2WjbsSXtoKr38e1h30N+wNHGaJrjFKzZ8
         s6ABICXZ7gfsZx/VjCByIHlJ5UkGkDn+fpmAkOfWP28hosWbnIrj6FUqZmXJs+e4r7
         yjyl8HBuJOPa4USVM79rdISmLRCmg4feYi6tYlHwRiO/3TOhHyNd63CaIJsSneKtpe
         NIVzj13kkxlzg==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed, 25 May 2022 21:15:41 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v2 0/3] iio: accel: add MSA311 accelerometer driver
Thread-Topic: [PATCH v2 0/3] iio: accel: add MSA311 accelerometer driver
Thread-Index: AQHYcGNo7EbciBjN3kyYafm+cTV5vA==
Date:   Wed, 25 May 2022 18:15:26 +0000
Message-ID: <20220525181532.6805-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/25 08:39:00 #19569940
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
sensitivity consumer applications. It has dynamical user selectable full
scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
with output data rates from 1Hz to 1000Hz.

Datasheet can be found at following URL:
https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf

This driver supports following MSA311 features:
    - IIO interface
    - Different power modes: NORMAL and SUSPEND (using pm_runtime)
    - ODR (Output Data Rate) selection
    - Scale and samp_freq selection
    - IIO triggered buffer, IIO reg access
    - NEW_DATA interrupt + trigger

Below features to be done:
    - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL

Also this patchset has new vendor prefix for MEMSensing Microsystems and
MSA311 dt-binding schema.

You can test msa311 driver using libiio and gnuplot following below
instructions:
  $ # Create hrtimer trigger object
  $ mkdir /sys/kernel/config/iio/triggers/hrtimer/iio_hrtimer_trigger
  $ # Read 4K samples using msa311-new-data trigger (irq) and
  $ # buffer with depth equals to 64 samples and rotate device a little bit
  $ iio_readdev -u "local:" -b 64 -s 4096 -t msa311-new-data -T 0 \
  $             msa311 > /tmp/msa311.dat
  $ # Or using hrtimer trigger instead of msa311-new-data trigger
  $ iio_readdev -u "local:" -b 64 -s 4096 -t iio_hrtimer_trigger -T 0 \
  $                msa311 > /data/local/tmp/msa311.dat
  $ cat <<EOF >> msa311_data.gnu
  set title "MSA311 Accel Data"

  set key below

  set xdata time
  set format x "%H:%M\n%.4S"
  set xlabel "timestamp"

  set autoscale y

  plot 'msa311.dat' binary endian=3Dlittle \
                    format=3D'%int16%int16%int16%uint16%uint64' using \
                    (\$5/1000000000):(int(\$1)/16) title "acc_x" \
                    with lines,\\
       'msa311.dat' binary endian=3Dlittle \
                    format=3D'%int16%int16%int16%uint16%uint64' using \
                    (\$5/1000000000):(int(\$2)/16) title "acc_y" \
                    with lines,\\
       'msa311.dat' binary endian=3Dlittle \
                    format=3D'%int16%int16%int16%uint16%uint64' using \
                    (\$5/1000000000):(int(\$3)/16) title "acc_z" with lines
  EOF
  $ gnuplot --persist msa311_data.gnu

Changes v1->v2:
    - memsensing vendor prefix was moved to right place by
      alphabetical order
    - LOW mode mention was deleted, because LOW mode isn't supported
      in the current driver version
    - reworked some enums with gaps to defines
    - reworked register names as Jonathan mentioned in the v1
    - do not use regmap_field API for entire registers
    - deleted all extra comments
    - supported info_mask_*_avail bitmaps instead of explicit IIO attrs
      definitions, implemented read_avail() callback for samp_freq and
      scale values
    - msa311 mutex is still used to protect msa311 power transitions,
      samp_freq/scale tune and axes data handling; described this lock
      more informative
    - ask new_data interruption status from appropriate register,
      do not hold atomic variable for that
    - optimized reads of axes data by I2C using regmap_bulk API
    - use dev_err_probe() instead of dev_err() for all probe() code paths
    - from now all I2C bus communication failures are interpreted as errors
    - described wait_from_next() semantic better
    - deleted all unneeded pm wrappers
    - interpreter all axes data as __le16 type and adjust them to right
      format (endianness + sign) for raw() flow only
    - redesigned msa311_fs_table[] to 2D matrix (it's more comfortable
      format for read_avail() callback)
    - align and initialize msa311 buffer before pushing properly
    - use pm_runtime resume and suspend from buffer preenable/postdisable,
      deleted them from trigger set_state
    - supported multiple trigger usage (tested with external hrtimer
      trigger and internal new_data trigger)
    - moved all irq related stuff to msa311_setup_interrupts() routine
    - implemented msa311_powerdown() devm release action
    - reworked initialization of pm_runtime msa311 flow, use
      autosuspend logic
    - purged driver remove() callback, because of devm release logic runs
      all deinit stuff fully
    - fixed dts bindings problems
    - changed irq type in the dt-binding description, because interrupt
      type for msa311 should have the same type as i2c irq, for example
      using the gpio_intc it's IRQ_TYPE_EDGE_RISING usually. Otherwise
      we may lose irq map on the second and further insmod attempts

Dmitry Rokosov (3):
  dt-bindings: vendor-prefixes: add MEMSensing Microsystems Co., Ltd.
  iio: add MEMSensing MSA311 3-axis accelerometer driver
  dt-bindings: iio: accel: add dt-binding schema for msa311 accel driver

 .../bindings/iio/accel/memsensing,msa311.yaml |   56 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    7 +
 drivers/iio/accel/Kconfig                     |   13 +
 drivers/iio/accel/Makefile                    |    2 +
 drivers/iio/accel/msa311.c                    | 1525 +++++++++++++++++
 6 files changed, 1605 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/memsensing,=
msa311.yaml
 create mode 100644 drivers/iio/accel/msa311.c

--=20
2.36.0
