Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D87512178
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiD0SsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiD0Srt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:47:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AFE98F4E;
        Wed, 27 Apr 2022 11:29:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 355F861EE0;
        Wed, 27 Apr 2022 18:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3E0C385A7;
        Wed, 27 Apr 2022 18:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651084181;
        bh=fRl5QBRUFoyxdbbm3vGEjIHcST0fn5HSwLbzywIOR88=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S8NLpJlqQOJyElbKUJJOnr+U4ja2LlNcd+OC4joCmAKAScIa70Ye091wNYNzN5DRe
         KjP7YG8mqFdNbFUr/EJs2+oPXu2WJo1Y9Re09xyPlQmvdtq7fB6Fa7VyUY2DEp62t7
         aA7xm2Aad+zOw7UkxhDEJVPkgDNkOaBsxMpQ2XpW4lKkpediuXDLIGMfHzWsSJFog2
         TpM06F+bNcPxOTlgDSUK1eCEKBM/LXpbEKFGtegRgnEXydGd8mrUA4hs85HecPwJHd
         7RBrXPqFiatb3CZJF8pdREpRd6LFaxiPItMnyeybMvPP7gr4vKevqnRykBvGN92Bfe
         d3bYarlrLQ+4A==
Date:   Wed, 27 Apr 2022 19:37:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 3/3] iio: imu: adis16480: Improve getting the
 optional clocks
Message-ID: <20220427193750.33d271be@jic23-huawei>
In-Reply-To: <20220414131559.24694-3-andriy.shevchenko@linux.intel.com>
References: <20220414131559.24694-1-andriy.shevchenko@linux.intel.com>
        <20220414131559.24694-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Thu, 14 Apr 2022 16:15:59 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The extended clocks are optional and may not be present for some
> configurations supported by this driver. Nevertheless, in case
> the clock is provided but some error happens during its getting,
> that error handling should be done properly.
>=20
> Use devm_clk_get_optional() API and report possible errors using
> dev_err_probe() to handle properly -EPROBE_DEFER error.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Series applied with Nuno's Tested-by as sent to v1.

Thanks,

Jonathan

> ---
> v2: added tag (Nuno), massaged commit message (Nuno)
>  drivers/iio/imu/adis16480.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 287914016f28..fe520194a837 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -1362,31 +1362,25 @@ static int adis16480_get_ext_clocks(struct adis16=
480 *st)
>  {
>  	struct device *dev =3D &st->adis.spi->dev;
> =20
> -	st->clk_mode =3D ADIS16480_CLK_INT;
> -	st->ext_clk =3D devm_clk_get(dev, "sync");
> -	if (!IS_ERR_OR_NULL(st->ext_clk)) {
> +	st->ext_clk =3D devm_clk_get_optional(dev, "sync");
> +	if (IS_ERR(st->ext_clk))
> +		return dev_err_probe(dev, PTR_ERR(st->ext_clk), "failed to get ext clk=
\n");
> +	if (st->ext_clk) {
>  		st->clk_mode =3D ADIS16480_CLK_SYNC;
>  		return 0;
>  	}
> =20
> -	if (PTR_ERR(st->ext_clk) !=3D -ENOENT) {
> -		dev_err(dev, "failed to get ext clk\n");
> -		return PTR_ERR(st->ext_clk);
> -	}
> -
>  	if (st->chip_info->has_pps_clk_mode) {
> -		st->ext_clk =3D devm_clk_get(dev, "pps");
> -		if (!IS_ERR_OR_NULL(st->ext_clk)) {
> +		st->ext_clk =3D devm_clk_get_optional(dev, "pps");
> +		if (IS_ERR(st->ext_clk))
> +			return dev_err_probe(dev, PTR_ERR(st->ext_clk), "failed to get ext cl=
k\n");
> +		if (st->ext_clk) {
>  			st->clk_mode =3D ADIS16480_CLK_PPS;
>  			return 0;
>  		}
> -
> -		if (PTR_ERR(st->ext_clk) !=3D -ENOENT) {
> -			dev_err(dev, "failed to get ext clk\n");
> -			return PTR_ERR(st->ext_clk);
> -		}
>  	}
> =20
> +	st->clk_mode =3D ADIS16480_CLK_INT;
>  	return 0;
>  }
> =20
> @@ -1447,7 +1441,7 @@ static int adis16480_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
> =20
> -	if (!IS_ERR_OR_NULL(st->ext_clk)) {
> +	if (st->ext_clk) {
>  		ret =3D adis16480_ext_clk_config(st, true);
>  		if (ret)
>  			return ret;

