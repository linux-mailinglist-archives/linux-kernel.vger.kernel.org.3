Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3E8585468
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiG2RXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiG2RXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:23:43 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DA988752;
        Fri, 29 Jul 2022 10:23:41 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id A1F405FD08;
        Fri, 29 Jul 2022 20:23:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1659115419;
        bh=PyxBA2BnLYxW1rMCm26qSJkySETPdFlB7N+MFu9zNgM=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=oe4GcA4kRHmGtk9d0AcBZYjZzhXsM810HW6dLxRsV8aVZLYCW1637TqHT+VXtN7ak
         DBeoG2ENgldW4TQIPY1VFfzGXqyZ8UVP3m35N7xBkHUzvZbmEDIdVD/SNTFAhXdBqe
         C34m2GM/eEr9I5ze6fQXsnQmbXtiiWkgbRLa3O4UFnmDbE/Cd/bzTC/he6Y2wZAHPr
         m/PyqkXuKNF0+M0f5nckJDjpkvV0QUyMX1gAZfnVauHfGgJmpnxOeMjnfk35qRjplq
         GYF1haejajXZlQiwxlkSc+kExoa5TUrKD78d0YC4omy8JlSQsZcpnGJhtPfxZWg3/E
         bpVv5F0HM4lmA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 29 Jul 2022 20:23:39 +0300 (MSK)
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
Subject: [PATCH v2 3/3] iio: common: scmi_sensors: use HZ macro from units.h
Thread-Topic: [PATCH v2 3/3] iio: common: scmi_sensors: use HZ macro from
 units.h
Thread-Index: AQHYo2/ffOY1iq+jkk6eezTkPE4aJA==
Date:   Fri, 29 Jul 2022 17:23:09 +0000
Message-ID: <20220729172332.19118-4-ddrokosov@sberdevices.ru>
References: <20220729172332.19118-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220729172332.19118-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/07/29 15:10:00 #20001216
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated definition of UHZ_PER_HZ, because it's available in
the units.h.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/commo=
n/scmi_sensors/scmi_iio.c
index 793d628db55f..c6d2cf5504cb 100644
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
--=20
2.36.0
