Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF9853304B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbiEXSPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbiEXSO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:14:59 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ABD69492;
        Tue, 24 May 2022 11:14:53 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id B4F6F5FD06;
        Tue, 24 May 2022 21:14:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653416090;
        bh=dOaYOkvqn36umqt+frOJLwfCvkCb/3auOlWf4DaSnGk=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=TJ6W+NhWhQfrjBpmyk5quLYuZbI/MHs9p78KWbj+PHiP8P5oXmSyUeXXKXtaULqp2
         /XNJ2SzZ50eF7tdnSaZP0Q5pdDwHOoD2h+50Yi+7VWiUBnEr7IwAftyCwVPktdHclU
         VCeYTBxwENr9wV4TYvl4NE7r3Q5qXcw/md65VOjOJtS1dJsyU/SnNY0QKZ/qWEnUjj
         iGtgF43WCSi3KNP8ry5AOwAZlCUORsduHsNqWRILij+alKtjhHdqyEWaYxAN44y+Jr
         Aez0KcA/n/avUD5NZQM2QnNLKLzu4OWQVgdJGPlIfEB/XHCvq7lw1nOU4QUIcIyWPm
         kTekoO9hkMwnw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 24 May 2022 21:14:50 +0300 (MSK)
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
Subject: [PATCH v2 2/5] iio:accel:kxcjk-1013: rearrange iio trigger get and
 register
Thread-Topic: [PATCH v2 2/5] iio:accel:kxcjk-1013: rearrange iio trigger get
 and register
Thread-Index: AQHYb5ojCEqLwP6/VUC+gHh54b7quA==
Date:   Tue, 24 May 2022 18:14:42 +0000
Message-ID: <20220524181150.9240-3-ddrokosov@sberdevices.ru>
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

Fixes: c1288b833881 ("iio: accel: kxcjk-1013: Increment ref counter for ind=
io_dev->trig")
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
