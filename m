Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE1F53304A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbiEXSPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbiEXSO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:14:59 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7821B6CA8F;
        Tue, 24 May 2022 11:14:55 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id A757C5FD0A;
        Tue, 24 May 2022 21:14:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653416093;
        bh=os6EAspX1ZzgEY1Q9Wl3TknUG4z4hWbD3e48SXn7EUU=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=N/VPJ9TmREnRmW8cYLn5Mchx1qALLGggqcrKBkHmK5X0veZC5DP3zaG3b9APH/VNj
         /nBpneVlJyc1t8tZ0Vi7angseTpJokVXTTT7Qd7F8ay+QICY3pfGdQ75+Po3zYp6AG
         sM7dsbej7gy4Ct6V8sbmE9SPpPwsMp4BD8HQ0r/cqkeMw414LUV2nVbbqLWVYrN1sk
         3zYTr1lN/Ugn/ZWgHTQJ1qLfHBbMLFycpG63YpFauWU5TRAjn8jLh9k8Hu1DNv61Pa
         Wox/qajk25j+I0b27b8ErvjkWPbWYB3qgv1/yUXq6xdgHyoFPi2FrVlReEHBwgarIA
         gPZJuZrm5lzgg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 24 May 2022 21:14:53 +0300 (MSK)
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
Subject: [PATCH v2 5/5] iio:humidity:hts221: rearrange iio trigger get and
 register
Thread-Topic: [PATCH v2 5/5] iio:humidity:hts221: rearrange iio trigger get
 and register
Thread-Index: AQHYb5omUbuzeC6UtE+2WwHgewDwHw==
Date:   Tue, 24 May 2022 18:14:46 +0000
Message-ID: <20220524181150.9240-6-ddrokosov@sberdevices.ru>
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

Fixes: e4a70e3e7d84 ("iio: humidity: add support to hts221 rh/temp combo de=
vice")
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/iio/humidity/hts221_buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/ht=
s221_buffer.c
index f29692b9d2db..66b32413cf5e 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -135,9 +135,12 @@ int hts221_allocate_trigger(struct iio_dev *iio_dev)
=20
 	iio_trigger_set_drvdata(hw->trig, iio_dev);
 	hw->trig->ops =3D &hts221_trigger_ops;
+
+	err =3D devm_iio_trigger_register(hw->dev, hw->trig);
+
 	iio_dev->trig =3D iio_trigger_get(hw->trig);
=20
-	return devm_iio_trigger_register(hw->dev, hw->trig);
+	return err;
 }
=20
 static int hts221_buffer_preenable(struct iio_dev *iio_dev)
--=20
2.36.0
