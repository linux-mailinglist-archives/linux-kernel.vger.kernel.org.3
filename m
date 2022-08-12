Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65603591454
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbiHLQxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiHLQxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:53:05 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC608ACA12;
        Fri, 12 Aug 2022 09:52:58 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 2A11C5FD0A;
        Fri, 12 Aug 2022 19:52:57 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660323177;
        bh=oibksYrmp8+cmV76Bmyg6glyKiwiaHuhHP5Cf1Ebjxg=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=i07pppQ6y/aragU2jdKWRvc+w2snpI8Ahvmp/HIFotDgrGdG8c+lCusfzt+SkgGHL
         +5ONep24efdrss0K7uHznNJJkfoeC9MmK3m7gMVDDXYbN37BAQeWJIuR6uNcHoOJm+
         kl/BfSsGsNtIWmsPbiFzLtOAWVEQ5PUOu7C2fTEPrUzxORrk/IWGUnX/EOTkRJowu0
         X8D+tr0Wv2cK2C17O2t3O5x5O8VedWfFtyPFzOacOqqY1Rktq4HKujgrF4mdYMFNxF
         4qcv/Gq5eNMLS2B4dlmB47PQxbS6ZJYieiu9VY5OqnYULzARWXmoWeQ0lax6iBbzRg
         EDHIOMDUVeyQg==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 12 Aug 2022 19:52:57 +0300 (MSK)
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
Subject: [PATCH v5 3/7] iio: accel: adxl345: use HZ macro from units.h
Thread-Topic: [PATCH v5 3/7] iio: accel: adxl345: use HZ macro from units.h
Thread-Index: AQHYrmvn+yd0HsMjbk2UK1PjZ2KMUA==
Date:   Fri, 12 Aug 2022 16:52:27 +0000
Message-ID: <20220812165243.22177-4-ddrokosov@sberdevices.ru>
References: <20220812165243.22177-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220812165243.22177-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/12 13:28:00 #20103614
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated definition of NHZ_PER_HZ, because it's available in
the units.h as NANOHZ_PER_HZ.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_c=
ore.c
index 370bfec1275a..1919e0089c11 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
=20
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -32,7 +33,6 @@
=20
 #define ADXL345_BW_RATE			GENMASK(3, 0)
 #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
-#define NHZ_PER_HZ			1000000000LL
=20
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
 #define ADXL345_POWER_CTL_STANDBY	0x00
@@ -139,7 +139,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
=20
 		samp_freq_nhz =3D ADXL345_BASE_RATE_NANO_HZ <<
 				(regval & ADXL345_BW_RATE);
-		*val =3D div_s64_rem(samp_freq_nhz, NHZ_PER_HZ, val2);
+		*val =3D div_s64_rem(samp_freq_nhz, NANOHZ_PER_HZ, val2);
=20
 		return IIO_VAL_INT_PLUS_NANO;
 	}
@@ -164,7 +164,8 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 				    ADXL345_REG_OFS_AXIS(chan->address),
 				    val / 4);
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		n =3D div_s64(val * NHZ_PER_HZ + val2, ADXL345_BASE_RATE_NANO_HZ);
+		n =3D div_s64(val * NANOHZ_PER_HZ + val2,
+			    ADXL345_BASE_RATE_NANO_HZ);
=20
 		return regmap_update_bits(data->regmap, ADXL345_REG_BW_RATE,
 					  ADXL345_BW_RATE,
--=20
2.36.0
