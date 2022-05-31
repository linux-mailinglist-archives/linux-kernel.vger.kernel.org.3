Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6452753969A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347097AbiEaS5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiEaS5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:57:43 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198BF5004A;
        Tue, 31 May 2022 11:57:41 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id C70CC5FD12;
        Tue, 31 May 2022 21:57:38 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1654023458;
        bh=82PgbgtlfLL0OLIobUgaluCR8orTi30NpPT+gbBqytk=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=dI8LMQ56+XB+pQnUVPqr7m1WK3scldAQwhoQhZPbbv9jH2RrevIFJrlOQAGt5VK+X
         hOiMLCF2bNJjM7YkZd/OD7ixeAJRJeFZwX7DzQGCgTBxEReeHbAzRucq1aEXjktzxw
         cjnk/d3hIv8dzMRwUdGBB7mswa6lWgP0HzHzAE8cElTjUv2c1c03EEyJs97n4tinzS
         AANwSTo/HEjFzmotDsRP6UL9i0xOdpJrZBpFI55ghe8gMX2c+ld7rhaxkbnyCSCXjB
         dSiAZ21MqoV95ivmNr9+s8hOno5lxgqjSXIg3ExB5xY8mDX/8iQDoIq6Y2+glqZ6g8
         NQNSLKk98QAXw==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 31 May 2022 21:57:38 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Topic: [PATCH v1] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Index: AQHYdRpaUrhZ5pf6gEC6S1oZ2DfDiK05JA2A
Date:   Tue, 31 May 2022 18:57:30 +0000
Message-ID: <20220531185729.z6246gexteyo4xmd@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220531181457.26034-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220531181457.26034-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A898A3C6A4D7CB49AFF74DBE28032B4D@sberdevices.ru>
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

Hi Jonathan,

I have one question about a cases when trigger owner is builtin module.
In the such cases trig->owner =3D=3D null, because THIS_MODULE equals to
null. How do you think, should we take into account such situations?

IMHO we have to take in and save this information to trig_info during
trigger allocation call. For example we can check THIS_MODULE from the
iio_trigger_alloc(), save builtin status to trig_info and look into it
from iio_trigger_get().

On Tue, May 31, 2022 at 06:15:05PM +0000, Dmitry Rokosov wrote:
> As a part of patch series about wrong trigger register() and get()
> calls order in the some IIO drivers trigger initialization path:
>=20
> https://lore.kernel.org/all/20220524181150.9240-1-ddrokosov@sberdevices.r=
u/
>=20
> runtime WARN() is added to alarm IIO driver authors who make such
> a mistake.
>=20
> When IIO driver allocates a new IIO trigger, it should register it before
> calling get() operation. Otherwise, the next iio_trigger_put() will upset
> refcnt balance.
>=20
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  include/linux/iio/trigger.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index 4c69b144677b..4a008b952710 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -93,6 +93,15 @@ static inline void iio_trigger_put(struct iio_trigger =
*trig)
>  static inline struct iio_trigger *iio_trigger_get(struct iio_trigger *tr=
ig)
>  {
>  	get_device(&trig->dev);
> +
> +	/*
> +	 * If driver hasn't called iio_trigger_register() before and trig->owne=
r
> +	 * wasn't initialized properly, trigger will have wrong number of users
> +	 */
> +	WARN(!trig->owner,
> +	     "Ignore module getting for non-registered iio trigger %s\n",
> +	     trig->name);
> +
>  	__module_get(trig->owner);
> =20
>  	return trig;
> --=20
> 2.36.0

--=20
Thank you,
Dmitry=
