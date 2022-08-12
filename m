Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2C5591441
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbiHLQxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239394AbiHLQxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:53:05 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBE8ACA14;
        Fri, 12 Aug 2022 09:52:59 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 90E7D5FD0B;
        Fri, 12 Aug 2022 19:52:57 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660323177;
        bh=TzU4kxbiPq2CIG0Dt3uNo8LzBU6MDWGbGwPmFW3Wyc8=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=BcJNak41TNVgMAEqn48XCEkqBus0EK3Fbhn2XPIifejTrR+50LRULNLAv5L8aT3uf
         QpG+u/FkatyeRKqxwke+LXGLr82wyNFpYZzfkQKLR9U/J/+e3pUXf/3FugvGYKQ5x1
         WS6c/zqe8KzjadK/llIu6sRfjvkHFUsX584AvW7Emh2EOJzdDYfRfaWgdPnxdtlFbV
         g1+OmZGooCxWOHfMX7gaRq4uKougQ17tsMkcA5Tofcz5xx6lFT7qe1DbVhr9SJEWte
         1jUGrgENNjaltG4WC+/yZHaEo8Px4UeUj9iJ/UzTuvbgXgJgoxAXWJOQ+IHbHkX7fc
         kweC8vgSAtO+A==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
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
Subject: [PATCH v5 4/7] iio: common: scmi_sensors: use HZ macro from units.h
Thread-Topic: [PATCH v5 4/7] iio: common: scmi_sensors: use HZ macro from
 units.h
Thread-Index: AQHYrmvn6T4LySVM6EmqFD3kF6Rglw==
Date:   Fri, 12 Aug 2022 16:52:27 +0000
Message-ID: <20220812165243.22177-5-ddrokosov@sberdevices.ru>
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

Remove duplicated definition of UHZ_PER_HZ, because it's available in
the units.h as MICROHZ_PER_HZ.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/commo=
n/scmi_sensors/scmi_iio.c
index 793d628db55f..54ccf19ab2bb 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -18,6 +18,7 @@
 #include <linux/scmi_protocol.h>
 #include <linux/time.h>
 #include <linux/types.h>
+#include <linux/units.h>
=20
 #define SCMI_IIO_NUM_OF_AXIS 3
=20
@@ -130,7 +131,6 @@ static const struct iio_buffer_setup_ops scmi_iio_buffe=
r_ops =3D {
 static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2=
)
 {
 	struct scmi_iio_priv *sensor =3D iio_priv(iio_dev);
-	const unsigned long UHZ_PER_HZ =3D 1000000UL;
 	u64 sec, mult, uHz, sf;
 	u32 sensor_config;
 	char buf[32];
@@ -145,7 +145,7 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev=
, int val, int val2)
 		return err;
 	}
=20
-	uHz =3D val * UHZ_PER_HZ + val2;
+	uHz =3D val * MICROHZ_PER_HZ + val2;
=20
 	/*
 	 * The seconds field in the sensor interval in SCMI is 16 bits long
@@ -156,10 +156,10 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_d=
ev, int val, int val2)
 	 * count the number of characters
 	 */
 	sf =3D (u64)uHz * 0xFFFF;
-	do_div(sf,  UHZ_PER_HZ);
+	do_div(sf,  MICROHZ_PER_HZ);
 	mult =3D scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
=20
-	sec =3D int_pow(10, mult) * UHZ_PER_HZ;
+	sec =3D int_pow(10, mult) * MICROHZ_PER_HZ;
 	do_div(sec, uHz);
 	if (sec =3D=3D 0) {
 		dev_err(&iio_dev->dev,
--=20
2.36.0
