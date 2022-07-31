Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D3B585F96
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbiGaPuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiGaPuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:50:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D17FEE3E;
        Sun, 31 Jul 2022 08:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1BDCB80D11;
        Sun, 31 Jul 2022 15:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC1DC433D6;
        Sun, 31 Jul 2022 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659282646;
        bh=Nb8/KbRuMq0D5hB06qTzpFBgs5A+mZTRpBygcswuGTA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PhvD5DSlj7aX4WUCA135VaXQjtYC1xTVVc34bshN5hll6g4bAvI8RYVouxWma1LFX
         +u7IW2KXKtbsZ4B27ywspeeKe6SlkjIrypDjYMI+adt5+zGEBcWdf71dwGdE0mQxww
         MduQOqb4u5oZAYG6q6E/QdB1Z2AGNuOVkVQC6Wj+MR0uYelq5N5vOm5xv6eP5YJxZe
         xwlHsplqrSzzQJ2rctOnev6MQ8Q3NZfKjAtJGZC1ruC3yLX0gJBUzmmZEHAu2ALa2V
         YbpXMn7EeDfwplDb+IamyGti74Lq0TtvX+AZ0VDeZE/NpO1MTAoxmSCrvxvqcvaNx+
         Bti9ND8Ahk3JA==
Date:   Sun, 31 Jul 2022 17:00:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti =?UTF-8?B?TGVodGltw6RraQ==?= <matti.lehtimaki@gmail.com>
Cc:     linux-iio@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: st_sensors: Retry ID verification on failure
Message-ID: <20220731170057.2b8ac00e@jic23-huawei>
In-Reply-To: <20220724164316.68393-1-matti.lehtimaki@gmail.com>
References: <20220724164316.68393-1-matti.lehtimaki@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 19:43:15 +0300
Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.com> wrote:

> Some sensors do not always start fast enough to read a valid ID from
> registers at first attempt. Let's retry at most 3 times with short sleep
> in between to fix random timing issues.
>=20
> Signed-off-by: Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.com>
Hi Matti,

My gut feeling is this isn't in a fast path, so why not just wait
for whatever the documented power up time of the sensor is?

I'd expect to see a sleep in st_sensors_power_enable() if one is
required.

Jonathan

> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/ii=
o/common/st_sensors/st_sensors_core.c
> index 9910ba1da085..106f7953683e 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -21,6 +21,8 @@
> =20
>  #include "st_sensors_core.h"
> =20
> +#define VERIFY_ID_RETRY_COUNT 3
> +
>  int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
>  				    u8 reg_addr, u8 mask, u8 data)
>  {
> @@ -619,11 +621,18 @@ EXPORT_SYMBOL_NS(st_sensors_get_settings_index, IIO=
_ST_SENSORS);
>  int st_sensors_verify_id(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> -	int wai, err;
> +	int wai, err, i;
> =20
>  	if (sdata->sensor_settings->wai_addr) {
> -		err =3D regmap_read(sdata->regmap,
> -				  sdata->sensor_settings->wai_addr, &wai);
> +		for (i =3D 0; i < VERIFY_ID_RETRY_COUNT; i++) {
> +			err =3D regmap_read(sdata->regmap,
> +					  sdata->sensor_settings->wai_addr, &wai);
> +
> +			if (!err && sdata->sensor_settings->wai =3D=3D wai)
> +				return 0;
> +
> +			msleep(20);
How do we know 60msecs is long enough for all sensors?

> +		}
>  		if (err < 0) {
>  			dev_err(&indio_dev->dev,
>  				"failed to read Who-Am-I register.\n");

