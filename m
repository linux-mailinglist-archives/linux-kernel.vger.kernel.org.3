Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D8159ADB6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiHTL4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiHTL4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:56:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978B0248E2;
        Sat, 20 Aug 2022 04:56:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E864B80B84;
        Sat, 20 Aug 2022 11:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B8CC433D6;
        Sat, 20 Aug 2022 11:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660996573;
        bh=MgC417tLSXd3BlaZH46ba+MTqWmzo/k/pKAsnyV/4G0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VaL2eQ/swY9p1WvSDHRYSdI4SBeymJ0+VTNe0SAEZUNxLJ3QwHN7y/y1ZJ0Sa2vlk
         X4azJG69J4tay1rkhMIJZc/OeCkPknSapjJPIK0JRWRhvXeZRETaJ/ZJG64vJExkYc
         FJPmpZwtIuxbBeJGAjGDoneXmmmSqPLTjE8S2RVnc4EYSmMz7D7Nl4GjoiyECYwkhP
         i7GuDJM1n85PYlW40ejDskwj9znBnroQ9nrdAycXipksthAYKZS0b8WPlmrqMhm1tM
         3t/Qn9sVySo8YFCnZNNC/+XozRACSyCbhz9tUdiDcOLnoc9E+P8Ps6w/sH6pLDZQig
         ilGAnLLZoME1A==
Date:   Sat, 20 Aug 2022 13:06:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     Meng.Li@windriver.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] iio: ltc2497: Fix reading conversion results
Message-ID: <20220820130648.5b9bc66f@jic23-huawei>
In-Reply-To: <20220815091647.1523532-1-dzagorui@cisco.com>
References: <20220815091647.1523532-1-dzagorui@cisco.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 09:16:47 +0000
Denys Zagorui <dzagorui@cisco.com> wrote:

> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> After the result of the previous conversion is read the chip
> automatically starts a new conversion and doesn't accept new i2c
> transfers until this conversion is completed which makes the function
> return failure.

That's rather nasty.

Could we add a cheeky sleep in the other path to ensure there is always
time for the conversion to be done?  Not ideal, but might ensure
there isn't a known problem path without introducing much complexity.


>=20
> So add an early return iff the programming of the new address isn't
> needed. Note this will not fix the problem in general, but all cases
> that are currently used. Once this changes we get the failure back, but
> this can be addressed when the need arises.
>=20
> Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol independent part =
in a separate module ")
> Reported-by: Meng Li <Meng.Li@windriver.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Tested-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  drivers/iio/adc/ltc2497.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index f7c786f37ceb..78b93c99cc47 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -41,6 +41,19 @@ static int ltc2497_result_and_measure(struct ltc2497co=
re_driverdata *ddata,
>  		}
> =20
>  		*val =3D (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> +
> +		/*
> +		 * The part started a new conversion at the end of the above i2c
> +		 * transfer, so if the address didn't change since the last call
> +		 * everything is fine and we can return early.
> +		 * If not (which should only happen when some sort of bulk
> +		 * conversion is implemented) we have to program the new
> +		 * address. Note that this probably fails as the conversion that
> +		 * was triggered above is like not complete yet and the two
> +		 * operations have to be done in a single transfer.
> +		 */
> +		if (ddata->addr_prev =3D=3D address)
> +			return 0;
>  	}
> =20
>  	ret =3D i2c_smbus_write_byte(st->client,

