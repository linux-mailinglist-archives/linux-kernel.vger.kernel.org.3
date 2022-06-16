Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682A854E2CA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377452AbiFPOAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377463AbiFPOAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:00:22 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCF54B423;
        Thu, 16 Jun 2022 07:00:03 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 044585FD08;
        Thu, 16 Jun 2022 17:00:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1655388000;
        bh=BFF9/E0PRVlK3YlyruWBFQLQJJ7X4aBdkgjrxHVmkn4=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=p6cz79awEzOcHFJiLhyEu2VQZBlkJdqLvNwRLiN9v+6DZBsz2tCtKPqf/8wP1JLVy
         3uUJrF08L3FKIgDsTXZNEuxlMitCFRFVpTQzxs8eoB8JWbm+Sjq89iGHLh2UkZ35f4
         eLKhXJz2m+hY1avsOHSjmvUNDFqIa+9MDYuppzWXDLrjomaVEtXtTI0hRO2f0LjJGO
         jOTuL/R9TIzV50wWHu01HCaaR/PydPfu2jea1kh46/mMfgNgVfByxUEf9OiqTZRNaV
         dOhilwH1gAoTQOZlNjRxvVGEBQUPJmvH4S6JOjxr5HSUJAOjVNv9K801NgrnRnRrJE
         AcGoQR6azYJzw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 16 Jun 2022 16:59:59 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "noname.nuno@gmail.com" <noname.nuno@gmail.com>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rockosov@gmail.com" <rockosov@gmail.com>
Subject: Re: [PATCH v3] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Topic: [PATCH v3] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Index: AQHYep3lZdCBX5wfLkWR1miHp7T4Oq1R6y8A
Date:   Thu, 16 Jun 2022 13:59:45 +0000
Message-ID: <20220616135954.jrzckwjwljitxkjg@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220607183907.20017-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220607183907.20017-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EDAFB1279776FF458417766EE0F9EFA4@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/16 07:44:00 #19785775
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Could you please review this patch version if possible?
I've changed WARN() to WARN_ONCE() and fixed commit msg as you suggested
in the v2.

On Tue, Jun 07, 2022 at 06:39:18PM +0000, Dmitry Rokosov wrote:
> As a part of patch series about wrong trigger register() and get()
> calls order in the some IIO drivers trigger initialization path:
>=20
> https://lore.kernel.org/all/20220524181150.9240-1-ddrokosov@sberdevices.r=
u/
>=20
> runtime WARN_ONCE() is added to alarm IIO driver authors who make such
> a mistake.
>=20
> When an IIO driver allocates a new IIO trigger, it should register it
> before calling the get() operation. In other words, each IIO driver
> must abide by IIO trigger alloc()/register()/get() calls order.
>=20
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
> Changes:
> v1 -> v2: totally reworked the patch, used trig->list entry instead of
>           trig->owner as driver registration indicator.
>           It works perfectly for both builtin and built as a module
>           drivers.
>=20
> v2 -> v3: changed WARN() call to WARN_ONCE() to avoid warn spamming
>           during deferred probe() as Andy suggested.
> ---
>  drivers/iio/industrialio-trigger.c | 2 ++
>  include/linux/iio/trigger.h        | 5 +++++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industriali=
o-trigger.c
> index f504ed351b3e..d6277e72d515 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -581,6 +581,8 @@ struct iio_trigger *viio_trigger_alloc(struct device =
*parent,
>  	if (trig->name =3D=3D NULL)
>  		goto free_descs;
> =20
> +	INIT_LIST_HEAD(&trig->list);
> +
>  	trig->subirq_chip.name =3D trig->name;
>  	trig->subirq_chip.irq_mask =3D &iio_trig_subirqmask;
>  	trig->subirq_chip.irq_unmask =3D &iio_trig_subirqunmask;
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index 4c69b144677b..03b1d6863436 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -93,6 +93,11 @@ static inline void iio_trigger_put(struct iio_trigger =
*trig)
>  static inline struct iio_trigger *iio_trigger_get(struct iio_trigger *tr=
ig)
>  {
>  	get_device(&trig->dev);
> +
> +	WARN_ONCE(list_empty(&trig->list),
> +		  "Getting non-registered iio trigger %s is prohibited\n",
> +		  trig->name);
> +
>  	__module_get(trig->owner);
> =20
>  	return trig;
> --=20
> 2.36.0

--=20
Thank you,
Dmitry=
