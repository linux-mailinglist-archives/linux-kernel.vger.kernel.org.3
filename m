Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29EC539605
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346898AbiEaSPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344730AbiEaSPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:15:30 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D4F8B0A8;
        Tue, 31 May 2022 11:15:26 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id B0D485FD12;
        Tue, 31 May 2022 21:15:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1654020923;
        bh=RECarx99JuMrKT6qW5q4w84D77se/I9xBnKlrdN/ovE=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=ALwDxe7ZRzPVEfD8Fsw0wIdgJYTIASfK/raqCAyGCDd8P08UMM4yGG60cdvGYprvt
         qQo8VYfFzx5gohHYOP0E8qhaX1tndQMwTGrb4cSNxPcFXIPx5GNE23Oc4DBgswWzI5
         9G5DIiucx3hrwc/n65AI3pLlim2kP2y5p7/lzypO3C9m4Sei3B96NYzPwbJG2GHCtu
         PpxhyTS5onmKOaBBKGHEumumGrEz4NY6LNihUlLq7YNinGxhZXhB78kfamSxAupvdp
         2QNh7zDq1h/zJdpW9iRtVLw7s6hVx6dEqSN0+yEHQGVOHhlmZHFFFWnhulwXDWkc1/
         2c1sbUp2gPMBg==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 31 May 2022 21:15:14 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v1] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Topic: [PATCH v1] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Index: AQHYdRpaUrhZ5pf6gEC6S1oZ2DfDiA==
Date:   Tue, 31 May 2022 18:15:05 +0000
Message-ID: <20220531181457.26034-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/31 13:37:00 #19629522
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a part of patch series about wrong trigger register() and get()
calls order in the some IIO drivers trigger initialization path:

https://lore.kernel.org/all/20220524181150.9240-1-ddrokosov@sberdevices.ru/

runtime WARN() is added to alarm IIO driver authors who make such
a mistake.

When IIO driver allocates a new IIO trigger, it should register it before
calling get() operation. Otherwise, the next iio_trigger_put() will upset
refcnt balance.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 include/linux/iio/trigger.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 4c69b144677b..4a008b952710 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -93,6 +93,15 @@ static inline void iio_trigger_put(struct iio_trigger *t=
rig)
 static inline struct iio_trigger *iio_trigger_get(struct iio_trigger *trig=
)
 {
 	get_device(&trig->dev);
+
+	/*
+	 * If driver hasn't called iio_trigger_register() before and trig->owner
+	 * wasn't initialized properly, trigger will have wrong number of users
+	 */
+	WARN(!trig->owner,
+	     "Ignore module getting for non-registered iio trigger %s\n",
+	     trig->name);
+
 	__module_get(trig->owner);
=20
 	return trig;
--=20
2.36.0
