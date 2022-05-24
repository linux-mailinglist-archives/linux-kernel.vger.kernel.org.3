Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89229533046
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbiEXSPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbiEXSO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:14:59 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC3C6C54F;
        Tue, 24 May 2022 11:14:54 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 6C46B5FD09;
        Tue, 24 May 2022 21:14:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653416092;
        bh=qgYEDOiqZYS47KPb+xFuxK7tgHcFYsBBq4aS6RNbuaQ=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=lyZTxqT1f9vowUaWcXgZAqtE7ogHVbp61ESEu5MrnbUqBUKfPu6K6xuh9C8ZKqkSn
         hApnz4okd+YqrD++Z/aENMfQ7qOOVFmgExXpxxQY9yzQUL/QoGGzcOQDw5oYB7i8ED
         TKi9DoJpMqGMWD+cQXJ4laaNLyzdkKJfOdmXX+CjsKZn2SVlmQoEG9aiyQO6EUYSRI
         Gp9MRkWHUGoxD7piHauc5y9K5nOUFLhzLyvdFKalxk1AvJv0f6WH79oK3rVTsF0aQg
         g7vS91KkPCfFzNli8PWI7c7XeqkoMrHLgs7X/K6qJCda/h7Q9VYVtX0hpc9Ra7wAjC
         2bmF9LAGEdNtQ==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 24 May 2022 21:14:52 +0300 (MSK)
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
Subject: [PATCH v2 4/5] iio:chemical:ccs811: rearrange iio trigger get and
 register
Thread-Topic: [PATCH v2 4/5] iio:chemical:ccs811: rearrange iio trigger get
 and register
Thread-Index: AQHYb5olzVWMeGfB9k26hyqb2INtTA==
Date:   Tue, 24 May 2022 18:14:45 +0000
Message-ID: <20220524181150.9240-5-ddrokosov@sberdevices.ru>
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

Fixes: f1f065d7ac30 ("iio: chemical: ccs811: Add support for data ready tri=
gger")
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/iio/chemical/ccs811.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 847194fa1e46..80ef1aa9aae3 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -499,11 +499,11 @@ static int ccs811_probe(struct i2c_client *client,
=20
 		data->drdy_trig->ops =3D &ccs811_trigger_ops;
 		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
-		indio_dev->trig =3D data->drdy_trig;
-		iio_trigger_get(indio_dev->trig);
 		ret =3D iio_trigger_register(data->drdy_trig);
 		if (ret)
 			goto err_poweroff;
+
+		indio_dev->trig =3D iio_trigger_get(data->drdy_trig);
 	}
=20
 	ret =3D iio_triggered_buffer_setup(indio_dev, NULL,
--=20
2.36.0
