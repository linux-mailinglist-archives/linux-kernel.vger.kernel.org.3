Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F95850728D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354369AbiDSQHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354328AbiDSQH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:07:29 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611B235ABB;
        Tue, 19 Apr 2022 09:04:35 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id B48355FD06;
        Tue, 19 Apr 2022 18:46:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1650383203;
        bh=FgIhnfyhkzdJQqe2GL+vfkTnpbKRdN4mqOCrSqMUQG4=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=jv7Wou6+JNuIklPgKYH35wR6JLyMCCUOdLXLmkHd3WM6dLt0WOqmvlsG8u3/ZxJ6D
         FUBu5OaunqsvMVodcZMDiLSoNmonn2iwP321lBiTFyR/xkwJzRiR1XdMzKtuJFxQJJ
         bGRKlWCT9rmeVM8KJ7X6q01JIm1HzLlK2IRyByg7VwqwZBTQjZ4vDz9ZxZYepVnCNZ
         Qs10cmRoKpDtwx4L7rhQ16BUDfsOVLDW5yX+0EwuPV/fp9O7Zn2qIi4xM9gkrRqCPA
         5j/cYtXpqPzejZp7Z3QYfzvNvkrwobL1LWHs8YPZUzl1xFYkQhnNPsR/Nu9t/gX4wx
         lw/Zp6EryiG1w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 19 Apr 2022 18:46:43 +0300 (MSK)
From:   Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
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
        Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
Subject: [PATCH v1 0/3] iio: accel: add MSA311 accelerometer driver
Thread-Topic: [PATCH v1 0/3] iio: accel: add MSA311 accelerometer driver
Thread-Index: AQHYVASG6e/L14/R5Uev6QnUCJ5Flw==
Date:   Tue, 19 Apr 2022 15:45:48 +0000
Message-ID: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/04/19 10:34:00 #19304456
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
    - Different power modes: NORMAL, SUSPEND and LOW (using pm_runtime)
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
$ # Read 4K samples using buffer with depth equals to 64 samples and
$ # rotate device a little bit
$ iio_readdev -u "local:" -b 64 -s 4096 msa311 > /data/local/tmp/msa311.dat
$ gnuplot
gnuplot> set title "MSA311 Accel Data"
gnuplot>
gnuplot> set key below
gnuplot>
gnuplot> set xdata time
gnuplot> set format x "%H:%M\n%.4S"
gnuplot> set xlabel "timestamp"
gnuplot>
gnuplot> set autoscale y
gnuplot> plot 'msa311.dat' binary format=3D'%int16%int16%int16%uint16%uint6=
4'\
>      using ($5/1000000000):1 title "acc_x" with lines,\
>     'msa311.dat' binary format=3D'%int16%int16%int16%uint16%uint64' using=
\
>     ($5/1000000000):2 title "acc_y" with lines,\
>     'msa311.dat' binary format=3D'%int16%int16%int16%uint16%uint64' using=
\
>     ($5/1000000000):3 title "acc_z" with lines

Dmitry Rokosov (3):
  dt-bindings: vendor-prefixes: add MEMSensing Microsystems Co., Ltd.
  iio: add MEMSensing MSA311 3-axis accelerometer driver
  dt-bindings: iio: accel: add dt-binding schema for msa311 accel driver

 .../bindings/iio/accel/memsensing,msa311.yaml      |   64 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 MAINTAINERS                                        |    7 +
 drivers/iio/accel/Kconfig                          |   13 +
 drivers/iio/accel/Makefile                         |    2 +
 drivers/iio/accel/msa311.c                         | 2068 ++++++++++++++++=
++++
 6 files changed, 2156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/memsensing,=
msa311.yaml
 create mode 100644 drivers/iio/accel/msa311.c

--=20
2.9.5
