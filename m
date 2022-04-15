Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74FE502E89
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbiDOSFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345070AbiDOSFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:05:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A76C97280;
        Fri, 15 Apr 2022 11:02:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D46DEB82E24;
        Fri, 15 Apr 2022 18:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89A8C385A5;
        Fri, 15 Apr 2022 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650045753;
        bh=mE99LsDyoPP+38aCE5uDC5gBiHSUiziZZX9l14XmXo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tCUGcNwUXJvt67vpLi/qpYwiXS3pFNhaa1Y4WkYz66Dvc7//DZk9Gs/tKqaSSrWiV
         D22rCrHO+uaXm9NGUrObohQwt6Jc54xHasKgm5tLnP0xQvULrYLqBNOFVhW5oJqv+7
         8czU+bbZuScEOWW6UsNGg2IZLeiCFbUwTuQC9T4Eq82XXrEcAXFWe7Dzf/CR6dNWb9
         tPzElDo/WFaRtdzxps1sQsnKwpgNxNsE2b3rZYC0TJXJl74+QAYylxzahNiHLDCRKn
         PSKwCIcVQJwOpVC+6QCiciMnLKWukooHfmEB3q72wwSH0tQR2Mpc/lfTlRECiEMpC6
         Vf0XaQGLsnt4A==
Date:   Fri, 15 Apr 2022 19:10:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 2/3] iio: imu: adis16480: Use temporary variable for
 struct device
Message-ID: <20220415191031.4cd40c35@jic23-huawei>
In-Reply-To: <20220414131559.24694-2-andriy.shevchenko@linux.intel.com>
References: <20220414131559.24694-1-andriy.shevchenko@linux.intel.com>
        <20220414131559.24694-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Thu, 14 Apr 2022 16:15:58 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use temporary variable for struct device to make code neater.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
> v2: added tag (Nuno)
>  drivers/iio/imu/adis16480.c | 46 ++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 68eed088cca6..287914016f28 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
...

> @@ -1216,12 +1217,12 @@ static const struct iio_info adis16480_info =3D {
>  static int adis16480_stop_device(struct iio_dev *indio_dev)
>  {
>  	struct adis16480 *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D &st->adis.spi->dev;
>  	int ret;
> =20
>  	ret =3D adis_write_reg_16(&st->adis, ADIS16480_REG_SLP_CNT, BIT(9));
>  	if (ret)
> -		dev_err(&indio_dev->dev,
> -			"Could not power down device: %d\n", ret);
> +		dev_err(dev, "Could not power down device: %d\n", ret);
> =20

Subtle but this is a functional change.  I think it's an improvement
to use the spi dev, but if anyone sees this error message it will
be different as a result, so ideally the patch description
would have mentioned this.  Meh. It's trivial so I don't really care
enough for a v3 or to modify it whilst applying :)

So fine as is, but I thought I'd call it out anyway.

Jonathan
