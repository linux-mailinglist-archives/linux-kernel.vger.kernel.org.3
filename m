Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F187586CFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiHAOi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiHAOiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:38:24 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13123336D;
        Mon,  1 Aug 2022 07:38:19 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 0C1D65FD19;
        Mon,  1 Aug 2022 17:38:18 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1659364698;
        bh=oibksYrmp8+cmV76Bmyg6glyKiwiaHuhHP5Cf1Ebjxg=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=GzwXIxQrYrOFwlFnyEkuF61j43Wn4QR/bEeiSVOycdY+Md8kjoLYxvfYmlErhsGEn
         QByNaI85qFhqYH3HpDYUSvsxO0FA9KOOZiMO9EBfmOkOQ0JfqqisHpJdx0Q98bUnIA
         vg4+qdKxbssX/m6kHC/CO8VbJKIxoS1a5YhhT8Vph1MiqG5NTW/fJo4mcNIRQ5lO3k
         aJgcUsRmMQxr9oKbPqe9O5r6dqST60uqrDzvwmCP9++gIHdgfmd4MERwmFFBkNaNfx
         7AKUZZTkaZdmny8wyhSpayWoHptgATf8aP2fBpoowuyXec1dhRrL5x3KaRlIWu6J7u
         CJoMP2nmQ21Ig==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon,  1 Aug 2022 17:38:18 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v3 2/3] iio: accel: adxl345: use HZ macro from units.h
Thread-Topic: [PATCH v3 2/3] iio: accel: adxl345: use HZ macro from units.h
Thread-Index: AQHYpbQ4GlLNqvVvrk2lqYyyK67LKQ==
Date:   Mon, 1 Aug 2022 14:37:26 +0000
Message-ID: <20220801143811.14817-3-ddrokosov@sberdevices.ru>
References: <20220801143811.14817-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220801143811.14817-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/01 10:27:00 #20025860
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
