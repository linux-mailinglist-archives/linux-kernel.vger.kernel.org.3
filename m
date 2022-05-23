Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86735319B9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbiEWQnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbiEWQmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:42:44 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252A6EF;
        Mon, 23 May 2022 09:42:42 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 738B75FD05;
        Mon, 23 May 2022 19:42:40 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653324160;
        bh=KSNN3/SNVVoMLQgBH67pg26wUu1UyA2zzxxh/p/8KWk=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=sAvZdvCEZDnGLrdkGMijlJyGRcX3vOOJ+KKH1sddY2eE1fFw1xvrFErxiyfQIbyqm
         usKxK/aO10ku67HtDHTEPpqmDVMqVcaJGo/tFQMlhlTasfUsr5dg9WYEM2+mQIsrhE
         FB6zPuzcXmHQC3wmwF1W4nkkN6/eAB+HSLzmvhLAJQLBUZaXCYMgAGjJHXknaYoLMv
         wtAL9T1aRwB7bjI8XEAPtCFNmIDRslOtAwN5n/1IjZG9IPWvpB7F+JGV7U5CXOJQ/8
         uuVIB1XPuwUBA5w547S6nDeh201NX7zXUnuahxnqKxk+DaAIOccuNOjGk6tNRinIdk
         bJI9+dBpiym8Q==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 23 May 2022 19:42:40 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
        "sean@geanix.com" <sean@geanix.com>,
        "linmq006@gmail.com" <linmq006@gmail.com>,
        "gwendal@chromium.org" <gwendal@chromium.org>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v1 2/5] iio:accel:kxcjk-1013: rearrange iio trigger get and
 register
Thread-Topic: [PATCH v1 2/5] iio:accel:kxcjk-1013: rearrange iio trigger get
 and register
Thread-Index: AQHYbsP+NLTBqMK3pECmP2jvyza5WA==
Date:   Mon, 23 May 2022 16:41:47 +0000
Message-ID: <20220523164159.11579-3-ddrokosov@sberdevices.ru>
References: <20220523164159.11579-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220523164159.11579-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/23 07:03:00 #19535618
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
callbacks or rmmod) will derefence "default" module refcnt, which is
completely incorrect.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/iio/accel/kxcjk-1013.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.=
c
index ac74cdcd2bc8..748b35c2f0c3 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1554,12 +1554,12 @@ static int kxcjk1013_probe(struct i2c_client *clien=
t,
=20
 		data->dready_trig->ops =3D &kxcjk1013_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
-		indio_dev->trig =3D data->dready_trig;
-		iio_trigger_get(indio_dev->trig);
 		ret =3D iio_trigger_register(data->dready_trig);
 		if (ret)
 			goto err_poweroff;
=20
+		indio_dev->trig =3D iio_trigger_get(data->dready_trig);
+
 		data->motion_trig->ops =3D &kxcjk1013_trigger_ops;
 		iio_trigger_set_drvdata(data->motion_trig, indio_dev);
 		ret =3D iio_trigger_register(data->motion_trig);
--=20
2.36.0
