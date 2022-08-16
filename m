Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62D8596305
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiHPTTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbiHPTTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:19:05 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8565AA28;
        Tue, 16 Aug 2022 12:18:59 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id AE1A15FD09;
        Tue, 16 Aug 2022 22:18:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660677536;
        bh=/UhLzGFFLGS0G2G2/rVTiwn7SEmS1KRcXRzpA9GGEas=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=LtDzNpJRqUy0gNJoYTxFTVT3DxTy7oMCxJXymV/fo075OpjUzpr2D6E44Q+cTZ35g
         SRhO50zMIKOHax8LICS057r/Ya+smhIzssLpSOnS6eRoyAilsOdtvSs0ERuxwOUGKc
         ztLG+bzQpslOO3u44H2GNUq3mPuiXLl83pbpn3SAr7k1WcyJ9mLU2pEAnK12kznlL2
         owQMirOWcR+OfjdWhUIMDAMSkKGBWiSHFpssDoXnEm9FpHkmiS/0jEWgRDdJpA+m2/
         SoyNfF0BpZdpkDfE5KY985YZTgDXxkYajhah7W2GeGazMepWFMg/Aw26YHqjHjK96U
         Mr0M7gxdH/yfw==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 16 Aug 2022 22:18:51 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v6 0/4] iio: accel: add MSA311 accelerometer driver
Thread-Topic: [PATCH v6 0/4] iio: accel: add MSA311 accelerometer driver
Thread-Index: AQHYsaT9QeNS+DtgdUK0vR92SwaJgQ==
Date:   Tue, 16 Aug 2022 19:18:42 +0000
Message-ID: <20220816191842.14020-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/16 16:01:00 #20126973
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
sensitivity consumer applications. It has dynamic user-selectable full
scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
with output data rates from 1Hz to 1000Hz.

Spec: https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf

This driver supports following MSA311 features:
    - IIO interface
    - Different power modes: NORMAL and SUSPEND (using pm_runtime)
    - ODR (Output Data Rate) selection
    - Scale and samp_freq selection
    - IIO triggered buffer, IIO reg access
    - NEW_DATA interrupt + trigger

Below features to be done:
    - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
    - Low Power mode

Also this patchset has new vendor prefix for MEMSensing Microsystems and
MSA311 dt-binding schema.

You can test msa311 driver using libiio and gnuplot following below
instructions:
  $ # Create hrtimer trigger object
  $ mkdir /sys/kernel/config/iio/triggers/hrtimer/iio_hrtimer_trigger
  $ # Read 4K samples using msa311-13-new-data trigger (irq) and
  $ # buffer with depth equals to 64 samples and rotate device a little bit
  $ iio_readdev -u "local:" -b 64 -s 4096 -t msa311-13-new-data -T 0 \
  $             msa311-13 > /tmp/msa311.dat
  $ # Or using hrtimer trigger instead of msa311-13-new-data trigger
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

Changes:
* v5->v6:
    - excluded hz units patch series because it was already merged by
      Andrew Morton to linux-next through the nomm-unstable, refer to
      https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/?id=3D0d8f705fc03e2629efa306ed62d5d19ae5c87de1
    - deduplicated val/val2 anonymous struct to iio_decimal_fract struct
    - update pm_runtime information before error handling inside
      msa311_read_raw_data()
    - removed null terminator after scnprintf() usage
    - reworked disabling and unmapping all interrupts to regmap bulk
      operations
    - wrapped up some multiline calls a little bit
    - added zero padding to fractional part of odr logs
    - replaced blank lines between reg fields definitions with registers
      names
    - s/cannot/can't/g

* v4->v5:
    - used chip_name for IRQ and trigger name generation in the form
      msa311-%partid%-*
    - split generic with IIO headers
    - fixup some mathematical forms inside comments
    - provided small code refactoring for commas, comments, and logs
    - removed errno value logging from dev_err_probe() calls per
      Christophe suggestion to avoid extra errno string output
    - returned INDIO_DIRECT_MODE default initializer for indio_dev->modes
    - provided pm_runtime_set_active() call during msa311 probing to let
      runtime PM know that we are starting up with msa311 chip turned on
      as Jonathan suggested
    - used HZ units for hz calculations
    - removed logging contractions
    - removed double calling of regulator_disable() in the probe error
      path
    - used postfix increment operations instead of prefix form :)
    - used %pe specifier to print errno as a string in the dev_err()
    - merged with HZ units patchset from
      https://lore.kernel.org/linux-iio/20220801143811.14817-1-ddrokosov@sb=
erdevices.ru/
    - merged with Andy's str_read_write() patch from
      https://lore.kernel.org/linux-i2c/20220703154232.55549-1-andriy.shevc=
henko@linux.intel.com/
    - used str_read_write() string helper inside driver implementation

* v3->v4:
    - totally reworked pm_runtime flow based on Jonathan suggestions
    - replaced temporary field variable with tmp pointer to field in the
      MSA311_GENMASK macro helper
    - removed i2c pointer from MSA311 private context, retrieved it from
      msa311 object, if anything
    - added struct device *dev reference to MSA311 private context for
      easier msa311->dev translation
    - moved regmap pointer to the beginning of MSA311 private context to
      save some instructions
    - refactored 'if' conditions to be positive and shorter
    - moved msa311_check_partid() and msa311_soft_reset() to separate
      routines and call them before powerup IP logic during probe()
      execution
    - used str_enable_disable() string helper as Andy suggested
    - used msa311_pwr_modes const char * array to translate power modes
      to strings
    - reworked hz->ms translation, used MICROHZ_PER_HZ from the
      following review:
      https://lore.kernel.org/linux-iio/20220801143811.14817-1-ddrokosov@sb=
erdevices.ru/
    - moved dev_dbg() log about MSA311 compatible chip finding under
      partid check
    - refactored stack variables definitions based on "longer lines
      first" thumb
    - used 0 instead of INDIO_DIRECT_MODE before iio buffer setup
    - moved i2c->irq check to msa311_setup_interrupts()
    - removed dev_dbg() prints from ->resume() and ->suspend() callbacks
    - removed "description" fields from "interrupts" and i2c "reg" YAML
      schema nodes
    - implemented simple power supply for MSA311 (vdd-supply)
    - reworked shared_by_all info mask to shared_by_type for MSA311
      accel channels
    - tagged datasheet URL link in the commit message
    - made mutex-based critical section shorter inside odr and fs loop as
      Jonathan suggested
    - fixed wording in the commit messages and comments a little bit,
      refactored some indentations
    - replaced blank lines between register offset definitions with
      short comments

* v2->v3:
    - removed MSA311_TIMESTAMP_CHANNEL() macro, used IIO_CHAN_SOFT_TIMESTAM=
P
      directly
    - do not call dev_err_probe() inside functions, which is used not only
      from probe() path
    - simplified error handling a little bit
    - used iio_device_claim_direct_mode() and
      iio_device_release_direct_mode() to lock attributes when buffer mode
      is enabled
    - prohibited sampling frequency changing during buffer usage because
      otherwise sometimes MSA311 returns outliers when frequency values
      grow up in the read operation moment
    - allowed scale value changing when buffer mode is enabled
    - removed IRQF_TRIGGER_RISING irq flag from irg registration because
      it's provided from device tree directly
    - do not switch off autosuspend from powerdown() devm callback,
      because it's already done from pm_runtime_disable() during
      devm pm_runtime actions
    - provided more information why we need force suspend state for MSA311
      in the powerdown flow
    - reworked comments stuff: removed obvious extra comments, provided
      more details in the complex driver code places

* v1->v2:
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

Andy Shevchenko (1):
  lib/string_helpers: Add str_read_write() helper

Dmitry Rokosov (3):
  dt-bindings: vendor-prefixes: add MEMSensing Microsystems Co., Ltd.
  iio: add MEMSensing MSA311 3-axis accelerometer driver
  dt-bindings: iio: accel: add dt-binding schema for msa311 accel driver

 .../bindings/iio/accel/memsensing,msa311.yaml |   53 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    7 +
 drivers/iio/accel/Kconfig                     |   13 +
 drivers/iio/accel/Makefile                    |    2 +
 drivers/iio/accel/msa311.c                    | 1328 +++++++++++++++++
 include/linux/string_helpers.h                |    5 +
 7 files changed, 1410 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/memsensing,=
msa311.yaml
 create mode 100644 drivers/iio/accel/msa311.c

--=20
2.36.0
