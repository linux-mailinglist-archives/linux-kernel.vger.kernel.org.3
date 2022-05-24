Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C73A53304C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240301AbiEXSPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbiEXSPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:15:00 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AB46CA9D;
        Tue, 24 May 2022 11:14:58 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 5416F5FD0B;
        Tue, 24 May 2022 21:14:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653416096;
        bh=K2muH5vO9MfAzTUQW005aRcgGyOuYwng/xoy88E0u9c=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=SEMwLohE6S/82nvvmh9ZWmGDOGokf9qQ98M3em72FmHhv531KUcJI4s/XJ4HPlNnG
         fzNzosGG6HFy0DUm43Y5JhznIeRf3E8swCLE01Rv1nLSx7fzPOu2WGAu5OA7Fu2/l0
         +Z1SO+dXQxi/ApFIZ5rHa0I1J2Huduqz7PPRGfDedJoDhOBP8Z+K9PNWew0kVon1VJ
         GKx3UDWSQKRmZInEwkvtLgodHeJQXgoAcJnh31JwtO7ovFoiuEds5L1fry547s2g9T
         D1dpLE3ITIXIrybk8G1rO4wOjtkSszaTNLoSAOlEc56Ua1xU9LJK12SL242B4h4PJ5
         KdKT2zmDe/LbQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 24 May 2022 21:14:46 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "teodora.baluta@intel.com" <teodora.baluta@intel.com>,
        "narcisaanamaria12@gmail.com" <narcisaanamaria12@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v2 1/5] iio:accel:bma180: rearrange iio trigger get and
 register
Thread-Topic: [PATCH v2 1/5] iio:accel:bma180: rearrange iio trigger get and
 register
Thread-Index: AQHYb5oiMClU4oOenUKT2ho77cNDVQ==
Date:   Tue, 24 May 2022 18:14:39 +0000
Message-ID: <20220524181150.9240-2-ddrokosov@sberdevices.ru>
References: <20220524181150.9240-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220524181150.9240-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/24 14:34:00 #19560786
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IIO trigger interface function iio_trigger_get() should be called after
iio_trigger_register() (or its devm analogue) strictly, because of
iio_trigger_get() acquires module refcnt based on the trigger->owner
pointer, which is initialized inside iio_trigger_register() to
THIS_MODULE.
If this call order is wrong, the next iio_trigger_put() (from sysfs
callback or "delete module" path) will dereference "default" module
refcnt, which is incorrect behaviour.

Fixes: 0668a4e4d297 ("iio: accel: bma180: Fix indio_dev->trig assignment")
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/iio/accel/bma180.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index d8a454c266d5..5d0bd0fc3018 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -1006,11 +1006,12 @@ static int bma180_probe(struct i2c_client *client,
=20
 		data->trig->ops =3D &bma180_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
-		indio_dev->trig =3D iio_trigger_get(data->trig);
=20
 		ret =3D iio_trigger_register(data->trig);
 		if (ret)
 			goto err_trigger_free;
+
+		indio_dev->trig =3D iio_trigger_get(data->trig);
 	}
=20
 	ret =3D iio_triggered_buffer_setup(indio_dev, NULL,
--=20
2.36.0
